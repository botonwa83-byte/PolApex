import XCTest
@testable import PolApex

final class PolApexTests: XCTestCase {
    func testMainLineHasPlannedCoverage() {
        XCTAssertEqual(MainLineData.nodes.count, 28)
        XCTAssertEqual(MainLineData.nodes.map(\.order), Array(1...28))
        XCTAssertEqual(Set(MainLineData.nodes.map(\.id)).count, MainLineData.nodes.count)
        XCTAssertTrue(MainLineData.nodes.prefix(9).allSatisfy { $0.stage == .junior })
        XCTAssertEqual(MainLineData.nodes.last?.stage, .sprint)
    }

    func testKnowledgeIdsUniqueAndEveryNodeCovered() {
        let ids = MainLineData.allKnowledgePoints.map(\.id)
        XCTAssertEqual(Set(ids).count, ids.count, "考点 ID 重复")
        for node in MainLineData.nodes {
            XCTAssertGreaterThanOrEqual(MainLineData.coveragePoints(for: node).count, 4,
                                        "节点 \(node.id) 考点覆盖不足")
        }
        XCTAssertGreaterThanOrEqual(MainLineData.allKnowledgePoints.count, 100)
        XCTAssertGreaterThan(MainLineData.allKnowledgePoints.filter { $0.grade == .s }.count, 20)
    }

    func testWeightedQuestionGenerationCoversEveryKnowledgePoint() {
        let grouped = Dictionary(grouping: QuestionBank.generated, by: \.knowledgeId)
        for point in MainLineData.allKnowledgePoints {
            let questions = grouped[point.id] ?? []
            XCTAssertEqual(questions.count, QuestionBank.questionCount(for: point.grade),
                           "考点 \(point.id) 题量未按 \(point.grade.rawValue) 级权重生成")
            for question in questions {
                XCTAssertTrue(question.options.indices.contains(question.answerIndex),
                              "题 \(question.id) 答案下标越界")
                XCTAssertEqual(question.knowledgeId, point.id)
            }
        }
    }

    func testNodePracticeIdsResolveFullCoverage() {
        for node in MainLineData.nodes {
            let expectedCount = MainLineData.coveragePoints(for: node)
                .map { QuestionBank.questionCount(for: $0.grade) }
                .reduce(0, +)
            XCTAssertEqual(node.allPracticeIds.count, expectedCount, "节点 \(node.id) 动态练习 ID 没覆盖全部考点")
            XCTAssertEqual(Set(node.allPracticeIds).count, node.allPracticeIds.count, "节点 \(node.id) 练习 ID 重复")
            for id in node.allPracticeIds {
                XCTAssertNotNil(QuestionBank.question(id: id), "节点 \(node.id) 练习 ID \(id) 没有关联到题库")
            }
        }
    }

    func testHighPriorityPointsHaveSubjectiveQuestions() {
        let subjectiveIds = Set(SubjectiveQuestionData.all.map(\.knowledgeId))
        for point in MainLineData.allKnowledgePoints where point.grade == .s || point.grade == .a {
            XCTAssertTrue(subjectiveIds.contains(point.id), "S/A 考点 \(point.id) 缺主观题")
        }
        XCTAssertTrue(SubjectiveQuestionData.all.allSatisfy { !$0.answerPoints.isEmpty })
    }

