import SwiftUI

struct AscentPathView: View {
    @EnvironmentObject var progress: ProgressManager
    @ObservedObject private var purchase = PurchaseManager.shared
    @State private var showPaywall = false
    @State private var demoNodeActive = ProcessInfo.processInfo.arguments.contains("-demoNodeDetail")

    private var nodes: [LearningNode] { MainLineData.nodes }
    private var recommended: LearningNode? { progress.currentNode(in: nodes) }
    private var demoNode: LearningNode? {
        nodes.first { $0.knowledgePoints.contains { $0.id == "k1301" } }
            ?? nodes.first { $0.knowledgePoints.contains { $0.hasDeepExplanation } }
    }

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
            .navigationDestination(isPresented: $demoNodeActive) {
                if let demoNode { NodeDetailView(node: demoNode) }
            }
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
                KnowledgePointStudyCard(point: point)
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

struct KnowledgePointStudyCard: View {
    let point: KnowledgePoint
    @State private var expandedBlocks: Set<String>

    init(point: KnowledgePoint, defaultExpanded: Set<String> = ["必背原文", "白话理解"]) {
        self.point = point
        _expandedBlocks = State(initialValue: defaultExpanded)
    }

    private var allBlocks: [(title: String, icon: String, color: Color, lines: [String])] {
        var blocks: [(title: String, icon: String, color: Color, lines: [String])] = []
        blocks.append((title: "必背原文", icon: "text.book.closed", color: .apexRed, lines: point.mustReciteLines))
        if !point.explanation.plainExplanation.isEmpty {
            blocks.append((title: "白话理解", icon: "lightbulb", color: .apexGold, lines: [point.explanation.plainExplanation]))
        }
        blocks.append((title: "答题模板", icon: "text.append", color: .apexTeal, lines: point.explanation.answerTemplate))
        blocks.append((title: "材料触发", icon: "scope", color: .apexBlue, lines: point.explanation.triggerScenes))
        blocks.append((title: "易混辨析", icon: "arrow.left.arrow.right", color: .apexViolet, lines: point.explanation.confusions))
        blocks.append((title: "高分答案句", icon: "text.quote", color: .apexEmerald, lines: point.sampleAnswerSentences))
        blocks.append((title: "扣分提醒", icon: "exclamationmark.triangle", color: .apexDanger, lines: point.commonTrapLines))
        blocks.append((title: "默写清单", icon: "checkmark.seal", color: .apexTeal, lines: point.explanation.reciteChecklist))
        return blocks.filter { !$0.lines.isEmpty }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 3) {
                    Text(point.title)
                        .font(AppFont.cardTitle)
                    Text(point.detail)
                        .font(.subheadline)
                        .foregroundColor(.primary)
                }
                Spacer(minLength: 0)
                VStack(alignment: .trailing, spacing: 4) {
                    TagChip(text: "\(point.grade.rawValue)级", color: .grade(point.grade))
                    TagChip(text: point.cardType.rawValue, color: .apexBlue)
                    if point.hasDeepExplanation {
                        TagChip(text: "深度讲解", color: .apexGold)
                    }
                }
            }
            .padding(.bottom, Spacing.xs)

