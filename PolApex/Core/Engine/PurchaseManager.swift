import StoreKit
import SwiftUI

// MARK: - 完整功能解锁 IAP（StoreKit 2 · 一次性买断）
//
// 产品 ID：com.polapex.app.full_unlock（¥22 一次性买断，价格以 App Store Connect 为准）
// 免费档：初中道法主线 9 关 + 少量武器 / 材料案例 / Boss 双解，用来体验背诵和材料切片。
// 解锁后：高中必修、选必、冲刺主线，高考比例套练，非选择题题型池，材料切片，主体矩阵，Boss 双解和复习闭环。
// 本地测试：PolApex.storekit 已挂到 scheme，可直接验证购买 / 恢复流程。

final class PurchaseManager: ObservableObject {
    static let shared = PurchaseManager()

    let productID = "com.polapex.app.full_unlock"

    static let freeNodeCount = 9
    static let freeDuelCount = 1
    static let freeMaterialCaseCount = 2
    static let freeWeaponCount = 6

    @Published private(set) var isUnlocked: Bool = false
    @Published private(set) var product: Product?
    @Published private(set) var productLoadState: ProductLoadState = .idle
    @Published private(set) var isPurchasing: Bool = false
    @Published private(set) var errorMessage: String?

    private let storageKey = "polapex_full_unlocked"
    private var transactionUpdatesTask: Task<Void, Never>?

    private init() {
        isUnlocked = UserDefaults.standard.bool(forKey: storageKey)
        transactionUpdatesTask = Task { [weak self] in
            await self?.observeTransactionUpdates()
        }
        Task {
            await refreshEntitlements()
            await prepareForPurchase()
        }
    }

    deinit {
        transactionUpdatesTask?.cancel()
    }

    func isNodePremiumLocked(_ node: LearningNode) -> Bool {
        guard !isUnlocked else { return false }
        return node.order > Self.freeNodeCount
    }

    func isDuelPremiumLocked(index: Int) -> Bool {
        guard !isUnlocked else { return false }
        return index >= Self.freeDuelCount
    }

    func isMaterialCasePremiumLocked(index: Int) -> Bool {
        guard !isUnlocked else { return false }
        return index >= Self.freeMaterialCaseCount
    }

    func isWeaponPremiumLocked(index: Int) -> Bool {
        guard !isUnlocked else { return false }
        return index >= Self.freeWeaponCount
    }

    @MainActor
    @discardableResult
    func prepareForPurchase(forceReload: Bool = false) async -> Product? {
        if let product, !forceReload {
            productLoadState = .ready
            return product
        }

        productLoadState = .loading
        errorMessage = nil

        do {
            let products = try await Product.products(for: [productID])
            if let storeProduct = products.first(where: { $0.id == productID }) {
                product = storeProduct
                productLoadState = .ready
                return storeProduct
            } else {
                product = nil
                productLoadState = .unavailable
                errorMessage = "暂时无法从 App Store 获取内购项目，请稍后重试或使用恢复购买。"
                return nil
            }
        } catch {
            product = nil
            productLoadState = .unavailable
            errorMessage = "连接 App Store 失败，请检查网络后重试。"
            return nil
        }
    }

    @MainActor
    func purchase() async {
        guard !isPurchasing else { return }
        isPurchasing = true
        errorMessage = nil
        defer { isPurchasing = false }

        let productToPurchase: Product?
        if let product {
            productToPurchase = product
        } else {
            productToPurchase = await prepareForPurchase(forceReload: true)
        }

        guard let product = productToPurchase else {
            return
        }

        do {
            let result = try await product.purchase()
            switch result {
            case .success(let verification):
                let transaction = try checkVerified(verification)
                await transaction.finish()
                unlock()
            case .userCancelled:
                break
            case .pending:
                errorMessage = "购买待处理（可能需要家长确认），完成后会自动解锁"
            @unknown default:
                break
            }
        } catch {
            errorMessage = "购买失败：\(error.localizedDescription)"
        }
    }

    @MainActor
    func restore() async {
        isPurchasing = true
        errorMessage = nil
        defer { isPurchasing = false }
        do {
            try await AppStore.sync()
            await refreshEntitlements()
            if !isUnlocked { errorMessage = "未找到购买记录" }
        } catch {
            errorMessage = "恢复失败：\(error.localizedDescription)"
        }
    }

    func refreshEntitlements() async {
        for await result in Transaction.currentEntitlements {
            if case .verified(let transaction) = result,
               transaction.productID == productID,
               transaction.revocationDate == nil {
                await MainActor.run { unlock() }
                return
            }
        }
    }

    private func observeTransactionUpdates() async {
        for await result in Transaction.updates {
            guard case .verified(let transaction) = result,
                  transaction.productID == productID else {
                continue
            }

            if transaction.revocationDate == nil {
                await MainActor.run { unlock() }
            }
            await transaction.finish()
        }
    }

    @MainActor
    private func unlock() {
        isUnlocked = true
        UserDefaults.standard.set(true, forKey: storageKey)
    }

    private func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        switch result {
        case .unverified(_, let error): throw error
        case .verified(let value): return value
        }
    }
}

enum ProductLoadState {
    case idle
    case loading
    case ready
    case unavailable
}
