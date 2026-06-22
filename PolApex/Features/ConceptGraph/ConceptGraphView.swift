import SwiftUI

struct ConceptGraphView: View {
    @State private var selected: ConceptNode? = {
        ProcessInfo.processInfo.arguments.contains("-demoConceptDetail") ? ConceptGraphData.nodes.first : nil
    }()
    @State private var filterTopic: PoliticsTopic?

    private let canvasSize = CGSize(width: 1300, height: 1300)
    private var positions: [String: CGPoint] { Self.layout(nodes: ConceptGraphData.nodes, size: canvasSize) }

    private var topicsPresent: [PoliticsTopic] {
        PoliticsTopic.allCases.filter { topic in ConceptGraphData.nodes.contains { $0.topic == topic } }
    }

    private var visibleNodes: [ConceptNode] {
        guard let filterTopic else { return ConceptGraphData.nodes }
        return ConceptGraphData.nodes.filter { $0.topic == filterTopic }
    }

    private var visibleIds: Set<String> { Set(visibleNodes.map(\.id)) }

    /// 默认聚焦到当前可见节点里最密集的星团中心，而不是画布几何中心——
    /// 几何中心刚好落在环形排布的星团之间，是一片空地，会让人觉得"星图"是空的。
    private var focusPoint: CGPoint {
        let topic = filterTopic ?? densestTopic
        let nodesInTopic = visibleNodes.filter { $0.topic == topic }
        let points = nodesInTopic.compactMap { positions[$0.id] }
        guard !points.isEmpty else { return CGPoint(x: canvasSize.width / 2, y: canvasSize.height / 2) }
        let x = points.map(\.x).reduce(0, +) / CGFloat(points.count)
        let y = points.map(\.y).reduce(0, +) / CGFloat(points.count)
        return CGPoint(x: x, y: y)
    }

    private var densestTopic: PoliticsTopic {
        topicsPresent.max { a, b in
            ConceptGraphData.nodes.filter { $0.topic == a }.count < ConceptGraphData.nodes.filter { $0.topic == b }.count
        } ?? .politicsLaw
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                header
                topicFilterBar
                Divider()
                ScrollViewReader { proxy in
                    ScrollView([.horizontal, .vertical], showsIndicators: true) {
                        graphCanvas
                            .frame(width: canvasSize.width, height: canvasSize.height)
                    }
                    .onAppear { proxy.scrollTo("focusAnchor", anchor: .center) }
                    .onChange(of: filterTopic) { _ in
                        proxy.scrollTo("focusAnchor", anchor: .center)
                    }
                }
            }
            .background(Color.apexBackground.ignoresSafeArea())
            .navigationTitle("概念星图")
            .sheet(item: $selected) { node in
                ConceptDetailSheet(node: node)
            }
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            Text("节点按权重着色和大小区分，连线表示包含、对比、因果或主体职责关系。双指或拖动可平移画布，点节点看详情。")
                .font(.caption)
                .foregroundColor(.secondary)
                .fixedSize(horizontal: false, vertical: true)
            HStack {
                stat("\(ConceptGraphData.nodes.count)", "核心节点", .apexTeal)
                stat("\(ConceptGraphData.edges.count)", "关系边", .apexBlue)
                stat("\(ConceptGraphData.nodes.filter { $0.grade == .s }.count)", "S级", .apexRed)
            }
        }
        .padding(.horizontal, Spacing.lg)
        .padding(.top, Spacing.sm)
        .padding(.bottom, Spacing.md)
    }

    private var topicFilterBar: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: Spacing.sm) {
                filterChip(title: "全部", isOn: filterTopic == nil) { filterTopic = nil }
                ForEach(topicsPresent) { topic in
                    filterChip(title: topic.name, isOn: filterTopic == topic) { filterTopic = topic }
                }
            }
            .padding(.horizontal, Spacing.lg)
            .padding(.bottom, Spacing.sm)
        }
    }

    private func filterChip(title: String, isOn: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(title)
                .font(.caption.weight(isOn ? .bold : .regular))
                .foregroundColor(isOn ? .white : .primary)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(isOn ? Color.apexTeal : Color.apexCardSurface)
                .clipShape(Capsule())
        }
        .buttonStyle(.plain)
    }

    private func stat(_ value: String, _ label: String, _ color: Color) -> some View {
        VStack(spacing: 2) {
            Text(value)
                .font(AppFont.stat(20))
                .foregroundColor(color)
            Text(label)
                .font(.caption2)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
    }

    private var graphCanvas: some View {
        ZStack {
            Canvas { context, _ in
                for edge in ConceptGraphData.edges {
                    guard visibleIds.contains(edge.from), visibleIds.contains(edge.to),
                          let from = positions[edge.from], let to = positions[edge.to] else { continue }
                    var path = Path()
                    path.move(to: from)
                    path.addLine(to: to)
                    let highlighted = selected?.id == edge.from || selected?.id == edge.to
                    context.stroke(path,
                                    with: .color(highlighted ? Color.apexTeal.opacity(0.55) : Color.secondary.opacity(0.18)),
                                    lineWidth: highlighted ? 1.8 : 1)
                }
            }
            .frame(width: canvasSize.width, height: canvasSize.height)
            .allowsHitTesting(false)

            ForEach(visibleNodes) { node in
                if let point = positions[node.id] {
                    NodeBubble(node: node, isSelected: selected?.id == node.id)
                        .position(point)
                        .onTapGesture { selected = node }
                }
            }

            Color.clear
                .frame(width: 1, height: 1)
                .position(focusPoint)
                .id("focusAnchor")
        }
    }

    /// 按学科模块把节点分成若干"星团"，团内再按圆周摆开，
    /// 让"星图"真正长成有节点位置和连线的网络图，而不是卡片网格。
    private static func layout(nodes: [ConceptNode], size: CGSize) -> [String: CGPoint] {
        var result: [String: CGPoint] = [:]
        let topics = PoliticsTopic.allCases.filter { topic in nodes.contains { $0.topic == topic } }
        guard !topics.isEmpty else { return result }

        let center = CGPoint(x: size.width / 2, y: size.height / 2)
        let clusterRadius = min(size.width, size.height) * 0.30
        let angleStep = (2 * Double.pi) / Double(topics.count)

        for (index, topic) in topics.enumerated() {
            let clusterAngle = angleStep * Double(index) - .pi / 2
            let clusterCenter = CGPoint(
                x: center.x + clusterRadius * cos(clusterAngle),
                y: center.y + clusterRadius * sin(clusterAngle)
            )
            let nodesInTopic = nodes.filter { $0.topic == topic }
            let nodeRadius = 64.0 + Double(nodesInTopic.count) * 9
            let nodeAngleStep = (2 * Double.pi) / Double(max(nodesInTopic.count, 1))
            for (nodeIndex, node) in nodesInTopic.enumerated() {
                let nodeAngle = nodeAngleStep * Double(nodeIndex)
                result[node.id] = CGPoint(
                    x: clusterCenter.x + nodeRadius * cos(nodeAngle),
                    y: clusterCenter.y + nodeRadius * sin(nodeAngle)
                )
            }
        }
        return result
    }
}

