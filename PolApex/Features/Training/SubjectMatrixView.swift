import SwiftUI

struct SubjectMatrixView: View {
    var body: some View {
        List {
            Section("主体职责速查") {
                ForEach(SubjectMatrixData.all) { subject in
                    NavigationLink { SubjectDetailView(subject: subject) } label: {
                        VStack(alignment: .leading, spacing: 5) {
                            Text(subject.title)
                                .font(AppFont.cardTitle)
                            Text(subject.role)
                                .font(.caption)
                                .foregroundColor(.secondary)
                            HStack {
                                ForEach(subject.triggerWords.prefix(3), id: \.self) { word in
                                    TagChip(text: word, color: .apexTeal)
                                }
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
        }
        .navigationTitle("政治主体矩阵")
    }
}

struct SubjectDetailView: View {
    let subject: SubjectResponsibility

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Spacing.lg) {
                VStack(alignment: .leading, spacing: Spacing.sm) {
                    Text(subject.title)
                        .font(.title2.weight(.bold))
                    Text(subject.role)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    HStack {
                        ForEach(subject.triggerWords, id: \.self) { word in
                            TagChip(text: word, color: .apexGold)
                        }
                    }
                }
                .cardSurface()

                bulletBlock("能做什么", icon: "checkmark.circle", color: .apexEmerald, items: subject.canDo)
                bulletBlock("不能写什么", icon: "xmark.octagon", color: .apexDanger, items: subject.cannotDo)

                VStack(alignment: .leading, spacing: Spacing.sm) {
                    SectionHeader(title: "关联考点", systemImage: "link", accent: .apexTeal)
                    ForEach(subject.knowledgeIds, id: \.self) { id in
                        if let point = MainLineData.knowledge(id: id) {
                            VStack(alignment: .leading, spacing: 3) {
                                HStack {
                                    Text(point.title)
                                        .font(AppFont.cardTitle)
                                    TagChip(text: "\(point.grade.rawValue)级", color: .grade(point.grade))
                                }
                                Text(point.detail)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            .padding(.vertical, 3)
                        }
                    }
                }
                .cardSurface()
            }
            .padding(Spacing.lg)
            .readableWidth()
        }
        .background(Color.apexBackground.ignoresSafeArea())
        .navigationTitle("主体详情")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func bulletBlock(_ title: String, icon: String, color: Color, items: [String]) -> some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            SectionHeader(title: title, systemImage: icon, accent: color)
            ForEach(items, id: \.self) { item in
                Label(item, systemImage: icon)
                    .font(.subheadline)
                    .foregroundColor(.primary)
            }
        }
        .cardSurface()
    }
}
