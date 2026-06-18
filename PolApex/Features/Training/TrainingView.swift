import SwiftUI

struct TrainingView: View {
    @ObservedObject private var purchase = PurchaseManager.shared
    @State private var showPaywall = false
    @State private var showMoreTools = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: Spacing.xl) {
                    heroSection
                    coreTrainingSection
                    moreToolsSection
                    if !purchase.isUnlocked {
                        premiumFooterCard
                    }
                }
                .padding(Spacing.lg)
                .padding(.bottom, Spacing.xxl)
                .readableWidth()
            }
            .background(Color.apexBackground.ignoresSafeArea())
            .navigationTitle("答案工厂")
            .sheet(isPresented: $showPaywall) { PaywallView() }
        }
    }

    // MARK: - 新布局分区

    private var heroSection: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            Text("答案工厂")
                .font(.title2.weight(.bold))
            Text("学 → 练 → 拆 → 复，形成提分闭环")
                .font(.subheadline)
                .foregroundColor(.secondary)
            HStack(spacing: Spacing.sm) {
                heroStep("学", "主线考点", .apexLava)
                heroStep("练", "选择/主观", .apexBlue)
                heroStep("拆", "材料切片", .apexGold)
                heroStep("复", "错题复习", .apexTeal)
            }
        }
        .padding(Spacing.lg)
        .background(
            LinearGradient(colors: [Color.apexLava.opacity(0.08), Color.apexGold.opacity(0.05)],
                          startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .clipShape(RoundedRectangle(cornerRadius: Radius.card))
    }

    private func heroStep(_ mark: String, _ title: String, _ color: Color) -> some View {
        VStack(spacing: 6) {
            Text(mark)
                .font(.title3.weight(.bold))
                .foregroundColor(.white)
                .frame(width: 36, height: 36)
                .background(color)
                .clipShape(Circle())
            Text(title)
                .font(.caption2)
                .foregroundColor(.secondary)
                .lineLimit(1)
        }
        .frame(maxWidth: .infinity)
    }

    private var coreTrainingSection: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            Text("王牌训练")
                .font(.headline.weight(.semibold))
                .foregroundColor(.secondary)
            VStack(spacing: Spacing.sm) {
                examPracticeSection
                materialCases
                bossDuels
            }
        }
    }

    private var moreToolsSection: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            Button {
                withAnimation(.easeInOut(duration: 0.25)) {
                    showMoreTools.toggle()
                }
            } label: {
                HStack {
                    Text("更多工具")
                        .font(.headline.weight(.semibold))
                        .foregroundColor(.secondary)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .rotationEffect(.degrees(showMoreTools ? 180 : 0))
                        .animation(.easeInOut(duration: 0.25), value: showMoreTools)
                }
                .padding(.horizontal, 2)
            }
            .buttonStyle(.plain)

            if showMoreTools {
                VStack(spacing: Spacing.sm) {
                    methodModules
                    subjectivePractice
                    memoryCards
                    coverageDashboard
                }
                .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
    }

    private var premiumFooterCard: some View {
        Button { showPaywall = true } label: {
            HStack(spacing: Spacing.md) {
                Image(systemName: "crown.fill")
                    .font(.title2)
                    .foregroundColor(.apexGold)
                VStack(alignment: .leading, spacing: 2) {
                    Text(PremiumContentPlan.title)
                        .font(.subheadline.weight(.semibold))
                        .foregroundColor(.primary)
                    Text("解锁全部内容，冲刺高分")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding(Spacing.md)
            .background(Color.apexGold.opacity(0.08))
            .clipShape(RoundedRectangle(cornerRadius: Radius.card))
        }
        .buttonStyle(.plain)
    }

    private var coverageDashboard: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            SectionHeader(title: "考点全覆盖", systemImage: "checklist.checked", accent: .apexTeal)
            HStack(spacing: Spacing.md) {
                stat("\(MainLineData.allKnowledgePoints.count)", "考点", .apexTeal)
                stat("\(QuestionBank.all.count)", "选择题", .apexBlue)
                stat("\(SubjectiveQuestionData.all.count)", "非选择题", .apexRed)
            }
            HStack(spacing: Spacing.sm) {
                ForEach(ImportanceGrade.allCases.reversed()) { grade in
                    let count = MainLineData.allKnowledgePoints.filter { $0.grade == grade }.count
                    TagChip(text: "\(grade.rawValue) \(count)", color: .grade(grade))
                }
            }
        }
        .cardSurface()
    }

    private var examPracticeSection: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            SectionHeader(title: "高考比例套练", systemImage: "doc.text.magnifyingglass", accent: .apexLava)
            HStack(spacing: Spacing.md) {
                stat("\(ExamPracticeBlueprint.choiceScore)", "选择题分", .apexBlue)
                stat("\(ExamPracticeBlueprint.subjectiveScore)", "非选择分", .apexRed)
                stat("\(ExamPracticeBlueprint.choiceQuestionCount)+\(ExamPracticeBlueprint.subjectiveQuestionCount)", "题型结构", .apexGold)
            }
            Text(ExamPracticeBlueprint.sourceNote)
                .font(.caption)
                .foregroundColor(.secondary)
            ForEach(ExamPracticeData.all.prefix(3)) { set in
                NavigationLink { ExamPracticeSetView(set: set) } label: {
                    HStack(spacing: Spacing.md) {
                        Image(systemName: "timer")
                            .font(.title3)
                            .frame(width: 42, height: 42)
                            .background(Color.apexLava.opacity(0.12))
                            .foregroundColor(.apexLava)
                            .clipShape(RoundedRectangle(cornerRadius: Radius.inner))
                        VStack(alignment: .leading, spacing: 3) {
                            Text(set.title)
                                .font(AppFont.cardTitle)
                                .foregroundColor(.primary)
                            Text("按分值配比：选择题 \(set.choiceScore) 分 + 非选择题 \(set.subjectiveScore) 分")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        Spacer(minLength: 0)
                        Image(systemName: "chevron.right")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .cardSurface()
                }
                .buttonStyle(.plain)
            }
        }
    }

    private func stat(_ value: String, _ label: String, _ color: Color) -> some View {
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

    private var expansionModules: some View {
        methodModules
    }

    private var learningLoop: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            SectionHeader(title: "提分闭环", systemImage: "arrow.triangle.2.circlepath", accent: .apexLava)
            HStack(spacing: Spacing.sm) {
                loopStep("学", "主线考点", .apexLava)
                loopStep("练", "选择/主观", .apexBlue)
                loopStep("拆", "材料切片", .apexGold)
                loopStep("复", "错题复习", .apexTeal)
            }
            Text("下面每个模块都接回题库：看完方法后直接练关联选择题和主观题。")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .cardSurface()
    }

    private func loopStep(_ mark: String, _ title: String, _ color: Color) -> some View {
        VStack(spacing: 4) {
            Text(mark)
                .font(AppFont.cardTitle)
                .foregroundColor(.white)
                .frame(width: 30, height: 30)
                .background(color)
                .clipShape(Circle())
            Text(title)
                .font(.caption2)
                .foregroundColor(.secondary)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
        }
        .frame(maxWidth: .infinity)
    }

    @ViewBuilder
    private var premiumValueCard: some View {
        if !purchase.isUnlocked {
            Button { showPaywall = true } label: {
                VStack(alignment: .leading, spacing: Spacing.md) {
                    HStack(spacing: Spacing.md) {
                        Image(systemName: "crown.fill")
                            .font(.title3)
                            .foregroundColor(.apexGold)
                            .frame(width: 42, height: 42)
                            .background(Color.apexGold.opacity(0.12))
                            .clipShape(RoundedRectangle(cornerRadius: Radius.inner))
                        VStack(alignment: .leading, spacing: 3) {
                            Text(PremiumContentPlan.title)
                                .font(AppFont.cardTitle)
                                .foregroundColor(.primary)
                            Text(PremiumContentPlan.unlockSummary)
                                .font(.caption)
                                .foregroundColor(.secondary)
                                .lineLimit(2)
                        }
                        Spacer(minLength: 0)
                        TagChip(text: purchase.product?.displayPrice ?? "¥22", color: .apexGold)
                    }
                    HStack(spacing: Spacing.sm) {
                        ForEach(PremiumContentPlan.pillars.prefix(3)) { pillar in
                            TagChip(text: pillar.metric, color: .apexLava)
                        }
                    }
                }
                .cardSurface()
            }
            .buttonStyle(.plain)
        }
    }

    private var methodModules: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            SectionHeader(title: "方法训练区", systemImage: "square.grid.2x2", accent: .apexBlue)
            NavigationLink { ReviewView() } label: {
                expansionRow(icon: "calendar.badge.clock",
                             title: "智能复习",
                             subtitle: "按 S/A/B/C 权重安排复习间隔",
                             value: "\(ReviewProgressManager.shared.dueCards.count)")
            }
            .buttonStyle(.plain)

            NavigationLink { TrapDrillView() } label: {
                expansionRow(icon: "exclamationmark.triangle",
                             title: "选择题排雷靶场",
                             subtitle: "主体错配、绝对化、因果倒置等六类错因",
                             value: "\(TrapDrillData.all.count)")
            }
            .buttonStyle(.plain)

            NavigationLink { SubjectMatrixView() } label: {
                expansionRow(icon: "tablecells",
                             title: "政治主体矩阵",
                             subtitle: "党、人大、政府、政协、公民等职责边界",
                             value: "\(SubjectMatrixData.all.count)")
            }
            .buttonStyle(.plain)

            NavigationLink { AnswerTemplateView() } label: {
                expansionRow(icon: "doc.text",
                             title: "答案模板库",
                             subtitle: "原因、措施、意义、体现、哲学、评析",
                             value: "\(AnswerTemplateData.all.count)")
            }
            .buttonStyle(.plain)

            NavigationLink { WeaponShelfView() } label: {
                expansionRow(icon: "shield.lefthalf.filled",
                             title: "秒杀武器库",
                             subtitle: "每把武器都接回关联选择题和主观题",
                             value: "\(WeaponGuideData.all.count)")
            }
            .buttonStyle(.plain)
        }
    }

    private func expansionRow(icon: String, title: String, subtitle: String, value: String) -> some View {
        HStack(spacing: Spacing.md) {
            Image(systemName: icon)
                .font(.title3)
                .frame(width: 42, height: 42)
                .background(Color.apexBlue.opacity(0.12))
                .foregroundColor(.apexBlue)
                .clipShape(RoundedRectangle(cornerRadius: Radius.inner))
            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                    .font(AppFont.cardTitle)
                    .foregroundColor(.primary)
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }
            Spacer(minLength: 0)
            TagChip(text: value, color: .apexBlue)
        }
        .cardSurface()
    }

    private var materialCases: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            SectionHeader(title: "材料切片机", systemImage: "scissors", accent: .apexGold)
            ForEach(Array(MaterialCaseData.all.enumerated()), id: \.element.id) { index, item in
                if purchase.isMaterialCasePremiumLocked(index: index) {
                    Button { showPaywall = true } label: {
                        MaterialCaseRow(item: item, locked: true)
                    }
                    .buttonStyle(.plain)
                } else {
                    NavigationLink { MaterialCaseDetailView(item: item) } label: {
                        MaterialCaseRow(item: item, locked: false)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }

    private var bossDuels: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            SectionHeader(title: "Boss 双解对决", systemImage: "bolt.shield", accent: .apexRed)
            ForEach(Array(BossDuelData.all.enumerated()), id: \.element.id) { index, duel in
                if purchase.isDuelPremiumLocked(index: index) {
                    Button { showPaywall = true } label: {
                        BossDuelTrainingRow(duel: duel, locked: true)
                    }
                    .buttonStyle(.plain)
                } else {
                    NavigationLink { DuelDetailView(duel: duel) } label: {
                        BossDuelTrainingRow(duel: duel, locked: false)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }

    private var subjectivePractice: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            SectionHeader(title: "S/A 非选择题训练", systemImage: "text.append", accent: .apexRed)
            ForEach(SubjectiveQuestionData.all.prefix(12)) { item in
                NavigationLink { SubjectiveQuestionDetailView(item: item) } label: {
                    HStack(spacing: Spacing.md) {
                        Image(systemName: "pencil.and.list.clipboard")
                            .font(.title3)
                            .frame(width: 42, height: 42)
                            .background(Color.grade(item.grade).opacity(0.12))
                            .foregroundColor(.grade(item.grade))
                            .clipShape(RoundedRectangle(cornerRadius: Radius.inner))
                        VStack(alignment: .leading, spacing: 3) {
                            Text(item.prompt)
                                .font(AppFont.cardTitle)
                                .foregroundColor(.primary)
                                .lineLimit(2)
                            HStack {
                                TagChip(text: "\(item.grade.rawValue)级", color: .grade(item.grade))
                                TagChip(text: item.questionType.shortName, color: .apexTeal)
                                TagChip(text: "\(item.score)分", color: .apexRed)
                            }
                        }
                        Spacer(minLength: 0)
                        Image(systemName: "chevron.right")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .cardSurface()
                }
                .buttonStyle(.plain)
            }
        }
    }

    private var memoryCards: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            SectionHeader(title: "高权重记忆引擎", systemImage: "brain.head.profile", accent: .apexViolet)
            ForEach(MemoryCardType.allCases) { type in
                NavigationLink { MemoryCardListView(type: type) } label: {
                    let count = MemoryData.cards(type: type).count
                    HStack {
                        Text(type.rawValue)
                            .font(AppFont.cardTitle)
                            .foregroundColor(.primary)
                        Spacer()
                        Text("\(count) 张")
                            .font(.caption)
                            .foregroundColor(.secondary)
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
}

private struct MaterialCaseRow: View {
    let item: MaterialCase
    let locked: Bool

    var body: some View {
        HStack(spacing: Spacing.md) {
            Image(systemName: locked ? "crown.fill" : "doc.text.magnifyingglass")
                .font(.title3)
                .frame(width: 42, height: 42)
                .background((locked ? Color.apexGold : Color.apexTeal).opacity(0.12))
                .foregroundColor(locked ? .apexGold : .apexTeal)
                .clipShape(RoundedRectangle(cornerRadius: Radius.inner))
            VStack(alignment: .leading, spacing: 3) {
                Text(item.title)
                    .font(AppFont.cardTitle)
                    .foregroundColor(.primary)
                Text("\(item.subject) · \(item.goal)")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            }
            Spacer(minLength: 0)
            if locked {
                TagChip(text: "完整版", color: .apexGold)
            } else {
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .cardSurface()
    }
}

private struct BossDuelTrainingRow: View {
    let duel: BossDuel
    let locked: Bool

    var body: some View {
        HStack(spacing: Spacing.md) {
            Image(systemName: locked ? "crown.fill" : duel.weapon.icon)
                .font(.title3)
                .frame(width: 42, height: 42)
                .background((locked ? Color.apexGold : Color.apexRed).opacity(0.12))
                .foregroundColor(locked ? .apexGold : .apexRed)
                .clipShape(RoundedRectangle(cornerRadius: Radius.inner))
            VStack(alignment: .leading, spacing: 3) {
                Text(duel.title)
                    .font(AppFont.cardTitle)
                    .foregroundColor(.primary)
                Text(duel.keyInsight)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                HStack(spacing: Spacing.sm) {
                    TagChip(text: duel.weapon.name, color: .apexRed)
                    TagChip(text: "\(PracticeLinker.choiceQuestions(for: duel).count) 题", color: .apexBlue)
                }
            }
            Spacer(minLength: 0)
            if locked {
                TagChip(text: "完整版", color: .apexGold)
            } else {
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .cardSurface()
    }
}

struct MaterialCaseDetailView: View {
    let item: MaterialCase
    private var choiceQuestions: [PoliticsQuestion] { PracticeLinker.choiceQuestions(for: item) }
    private var subjectiveQuestions: [SubjectiveQuestion] { PracticeLinker.subjectiveQuestions(for: item) }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Spacing.lg) {
                VStack(alignment: .leading, spacing: Spacing.sm) {
                    Text(item.title)
                        .font(.title2.weight(.bold))
                    Text(item.material)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text(item.question)
                        .font(AppFont.cardTitle)
                }
                .cardSurface()

                slicerGrid
                answerBlock
                linkedPracticeBlock
                diagnosticsBlock
            }
            .padding(Spacing.lg)
            .readableWidth()
        }
        .background(Color.apexBackground.ignoresSafeArea())
        .navigationTitle("材料切片")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var slicerGrid: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            SectionHeader(title: "五刀切开", systemImage: "scissors", accent: .apexGold)
            slice("主体", item.subject, .apexRed)
            slice("行为", item.action, .apexTeal)
            slice("对象", item.object, .apexBlue)
            slice("目标", item.goal, .apexGold)
            slice("召回考点", item.knowledgeIds.compactMap { MainLineData.knowledge(id: $0)?.title }.joined(separator: "、"), .apexViolet)
        }
        .cardSurface()
    }

    private func slice(_ title: String, _ value: String, _ color: Color) -> some View {
        HStack(alignment: .top, spacing: Spacing.md) {
            TagChip(text: title, color: color)
            Text(value)
                .font(.subheadline)
            Spacer(minLength: 0)
        }
    }

    private var answerBlock: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            SectionHeader(title: "答案句", systemImage: "text.quote", accent: .apexTeal)
            ForEach(Array(item.answerSentences.enumerated()), id: \.offset) { index, sentence in
                Text("\(index + 1). \(sentence)")
                    .font(.subheadline)
            }
        }
        .cardSurface()
    }

    private var linkedPracticeBlock: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            SectionHeader(title: "关联练习", systemImage: "pencil.and.list.clipboard", accent: .apexBlue)
            ForEach(subjectiveQuestions.prefix(4)) { question in
                NavigationLink { SubjectiveQuestionDetailView(item: question) } label: {
                    practiceLine(question.prompt, subtitle: "主观题", color: .apexRed)
                }
                .buttonStyle(.plain)
            }
            ForEach(choiceQuestions.prefix(4)) { question in
                NavigationLink { QuestionDetailView(question: question) } label: {
                    practiceLine(question.prompt, subtitle: "选择题", color: .apexBlue)
                }
                .buttonStyle(.plain)
            }
        }
        .cardSurface()
    }

    private func practiceLine(_ title: String, subtitle: String, color: Color) -> some View {
        HStack(spacing: Spacing.md) {
            TagChip(text: subtitle, color: color)
            Text(title)
                .font(.subheadline)
                .foregroundColor(.primary)
                .lineLimit(2)
            Spacer(minLength: 0)
        }
        .padding(.vertical, 3)
    }

    private var diagnosticsBlock: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            SectionHeader(title: "扣分提醒", systemImage: "exclamationmark.triangle", accent: .apexDanger)
            ForEach(item.diagnostics, id: \.self) { text in
                Label(text, systemImage: "checkmark.circle")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .cardSurface()
    }
}

struct SubjectiveQuestionDetailView: View {
    let item: SubjectiveQuestion

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Spacing.lg) {
                VStack(alignment: .leading, spacing: Spacing.sm) {
                    TagChip(text: "\(item.grade.rawValue)级", color: .grade(item.grade))
                    TagChip(text: item.questionType.rawValue, color: .apexTeal)
                    TagChip(text: "\(item.score)分", color: .apexRed)
                    Text(item.material)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text(item.prompt)
                        .font(.title3.weight(.bold))
                }
                .cardSurface()

                VStack(alignment: .leading, spacing: Spacing.sm) {
                    SectionHeader(title: "采分点", systemImage: "list.bullet.clipboard", accent: .apexRed)
                    ForEach(Array(item.answerPoints.enumerated()), id: \.offset) { index, point in
                        Text("\(index + 1). \(point)")
                            .font(.subheadline)
                    }
                }
                .cardSurface()

                VStack(alignment: .leading, spacing: Spacing.sm) {
                    SectionHeader(title: "自查清单", systemImage: "checkmark.seal", accent: .apexTeal)
                    ForEach(item.diagnostics, id: \.self) { text in
                        Label(text, systemImage: "square")
                            .font(.subheadline)
                    }
                }
                .cardSurface()
            }
            .padding(Spacing.lg)
            .readableWidth()
        }
        .background(Color.apexBackground.ignoresSafeArea())
        .navigationTitle("主观题训练")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ExamPracticeSetView: View {
    let set: ExamPracticeSet

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Spacing.lg) {
                VStack(alignment: .leading, spacing: Spacing.md) {
                    Text(set.title)
                        .font(.title2.weight(.bold))
                    Text(ExamPracticeBlueprint.sourceNote)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    HStack(spacing: Spacing.md) {
                        scoreBlock("\(set.choiceScore)", "选择题分", .apexBlue)
                        scoreBlock("\(set.subjectiveScore)", "非选择分", .apexRed)
                    }
                }
                .cardSurface()

                VStack(alignment: .leading, spacing: Spacing.md) {
                    SectionHeader(title: "一、单项选择题（48分）", systemImage: "checkmark.seal", accent: .apexBlue)
                    ForEach(Array(set.choiceQuestions.enumerated()), id: \.element.id) { index, question in
                        NavigationLink { QuestionDetailView(question: question) } label: {
                            practiceRow("\(index + 1). \(question.prompt)",
                                        subtitle: MainLineData.knowledge(id: question.knowledgeId)?.title,
                                        color: .apexBlue)
                        }
                        .buttonStyle(.plain)
                    }
                }

                VStack(alignment: .leading, spacing: Spacing.md) {
                    SectionHeader(title: "二、非选择题（52分）", systemImage: "text.append", accent: .apexRed)
                    ForEach(Array(set.subjectiveQuestions.enumerated()), id: \.element.id) { index, question in
                        NavigationLink { SubjectiveQuestionDetailView(item: question) } label: {
                            practiceRow("\(index + 17). \(question.prompt)",
                                        subtitle: "\(question.questionType.rawValue) · \(question.score)分 · \(MainLineData.knowledge(id: question.knowledgeId)?.title ?? "")",
                                        color: .apexRed)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .padding(Spacing.lg)
            .readableWidth()
        }
        .background(Color.apexBackground.ignoresSafeArea())
        .navigationTitle("高考比例套练")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func scoreBlock(_ value: String, _ title: String, _ color: Color) -> some View {
        VStack(spacing: 2) {
            Text(value)
                .font(AppFont.stat(24))
                .foregroundColor(color)
            Text(title)
                .font(.caption2)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
    }

    private func practiceRow(_ title: String, subtitle: String?, color: Color) -> some View {
        HStack(spacing: Spacing.md) {
            Image(systemName: "arrow.right.circle")
                .foregroundColor(color)
                .frame(width: 24)
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(.primary)
                    .lineLimit(2)
                if let subtitle {
                    Text(subtitle)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            Spacer(minLength: 0)
        }
        .cardSurface(padding: Spacing.md)
    }
}

struct MemoryCardListView: View {
    let type: MemoryCardType

    private var cards: [MemoryCard] { MemoryData.cards(type: type) }

    var body: some View {
        List(cards) { card in
            VStack(alignment: .leading, spacing: Spacing.sm) {
                HStack {
                    Text(card.front)
                        .font(AppFont.cardTitle)
                    Spacer()
                    TagChip(text: "\(card.grade.rawValue)级", color: .grade(card.grade))
                }
                Text(card.back)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding(.vertical, 4)
        }
        .navigationTitle(type.rawValue)
    }
}
