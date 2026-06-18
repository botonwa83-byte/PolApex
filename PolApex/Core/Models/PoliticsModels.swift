import Foundation

enum ImportanceGrade: String, Codable, CaseIterable, Identifiable, Comparable {
    case s = "S"
    case a = "A"
    case b = "B"
    case c = "C"

    var id: String { rawValue }

    var scoreRange: String {
        switch self {
        case .s: return "90-100"
        case .a: return "75-89"
        case .b: return "55-74"
        case .c: return "0-54"
        }
    }

    var reviewIntervals: [Int] {
        switch self {
        case .s: return [1, 2, 4, 7, 15, 30]
        case .a: return [1, 3, 7, 15, 30, 60]
        case .b: return [2, 7, 15, 30, 60]
        case .c: return [7, 30, 60]
        }
    }

    static func < (lhs: ImportanceGrade, rhs: ImportanceGrade) -> Bool {
        lhs.rank < rhs.rank
    }

    private var rank: Int {
        switch self {
        case .s: return 3
        case .a: return 2
        case .b: return 1
        case .c: return 0
        }
    }
}

enum MemoryCardType: String, Codable, CaseIterable, Identifiable {
    case original = "原话卡"
    case boundary = "边界卡"
    case subject = "主体卡"
    case scene = "场景卡"
    case template = "模板卡"

    var id: String { rawValue }
}

enum RecallMode: String, Codable, CaseIterable, Identifiable {
    case recognize = "认得出"
    case recite = "背得出"
    case distinguish = "分得清"
    case apply = "用得上"

    var id: String { rawValue }
}

enum PoliticsTopic: String, Codable, CaseIterable, Identifiable {
    case juniorGrowth
    case juniorLaw
    case juniorNation
    case socialism
    case economy
    case politicsLaw
    case philosophyCulture
    case international
    case legalLife
    case logicThinking
    case sprint

    var id: String { rawValue }

    var name: String {
        switch self {
        case .juniorGrowth: return "成长与社会"
        case .juniorLaw: return "宪法与法治"
        case .juniorNation: return "国情与责任"
        case .socialism: return "中国特色社会主义"
        case .economy: return "经济与社会"
        case .politicsLaw: return "政治与法治"
        case .philosophyCulture: return "哲学与文化"
        case .international: return "当代国际政治与经济"
        case .legalLife: return "法律与生活"
        case .logicThinking: return "逻辑与思维"
        case .sprint: return "冲刺综合"
        }
    }

    var stage: Stage {
        switch self {
        case .juniorGrowth, .juniorLaw, .juniorNation: return .junior
        case .socialism, .economy, .politicsLaw, .philosophyCulture: return .required
        case .international, .legalLife, .logicThinking: return .elective
        case .sprint: return .sprint
        }
    }

    var icon: String {
        switch self {
        case .juniorGrowth: return "person.crop.circle.badge.checkmark"
        case .juniorLaw: return "building.columns"
        case .juniorNation: return "flag"
        case .socialism: return "star.circle"
        case .economy: return "chart.line.uptrend.xyaxis"
        case .politicsLaw: return "person.3.sequence"
        case .philosophyCulture: return "brain.head.profile"
        case .international: return "globe.asia.australia"
        case .legalLife: return "doc.text.magnifyingglass"
        case .logicThinking: return "checklist"
        case .sprint: return "target"
        }
    }
}

enum PoliticsWeapon: String, Codable, CaseIterable, Identifiable {
    case keywordLocator
    case rightDutyPair
    case organDutyTable
    case responsibilityChain
    case questionTranslator
    case subjectLocator
    case materialSlicer
    case economyChain
    case politicalSubjectMatrix
    case ruleOfLawLayers
    case philosophyLocator
    case contradictionThreeQuestions
    case cultureTemplate
    case internationalFilter
    case choiceTrapFilter
    case civilCaseFourSteps
    case logicFormFilter
    case hotTopicTranslator
    case essaySixSteps

    var id: String { rawValue }

    var name: String {
        switch self {
        case .keywordLocator: return "关键词定位"
        case .rightDutyPair: return "权利义务配对"
        case .organDutyTable: return "国家机关职责表"
        case .responsibilityChain: return "责任链三问"
        case .questionTranslator: return "设问翻译器"
        case .subjectLocator: return "主体定位法"
        case .materialSlicer: return "材料切片法"
        case .economyChain: return "经济传导链"
        case .politicalSubjectMatrix: return "政治主体职责表"
        case .ruleOfLawLayers: return "法治四层定位"
        case .philosophyLocator: return "哲学原理定位"
        case .contradictionThreeQuestions: return "矛盾秒杀三问"
        case .cultureTemplate: return "文化三维模板"
        case .internationalFilter: return "国际关系秒杀"
        case .choiceTrapFilter: return "选择题五排雷"
        case .civilCaseFourSteps: return "民事案例四步"
        case .logicFormFilter: return "逻辑形式排雷"
        case .hotTopicTranslator: return "热点三层转译"
        case .essaySixSteps: return "主观题六步法"
        }
    }