    func testExamPracticeSetsFollowGaokaoRatio() {
        XCTAssertEqual(ExamPracticeBlueprint.choiceQuestionCount, 16)
        XCTAssertEqual(ExamPracticeBlueprint.choiceScore, 48)
        XCTAssertEqual(ExamPracticeBlueprint.subjectiveQuestionCount, 4)
        XCTAssertEqual(ExamPracticeBlueprint.subjectiveScore, 52)
        XCTAssertEqual(ExamPracticeBlueprint.totalScore, 100)

        for set in ExamPracticeData.all {
            XCTAssertEqual(set.choiceQuestions.count, ExamPracticeBlueprint.choiceQuestionCount,
                           "套练 \(set.id) 选择题数量不符合高考比例")
            XCTAssertEqual(set.subjectiveQuestions.count, ExamPracticeBlueprint.subjectiveQuestionCount,
                           "套练 \(set.id) 非选择题数量不符合高考比例")
            XCTAssertEqual(set.subjectiveQuestions.map(\.score).reduce(0, +), ExamPracticeBlueprint.subjectiveScore,
                           "套练 \(set.id) 非选择题分值未按高考比重配置")
            XCTAssertTrue(set.choiceQuestions.contains { $0.id.hasPrefix("aq_") },
                          "套练 \(set.id) 选择题没有使用人工高考风格题")
            XCTAssertTrue(set.subjectiveQuestions.contains { $0.id.hasPrefix("asq_") },
                          "套练 \(set.id) 非选择题没有使用人工题")

            let subjectiveTopics = Set(set.subjectiveQuestions.compactMap { MainLineData.node(id: $0.nodeId)?.topic })
            XCTAssertTrue(subjectiveTopics.contains(.economy), "套练 \(set.id) 缺经济非选择题")
            XCTAssertTrue(subjectiveTopics.contains(.politicsLaw), "套练 \(set.id) 缺政治与法治非选择题")
            XCTAssertTrue(subjectiveTopics.contains(.philosophyCulture), "套练 \(set.id) 缺哲学文化非选择题")
            XCTAssertTrue(subjectiveTopics.contains(.sprint), "套练 \(set.id) 缺综合冲刺非选择题")

            let subjectiveTypes = Set(set.subjectiveQuestions.map(\.questionType))
            XCTAssertTrue(subjectiveTypes.contains(.measure), "套练 \(set.id) 缺措施题")
            XCTAssertTrue(subjectiveTypes.contains(.materialAnalysis), "套练 \(set.id) 缺材料分析题")
            XCTAssertTrue(subjectiveTypes.contains(.evaluation), "套练 \(set.id) 缺评析题")
            XCTAssertTrue(subjectiveTypes.contains(.openInquiry), "套练 \(set.id) 缺开放探究题")
        }
    }

    func testAuthoredPracticeQuestionsAreValidAndTyped() {
        XCTAssertGreaterThanOrEqual(AuthoredQuestionData.all.count, ExamPracticeBlueprint.choiceQuestionCount)
        XCTAssertGreaterThanOrEqual(AuthoredSubjectiveQuestionData.all.count, 8)
        XCTAssertEqual(Set(AuthoredQuestionData.all.map(\.id)).count, AuthoredQuestionData.all.count)
        XCTAssertEqual(Set(AuthoredSubjectiveQuestionData.all.map(\.id)).count, AuthoredSubjectiveQuestionData.all.count)

        let choiceTopics = Set(AuthoredQuestionData.all.map(\.topic))
        for slot in ExamPracticeBlueprint.choiceTopicSlots {
            XCTAssertTrue(choiceTopics.contains(slot.topic), "人工选择题缺 \(slot.topic.name)")
        }

        for question in AuthoredQuestionData.all {
            XCTAssertNotNil(MainLineData.node(id: question.nodeId), "人工选择题 \(question.id) nodeId 无效")
            XCTAssertNotNil(MainLineData.knowledge(id: question.knowledgeId), "人工选择题 \(question.id) knowledgeId 无效")
            XCTAssertEqual(question.options.count, 4, "人工选择题 \(question.id) 选项数不为 4")
            XCTAssertTrue(question.options.indices.contains(question.answerIndex), "人工选择题 \(question.id) 答案下标越界")
            XCTAssertFalse(question.prompt.isEmpty)
            XCTAssertFalse(question.explanation.isEmpty)
        }

        let subjectiveTopics = Set(AuthoredSubjectiveQuestionData.all.compactMap { MainLineData.node(id: $0.nodeId)?.topic })
        for topic in ExamPracticeBlueprint.subjectiveTopicSlots {
            XCTAssertTrue(subjectiveTopics.contains(topic), "人工非选择题缺 \(topic.name)")
        }

        let subjectiveTypes = Set(AuthoredSubjectiveQuestionData.all.map(\.questionType))
        XCTAssertTrue(subjectiveTypes.contains(.measure))
        XCTAssertTrue(subjectiveTypes.contains(.materialAnalysis))
        XCTAssertTrue(subjectiveTypes.contains(.significance))
        XCTAssertTrue(subjectiveTypes.contains(.evaluation))
        XCTAssertTrue(subjectiveTypes.contains(.openInquiry))

        for question in AuthoredSubjectiveQuestionData.all {
            XCTAssertNotNil(MainLineData.node(id: question.nodeId), "人工非选择题 \(question.id) nodeId 无效")
            XCTAssertNotNil(MainLineData.knowledge(id: question.knowledgeId), "人工非选择题 \(question.id) knowledgeId 无效")
            XCTAssertGreaterThanOrEqual(question.score, 10, "人工非选择题 \(question.id) 分值过低")
            XCTAssertGreaterThanOrEqual(question.answerPoints.count, 4, "人工非选择题 \(question.id) 采分点不足")
            XCTAssertFalse(question.material.isEmpty)
            XCTAssertFalse(question.prompt.isEmpty)
            XCTAssertFalse(question.diagnostics.isEmpty)
        }
    }

