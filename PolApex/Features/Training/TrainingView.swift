import SwiftUI

struct TrainingView: View {
    @ObservedObject private var purchase = PurchaseManager.shared
    @State private var showPaywall = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: Spacing.lg) {
                    coverageDashboard
                    expansionModules
                    materialCases
                    subjectivePractice
                    memoryCards
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

    private var coverageDashboard: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            SectionHeader(title: "考点全覆盖", systemImage: "checklist.checked", accent: .apexTeal)
            HStack(spacing: Spacing.md) {
                stat("\(MainLineData.allKnowledgePoints.count)", "考点", .apexTeal)
                stat("\(QuestionBank.all.count)", "选择题", .apexBlue)
                stat("\(SubjectiveQuestionData.all.count)", "主观题", .apexRed)
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
        VStack(alignment: .leading, spacing: Spacing.md) {
            SectionHeader(title: "第一轮扩容模块", systemImage: "square.grid.2x2", accent: .apexBlue)
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

    private var subjectivePractice: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            SectionHeader(title: "S/A 主观题训练", systemImage: "text.append", accent: .apexRed)
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
                                TagChip(text: "答案句三件套", color: .apexTeal)
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

struct MaterialCaseDetailView: View {
    let item: MaterialCase

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
