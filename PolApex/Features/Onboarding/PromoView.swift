import SwiftUI

// MARK: - 启动广告页（开头首页）：品牌 → 卖点 → 数据 → 开发者 → 版权 → 进入
// 设计参考 ChinApex / ChemApex PromoView，保持 Apex 家族一致的视觉与信息结构。

struct PromoView: View {
    var onEnter: () -> Void

    @State private var appeared = false
    @State private var glow = false

    private let features: [(icon: String, color: Color, title: String, desc: String)] = [
        ("scissors", .apexLava, "答案工厂 · 材料切片", "主体、行为、对象、目标四刀拆开材料，自动召回知识点与高分答案句"),
        ("brain.head.profile", .apexGold, "高权重记忆引擎", "125 个知识点按 S/A/B/C 定权重，必背原文、答题模板、易混辨析一次配齐"),
        ("bolt.fill", .apexMystery, "秒杀武器库", "19 把武器覆盖主体定位、经济传导链、选择题五排雷，配 Boss 双解对比速度差"),
        ("chart.pie.fill", .apexStarBlue, "高考比例套练", "16 道选择题 48 分 + 4 道非选择题 52 分，按真实分值权重组卷"),
        ("point.3.connected.trianglepath.dotted", .apexEmerald, "概念星图", "50+ 概念节点、60+ 关系连线，把党的领导、市场调控等因果与职责可视化"),
    ]

    private var bg: some View {
        LinearGradient(colors: [Color(UIColor(hex6: 0x170A0C)),
                                Color(UIColor(hex6: 0x3A1018)),
                                Color(UIColor(hex6: 0x170A0C))],
                       startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
    }

    var body: some View {
        ZStack {
            bg

            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    VStack(spacing: 14) {
                        ZStack {
                            Circle()
                                .fill(LinearGradient(colors: [.apexGold, .apexLava],
                                                     startPoint: .topLeading,
                                                     endPoint: .bottomTrailing))
                                .frame(width: 96, height: 96)
                                .shadow(color: Color.apexGold.opacity(glow ? 0.58 : 0.25),
                                        radius: glow ? 26 : 12)
                            Image(systemName: "building.columns.fill")
                                .font(.system(size: 44, weight: .bold))
                                .foregroundColor(.white)
                        }
                        Text("POL APEX")
                            .font(.system(size: 30, weight: .heavy, design: .rounded))
                            .tracking(2)
                            .foregroundStyle(LinearGradient(colors: [.apexGold, .apexLava],
                                                            startPoint: .leading,
                                                            endPoint: .trailing))
                        Text("政 治 登 顶 · 背 准 答 像")
                            .font(.system(size: 14, weight: .medium))
                            .tracking(2)
                            .foregroundColor(.white.opacity(0.62))
                    }
                    .padding(.top, 48)

                    VStack(spacing: 10) {
                        Text("装上 PolApex，解锁「答案工厂」超能力")
                            .font(.system(size: 18, weight: .bold))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                        Text("从死记硬背的口号，到材料分析与答案输出\n看清材料里的主体与考点，一步步写出像答案的答案")
                            .font(.system(size: 13))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white.opacity(0.66))
                            .lineSpacing(4)
                    }
                    .padding(.top, 28)
                    .padding(.horizontal, 24)

                    VStack(spacing: 12) {
                        ForEach(Array(features.enumerated()), id: \.offset) { _, f in
                            HStack(spacing: 14) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(f.color.opacity(0.20))
                                        .frame(width: 46, height: 46)
                                    Image(systemName: f.icon)
                                        .font(.system(size: 20, weight: .semibold))
                                        .foregroundColor(f.color)
                                }
                                VStack(alignment: .leading, spacing: 3) {
                                    Text(f.title)
                                        .font(.system(size: 16, weight: .bold))
                                        .foregroundColor(.white)
                                    Text(f.desc)
                                        .font(.system(size: 13))
                                        .foregroundColor(.white.opacity(0.66))
                                        .lineSpacing(2)
                                        .fixedSize(horizontal: false, vertical: true)
                                }
                                Spacer(minLength: 0)
                            }
                            .padding(14)
                            .background(RoundedRectangle(cornerRadius: 16).fill(Color.white.opacity(0.06)))
                        }
                    }
                    .padding(.top, 28)
                    .padding(.horizontal, 24)