    func testPrioritySPointsHaveDeepExplanations() {
        let allSPoints = MainLineData.allKnowledgePoints.filter { $0.grade == .s }
        let points = allSPoints.filter(\.hasDeepExplanation)
        XCTAssertEqual(points.count, allSPoints.count, "所有 S 级考点都必须有深度讲解")
        XCTAssertGreaterThanOrEqual(points.count, 36, "S 级深度讲解数量异常")

        for point in points {
            XCTAssertGreaterThanOrEqual(point.mustReciteLines.count, 3, "S 级考点 \(point.id) 必背句不足")
            XCTAssertGreaterThanOrEqual(point.sampleAnswerSentences.count, 2, "S 级考点 \(point.id) 高分答案句不足")
            XCTAssertGreaterThanOrEqual(point.commonTrapLines.count + point.explanation.confusions.count, 2,
                                        "S 级考点 \(point.id) 易错/易混信息不足")
            XCTAssertFalse(point.explanation.plainExplanation.isEmpty, "S 级考点 \(point.id) 缺白话理解")
            XCTAssertFalse(point.explanation.answerTemplate.isEmpty, "S 级考点 \(point.id) 缺答题模板")
            XCTAssertFalse(point.explanation.reciteChecklist.isEmpty, "S 级考点 \(point.id) 缺默写清单")
        }
    }

    func testPriorityAPointsHaveDeepExplanations() {
        let allAPoints = MainLineData.allKnowledgePoints.filter { $0.grade == .a }
        let points = allAPoints.filter(\.hasDeepExplanation)
        XCTAssertEqual(points.count, allAPoints.count, "所有 A 级考点都必须有深度讲解")
        XCTAssertGreaterThanOrEqual(points.count, 48, "A 级深度讲解数量异常")

        for point in points {
            XCTAssertGreaterThanOrEqual(point.mustReciteLines.count, 3, "A 级考点 \(point.id) 必背句不足")
            XCTAssertGreaterThanOrEqual(point.sampleAnswerSentences.count, 2, "A 级考点 \(point.id) 高分答案句不足")
            XCTAssertGreaterThanOrEqual(point.commonTrapLines.count + point.explanation.confusions.count, 2,
                                        "A 级考点 \(point.id) 易错/易混信息不足")
            XCTAssertFalse(point.explanation.plainExplanation.isEmpty, "A 级考点 \(point.id) 缺白话理解")
            XCTAssertFalse(point.explanation.answerTemplate.isEmpty, "A 级考点 \(point.id) 缺答题模板")
        }
    }

    func testAuthoredQuestionsReferenceTheirDeclaredNode() {
        var home: [String: String] = [:]
        for node in MainLineData.nodes {
            for point in MainLineData.coveragePoints(for: node) {
                home[point.id] = node.id
            }
        }
        for question in AuthoredQuestionData.all {
            XCTAssertEqual(home[question.knowledgeId], question.nodeId,
                           "人工选择题 \(question.id) 的 knowledgeId \(question.knowledgeId) 实际归属节点与声明的 nodeId 不一致")
        }
        for question in AuthoredSubjectiveQuestionData.all {
            XCTAssertEqual(home[question.knowledgeId], question.nodeId,
                           "人工非选择题 \(question.id) 的 knowledgeId \(question.knowledgeId) 实际归属节点与声明的 nodeId 不一致")
        }
    }

    func testBLevelPointsHaveDeepExplanations() {
        let allBPoints = MainLineData.allKnowledgePoints.filter { $0.grade == .b }
        let points = allBPoints.filter(\.hasDeepExplanation)
        XCTAssertEqual(points.count, allBPoints.count, "所有 B 级考点都必须有深度讲解")
        XCTAssertGreaterThanOrEqual(points.count, 26, "B 级深度讲解数量异常")

        for point in points {
            XCTAssertGreaterThanOrEqual(point.mustReciteLines.count, 3, "B 级考点 \(point.id) 必背句不足")
            XCTAssertGreaterThanOrEqual(point.sampleAnswerSentences.count, 2, "B 级考点 \(point.id) 高分答案句不足")
            XCTAssertGreaterThanOrEqual(point.commonTrapLines.count + point.explanation.confusions.count, 2,
                                        "B 级考点 \(point.id) 易错/易混信息不足")
            XCTAssertFalse(point.explanation.plainExplanation.isEmpty, "B 级考点 \(point.id) 缺白话理解")
            XCTAssertFalse(point.explanation.answerTemplate.isEmpty, "B 级考点 \(point.id) 缺答题模板")
        }
    }

