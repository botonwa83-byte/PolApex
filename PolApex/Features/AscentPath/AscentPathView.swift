import SwiftUI

struct AscentPathView: View {
    @EnvironmentObject var progress: ProgressManager
    @ObservedObject private var purchase = PurchaseManager.shared
    @State private var showPaywall = false

    private var nodes: [LearningNode] { MainLineData.nodes }
    private var recommended: LearningNode? { progress.currentNode(in: nodes) }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: Spacing.lg) {
                    premiumBanner
                    dashboard
                    todayFocus
                    pathHeader

                    ForEach(Array(nodes.enumerated()), id: \.element.id) { index, node in
                        if index == 0 || node.stage != nodes[index - 1].stage {
                            stageDivider(node.stage)
                        }

                        if purchase.isNodePremiumLocked(node) {
                            Button { showPaywall = true } label: {
                                NodeCard(node: node,
                                         state: progress.nodeState(node, in: nodes),
                                         progressValue: progress.nodeProgress(node),
                                         isRecommended: node.id == recommended?.id,
                                         premiumLocked: true)
                            }
                            .buttonStyle(.plain)
                        } else {
                            NavigationLink { NodeDetailView(node: node) } label: {
                                NodeCard(node: node,
                                         state: progress.nodeState(node, in: nodes),
                                         progressValue: progress.nodeProgress(node),
                                         isRecommended: node.id == recommended?.id,
                                         premiumLocked: false)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .padding(Spacing.lg)
                .padding(.bottom, Spacing.xxl)
                .readableWidth()
            }
            .background(Color.apexBackground.ignoresSafeArea())
            .navigationTitle("指挥中心")
            .sheet(isPresented: $showPaywall) { PaywallView() }
        }
    }

    @ViewBuilder
    private var premiumBanner: some View {
        if !purchase.isUnlocked {
            Button { showPaywall = true } label: {
                HStack(spacing: Spacing.md) {
                    Image(systemName: "crown.fill")
                        .foregroundColor(.white)
                        .frame(width: 42, height: 42)
                        .background(Color.white.opacity(0.16))
                        .clipShape(RoundedRectangle(cornerRadius: Radius.inner))
                    VStack(alignment: .leading, spacing: 3) {
                        Text("解锁完整版")
                            .font(AppFont.cardTitle)
                            .foregroundColor(.white)
                        Text("全部 \(nodes.count) 关 · \(WeaponGuideData.all.count) 把武器 · 材料题答案工厂")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.9))
                    }
                    Spacer(minLength: 0)
                    Text(purchase.product?.displayPrice ?? "¥22")
                        .font(AppFont.cardTitle)
                        .foregroundColor(.white)
                        .padding(.horizontal, 11)
                        .padding(.vertical, 6)
                        .background(Color.white.opacity(0.18))
                        .clipShape(RoundedRectangle(cornerRadius: Radius.inner))
                }
                .padding(Spacing.lg)
                .background(LinearGradient(colors: [.apexRed, .apexGold],
                                           startPoint: .leading,
                                           endPoint: .trailing))
                .clipShape(RoundedRectangle(cornerRadius: Radius.card, style: .continuous))
            }
            .buttonStyle(.plain)
        }
    }

    private var dashboard: some View {
        HStack(spacing: Spacing.md) {
            statBlock("\(progress.completedNodeCount)/\(nodes.count)", "主线进度", .apexTeal)
            statBlock("\(MemoryData.highWeight(limit: 99).filter { $0.grade == .s }.count)", "S级卡", .apexRed)
            statBlock("\(WeaponGuideData.all.count)", "武器", .apexGold)
        }
        .cardSurface()
    }

    private func statBlock(_ value: String, _ label: String, _ color: Color) -> some View {
        VStack(spacing: 2) {
            Text(value)
                .font(AppFont.stat(24))
                .foregroundColor(color)
            Text(label)
                .font(.caption2)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
    }

    private var todayFocus: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            SectionHeader(title: "今日提分入口", systemImage: "bolt.fill", accent: .apexGold)
            if let weak = progress.weakNodes(limit: 1).first {
                NavigationLink { NodeDetailView(node: weak.node) } label: {
                    focusRow(icon: "target",
                             color: .apexDanger,
                             title: weak.node.title,
                             subtitle: "薄弱优先 · 预计正确率 \(Int(weak.accuracy * 100))%",
                             badge: "补短板")
                }
                .buttonStyle(.plain)
            }
            if let guide = WeaponGuideData.guide(for: .essaySixSteps) {
                NavigationLink { WeaponDetailView(guide: guide) } label: {
                    focusRow(icon: guide.weapon.icon,
                             color: .apexTeal,
                             title: guide.weapon.name,
                             subtitle: guide.tagline,
                             badge: "主观题")
                }
                .buttonStyle(.plain)
            }
        }
    }

    private func focusRow(icon: String, color: Color, title: String, subtitle: String, badge: String) -> some View {
        HStack(spacing: Spacing.md) {
            Image(systemName: icon)
                .font(.title3)
                .frame(width: 44, height: 44)
                .background(color.opacity(0.13))
                .foregroundColor(color)
                .clipShape(RoundedRectangle(cornerRadius: Radius.inner))
            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                    .font(AppFont.cardTitle)
                    .foregroundColor(.primary)
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            Spacer(minLength: 0)
            TagChip(text: badge, color: color)
        }
        .cardSurface()
    }

    private var pathHeader: some View {
        HStack {
            SectionHeader(title: "登顶之路 · 28关", systemImage: "map", accent: .apexTeal)
            if let recommended {
                Text("推荐 \(recommended.order)")
                    .font(AppFont.chip)
                    .foregroundColor(.secondary)
            }
        }
    }

    private func stageDivider(_ stage: Stage) -> some View {
        HStack(spacing: Spacing.sm) {
            Rectangle()
                .fill(stage.color.opacity(0.35))
                .frame(height: 1)
            Text("\(stage.mark) \(stage.title)")
                .font(AppFont.chip)
                .foregroundColor(stage.color)
                .fixedSize()
            Rectangle()
                .fill(stage.color.opacity(0.35))
                .frame(height: 1)
        }
        .padding(.vertical, Spacing.xs)
    }
}

