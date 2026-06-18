import SwiftUI

struct PaywallView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject private var purchase = PurchaseManager.shared

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: Spacing.lg) {
                    VStack(alignment: .leading, spacing: Spacing.sm) {
                        Image(systemName: "crown.fill")
                            .font(.largeTitle)
                            .foregroundColor(.apexGold)
                        Text("PolApex 完整版")
                            .font(.title.weight(.bold))
                        Text("一次买断，解锁完整政治高考冲刺系统。")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .cardSurface()

                    VStack(alignment: .leading, spacing: Spacing.md) {
                        feature("全部 \(MainLineData.nodes.count) 关登顶之路")
                        feature("\(MainLineData.allKnowledgePoints.count) 个考点全覆盖")
                        feature("\(QuestionBank.all.count) 道按权重生成的选择题")
                        feature("\(SubjectiveQuestionData.all.count) 道 S/A 主观题")
                        feature("\(WeaponGuideData.all.count) 把政治答题武器")
                    }
                    .cardSurface()

                    Button {
                        Task { await purchase.purchase() }
                    } label: {
                        Text(purchase.isPurchasing ? "处理中..." : "解锁 \(purchase.product?.displayPrice ?? "¥22")")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(Color.apexRed)
                            .clipShape(RoundedRectangle(cornerRadius: Radius.card))
                    }
                    .disabled(purchase.isPurchasing)

                    Button {
                        Task { await purchase.restore() }
                    } label: {
                        Text("恢复购买")
                            .font(.subheadline)
                            .frame(maxWidth: .infinity)
                    }

                    if let message = purchase.errorMessage {
                        Text(message)
                            .font(.caption)
                            .foregroundColor(.apexDanger)
                    }
                }
                .padding(Spacing.lg)
                .readableWidth(560)
            }
            .background(Color.apexBackground.ignoresSafeArea())
            .navigationTitle("完整版")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("关闭") { dismiss() }
                }
            }
        }
    }

    private func feature(_ text: String) -> some View {
        Label(text, systemImage: "checkmark.circle.fill")
            .font(.subheadline)
            .foregroundColor(.primary)
    }
}
