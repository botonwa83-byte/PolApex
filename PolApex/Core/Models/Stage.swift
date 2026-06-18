import SwiftUI

enum Stage: String, Codable, CaseIterable, Identifiable {
    case junior
    case required
    case elective
    case sprint

    var id: String { rawValue }

    var title: String {
        switch self {
        case .junior: return "初中 · 道法打底"
        case .required: return "高中必修 · 高考主战场"
        case .elective: return "选择性必修 · 案例与逻辑"
        case .sprint: return "冲刺 · 热点与答案"
        }
    }

    var shortTitle: String {
        switch self {
        case .junior: return "初中"
        case .required: return "必修"
        case .elective: return "选必"
        case .sprint: return "冲刺"
        }
    }

    var mark: String {
        switch self {
        case .junior: return "基"
        case .required: return "核"
        case .elective: return "拓"
        case .sprint: return "战"
        }
    }

    var subtitle: String {
        switch self {
        case .junior: return "生命成长 · 规则法治 · 国情责任"
        case .required: return "中特 · 经济 · 政治法治 · 哲学文化"
        case .elective: return "国际政治经济 · 法律生活 · 逻辑思维"
        case .sprint: return "时政转译 · 主观题高分表达"
        }
    }

    var color: Color {
        switch self {
        case .junior: return .stageJunior
        case .required: return .stageRequired
        case .elective: return .stageElective
        case .sprint: return .stageSprint
        }
    }
}