    var icon: String {
        switch self {
        case .keywordLocator: return "scope"
        case .rightDutyPair: return "arrow.left.arrow.right"
        case .organDutyTable: return "building.2.crop.circle"
        case .responsibilityChain: return "link"
        case .questionTranslator: return "text.bubble"
        case .subjectLocator: return "person.crop.rectangle.stack"
        case .materialSlicer: return "scissors"
        case .economyChain: return "arrow.triangle.branch"
        case .politicalSubjectMatrix: return "tablecells"
        case .ruleOfLawLayers: return "square.stack.3d.up"
        case .philosophyLocator: return "brain"
        case .contradictionThreeQuestions: return "questionmark.diamond"
        case .cultureTemplate: return "sparkles"
        case .internationalFilter: return "globe"
        case .choiceTrapFilter: return "exclamationmark.triangle"
        case .civilCaseFourSteps: return "doc.badge.gearshape"
        case .logicFormFilter: return "function"
        case .hotTopicTranslator: return "newspaper"
        case .essaySixSteps: return "text.append"
        }
    }
}

struct KnowledgePoint: Codable, Identifiable {
    let id: String
    let title: String
    let detail: String
    let grade: ImportanceGrade
    let cardType: MemoryCardType
    var pitfall: String? = nil
    var keywords: [String] = []
}

struct LearningNode: Codable, Identifiable {
    let id: String
    var order: Int
    let stage: Stage
    let topic: PoliticsTopic
    let title: String
    let tagline: String
    let knowledgePoints: [KnowledgePoint]
    let practiceIds: [String]
    var bossCaseId: String? = nil
    var weaponUnlocked: PoliticsWeapon? = nil
}

enum NodeState {
    case locked
    case current
    case completed
}

struct PoliticsQuestion: Codable, Identifiable {
    let id: String
    let nodeId: String
    let knowledgeId: String
    let topic: PoliticsTopic
    let stage: Stage
    let prompt: String
    let options: [String]
    let answerIndex: Int
    let explanation: String
    var trapTags: [String] = []
    var weapon: PoliticsWeapon? = nil
}

struct SubjectiveQuestion: Identifiable {
    let id: String
    let nodeId: String
    let knowledgeId: String
    let grade: ImportanceGrade
    let material: String
    let prompt: String
    let answerPoints: [String]
    let diagnostics: [String]
}

struct SolutionPath: Codable {
    let title: String
    let steps: [String]
    let timeMinutes: Double
}

struct BossDuel: Codable, Identifiable {
    let id: String
    let nodeId: String
    let title: String
    let material: String
    let question: String
    let standard: SolutionPath
    let weaponPath: SolutionPath
    let weapon: PoliticsWeapon
    let keyInsight: String
    let sampleAnswer: [String]

    var timeRatio: Double { max(standard.timeMinutes / max(weaponPath.timeMinutes, 0.1), 1) }
}

enum TrapCategory: String, Codable, CaseIterable, Identifiable {
    case subjectMismatch = "主体错配"
    case absoluteTerm = "绝对化"
    case causalityReversed = "因果倒置"
    case scopeOverreach = "范围越界"
    case invented = "无中生有"
    case irrelevant = "正确无关"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .subjectMismatch: return "person.crop.rectangle.badge.xmark"
        case .absoluteTerm: return "exclamationmark.octagon"
        case .causalityReversed: return "arrow.uturn.left"
        case .scopeOverreach: return "rectangle.expand.vertical"
        case .invented: return "questionmark.app"
        case .irrelevant: return "link.badge.plus"
        }
    }
}

struct TrapDrill: Identifiable {
    let id: String
    let category: TrapCategory
    let knowledgeId: String
    let stem: String
    let trapOption: String
    let verdict: String
    let correction: String
    let explanation: String
}

struct SubjectResponsibility: Identifiable {
    let id: String
    let title: String
    let role: String
    let canDo: [String]
    let cannotDo: [String]
    let triggerWords: [String]
    let knowledgeIds: [String]
}

struct AnswerTemplate: Identifiable {
    let id: String
    let title: String
    let promptType: String
    let structure: [String]
    let sentenceStarters: [String]
    let diagnostics: [String]
    let sample: String
}

struct ReviewCardState: Codable, Equatable {
    var level: Int = 0
    var nextDue: Date = .distantPast
    var correctCount: Int = 0
    var wrongCount: Int = 0
    var lastReviewed: Date? = nil
}

struct WeaponGuide: Identifiable {
    let weapon: PoliticsWeapon
    let tagline: String
    let whenToUse: [String]
    let steps: [String]
    let exampleCaseId: String?

    var id: String { weapon.rawValue }
}

struct MemoryCard: Identifiable {
    let id: String
    let knowledgeId: String
    let type: MemoryCardType
    let grade: ImportanceGrade
    let front: String
    let back: String
    let mode: RecallMode
}

struct MaterialCase: Codable, Identifiable {
    let id: String
    let title: String
    let material: String
    let question: String
    let subject: String
    let action: String
    let object: String
    let goal: String
    let knowledgeIds: [String]
    let answerSentences: [String]
    let diagnostics: [String]
}

struct ConceptNode: Identifiable {
    let id: String
    let title: String
    let subtitle: String
    let grade: ImportanceGrade
    let topic: PoliticsTopic
    let triggerWords: [String]
}

struct ConceptEdge: Identifiable {
    let id: String
    let from: String
    let to: String
    let relation: String
}