private struct NodeBubble: View {
    let node: ConceptNode
    let isSelected: Bool

    private var bubbleSize: CGFloat {
        switch node.grade {
        case .s: return 70
        case .a: return 62
        case .b: return 54
        case .c: return 46
        }
    }

    var body: some View {
        Text(node.title)
            .font(.system(size: 10.5, weight: .semibold))
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
            .lineLimit(3)
            .minimumScaleFactor(0.7)
            .padding(4)
            .frame(width: bubbleSize, height: bubbleSize)
            .background(Circle().fill(Color.grade(node.grade)))
            .overlay(Circle().stroke(Color.white, lineWidth: isSelected ? 3 : 0))
            .shadow(color: .black.opacity(0.18), radius: isSelected ? 6 : 3, y: 1)
            .scaleEffect(isSelected ? 1.15 : 1)
            .animation(.spring(response: 0.3), value: isSelected)
    }
}

private struct ConceptDetailSheet: View {
    let node: ConceptNode
    @Environment(\.dismiss) private var dismiss

    private var edges: [ConceptEdge] { ConceptGraphData.related(to: node.id) }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: Spacing.md) {
                    VStack(alignment: .leading, spacing: Spacing.sm) {
                        Text(node.subtitle)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        HStack {
                            TagChip(text: "\(node.grade.rawValue)级", color: .grade(node.grade))
                            TagChip(text: node.topic.name, color: node.topic.stage.color)
                        }
                    }
                    .cardSurface()

                    VStack(alignment: .leading, spacing: Spacing.sm) {
                        SectionHeader(title: "材料触发词", systemImage: "scope", accent: .apexGold)
                        HStack {
                            ForEach(node.triggerWords, id: \.self) { word in
                                TagChip(text: word, color: .apexGold)
                            }
                        }
                    }
                    .cardSurface()

                    if !edges.isEmpty {
                        VStack(alignment: .leading, spacing: Spacing.sm) {
                            SectionHeader(title: "关系边（\(edges.count)）", systemImage: "arrow.triangle.branch", accent: .apexTeal)
                            ForEach(edges) { edge in
                                let otherId = edge.from == node.id ? edge.to : edge.from
                                let other = ConceptGraphData.concept(id: otherId)
                                NavigationLink {
                                    if let other {
                                        ConceptDetailSheet(node: other)
                                    }
                                } label: {
                                    HStack(alignment: .top, spacing: Spacing.sm) {
                                        Image(systemName: edge.from == node.id ? "arrow.right" : "arrow.left")
                                            .foregroundColor(.apexTeal)
                                        VStack(alignment: .leading, spacing: 2) {
                                            Text(other?.title ?? otherId)
                                                .font(.subheadline.weight(.semibold))
                                                .foregroundColor(.primary)
                                            Text(edge.relation)
                                                .font(.caption)
                                                .foregroundColor(.secondary)
                                        }
                                        Spacer(minLength: 0)
                                        Image(systemName: "chevron.right")
                                            .font(.caption2)
                                            .foregroundColor(.secondary)
                                    }
                                }
                                .buttonStyle(.plain)
                                .padding(.vertical, 4)
                            }
                        }
                        .cardSurface()
                    }
                }
                .padding(Spacing.lg)
                .readableWidth()
            }
            .background(Color.apexBackground.ignoresSafeArea())
            .navigationTitle(node.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("关闭") { dismiss() }
                }
            }
        }
        .presentationDetents([.medium, .large])
    }
}