    func testDeepExplanationsImproveGeneratedTrainingContent() {
        let deepPoint = MainLineData.allKnowledgePoints.first { $0.id == "k1601" }
        XCTAssertNotNil(deepPoint)
        XCTAssertTrue(deepPoint?.hasDeepExplanation == true)

        let subjective = SubjectiveQuestionData.questions(knowledgeId: "k1601").first
        XCTAssertNotNil(subjective)
        XCTAssertTrue(subjective?.answerPoints.contains { $0.contains("总揽全局") } == true,
                      "深度主观题应使用结构化采分句，而不是只引用 detail")

        let card = MemoryData.all.first { $0.knowledgeId == "k1601" }
        XCTAssertNotNil(card)
        XCTAssertTrue(card?.back.contains("最本质的特征") == true,
                      "深度记忆卡应包含必背原文")
    }

    func testBossDuelReferencesResolveAndAreFaster() {
        XCTAssertGreaterThanOrEqual(BossDuelData.all.count, 15, "Boss Duel 数量不足，不能只保留少量示例")
        let ids = BossDuelData.all.map(\.id)
        XCTAssertEqual(Set(ids).count, ids.count, "Boss Duel ID 重复")
        let nodeIds = Set(MainLineData.nodes.map(\.id))
        for duel in BossDuelData.all {
            XCTAssertTrue(nodeIds.contains(duel.nodeId), "Boss \(duel.id) nodeId 不存在")
            XCTAssertGreaterThan(duel.timeRatio, 1)
            XCTAssertGreaterThanOrEqual(duel.standard.steps.count, 3, "Boss \(duel.id) 常规解步骤不足")
            XCTAssertGreaterThanOrEqual(duel.weaponPath.steps.count, 3, "Boss \(duel.id) 武器解步骤不足")
            XCTAssertGreaterThanOrEqual(duel.sampleAnswer.count, 3, "Boss \(duel.id) 高分答案句不足")
        }
        for node in MainLineData.nodes where node.bossCaseId != nil {
            XCTAssertNotNil(BossDuelData.duel(id: node.bossCaseId!))
        }
    }

    func testMaterialCaseBreadthAndReferencesResolve() {
        XCTAssertGreaterThanOrEqual(MaterialCaseData.all.count, 15, "材料案例数量不足，不能只覆盖少量模块")
        let ids = MaterialCaseData.all.map(\.id)
        XCTAssertEqual(Set(ids).count, ids.count, "材料案例 ID 重复")
        let knowledgeIds = Set(MainLineData.allKnowledgePoints.map(\.id))
        for item in MaterialCaseData.all {
            XCTAssertGreaterThanOrEqual(item.knowledgeIds.count, 2, "材料案例 \(item.id) 关联考点不足")
            XCTAssertGreaterThanOrEqual(item.answerSentences.count, 3, "材料案例 \(item.id) 答案句不足")
            XCTAssertFalse(item.diagnostics.isEmpty, "材料案例 \(item.id) 缺扣分提醒")
            for id in item.knowledgeIds {
                XCTAssertTrue(knowledgeIds.contains(id), "材料案例 \(item.id) 引用不存在考点 \(id)")
            }
        }
    }

    func testConceptGraphReferencesResolve() {
        let conceptIds = Set(ConceptGraphData.nodes.map(\.id))
        XCTAssertEqual(conceptIds.count, ConceptGraphData.nodes.count)
        for edge in ConceptGraphData.edges {
            XCTAssertTrue(conceptIds.contains(edge.from), "边 \(edge.id) from 不存在")
            XCTAssertTrue(conceptIds.contains(edge.to), "边 \(edge.id) to 不存在")
            XCTAssertFalse(edge.relation.isEmpty)
        }
    }

    func testFreeTierPolicy() {
        let freeNodes = MainLineData.nodes.filter { $0.order <= PurchaseManager.freeNodeCount }
        XCTAssertTrue(freeNodes.allSatisfy { $0.stage == .junior }, "免费主线应完整覆盖初中道法")
        XCTAssertEqual(freeNodes.count, 9, "免费档应完整覆盖初中 9 关")
        XCTAssertLessThanOrEqual(PurchaseManager.freeDuelCount, BossDuelData.all.count)
        XCTAssertLessThanOrEqual(PurchaseManager.freeMaterialCaseCount, MaterialCaseData.all.count)
        XCTAssertLessThanOrEqual(PurchaseManager.freeWeaponCount, WeaponGuideData.all.count)
    }

