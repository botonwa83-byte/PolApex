import Foundation

enum TrapDrillData {
    static let all: [TrapDrill] = [
        TrapDrill(
            id: "trap_party_01",
            category: .subjectMismatch,
            knowledgeId: "k1602",
            stem: "某地党委牵头研究优化营商环境，政府随后出台具体行政措施。",
            trapOption: "党委依法履行经济建设职能，直接管理市场主体经营活动。",
            verdict: "错在主体错配",
            correction: "党发挥领导核心作用，政府依法行政、履行经济职能。",
            explanation: "党领导一切不等于党代替国家机关履职。材料中的具体行政措施应归政府。"
        ),
        TrapDrill(
            id: "trap_npc_01",
            category: .subjectMismatch,
            knowledgeId: "k1702",
            stem: "全国人大常委会听取并审议国务院专项工作报告。",
            trapOption: "人大代表行使监督权，监督国务院工作。",
            verdict: "错在主体层级",
            correction: "人大常委会依法行使监督权；人大代表依法行使审议权、表决权等。",
            explanation: "人大与人大代表的职权不能互换。"
        ),
        TrapDrill(
            id: "trap_cppcc_01",
            category: .subjectMismatch,
            knowledgeId: "k1703",
            stem: "政协委员围绕养老服务体系建设提交提案。",
            trapOption: "政协作为国家机关依法行使决定权。",
            verdict: "错在主体性质",
            correction: "政协不是国家机关，履行政治协商、民主监督、参政议政职能。",
            explanation: "决定权属于人大，不能写给政协。"
        ),
        TrapDrill(
            id: "trap_market_01",
            category: .absoluteTerm,
            knowledgeId: "k1401",
            stem: "市场通过价格、供求、竞争引导资源配置。",
            trapOption: "只要发挥市场决定作用，就能自动实现公共利益最大化。",
            verdict: "错在绝对化",
            correction: "市场起决定性作用，但市场调节存在自发性、盲目性、滞后性，需要政府治理。",
            explanation: "看到“只要、自动、必然、彻底”要高度警惕。"
        ),
        TrapDrill(
            id: "trap_common_01",
            category: .absoluteTerm,
            knowledgeId: "k0802",
            stem: "共同富裕是社会主义的本质要求。",
            trapOption: "共同富裕就是全体人民同步富裕、同等富裕。",
            verdict: "错在绝对化和概念混淆",
            correction: "共同富裕不是同步富裕、同时富裕、平均主义。",
            explanation: "共同富裕强调共同和富裕的统一，不能理解为平均主义。"
        ),
        TrapDrill(
            id: "trap_rulelaw_01",
            category: .scopeOverreach,
            knowledgeId: "k1802",
            stem: "某地开展社区普法活动，增强居民法治意识。",
            trapOption: "该做法体现司法机关公正司法。",
            verdict: "错在范围越界",
            correction: "社区普法主要对应全民守法；公正司法对应司法机关依法办案。",
            explanation: "法治四层定位要看材料动作：立法、执法、司法、守法不能混写。"
        ),
        TrapDrill(
            id: "trap_court_01",
            category: .subjectMismatch,
            knowledgeId: "k1804",
            stem: "法院公开审理一起公益诉讼案件。",
            trapOption: "人民法院依法行使检察权，维护社会公共利益。",
            verdict: "错在主体职权",
            correction: "法院行使审判权，检察院行使检察权。",
            explanation: "司法机关内部也要细分职责。"
        ),
        TrapDrill(
            id: "trap_practice_01",
            category: .causalityReversed,
            knowledgeId: "k1902",
            stem: "科研团队在长期实验中修正原有认识，形成新理论。",
            trapOption: "认识推动实践发展，因此认识是实践的来源。",
            verdict: "错在因果倒置",
            correction: "实践是认识的来源，正确认识对实践具有指导作用。",
            explanation: "实践与认识的关系中，来源、动力、目的、检验标准都归实践。"
        ),
        TrapDrill(
            id: "trap_law_01",
            category: .invented,
            knowledgeId: "k0503",
            stem: "某学生违反治安管理处罚法，被公安机关依法处罚。",
            trapOption: "只要违法，就必然承担刑罚处罚。",
            verdict: "错在无中生有和绝对化",
            correction: "违法包括民事、行政、刑事违法；犯罪才应依法承担刑事责任。",
            explanation: "违法不一定犯罪，犯罪一定违法。"
        ),
        TrapDrill(
            id: "trap_culture_01",
            category: .irrelevant,
            knowledgeId: "k2201",
            stem: "某地用数字展陈方式传播传统工艺，吸引青年参与。",
            trapOption: "发展文化产业有利于扩大就业。",
            verdict: "正确但无关",
            correction: "本题应围绕优秀传统文化创造性转化、创新性发展作答。",
            explanation: "选项本身正确，不代表符合设问限定和材料主旨。"
        ),
        TrapDrill(
            id: "trap_global_01",
            category: .scopeOverreach,
            knowledgeId: "k2301",
            stem: "我国在国际合作中坚定维护国家主权、安全和发展利益。",
            trapOption: "共同利益是主权国家对外活动的出发点和落脚点。",
            verdict: "错在范围越界",
            correction: "维护国家利益是主权国家对外活动的出发点和落脚点。",
            explanation: "国家间有共同利益，但不能替代国家利益的基础地位。"
        ),
        TrapDrill(
            id: "trap_logic_01",
            category: .scopeOverreach,
            knowledgeId: "k2602",
            stem: "如果加强科技创新，就能培育新动能。",
            trapOption: "加强科技创新是培育新动能的必要条件，所以没有科技创新也一定能培育新动能。",
            verdict: "错在条件关系混乱",
            correction: "充分条件和必要条件不能互推，需按逻辑连接词判断。",
            explanation: "逻辑题先还原形式，再判断推理是否有效。"
        )
    ]

