import SwiftUI

struct PromoView: View {
    let onStart: () -> Void

    var body: some View {
        ZStack {
            LinearGradient(colors: [.apexBlue, .apexTeal],
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .ignoresSafeArea()

            VStack(alignment: .leading, spacing: Spacing.xl) {
                Spacer(minLength: 24)

                VStack(alignment: .leading, spacing: Spacing.md) {
                    Text("PolApex")
                        .font(.system(size: 46, weight: .black, design: .rounded))
                        .foregroundColor(.white)
                    Text("政治登顶")
                        .font(.system(size: 30, weight: .bold, design: .rounded))
                        .foregroundColor(.white.opacity(0.92))
                    Text("背得准、调得出、写得像答案。")
                        .font(.headline)
                        .foregroundColor(.white.opacity(0.86))
                }

                VStack(spacing: Spacing.md) {
                    promoRow("scope", "材料切片", "主体、行为、对象、目标、知识点五刀切开")
                    promoRow("text.append", "答案工厂", "教材术语 + 材料对应 + 结果意义")
                    promoRow("exclamationmark.triangle", "选择题排雷", "主体错配、因果倒置、绝对化逐一清掉")
                }

                Spacer()

                Button(action: onStart) {
                    HStack {
                        Text("开始登顶")
                            .font(.headline)
                        Image(systemName: "arrow.right")
                    }
                    .foregroundColor(.apexBlue)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 15)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: Radius.card, style: .continuous))
                }
            }
            .padding(Spacing.xl)
            .readableWidth(560)
        }
    }

    private func promoRow(_ icon: String, _ title: String, _ subtitle: String) -> some View {
        HStack(spacing: Spacing.md) {
            Image(systemName: icon)
                .font(.title3)
                .frame(width: 42, height: 42)
                .background(Color.white.opacity(0.15))
                .clipShape(RoundedRectangle(cornerRadius: Radius.inner, style: .continuous))
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(AppFont.cardTitle)
                    .foregroundColor(.white)
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.82))
            }
            Spacer(minLength: 0)
        }
    }
}