struct NodeCard: View {
    let node: LearningNode
    let state: NodeState
    let progressValue: Double
    let isRecommended: Bool
    let premiumLocked: Bool

    var body: some View {
        HStack(alignment: .top, spacing: Spacing.md) {
            ZStack {
                RoundedRectangle(cornerRadius: Radius.inner, style: .continuous)
                    .fill(node.stage.color.opacity(0.13))
                Text("\(node.order)")
                    .font(AppFont.cardTitle)
                    .foregroundColor(node.stage.color)
            }
            .frame(width: 42, height: 42)

            VStack(alignment: .leading, spacing: Spacing.sm) {
                HStack(spacing: Spacing.xs) {
                    Text(node.title)
                        .font(AppFont.cardTitle)
                        .foregroundColor(.primary)
                        .lineLimit(2)
                    if isRecommended {
                        TagChip(text: "推荐", color: .apexRed)
                    }
                    if premiumLocked {
                        TagChip(text: "完整版", color: .apexGold)
                    }
                }
                Text(node.tagline)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                HStack(spacing: 6) {
                    TagChip(text: node.topic.name, color: node.stage.color)
                    if let weapon = node.weaponUnlocked {
                        TagChip(text: weapon.name, color: .apexTeal)
                    }
                    ForEach(node.knowledgePoints.prefix(1)) { point in
                        TagChip(text: "\(point.grade.rawValue)级", color: .grade(point.grade))
                    }
                }
                ProgressView(value: progressValue)
                    .tint(node.stage.color)
            }

            Spacer(minLength: 0)

            Image(systemName: trailingIcon)
                .font(.caption)
                .foregroundColor(premiumLocked ? .apexGold : .secondary)
                .padding(.top, 4)
        }
        .cardSurface()
    }

    private var trailingIcon: String {
        if premiumLocked { return "crown.fill" }
        switch state {
        case .completed: return "checkmark.circle.fill"
        case .current: return "play.circle.fill"
        case .locked: return "chevron.right"
        }
    }
}

struct NodeDetailView: View {
    let node: LearningNode
    @EnvironmentObject var progress: ProgressManager