    static func drills(category: TrapCategory) -> [TrapDrill] {
        all.filter { $0.category == category }
    }
}

enum SubjectMatrixData {
    static let all: [SubjectResponsibility] = [
        SubjectResponsibility(
            id: "subject_party",
            title: "中国共产党",
            role: "领导核心，总揽全局、协调各方",
            canDo: ["把方向、谋大局、定政策、促改革", "坚持科学执政、民主执政、依法执政", "支持国家机关依法依章程履职"],
            cannotDo: ["不能代替人大行使国家权力", "不能代替政府履行行政职能", "不能直接审判案件"],
            triggerWords: ["党委", "党的领导", "从严治党", "依法执政"],
            knowledgeIds: ["k1601", "k1602", "k1603", "k1604"]
        ),
        SubjectResponsibility(
            id: "subject_npc",
            title: "人民代表大会",
            role: "国家权力机关",
            canDo: ["行使立法权、决定权、任免权、监督权", "把党的主张通过法定程序转化为国家意志", "监督政府、监察机关、审判机关、检察机关工作"],
            cannotDo: ["不能履行行政管理职能", "不能进行政治协商", "不能行使审判权"],
            triggerWords: ["审议", "表决", "立法", "听取报告"],
            knowledgeIds: ["k1702", "k0701", "k0704"]
        ),
        SubjectResponsibility(
            id: "subject_government",
            title: "政府",
            role: "行政机关，依法行政",
            canDo: ["履行经济、政治、文化、社会、生态等职能", "进行科学宏观调控和市场监管", "建设人民满意的服务型政府"],
            cannotDo: ["不能行使立法权和审判权", "不能包办企业经营", "不能代替市场配置所有资源"],
            triggerWords: ["出台政策", "监管", "执法", "公共服务"],
            knowledgeIds: ["k1402", "k1802", "k0701"]
        ),
        SubjectResponsibility(
            id: "subject_cppcc",
            title: "人民政协",
            role: "爱国统一战线组织，社会主义协商民主重要渠道",
            canDo: ["政治协商", "民主监督", "参政议政"],
            cannotDo: ["不是国家机关", "不能行使决定权", "不能直接管理行政事务"],
            triggerWords: ["政协委员", "提案", "协商", "建言资政"],
            knowledgeIds: ["k1703"]
        ),
        SubjectResponsibility(
            id: "subject_court",
            title: "人民法院",
            role: "审判机关",
            canDo: ["依法行使审判权", "公开审判", "维护公平正义"],
            cannotDo: ["不能行使检察权", "不能履行行政执法职能"],
            triggerWords: ["法院", "审理", "判决", "审判"],
            knowledgeIds: ["k1804", "k0701"]
        ),
        SubjectResponsibility(
            id: "subject_procuratorate",
            title: "人民检察院",
            role: "法律监督机关",
            canDo: ["依法行使检察权", "提起公诉", "开展公益诉讼"],
            cannotDo: ["不能行使审判权", "不能代替政府执法"],
            triggerWords: ["检察院", "公诉", "公益诉讼", "法律监督"],
            knowledgeIds: ["k0701", "k1804"]
        ),
        SubjectResponsibility(
            id: "subject_citizen",
            title: "公民",
            role: "权利享有者和义务承担者",
            canDo: ["依法行使监督权", "参与民主选举、协商、决策、管理、监督", "履行维护国家安全等义务"],
            cannotDo: ["不能直接行使国家权力", "不能突破法律边界行使权利"],
            triggerWords: ["居民", "公民", "监督", "参与"],
            knowledgeIds: ["k0602", "k0604", "k0702"]
        ),
        SubjectResponsibility(
            id: "subject_enterprise",
            title: "企业",
            role: "市场主体",
            canDo: ["自主经营、公平竞争", "提升创新能力和管理水平", "依法诚信经营、承担社会责任"],
            cannotDo: ["不能制定宏观政策", "不能进行行政监管", "不能垄断市场、损害消费者权益"],
            triggerWords: ["企业", "平台", "创新", "经营"],
            knowledgeIds: ["k1401", "k1403"]
        ),
        SubjectResponsibility(
            id: "subject_market",
            title: "市场",
            role: "资源配置机制",
            canDo: ["通过价格、供求、竞争引导资源配置", "激发市场主体活力"],
            cannotDo: ["不能解决所有公共利益问题", "不能替代政府宏观调控"],
            triggerWords: ["价格", "供求", "竞争", "资源配置"],
            knowledgeIds: ["k1401", "k1403"]
        ),
        SubjectResponsibility(
            id: "subject_grassroots",
            title: "基层群众自治组织",
            role: "基层民主自治平台",
            canDo: ["组织居民或村民依法直接行使民主权利", "协商办理公共事务", "开展民主监督"],
            cannotDo: ["不是基层政权机关", "不能行使国家权力"],
            triggerWords: ["居委会", "村委会", "居民议事", "村民监督"],
            knowledgeIds: ["k1701", "k0703"]
        )
    ]
}

