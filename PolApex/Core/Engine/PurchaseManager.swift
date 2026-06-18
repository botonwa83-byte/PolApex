import StoreKit
import SwiftUI

final class PurchaseManager: ObservableObject {
    static let shared = PurchaseManager()

    let productID = "com.polapex.app.full_unlock"

    static let freeNodeCount = 9
    static let freeDuelCount = 1
    static let freeMaterialCaseCount = 2
    static let freeWeaponCount = 6

    @Published private(set) var isUnlocked: Bool = false
    @Published private(set) var product: Product?
    @Published private(set) var isPurchasing: Bool = false
    @Published private(set) var errorMessage: String?

    private let storageKey = "polapex_full_unlocked"

    private init() {
        isUnlocked = UserDefaults.standard.bool(forKey: storageKey)
        Task {
            await loadProduct()
            await refreshEntitlements()
        }
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
    func loadProduct() async {
        do {
            let products = try await Product.products(for: [productID])
            product = products.first
        } catch {
            errorMessage = nil
        }
    }

    @MainActor
    func purchase() async {
        guard let product else {
            errorMessage = "获取产品信息失败，请检查网络后重试"
            return
        }
        isPurchasing = true
        errorMessage = nil
        defer { isPurchasing = false }
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
                errorMessage = "购买待处理，完成后会自动解锁"
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