            if point.hasDeepExplanation {
                ForEach(allBlocks, id: \.title) { block in
                    collapsibleBlock(title: block.title, icon: block.icon, color: block.color, lines: block.lines)
                }
            } else if let pitfall = point.pitfall {
                Label(pitfall, systemImage: "exclamationmark.triangle")
                    .font(.caption)
                    .foregroundColor(.apexDanger)
            }
        }
        .cardSurface(padding: Spacing.md)
    }

    @ViewBuilder
    private func collapsibleBlock(title: String, icon: String, color: Color, lines: [String]) -> some View {
        let isExpanded = expandedBlocks.contains(title)
        VStack(alignment: .leading, spacing: Spacing.xs) {
            Button {
                withAnimation(.easeInOut(duration: 0.2)) {
                    if isExpanded {
                        expandedBlocks.remove(title)
                    } else {
                        expandedBlocks.insert(title)
                    }
                }
            } label: {
                HStack(spacing: Spacing.sm) {
                    Image(systemName: icon)
                        .font(.caption)
                        .foregroundColor(color)
                        .frame(width: 16)
                    Text(title)
                        .font(.subheadline.weight(.semibold))
                        .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                        .rotationEffect(.degrees(isExpanded ? 180 : 0))
                        .animation(.easeInOut(duration: 0.2), value: isExpanded)
                }
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)

            if isExpanded {
                VStack(alignment: .leading, spacing: Spacing.xs) {
                    ForEach(Array(lines.enumerated()), id: \.offset) { index, line in
                        HStack(alignment: .top, spacing: Spacing.sm) {
                            Text("\(index + 1).")
                                .font(.caption.weight(.semibold))
                                .foregroundColor(color)
                                .frame(width: 20, alignment: .leading)
                            Text(line)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .padding(.leading, 22)
                .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
        .padding(.vertical, 4)
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
                .padding(Spacing.lg)
                .background(Color.apexSurface)
                .clipShape(RoundedRectangle(cornerRadius: Radius.card))

                VStack(spacing: 0) {
                    ForEach(Array(question.options.enumerated()), id: \.offset) { index, option in
                        Button {
                            selectedIndex = index
                            progress.record(question, correct: index == question.answerIndex)
                        } label: {
                            HStack(spacing: Spacing.md) {
                                Text(String(UnicodeScalar(65 + index)!))
                                    .font(.subheadline.weight(.semibold))
                                    .frame(width: 28, height: 28)
                                    .background(optionColor(index).opacity(0.14))
                                    .foregroundColor(optionColor(index))
                                    .clipShape(Circle())
                                Text(option)
                                    .font(.subheadline)
                                    .foregroundColor(.primary)
                                    .multilineTextAlignment(.leading)
                                Spacer(minLength: 0)
                                if selectedIndex == question.answerIndex && index == question.answerIndex {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.apexEmerald)
                                } else if selectedIndex == index && index != question.answerIndex {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.apexDanger)
                                }
                            }
                            .padding(.vertical, Spacing.md)
                            .contentShape(Rectangle())
                        }
                        .buttonStyle(.plain)

                        if index < question.options.count - 1 {
                            Divider()
                                .padding(.leading, 40)
                        }
                    }
                }
                .padding(.horizontal, Spacing.lg)
                .background(Color.apexSurface)
                .clipShape(RoundedRectangle(cornerRadius: Radius.card))

                if let selectedIndex {
                    let isCorrect = selectedIndex == question.answerIndex
                    VStack(alignment: .leading, spacing: Spacing.md) {
                        HStack(spacing: Spacing.md) {
                            Image(systemName: isCorrect ? "checkmark.circle.fill" : "xmark.circle.fill")
                                .font(.title2)
                                .foregroundColor(isCorrect ? .apexEmerald : .apexDanger)
                            VStack(alignment: .leading, spacing: 2) {
                                Text(isCorrect ? "答对了！" : "再想想～")
                                    .font(.headline.weight(.bold))
                                    .foregroundColor(isCorrect ? .apexEmerald : .apexDanger)
                                Text(isCorrect ? "陷阱都避开了，很棒！" : "这道题的陷阱很经典，来看看解析。")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                        }

                        VStack(alignment: .leading, spacing: Spacing.sm) {
                            Label("解析", systemImage: "lightbulb.fill")
                                .font(.subheadline.weight(.semibold))
                                .foregroundColor(.apexGold)
                            Text(question.explanation)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }

                        if !question.trapTags.isEmpty {
                            HStack(spacing: Spacing.sm) {
                                Image(systemName: "exclamationmark.triangle.fill")
                                    .foregroundColor(.apexDanger)
                                    .font(.caption)
                                ForEach(question.trapTags, id: \.self) { tag in
                                    TagChip(text: tag, color: .apexDanger)
                                }
                            }
                        }

                        if let weapon = question.weapon {
                            HStack(spacing: Spacing.sm) {
                                Image(systemName: weapon.icon)
                                    .foregroundColor(.apexMystery)
                                Text(weapon.rawValue)
                                    .font(.subheadline.weight(.medium))
                                    .foregroundColor(.apexMystery)
                                Spacer()
                            }
                            .padding(.horizontal, Spacing.md)
                            .padding(.vertical, Spacing.sm)
                            .background(Color.apexMystery.opacity(0.1))
                            .clipShape(RoundedRectangle(cornerRadius: Radius.inner))
                        }
                    }
                    .padding(Spacing.lg)
                    .background(Color.apexSurface)
                    .clipShape(RoundedRectangle(cornerRadius: Radius.card))
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