enum AnswerTemplateData {
    static let all: [AnswerTemplate] = [
        AnswerTemplate(
            id: "tpl_why",
            title: "原因类",
            promptType: "为什么、必要性、依据",
            structure: ["现实问题或材料背景", "教材原理或制度依据", "重要意义或结果"],
            sentenceStarters: ["这是由……决定的", "有利于……", "是……的必然要求"],
            diagnostics: ["是否回答了必要性", "是否写出重要性", "是否贴合材料问题"],
            sample: "治理平台垄断，是弥补市场调节弊端、维护公平竞争的需要，有利于保护消费者权益，促进平台经济规范健康发展。"
        ),
        AnswerTemplate(
            id: "tpl_how",
            title: "措施类",
            promptType: "如何、怎样、措施",
            structure: ["分主体", "写措施", "落结果"],
            sentenceStarters: ["党要……", "政府应……", "企业要……", "公民应……"],
            diagnostics: ["主体是否分清", "措施是否可执行", "结果是否回扣设问"],
            sample: "政府应依法履行市场监管职能，规范平台经营秩序，营造公平竞争市场环境。"
        ),
        AnswerTemplate(
            id: "tpl_meaning",
            title: "意义类",
            promptType: "意义、价值、作用",
            structure: ["对主体的意义", "对制度或治理的意义", "对国家社会发展的意义"],
            sentenceStarters: ["有利于保障……", "有利于推动……", "有利于增强……"],
            diagnostics: ["是否只写空泛好处", "是否区分直接和长远意义"],
            sample: "基层协商有利于保障居民依法直接行使民主权利，提升基层治理效能，形成共建共治共享格局。"
        ),
        AnswerTemplate(
            id: "tpl_reflect",
            title: "体现类",
            promptType: "体现了什么、如何体现",
            structure: ["材料动作", "对应原理", "点明体现关系"],
            sentenceStarters: ["材料中……体现了……", "这一做法表明……"],
            diagnostics: ["是否逐条对应", "是否把原理和材料分离"],
            sample: "社区公开资金使用并接受居民监督，体现了基层民主实践中民主管理和民主监督的贯通。"
        ),
        AnswerTemplate(
            id: "tpl_philosophy",
            title: "哲学类",
            promptType: "运用某哲学原理分析",
            structure: ["原理句", "方法论句", "材料句"],
            sentenceStarters: ["……要求我们……", "材料中……坚持了……"],
            diagnostics: ["原理范围是否准确", "方法论是否遗漏", "材料是否贴上"],
            sample: "矛盾具有特殊性，要求具体问题具体分析。老旧小区改造根据不同小区实际制定方案，体现了这一要求。"
        ),
        AnswerTemplate(
            id: "tpl_evaluate",
            title: "评析类",
            promptType: "评析、辨析、看法",
            structure: ["判断合理处", "指出片面或错误处", "给出完整观点"],
            sentenceStarters: ["该观点看到了……", "但忽视了……", "应坚持……"],
            diagnostics: ["是否先判后析", "是否只肯定或只否定", "是否补完整结论"],
            sample: "该观点看到了市场竞争的重要性，但忽视了市场调节的弊端。应把有效市场和有为政府结合起来。"
        )
    ]
}
