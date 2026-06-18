import Foundation

enum PracticeLinker {
    static func choiceQuestions(knowledgeIds: [String]) -> [PoliticsQuestion] {
        let wanted = Set(knowledgeIds)
        return QuestionBank.all.filter { wanted.contains($0.knowledgeId) }
    }

    static func subjectiveQuestions(knowledgeIds: [String]) -> [SubjectiveQuestion] {
        let wanted = Set(knowledgeIds)
        return SubjectiveQuestionData.all.filter { wanted.contains($0.knowledgeId) }
    }

    static func choiceQuestions(for guide: WeaponGuide) -> [PoliticsQuestion] {
        let byWeapon = QuestionBank.all.filter { $0.weapon == guide.weapon }
        if !byWeapon.isEmpty {
            return byWeapon
        }
        return fallbackChoiceQuestions(for: guide.weapon)
    }

    static func subjectiveQuestions(for guide: WeaponGuide) -> [SubjectiveQuestion] {
        let nodeIds = Set(MainLineData.nodes.filter { $0.weaponUnlocked == guide.weapon }.map(\.id))
        let byNode = SubjectiveQuestionData.all.filter { nodeIds.contains($0.nodeId) }
        if !byNode.isEmpty {
            return byNode
        }
        return subjectiveQuestions(knowledgeIds: fallbackKnowledgeIds(for: guide.weapon))
    }

    static func choiceQuestions(for duel: BossDuel) -> [PoliticsQuestion] {
        let nodeQuestions = QuestionBank.questions(nodeId: duel.nodeId)
        if !nodeQuestions.isEmpty {
            return nodeQuestions
        }
        return choiceQuestions(for: WeaponGuide(weapon: duel.weapon,
                                               tagline: "",
                                               whenToUse: [],
                                               steps: [],
                                               exampleCaseId: nil))
    }

    static func choiceQuestions(for drill: TrapDrill) -> [PoliticsQuestion] {
        let direct = QuestionBank.all.filter {
            $0.knowledgeId == drill.knowledgeId &&
            !$0.trapTags.isEmpty
        }
        if !direct.isEmpty {
            return direct
        }
        return QuestionBank.all.filter { $0.knowledgeId == drill.knowledgeId }
    }

    static func subjectiveQuestions(for template: AnswerTemplate) -> [SubjectiveQuestion] {
        let matched = SubjectiveQuestionData.all.filter { question in
            matchesTemplate(template, prompt: question.prompt) ||
            question.answerPoints.contains { matchesTemplate(template, prompt: $0) }
        }
        if !matched.isEmpty {
            return matched
        }
        return subjectiveQuestions(knowledgeIds: fallbackKnowledgeIds(for: template))
    }

    static func choiceQuestions(for template: AnswerTemplate) -> [PoliticsQuestion] {
        let subjectiveIds = Set(subjectiveQuestions(for: template).map(\.knowledgeId))
        if !subjectiveIds.isEmpty {
            return choiceQuestions(knowledgeIds: Array(subjectiveIds))
        }
        return choiceQuestions(knowledgeIds: fallbackKnowledgeIds(for: template))
    }

    static func choiceQuestions(for subject: SubjectResponsibility) -> [PoliticsQuestion] {
        choiceQuestions(knowledgeIds: subject.knowledgeIds)
    }

    static func subjectiveQuestions(for subject: SubjectResponsibility) -> [SubjectiveQuestion] {
        subjectiveQuestions(knowledgeIds: subject.knowledgeIds)
    }

    static func choiceQuestions(for item: MaterialCase) -> [PoliticsQuestion] {
        choiceQuestions(knowledgeIds: item.knowledgeIds)
    }

    static func subjectiveQuestions(for item: MaterialCase) -> [SubjectiveQuestion] {
        subjectiveQuestions(knowledgeIds: item.knowledgeIds)
    }

    private static func fallbackChoiceQuestions(for weapon: PoliticsWeapon) -> [PoliticsQuestion] {
        choiceQuestions(knowledgeIds: fallbackKnowledgeIds(for: weapon))
    }

    private static func fallbackKnowledgeIds(for weapon: PoliticsWeapon) -> [String] {
        switch weapon {
        case .keywordLocator: return ["k0801", "k0901", "k2701"]
        case .rightDutyPair: return ["k0501", "k0602", "k0604"]
        case .organDutyTable: return ["k0701", "k1702", "k1804"]
        case .responsibilityChain: return ["k0301", "k0402", "k1701"]
        case .questionTranslator: return ["k1001", "k1102", "k1202"]
        case .subjectLocator: return ["k1601", "k1602", "k1702"]
        case .materialSlicer: return ["k1401", "k1701", "k2801"]
        case .economyChain: return ["k1301", "k1401", "k1501"]
        case .politicalSubjectMatrix: return ["k1701", "k1702", "k1703"]
        case .ruleOfLawLayers: return ["k1801", "k1802", "k1804"]
        case .philosophyLocator: return ["k1901", "k1902", "k2102"]
        case .contradictionThreeQuestions: return ["k2001", "k2002", "k2004"]
        case .cultureTemplate: return ["k2201", "k2202", "k2204"]
        case .internationalFilter: return ["k2301", "k2302", "k2303"]
        case .choiceTrapFilter: return TrapDrillData.all.map(\.knowledgeId)
        case .civilCaseFourSteps: return ["k2401", "k2402", "k2502"]
        case .logicFormFilter: return ["k2601", "k2602", "k2604"]
        case .hotTopicTranslator: return ["k2701", "k2702", "k2703"]
        case .essaySixSteps: return ["k2801", "k2802", "k1701"]
        }
    }

    private static func fallbackKnowledgeIds(for template: AnswerTemplate) -> [String] {
        switch template.id {
        case "tpl_why": return ["k1401", "k1601", "k1801"]
        case "tpl_how": return ["k1402", "k1602", "k2502"]
        case "tpl_meaning": return ["k1701", "k2202", "k2801"]
        case "tpl_reflect": return ["k1701", "k1802", "k2201"]
        case "tpl_philosophy": return ["k1901", "k1902", "k2002"]
        case "tpl_evaluate": return ["k1401", "k0602", "k2602"]
        default: return ["k2801", "k2802"]
        }
    }

    private static func matchesTemplate(_ template: AnswerTemplate, prompt: String) -> Bool {
        template.promptType
            .split(separator: "、")
            .map(String.init)
            .contains { prompt.contains($0) }
    }
}