    func testPremiumPlanCommunicatesCoreUnlocks() {
        XCTAssertGreaterThanOrEqual(PremiumContentPlan.heroBenefits.count, 6)
        XCTAssertTrue(PremiumContentPlan.unlockSummary.contains("高考比例套练"))
        XCTAssertTrue(PremiumContentPlan.unlockSummary.contains("非选择题题型池"))
        XCTAssertTrue(PremiumContentPlan.paywallFootnote.contains("无订阅"))
        XCTAssertTrue(PremiumContentPlan.paywallFootnote.contains("恢复购买"))

        let pillarText = PremiumContentPlan.pillars
            .map { "\($0.title) \($0.detail) \($0.metric)" }
            .joined(separator: " ")
        XCTAssertTrue(pillarText.contains("48/52"), "内购价值必须明确按高考分值权重组织")
        XCTAssertTrue(pillarText.contains("非选择题"), "内购价值必须突出非选择题题型池")
        XCTAssertTrue(PremiumContentPlan.heroBenefits.contains { $0.title.contains("一次买断") })
    }

    func testExpansionModulesLinkToPractice() {
        for guide in WeaponGuideData.all {
            XCTAssertFalse(PracticeLinker.choiceQuestions(for: guide).isEmpty, "武器 \(guide.weapon.name) 缺关联选择题")
            XCTAssertFalse(PracticeLinker.subjectiveQuestions(for: guide).isEmpty, "武器 \(guide.weapon.name) 缺关联主观题")
            if let id = guide.exampleCaseId {
                XCTAssertNotNil(BossDuelData.duel(id: id), "武器 \(guide.weapon.name) 的 Boss 示例不存在")
            }
        }

        for duel in BossDuelData.all {
            XCTAssertFalse(PracticeLinker.choiceQuestions(for: duel).isEmpty, "Boss \(duel.id) 缺关联练习题")
        }

        for item in MaterialCaseData.all {
            XCTAssertFalse(PracticeLinker.choiceQuestions(for: item).isEmpty, "材料案例 \(item.id) 缺关联选择题")
            XCTAssertFalse(PracticeLinker.subjectiveQuestions(for: item).isEmpty, "材料案例 \(item.id) 缺关联主观题")
        }

        for drill in TrapDrillData.all {
            XCTAssertFalse(PracticeLinker.choiceQuestions(for: drill).isEmpty, "排雷题 \(drill.id) 缺关联选择题")
        }

        for subject in SubjectMatrixData.all {
            XCTAssertFalse(PracticeLinker.choiceQuestions(for: subject).isEmpty, "主体 \(subject.id) 缺关联选择题")
            XCTAssertFalse(PracticeLinker.subjectiveQuestions(for: subject).isEmpty, "主体 \(subject.id) 缺关联主观题")
        }

        for template in AnswerTemplateData.all {
            XCTAssertFalse(PracticeLinker.choiceQuestions(for: template).isEmpty, "模板 \(template.id) 缺关联选择题")
            XCTAssertFalse(PracticeLinker.subjectiveQuestions(for: template).isEmpty, "模板 \(template.id) 缺关联主观题")
        }
    }

    func testReviewIntervalsRespectImportance() {
        XCTAssertEqual(ReviewScheduler.nextInterval(currentLevel: 0, grade: .s, correct: true).days, 2)
        XCTAssertEqual(ReviewScheduler.nextInterval(currentLevel: 0, grade: .a, correct: true).days, 3)
        XCTAssertEqual(ReviewScheduler.nextInterval(currentLevel: 0, grade: .b, correct: true).days, 7)
        XCTAssertEqual(ReviewScheduler.nextInterval(currentLevel: 0, grade: .c, correct: true).days, 30)
        XCTAssertEqual(ReviewScheduler.nextInterval(currentLevel: 4, grade: .s, correct: false).days, 1)
    }

