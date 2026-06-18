import SwiftUI

enum PremiumContentPlan {
    static let title = "解锁政治提分闭环"
    static let tagline = "不是多给几道题，是把背诵、材料、题型和复习串成一套。"

    static var freeSummary: String {
        "免费已开放：初中道法 \(PurchaseManager.freeNodeCount) 关、\(PurchaseManager.freeWeaponCount) 把武器、\(PurchaseManager.freeMaterialCaseCount) 个材料案例、\(PurchaseManager.freeDuelCount) 个 Boss 双解。"
    }

    static var unlockSummary: String {
        "解锁后：高中必修/选必/冲刺主线、高考比例套练、非选择题题型池、材料切片、主体矩阵、Boss 双解和复习闭环全部开放。"
    }

    static var paywallFootnote: String {
        "一次买断，永久使用；无订阅、无续费，换机后可恢复购买。"
    }

    static var pillars: [PremiumPillar] {
        [
            PremiumPillar(
                icon: "map",
                title: "完整登顶主线",
                detail: "从初中道法到高中必修、选必和冲刺热点，\(MainLineData.nodes.count) 关按考试模块串起来。",
                metric: "\(MainLineData.nodes.count) 关"
            ),
            PremiumPillar(
                icon: "text.book.closed",
                title: "深度背诵考点",
                detail: "S/A 高频点不只一句话，包含必背原文、易混辨析、答题模板和高分答案句。",
                metric: "\(MainLineData.allKnowledgePoints.filter(\.hasDeepExplanation).count) 个深讲"
            ),
            PremiumPillar(
                icon: "pencil.and.list.clipboard",
                title: "高考比例套练",
                detail: "按 48 分选择题 + 52 分非选择题组织训练，不用题目数量冒充分值权重。",
                metric: "48/52"
            ),
            PremiumPillar(
                icon: "text.append",
                title: "非选择题题型池",
                detail: "覆盖材料分析、措施、意义、评析、开放探究，采分点和自查清单一起给。",
                metric: "\(SubjectiveQuestionType.allCases.count) 类"
            ),
            PremiumPillar(
                icon: "scissors",
                title: "材料题答案工厂",
                detail: "用主体、行为、对象、目标、知识点五刀切材料，再输出答案句。",
                metric: "\(MaterialCaseData.all.count) 案例"
            ),
            PremiumPillar(
                icon: "shield.lefthalf.filled",
                title: "秒杀武器库",
                detail: "主体矩阵、经济传导链、法治四层、哲学定位、主观题六步法等方法直接配题练。",
                metric: "\(WeaponGuideData.all.count) 把"
            ),
            PremiumPillar(
                icon: "bolt.shield",
                title: "Boss 双解对决",
                detail: "同一题对比常规解和武器解，展示为什么能更快、更稳、更像答案。",
                metric: "\(BossDuelData.all.count) 场"
            )
        ]
    }

    static var heroBenefits: [PremiumBenefit] {
        [
            PremiumBenefit(icon: "doc.text.magnifyingglass",
                           color: .apexLava,
                           title: "解锁 \(ExamPracticeData.all.count) 套高考比例套练",
                           detail: "按分值权重排题，\(AuthoredQuestionData.all.count) 道精编选择 + \(AuthoredSubjectiveQuestionData.all.count) 道精编主观，不用题库量冒充质量。"),
            PremiumBenefit(icon: "text.append",
                           color: .apexMystery,
                           title: "解锁非选择题题型池",
                           detail: "材料分析、措施、意义、评析、开放探究 \(SubjectiveQuestionType.allCases.count) 类题型，每题标分值、采分点和自查清单。"),
            PremiumBenefit(icon: "scissors",
                           color: .apexGold,
                           title: "解锁材料切片与答案工厂",
                           detail: "把材料拆成主体、行为、对象、目标、知识点，再输出原理句、材料句、结果句的标准答案。"),
            PremiumBenefit(icon: "tablecells",
                           color: .apexEmerald,
                           title: "解锁政治主体矩阵",
                           detail: "党、人大、政府、政协、公民、司法机关边界分清，根治政治题最常见的主体错配。"),
            PremiumBenefit(icon: "network",
                           color: .apexViolet,
                           title: "解锁概念星图",
                           detail: "\(ConceptGraphData.nodes.count) 个核心概念 + \(ConceptGraphData.edges.count) 条关系链，跨模块知识可视化串联。"),
            PremiumBenefit(icon: "text.book.closed.fill",
                           color: .apexTeal,
                           title: "解锁 \(MainLineData.allKnowledgePoints.filter(\.hasDeepExplanation).count) 个深度知识点",
                           detail: "S/A 级点八维深讲：原话、白话、模板、场景、辨析、陷阱、样例、清单，不是一句话考点。"),
            PremiumBenefit(icon: "shield.lefthalf.filled",
                           color: .apexStarBlue,
                           title: "解锁全套 \(WeaponGuideData.all.count) 把秒杀武器",
                           detail: "经济传导链、法治四层、哲学定位、矛盾三问、主观题六步法，每把武器都配题练。"),
            PremiumBenefit(icon: "bolt.shield",
                           color: .apexRed,
                           title: "解锁 \(BossDuelData.all.count) 场 Boss 双解对决",
                           detail: "同一道大题对比常规解和武器解，直观感受为什么高分答案更快更稳更准。"),
            PremiumBenefit(icon: "infinity",
                           color: .apexGold,
                           title: "一次买断，永久使用",
                           detail: "无订阅、无续费，内容持续更新，支持换机恢复购买，iOS 全设备通用。")
        ]
    }
}

struct PremiumPillar: Identifiable {
    let icon: String
    let title: String
    let detail: String
    let metric: String

    var id: String { title }
}

struct PremiumBenefit: Identifiable {
    let icon: String
    let color: Color
    let title: String
    let detail: String

    var id: String { title }
}