    private var questions: [PoliticsQuestion] { QuestionBank.questions(nodeId: node.id) }
    private var duel: BossDuel? { node.bossCaseId.flatMap { BossDuelData.duel(id: $0) } }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Spacing.lg) {
                header
                knowledgeSection
                practiceSection
                if let duel {
                    duelSection(duel)
                }
                completeButton
            }
            .padding(Spacing.lg)
            .readableWidth()
        }
        .background(Color.apexBackground.ignoresSafeArea())
        .navigationTitle("第 \(node.order) 关")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            HStack {
                TagChip(text: node.stage.shortTitle, color: node.stage.color)
                TagChip(text: node.topic.name, color: node.stage.color)
                if let weapon = node.weaponUnlocked {
                    TagChip(text: "解锁 \(weapon.name)", color: .apexGold)
                }
            }
            Text(node.title)
                .font(.title2.weight(.bold))
            Text(node.tagline)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .cardSurface()
    }

    private var knowledgeSection: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            SectionHeader(title: "高权重考点", systemImage: "seal", accent: .apexTeal)
            ForEach(MainLineData.coveragePoints(for: node)) { point in
                VStack(alignment: .leading, spacing: Spacing.sm) {
                    HStack {
                        Text(point.title)
                            .font(AppFont.cardTitle)
                        TagChip(text: "\(point.grade.rawValue)级", color: .grade(point.grade))
                        TagChip(text: point.cardType.rawValue, color: .apexBlue)
                    }
                    Text(point.detail)
                        .font(.subheadline)
                        .foregroundColor(.primary)
                    if let pitfall = point.pitfall {
                        Label(pitfall, systemImage: "exclamationmark.triangle")
                            .font(.caption)
                            .foregroundColor(.apexDanger)
                    }
                }
                .cardSurface(padding: Spacing.md)
            }
        }
    }

    private var practiceSection: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            SectionHeader(title: "选择题排雷", systemImage: "checkmark.seal", accent: .apexBlue)
            ForEach(questions) { question in
                NavigationLink { QuestionDetailView(question: question) } label: {
                    HStack(spacing: Spacing.md) {
                        Image(systemName: progress.stats(for: question.id).everCorrect ? "checkmark.circle.fill" : "circle")
                            .foregroundColor(progress.stats(for: question.id).everCorrect ? .apexEmerald : .secondary)
                        Text(question.prompt)
                            .font(.subheadline)
                            .foregroundColor(.primary)
                            .lineLimit(2)
                        Spacer(minLength: 0)
                        Image(systemName: "chevron.right")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .cardSurface(padding: Spacing.md)
                }
                .buttonStyle(.plain)
            }
        }
    }

    private func duelSection(_ duel: BossDuel) -> some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            SectionHeader(title: "Boss 双解对决", systemImage: "bolt.shield", accent: .apexRed)
            NavigationLink { DuelDetailView(duel: duel) } label: {
                HStack(spacing: Spacing.md) {
                    Image(systemName: duel.weapon.icon)
                        .font(.title3)
                        .frame(width: 44, height: 44)
                        .background(Color.apexRed.opacity(0.12))
                        .foregroundColor(.apexRed)
                        .clipShape(RoundedRectangle(cornerRadius: Radius.inner))
                    VStack(alignment: .leading, spacing: 3) {
                        Text(duel.title)
                            .font(AppFont.cardTitle)
                            .foregroundColor(.primary)
                        Text("常规 \(timeText(duel.standard.timeMinutes)) → 武器 \(timeText(duel.weaponPath.timeMinutes))")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    TagChip(text: String(format: "快 %.1f 倍", duel.timeRatio), color: .apexRed)
                }
                .cardSurface()
            }
            .buttonStyle(.plain)
        }
    }

    private var completeButton: some View {
        Button {
            progress.complete(node)
        } label: {
            Label(progress.completedNodeIds.contains(node.id) ? "已通关" : "标记本关通关",
                  systemImage: progress.completedNodeIds.contains(node.id) ? "checkmark.circle.fill" : "flag.checkered")
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(node.stage.color)
                .clipShape(RoundedRectangle(cornerRadius: Radius.card))
        }
    }

    private func timeText(_ value: Double) -> String {
        value >= 1 ? String(format: "%.0f分钟", value) : String(format: "%.1f分钟", value)
    }
}