    func testTrapDrillIntegrity() {
        XCTAssertGreaterThanOrEqual(TrapDrillData.all.count, 12)
        let ids = TrapDrillData.all.map(\.id)
        XCTAssertEqual(Set(ids).count, ids.count, "陷阱题 ID 重复")
        let knowledgeIds = Set(MainLineData.allKnowledgePoints.map(\.id))
        let categories = Set(TrapDrillData.all.map(\.category))
        XCTAssertEqual(categories, Set(TrapCategory.allCases), "六类选择题陷阱必须都有训练")
        for drill in TrapDrillData.all {
            XCTAssertTrue(knowledgeIds.contains(drill.knowledgeId), "陷阱题 \(drill.id) 引用不存在考点")
            XCTAssertFalse(drill.trapOption.isEmpty)
            XCTAssertFalse(drill.correction.isEmpty)
            XCTAssertFalse(drill.explanation.isEmpty)
        }
    }

    func testSubjectMatrixIntegrity() {
        XCTAssertGreaterThanOrEqual(SubjectMatrixData.all.count, 10)
        let ids = SubjectMatrixData.all.map(\.id)
        XCTAssertEqual(Set(ids).count, ids.count, "主体矩阵 ID 重复")
        let knowledgeIds = Set(MainLineData.allKnowledgePoints.map(\.id))
        for subject in SubjectMatrixData.all {
            XCTAssertFalse(subject.canDo.isEmpty, "主体 \(subject.id) 缺可做职责")
            XCTAssertFalse(subject.cannotDo.isEmpty, "主体 \(subject.id) 缺禁止串台提醒")
            XCTAssertFalse(subject.triggerWords.isEmpty, "主体 \(subject.id) 缺材料触发词")
            for id in subject.knowledgeIds {
                XCTAssertTrue(knowledgeIds.contains(id), "主体 \(subject.id) 引用不存在考点 \(id)")
            }
        }
    }

    func testAnswerTemplateIntegrity() {
        XCTAssertGreaterThanOrEqual(AnswerTemplateData.all.count, 6)
        let ids = AnswerTemplateData.all.map(\.id)
        XCTAssertEqual(Set(ids).count, ids.count, "模板 ID 重复")
        for item in AnswerTemplateData.all {
            XCTAssertFalse(item.promptType.isEmpty)
            XCTAssertGreaterThanOrEqual(item.structure.count, 3)
            XCTAssertFalse(item.sentenceStarters.isEmpty)
            XCTAssertFalse(item.sample.isEmpty)
        }
    }

    func testReviewProgressManagerRecordsCardState() {
        let manager = ReviewProgressManager.shared
        manager.reset()
        let card = MemoryData.highWeight(limit: 1)[0]
        let now = Date(timeIntervalSince1970: 1_800_000_000)
        manager.record(card: card, correct: true, now: now)
        var state = manager.state(for: card)
        XCTAssertEqual(state.level, 1)
        XCTAssertEqual(state.correctCount, 1)
        XCTAssertGreaterThan(state.nextDue, now)

        manager.record(card: card, correct: false, now: now)
        state = manager.state(for: card)
        XCTAssertEqual(state.level, 0)
        XCTAssertEqual(state.wrongCount, 1)
    }

    func testGaokaoCoverageGapsAreFilled() {
        let searchableText = MainLineData.allKnowledgePoints.map { "\($0.title) \($0.detail)" }
        let mustCoverKeywords = [
            "新发展理念",
            "新质生产力",
            "国家的本质与结构形式",
            "国际组织体系",
            "婚姻家庭与继承",
            "哲学的基本问题",
            "价值的创造与实现",
            "辩证思维方法",
            "新民主主义革命的胜利",
            "社会主义制度在中国的确立"
        ]
        for keyword in mustCoverKeywords {
            XCTAssertTrue(searchableText.contains { $0.contains(keyword) },
                          "高考覆盖缺口未补齐：缺少「\(keyword)」相关知识点")
        }

        let supplementedIds = ["k1405", "k1406", "k1407", "k1905", "k2105", "k2305", "k2306", "k2405", "k2406", "k2605", "k1005", "k1006"]
        for id in supplementedIds {
            guard let point = MainLineData.knowledge(id: id) else {
                XCTFail("补充知识点 \(id) 缺失")
                continue
            }
            XCTAssertTrue(point.hasDeepExplanation, "补充知识点 \(id) 缺少结构化深度讲解")
            if point.grade == .s || point.grade == .a {
                XCTAssertGreaterThanOrEqual(point.mustReciteLines.count, 3, "补充知识点 \(id) 必背句不足")
                XCTAssertGreaterThanOrEqual(point.sampleAnswerSentences.count, 2, "补充知识点 \(id) 高分答案句不足")
            }
        }
    }
}