                    HStack(spacing: 0) {
                        stat("\(MainLineData.nodes.count)", "登顶关卡")
                        statDivider
                        stat("\(MainLineData.allKnowledgePoints.count)", "知识点深讲")
                        statDivider
                        stat("\(WeaponGuideData.all.count)", "秒杀武器")
                    }
                    .padding(.vertical, 18)
                    .padding(.horizontal, 24)
                    .background(RoundedRectangle(cornerRadius: 16).fill(Color.white.opacity(0.05)))
                    .padding(.top, 24)
                    .padding(.horizontal, 24)

                    VStack(alignment: .leading, spacing: 12) {
                        HStack(spacing: 12) {
                            ZStack {
                                Circle()
                                    .fill(LinearGradient(colors: [.apexGold, .apexLava],
                                                         startPoint: .top,
                                                         endPoint: .bottom))
                                    .frame(width: 44, height: 44)
                                Text("K")
                                    .font(.system(size: 22, weight: .heavy))
                                    .foregroundColor(.white)
                            }
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Top King")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.white)
                                Text("独立开发者 / 教育科技探索者")
                                    .font(.system(size: 12))
                                    .foregroundColor(.white.opacity(0.62))
                            }
                            Spacer()
                        }
                        Text("专注教育类 App，用科技让学习更清晰。PolApex 把政治的「答案逻辑」拆成可练动作：材料切片、知识点匹配、模板套用、采分点核对，让每一次练习都知道自己在补哪一分。")
                            .font(.system(size: 13))
                            .foregroundColor(.white.opacity(0.66))
                            .lineSpacing(3)
                    }
                    .padding(16)
                    .background(RoundedRectangle(cornerRadius: 16).fill(Color.white.opacity(0.06)))
                    .padding(.top, 24)
                    .padding(.horizontal, 24)

                    VStack(spacing: 4) {
                        Text("PolApex · 政治登顶  v1.0.0")
                            .font(.system(size: 12))
                            .foregroundColor(.white.opacity(0.50))
                        Text("© 2026 Top King. All rights reserved.")
                            .font(.system(size: 11))
                            .foregroundColor(.white.opacity(0.35))
                    }
                    .padding(.top, 22)
                    .padding(.bottom, 120)
                }
                .frame(maxWidth: 600)
                .frame(maxWidth: .infinity)
                .opacity(appeared ? 1 : 0)
                .offset(y: appeared ? 0 : 24)
            }

            VStack {
                Spacer()
                Button(action: onEnter) {
                    HStack(spacing: 8) {
                        Text("开 启 政 治 登 顶 之 旅")
                            .fontWeight(.bold)
                            .tracking(1)
                        Image(systemName: "arrow.right")
                    }
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(LinearGradient(colors: [.apexLava, .apexGold],
                                               startPoint: .leading,
                                               endPoint: .trailing),
                                in: RoundedRectangle(cornerRadius: 16))
                    .shadow(color: Color.apexLava.opacity(0.45), radius: 14, y: 4)
                }
                .frame(maxWidth: 552)
                .padding(.horizontal, 24)
                .padding(.bottom, 20)
                .background(
                    LinearGradient(colors: [Color(UIColor(hex6: 0x170A0C)).opacity(0),
                                            Color(UIColor(hex6: 0x170A0C))],
                                   startPoint: .top,
                                   endPoint: .bottom)
                        .frame(height: 120)
                        .allowsHitTesting(false),
                    alignment: .bottom
                )
            }
            .ignoresSafeArea(edges: .bottom)
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.7)) { appeared = true }
            withAnimation(.easeInOut(duration: 1.6).repeatForever(autoreverses: true)) { glow = true }
        }
    }

    private func stat(_ n: String, _ label: String) -> some View {
        VStack(spacing: 4) {
            Text(n)
                .font(.system(size: 24, weight: .heavy, design: .rounded))
                .foregroundColor(.apexGold)
                .lineLimit(1)
                .minimumScaleFactor(0.7)
            Text(label)
                .font(.system(size: 12))
                .foregroundColor(.white.opacity(0.62))
                .lineLimit(1)
                .minimumScaleFactor(0.75)
        }
        .frame(maxWidth: .infinity)
    }

    private var statDivider: some View {
        Rectangle()
            .fill(Color.white.opacity(0.20))
            .frame(width: 1, height: 30)
    }
}
