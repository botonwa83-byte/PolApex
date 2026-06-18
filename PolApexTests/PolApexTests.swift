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
        let grouped = Dictionary(grouping: QuestionBank.all, by: \.knowledgeId)
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

    func testHighPriorityPointsHaveSubjectiveQuestions() {
        let subjectiveIds = Set(SubjectiveQuestionData.all.map(\.knowledgeId))
        for point in MainLineData.allKnowledgePoints where point.grade == .s || point.grade == .a {
            XCTAssertTrue(subjectiveIds.contains(point.id), "S/A 考点 \(point.id) 缺主观题")
        }
        XCTAssertTrue(SubjectiveQuestionData.all.allSatisfy { !$0.answerPoints.isEmpty })
    }

    func testBossDuelReferencesResolveAndAreFaster() {
        let nodeIds = Set(MainLineData.nodes.map(\.id))
        for duel in BossDuelData.all {
            XCTAssertTrue(nodeIds.contains(duel.nodeId), "Boss \(duel.id) nodeId 不存在")
            XCTAssertGreaterThan(duel.timeRatio, 1)
            XCTAssertFalse(duel.sampleAnswer.isEmpty)
        }
        for node in MainLineData.nodes where node.bossCaseId != nil {
            XCTAssertNotNil(BossDuelData.duel(id: node.bossCaseId!))
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
        XCTAssertLessThanOrEqual(PurchaseManager.freeDuelCount, BossDuelData.all.count)
        XCTAssertLessThanOrEqual(PurchaseManager.freeMaterialCaseCount, MaterialCaseData.all.count)
        XCTAssertLessThanOrEqual(PurchaseManager.freeWeaponCount, WeaponGuideData.all.count)
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
}