struct QuestionDetailView: View {
    let question: PoliticsQuestion
    @EnvironmentObject var progress: ProgressManager
    @State private var selectedIndex: Int?

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Spacing.lg) {
                VStack(alignment: .leading, spacing: Spacing.md) {
                    Text(question.prompt)
                        .font(.title3.weight(.bold))
                    HStack {
                        TagChip(text: question.stage.shortTitle, color: question.stage.color)
                        TagChip(text: question.topic.name, color: question.stage.color)
                    }
                }
                .cardSurface()

                ForEach(Array(question.options.enumerated()), id: \.offset) { index, option in
                    Button {
                        selectedIndex = index
                        progress.record(question, correct: index == question.answerIndex)
                    } label: {
                        HStack(spacing: Spacing.md) {
                            Text(String(UnicodeScalar(65 + index)!))
                                .font(AppFont.cardTitle)
                                .frame(width: 32, height: 32)
                                .background(optionColor(index).opacity(0.14))
                                .foregroundColor(optionColor(index))
                                .clipShape(RoundedRectangle(cornerRadius: Radius.inner))
                            Text(option)
                                .font(.subheadline)
                                .foregroundColor(.primary)
                                .multilineTextAlignment(.leading)
                            Spacer(minLength: 0)
                        }
                        .cardSurface(padding: Spacing.md)
                    }
                    .buttonStyle(.plain)
                }

                if selectedIndex != nil {
                    VStack(alignment: .leading, spacing: Spacing.sm) {
                        SectionHeader(title: "解析", systemImage: "lightbulb", accent: .apexGold)
                        Text(question.explanation)
                            .font(.subheadline)
                        if !question.trapTags.isEmpty {
                            HStack {
                                ForEach(question.trapTags, id: \.self) { tag in
                                    TagChip(text: tag, color: .apexDanger)
                                }
                            }
                        }
                    }
                    .cardSurface()
                }
            }
            .padding(Spacing.lg)
            .readableWidth()
        }
        .background(Color.apexBackground.ignoresSafeArea())
        .navigationTitle("选择题排雷")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func optionColor(_ index: Int) -> Color {
        guard let selectedIndex else { return .apexBlue }
        if index == question.answerIndex { return .apexEmerald }
        if index == selectedIndex { return .apexDanger }
        return .secondary
    }
}

struct DuelDetailView: View {
    let duel: BossDuel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Spacing.lg) {
                VStack(alignment: .leading, spacing: Spacing.sm) {
                    Text(duel.title)
                        .font(.title2.weight(.bold))
                    Text(duel.material)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text(duel.question)
                        .font(AppFont.cardTitle)
                }
                .cardSurface()

                solutionCard(path: duel.standard, color: .secondary)
                solutionCard(path: duel.weaponPath, color: .apexRed)

                VStack(alignment: .leading, spacing: Spacing.sm) {
                    SectionHeader(title: "为什么能快", systemImage: "sparkles", accent: .apexGold)
                    Text(duel.keyInsight)
                        .font(.subheadline)
                }
                .cardSurface()

                VStack(alignment: .leading, spacing: Spacing.sm) {
                    SectionHeader(title: "高分答案句", systemImage: "text.quote", accent: .apexTeal)
                    ForEach(Array(duel.sampleAnswer.enumerated()), id: \.offset) { index, sentence in
                        Text("\(index + 1). \(sentence)")
                            .font(.subheadline)
                    }
                }
                .cardSurface()
            }
            .padding(Spacing.lg)
            .readableWidth()
        }
        .background(Color.apexBackground.ignoresSafeArea())
        .navigationTitle("双解对决")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func solutionCard(path: SolutionPath, color: Color) -> some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            HStack {
                Text(path.title)
                    .font(AppFont.cardTitle)
                Spacer()
                TagChip(text: String(format: "%.1f 分钟", path.timeMinutes), color: color)
            }
            ForEach(Array(path.steps.enumerated()), id: \.offset) { index, step in
                HStack(alignment: .top, spacing: Spacing.sm) {
                    Text("\(index + 1)")
                        .font(AppFont.chip)
                        .foregroundColor(.white)
                        .frame(width: 20, height: 20)
                        .background(color)
                        .clipShape(Circle())
                    Text(step)
                        .font(.subheadline)
                }
            }
        }
        .cardSurface()
    }
}
