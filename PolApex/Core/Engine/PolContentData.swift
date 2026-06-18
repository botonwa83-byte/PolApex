import Foundation

enum MainLineData {
    static let nodes: [LearningNode] = assignOrder([
        node("n01", .junior, .juniorGrowth, "生命成长与青春心理", "先把价值判断、生命观和自我管理打稳", .keywordLocator, [
            kp("k0101", "生命价值", "生命是独特、不可逆、短暂而有接续的。答题要落到敬畏生命、守护生命、增强生命韧性。", .b, .original, "只写珍惜生命不够，要写清做法。", ["生命", "韧性", "守护"]),
            kp("k0102", "青春成长", "青春期矛盾心理需要接纳和调适，独立思考不等于一味追求独特，批判精神要有质疑也要有建设。", .b, .boundary, "独立不是任性，批判不是否定一切。", ["青春", "独立", "批判"])
        ]),
        node("n02", .junior, .juniorGrowth, "情绪情感、学习与自我", "把个人成长题从空话变成可得分表达", .keywordLocator, [
            kp("k0201", "情绪调节", "情绪会影响观念和行动，合理调节可用改变认知评价、转移注意、合理宣泄、放松训练。", .b, .scene, nil, ["情绪", "调节", "认知"]),
            kp("k0202", "学习观", "学习点亮生命，既包括知识获取，也包括能力培养、品格养成和社会实践。", .b, .template, "不要把学习窄化成课堂刷题。", ["学习", "实践", "成长"])
        ]),
        node("n03", .junior, .juniorGrowth, "友谊、师长与集体", "关系题先看主体，再看责任和边界", .responsibilityChain, [
            kp("k0301", "集体与个人", "个人利益与集体利益本质上一致。发生冲突时，要坚持集体主义，兼顾个人正当利益。", .b, .boundary, "维护集体不是无条件牺牲个人正当权益。", ["集体", "个人", "集体主义"]),
            kp("k0302", "师长关系", "尊重老师、孝亲敬长不是盲从，要在沟通、理解和依法依规中处理分歧。", .c, .scene, nil, ["老师", "父母", "沟通"])
        ]),
        node("n04", .junior, .juniorGrowth, "规则、责任与社会生活", "把规则、秩序、责任三件事连成链", .responsibilityChain, [
            kp("k0401", "规则与自由", "社会规则保障社会秩序，自由不是随心所欲，而是在法律和规则范围内行使权利。", .a, .boundary, "自由和规则不是对立关系。", ["规则", "自由", "秩序"]),
            kp("k0402", "责任链三问", "责任题按谁负责、对谁负责、怎么负责展开，结尾落到担当、规则和公共利益。", .a, .template, nil, ["责任", "担当", "公共利益"])
        ]),
        node("n05", .junior, .juniorLaw, "法律基础与未成年人保护", "先分清法律关系，再谈权利救济", .rightDutyPair, [
            kp("k0501", "法律特征", "法律由国家制定或认可，由国家强制力保证实施，对全体社会成员具有普遍约束力。", .a, .original, nil, ["法律", "强制力", "普遍约束"]),
            kp("k0502", "未成年人保护", "保护未成年人包括家庭、学校、社会、网络、政府、司法六道防线，同时未成年人也要依法自律。", .a, .subject, "保护不是纵容，权利旁边总有义务。", ["未成年人", "保护", "义务"])
        ]),
        node("n06", .junior, .juniorLaw, "宪法、公民权利与义务", "权利义务配对，选择题少掉坑", .rightDutyPair, [
            kp("k0601", "宪法地位", "宪法是国家根本法，是治国安邦的总章程，具有最高法律效力。", .a, .original, "不能把普通法律说成根本法。", ["宪法", "根本法", "最高效力"]),
            kp("k0602", "权利义务统一", "公民既是合法权利的享有者，也是法定义务的承担者。权利可以放弃，法定义务必须履行。", .a, .boundary, nil, ["权利", "义务", "统一"])
        ]),
        node("n07", .junior, .juniorLaw, "民主、法治与国家机构", "国家机关各司其职，别把主体写串", .organDutyTable, [
            kp("k0701", "国家机关职责", "人大是国家权力机关，政府是行政机关，法院行使审判权，检察院行使检察权，监察委员会行使监察权。", .a, .subject, "政协不是国家机关，不能写成行使国家权力。", ["人大", "政府", "法院", "检察院"]),
            kp("k0702", "民主参与", "公民可依法通过民主选举、民主协商、民主决策、民主管理、民主监督参与公共生活。", .a, .scene, "公民不能直接行使国家权力。", ["民主", "参与", "监督"])
        ], boss: "duel_organs"),
        node("n08", .junior, .juniorNation, "富强、创新、共同富裕", "国情材料题抓住发展、改革、共享", .keywordLocator, [
            kp("k0801", "创新驱动", "创新是引领发展的第一动力，教育、科技、人才是全面建设社会主义现代化国家的基础性、战略性支撑。", .a, .original, nil, ["创新", "教育", "科技", "人才"]),
            kp("k0802", "共同富裕", "共同富裕是全体人民共同富裕，不是同步富裕、同时富裕、平均主义。", .a, .boundary, "选择题见平均、同步、消除差距要警惕。", ["共同富裕", "共享", "分配"])
        ]),
        node("n09", .junior, .juniorNation, "中国精神、文化、生态、世界", "价值关键词要能回扣国家发展", .keywordLocator, [
            kp("k0901", "中国精神", "中国精神就是以爱国主义为核心的民族精神和以改革创新为核心的时代精神。", .b, .original, nil, ["民族精神", "时代精神", "爱国主义"]),
            kp("k0902", "生态文明", "坚持节约资源和保护环境的基本国策，走绿色发展道路，处理好经济发展与生态环境保护关系。", .b, .scene, "不能把发展和保护简单对立。", ["生态", "绿色", "保护"])
        ]),
        node("n10", .required, .socialism, "人类社会发展规律", "把历史逻辑讲清，少背散句", .questionTranslator, [
            kp("k1001", "社会基本矛盾", "生产力与生产关系、经济基础与上层建筑的矛盾运动推动社会发展。", .a, .original, nil, ["生产力", "生产关系", "经济基础"]),
            kp("k1002", "科学社会主义", "科学社会主义揭示人类社会发展规律，为社会主义从空想到科学提供理论基础。", .a, .scene, nil, ["科学社会主义", "规律", "理论"])
        ]),
        node("n11", .required, .socialism, "中国特色社会主义道路理论制度文化", "四个自信不是口号，是答题骨架", .questionTranslator, [
            kp("k1101", "四个自信", "中国特色社会主义道路、理论、制度、文化相互联系，统一于中国特色社会主义伟大实践。", .s, .template, nil, ["道路自信", "理论自信", "制度自信", "文化自信"]),
            kp("k1102", "中国式现代化", "中国式现代化具有中国特色、本质要求和重大原则，材料题要落到党的领导、人民立场、高质量发展。", .a, .scene, "不能套西方现代化路径解释中国发展。", ["现代化", "高质量发展", "人民"])
        ]),
        node("n12", .required, .socialism, "新时代、中国梦与青年担当", "大概念最后要落到青年行动", .questionTranslator, [
            kp("k1201", "新时代", "新时代是我国发展新的历史方位，意味着中华民族迎来了从站起来、富起来到强起来的伟大飞跃。", .a, .original, nil, ["新时代", "历史方位", "强起来"]),
            kp("k1202", "青年担当", "青年答题用坚定理想信念、锤炼本领、勇于实践、服务人民、报效国家构成行动链。", .a, .template, nil, ["青年", "理想信念", "实践"])
        ]),
        node("n13", .required, .economy, "我国基本经济制度", "所有制、分配、市场体制三位一体", .economyChain, [
            kp("k1301", "基本经济制度", "我国坚持公有制为主体、多种所有制经济共同发展，按劳分配为主体、多种分配方式并存，社会主义市场经济体制。", .s, .original, nil, ["基本经济制度", "公有制", "分配"]),
            kp("k1302", "两个毫不动摇", "毫不动摇巩固和发展公有制经济，毫不动摇鼓励、支持、引导非公有制经济发展。", .s, .boundary, "国有经济起主导作用，公有制经济占主体地位。", ["公有制", "非公有制", "国有经济"])
        ]),
        node("n14", .required, .economy, "市场经济体制与宏观调控", "经济题最常见的传导链", .economyChain, [
            kp("k1401", "市场决定作用", "市场在资源配置中起决定性作用，通过价格、供求、竞争机制引导资源流动。", .s, .boundary, "市场不是万能的，不能替代政府宏观调控。", ["市场", "价格", "竞争"]),
            kp("k1402", "宏观调控", "科学的宏观调控、有效的政府治理，是发挥社会主义市场经济体制优势的内在要求。", .s, .subject, "政府调控不等于直接包办企业经营。", ["宏观调控", "政府", "市场失灵"])
        ], boss: "duel_market_macro"),
        node("n15", .required, .economy, "收入分配、社会保障、共同富裕", "公平效率、三次分配、民生保障一起看", .economyChain, [
            kp("k1501", "收入分配", "完善个人收入分配，要规范收入分配秩序，形成初次分配、再分配、第三次分配协调配套的制度体系。", .a, .template, nil, ["收入分配", "再分配", "第三次分配"]),
            kp("k1502", "社会保障", "社会保障通过风险分摊与责任共担，保障基本生活、维护社会公平、促进社会和谐。", .a, .scene, "社会救助是最后一道防线。", ["社会保障", "公平", "民生"])
        ]),
        node("n16", .required, .politicsLaw, "党的领导", "高考政治最高频主线之一", .subjectLocator, [
            kp("k1601", "党的领导地位", "中国共产党领导是中国特色社会主义最本质的特征，是中国特色社会主义制度的最大优势。", .s, .original, nil, ["党的领导", "最本质特征", "最大优势"]),
            kp("k1602", "依法执政", "党坚持科学执政、民主执政、依法执政，支持人大、政府、政协、监察机关、审判机关、检察机关依法依章程履职。", .s, .boundary, "党领导一切不等于党代替国家机关履职。", ["依法执政", "党政关系", "主体"])
        ], boss: "duel_party"),
        node("n17", .required, .politicsLaw, "人民当家作主制度体系", "制度题要写出全过程人民民主", .politicalSubjectMatrix, [
            kp("k1701", "全过程人民民主", "全过程人民民主把民主选举、协商、决策、管理、监督贯通起来，是最广泛、最真实、最管用的民主。", .s, .template, nil, ["全过程人民民主", "人民当家作主", "民主"]),
            kp("k1702", "人大制度", "人民代表大会制度是我国根本政治制度，人大依法行使立法权、决定权、任免权、监督权。", .s, .subject, "人大代表行使提案权、审议权等，不等于人大行使四权。", ["人大", "根本政治制度", "监督权"])
        ]),
        node("n18", .required, .politicsLaw, "全面依法治国", "立法、执法、司法、守法分别归位", .ruleOfLawLayers, [
            kp("k1801", "依法治国总目标", "全面推进依法治国总目标是建设中国特色社会主义法治体系、建设社会主义法治国家。", .s, .original, nil, ["依法治国", "法治体系", "法治国家"]),
            kp("k1802", "法治四层", "科学立法、严格执法、公正司法、全民守法各有主体和要求，主观题不能混写。", .s, .subject, "政府严格执法，司法机关公正司法。", ["立法", "执法", "司法", "守法"])
        ], boss: "duel_rulelaw"),
        node("n19", .required, .philosophyCulture, "唯物论与认识论", "哲学题先定范围，再调原理", .philosophyLocator, [
            kp("k1901", "物质与意识", "物质决定意识，意识对物质具有能动作用，要求一切从实际出发、实事求是，重视正确意识指导。", .s, .template, nil, ["物质", "意识", "实际"]),
            kp("k1902", "实践与认识", "实践是认识的来源、动力、目的和检验认识真理性的唯一标准，认识对实践具有反作用。", .s, .original, nil, ["实践", "认识", "真理"])
        ]),
        node("n20", .required, .philosophyCulture, "唯物辩证法：联系、发展、矛盾", "哲学压轴核心，矛盾先问三句", .contradictionThreeQuestions, [
            kp("k2001", "联系与发展", "联系具有普遍性、客观性、多样性，发展是事物的前进和上升，要用联系、发展观点看问题。", .s, .template, nil, ["联系", "发展", "系统"]),
            kp("k2002", "矛盾观", "矛盾具有普遍性和特殊性，要坚持具体问题具体分析；主要矛盾和矛盾主要方面不能混。", .s, .boundary, "问做法多看主要矛盾，问性质多看矛盾主要方面。", ["矛盾", "具体问题具体分析", "主次"])
        ], boss: "duel_contradiction"),
        node("n21", .required, .philosophyCulture, "历史唯物主义与价值选择", "社会历史双线：人民与价值", .philosophyLocator, [
            kp("k2101", "社会存在与社会意识", "社会存在决定社会意识，社会意识具有相对独立性，先进社会意识对社会发展起积极推动作用。", .s, .original, nil, ["社会存在", "社会意识", "相对独立"]),
            kp("k2102", "人民群众", "人民群众是社会历史的主体，是历史的创造者，要坚持群众观点和群众路线。", .s, .template, nil, ["人民群众", "主体", "群众路线"])
        ]),
        node("n22", .required, .philosophyCulture, "文化传承、文化创新与文化强国", "文化题按传承、创新、交流三维组织", .cultureTemplate, [
            kp("k2201", "文化传承发展", "对优秀传统文化要创造性转化、创新性发展，既守正又创新。", .a, .template, nil, ["传统文化", "创造性转化", "创新性发展"]),
            kp("k2202", "文化强国", "建设文化强国要坚定文化自信，发展社会主义先进文化，弘扬革命文化，传承中华优秀传统文化。", .a, .original, nil, ["文化自信", "文化强国", "先进文化"])
        ]),
        node("n23", .elective, .international, "国际政治经济与国家利益", "国际题先看主权、利益、时代主题", .internationalFilter, [
            kp("k2301", "国家利益", "国家利益和国家实力是影响国际关系的决定性因素，维护国家利益是主权国家对外活动的出发点和落脚点。", .a, .original, nil, ["国家利益", "国际关系", "国家实力"]),
            kp("k2302", "和平与发展", "和平与发展是当今时代主题，世界多极化、经济全球化深入发展，但国际竞争也更加复杂。", .a, .scene, "经济全球化不等于各国利益完全一致。", ["和平", "发展", "全球化"])
        ]),
        node("n24", .elective, .legalLife, "民法、婚姻家庭、就业创业", "案例题先定权利，再定责任", .civilCaseFourSteps, [
            kp("k2401", "民事权利", "民事主体依法享有人身权、财产权、知识产权等权利，行使权利不得损害国家、社会、集体和他人合法权益。", .a, .subject, nil, ["民事权利", "财产权", "人身权"]),
            kp("k2402", "侵权与违约", "民事案例先分合同关系还是侵权关系，再判断过错、损害、因果关系和责任承担方式。", .a, .template, "侵权责任和违约责任不要混答。", ["侵权", "违约", "责任"])
        ]),
        node("n25", .elective, .legalLife, "诉讼、调解、仲裁与维权", "纠纷解决路径要选对", .civilCaseFourSteps, [
            kp("k2501", "纠纷解决", "调解、仲裁、诉讼各有适用条件。诉讼是解决纠纷的最后途径，证据是诉讼的灵魂。", .b, .scene, "仲裁通常需有效仲裁协议。", ["调解", "仲裁", "诉讼"]),
            kp("k2502", "依法维权", "依法维权要保全证据、选择合法途径、遵守程序，不得以违法方式维护权利。", .b, .template, nil, ["维权", "证据", "程序"])
        ]),
        node("n26", .elective, .logicThinking, "概念、判断、推理", "逻辑形式排雷，选必题稳住区分度", .logicFormFilter, [
            kp("k2601", "概念外延", "概念要明确内涵和外延，划分必须遵循同一标准、子项相互排斥、划分完全。", .b, .boundary, "划分标准混乱会导致逻辑错误。", ["概念", "外延", "划分"]),
            kp("k2602", "推理有效", "演绎推理重形式有效，归纳推理和类比推理重可靠程度，充分条件和必要条件要分清。", .b, .scene, nil, ["推理", "充分条件", "必要条件"])
        ]),
        node("n27", .sprint, .sprint, "时政热点与教材映射", "把新闻语言翻译成教材语言", .hotTopicTranslator, [
            kp("k2701", "热点三层转译", "时政材料先转成政策主题，再落到教材模块，最后写成可采分答案句。", .s, .template, nil, ["时政", "教材语言", "答案语言"]),
            kp("k2702", "热点不替代教材", "热点只是材料载体，答案仍以教材原理和学科术语为核心。", .s, .boundary, "不能把新闻评论直接当政治答案。", ["热点", "教材", "术语"])
        ], boss: "duel_hot"),
        node("n28", .sprint, .sprint, "主观题答案工厂", "审题、定域、定主体、调知识、贴材料、成答案", .essaySixSteps, [
            kp("k2801", "答案句三件套", "高分答案句由教材术语、材料对应、结果意义组成，三者缺一就容易失分。", .s, .template, nil, ["术语", "材料", "意义"]),
            kp("k2802", "主观题六步法", "审设问、定模块、定主体、召回原理、切材料、写答案句，最后查主体错配和范围越界。", .s, .template, nil, ["审题", "主体", "材料"])
        ], boss: "duel_essay")
    ])

    static var allKnowledgePoints: [KnowledgePoint] {
        nodes.flatMap { coveragePoints(for: $0) }
    }

    static func coveragePoints(for node: LearningNode) -> [KnowledgePoint] {
        node.knowledgePoints + ExamPointCatalog.points(for: node.id)
    }

    static func node(id: String) -> LearningNode? {
        nodes.first { $0.id == id }
    }

    static func knowledge(id: String) -> KnowledgePoint? {
        allKnowledgePoints.first { $0.id == id }
    }

    private static func node(_ id: String,
                             _ stage: Stage,
                             _ topic: PoliticsTopic,
                             _ title: String,
                             _ tagline: String,
                             _ weapon: PoliticsWeapon,
                             _ points: [KnowledgePoint],
                             boss: String? = nil) -> LearningNode {
        LearningNode(id: id,
                     order: 0,
                     stage: stage,
                     topic: topic,
                     title: title,
                     tagline: tagline,
                     knowledgePoints: points,
                     practiceIds: points.map { "q_\(id)_\($0.id)_0" },
                     bossCaseId: boss,
                     weaponUnlocked: weapon)
    }

    private static func kp(_ id: String,
                           _ title: String,
                           _ detail: String,
                           _ grade: ImportanceGrade,
                           _ type: MemoryCardType,
                           _ pitfall: String? = nil,
                           _ keywords: [String] = []) -> KnowledgePoint {
        KnowledgePoint(id: id,
                       title: title,
                       detail: detail,
                       grade: grade,
                       cardType: type,
                       pitfall: pitfall,
                       keywords: keywords)
    }

    private static func assignOrder(_ list: [LearningNode]) -> [LearningNode] {
        var copy = list
        for index in copy.indices {
            copy[index].order = index + 1
        }
        return copy
    }
}

enum ExamPointCatalog {
    static func points(for nodeId: String) -> [KnowledgePoint] {
        additional[nodeId] ?? []
    }

    static let additional: [String: [KnowledgePoint]] = [
        "n01": [
            kp("k0103", "敬畏生命", "敬畏生命要求珍视自己的生命，也关怀他人的生命，做到休戚与共。", .b, .scene, nil, ["敬畏生命", "关怀"]),
            kp("k0104", "挫折与生命韧性", "挫折具有双重影响，关键在于发掘生命力量、增强承受力和自我调节能力。", .b, .template, nil, ["挫折", "韧性"])
        ],
        "n02": [
            kp("k0203", "情感的作用", "美好情感表达愿望、促进精神发展，负面情感也可丰富人生阅历、促进成长。", .c, .boundary, nil, ["情感", "精神发展"]),
            kp("k0204", "正确认识自己", "认识自己要从生理、心理、社会等方面，通过自我评价和他人评价相结合。", .b, .template, nil, ["认识自己", "评价"])
        ],
        "n03": [
            kp("k0303", "友谊的澄清", "友谊不能没有原则，竞争并不必然伤害友谊，网上交友要慎重。", .b, .boundary, nil, ["友谊", "原则", "竞争"]),
            kp("k0304", "美好集体", "美好集体是民主公正、充满关怀、善于合作、充满活力的共同体。", .b, .original, nil, ["集体", "合作"])
        ],
        "n04": [
            kp("k0403", "亲社会行为", "亲社会行为在人际交往和社会实践中养成，要主动了解社会、服务社会。", .b, .scene, nil, ["亲社会", "服务"]),
            kp("k0404", "维护国家安全", "国家安全是国家生存与发展的重要保障，人人都是维护国家安全的主角。", .a, .original, nil, ["国家安全", "责任"])
        ],
        "n05": [
            kp("k0503", "违法行为分类", "违法行为包括民事违法、行政违法和刑事违法，犯罪是最严重的违法行为。", .a, .boundary, "违法不一定犯罪，犯罪一定违法。", ["违法", "犯罪"]),
            kp("k0504", "依法求助", "遇到侵害要及时寻求法律救助，善用调解、仲裁、诉讼等合法途径。", .b, .scene, nil, ["法律救助", "诉讼"])
        ],
        "n06": [
            kp("k0603", "规范权力运行", "国家权力必须在宪法和法律限定范围内行使，把权力关进制度的笼子。", .a, .template, nil, ["权力", "宪法监督"]),
            kp("k0604", "基本权利", "公民基本权利包括政治权利和自由、人身自由、社会经济与文化教育权利等。", .a, .subject, "监督权不是随意造谣攻击。", ["基本权利", "监督权"])
        ],
        "n07": [
            kp("k0703", "基本政治制度", "中国共产党领导的多党合作和政治协商制度、民族区域自治制度、基层群众自治制度是我国基本政治制度。", .a, .original, nil, ["基本政治制度", "基层自治"]),
            kp("k0704", "国家机构组织原则", "民主集中制是我国国家机构的组织和活动原则。", .a, .original, nil, ["民主集中制", "国家机构"])
        ],
        "n08": [
            kp("k0803", "改革开放", "改革开放是决定当代中国命运的关键抉择，是强国之路、富民之路。", .a, .original, nil, ["改革开放", "强国"]),
            kp("k0804", "新发展理念", "创新、协调、绿色、开放、共享的发展理念相互贯通，统一服务高质量发展。", .a, .template, nil, ["新发展理念", "高质量"])
        ],
        "n09": [
            kp("k0903", "民族团结", "维护民族团结要坚持民族平等、民族团结和各民族共同繁荣的方针。", .b, .original, nil, ["民族团结", "共同繁荣"]),
            kp("k0904", "世界舞台上的中国", "中国坚持合作共赢理念，推动构建人类命运共同体。", .b, .scene, nil, ["中国担当", "命运共同体"])
        ],
        "n10": [
            kp("k1003", "生产力决定生产关系", "生产力是最革命、最活跃的因素，生产关系一定要适应生产力发展状况。", .a, .boundary, nil, ["生产力", "生产关系"]),
            kp("k1004", "资本主义基本矛盾", "生产社会化和生产资料资本主义私人占有之间的矛盾是资本主义社会的基本矛盾。", .b, .original, nil, ["资本主义", "基本矛盾"])
        ],
        "n11": [
            kp("k1103", "中国特色社会主义制度优势", "制度优势要结合党的领导、人民当家作主、集中力量办大事、依法治国等角度说明。", .s, .template, nil, ["制度优势", "治理效能"]),
            kp("k1104", "伟大实践与理论创新", "中国特色社会主义理论体系形成于改革开放和社会主义现代化建设实践，并随实践不断发展。", .a, .scene, nil, ["理论创新", "实践"])
        ],
        "n12": [
            kp("k1203", "中国梦本质", "中国梦的本质是国家富强、民族振兴、人民幸福。", .a, .original, nil, ["中国梦", "人民幸福"]),
            kp("k1204", "两步走战略安排", "全面建设社会主义现代化国家分阶段推进，青年担当要服务民族复兴进程。", .b, .scene, nil, ["现代化", "青年"])
        ],
        "n13": [
            kp("k1303", "公有制主体地位", "公有制主体地位主要体现在公有资产在社会总资产中占优势，国有经济控制国民经济命脉。", .s, .boundary, "主体地位不等于国有资产在每个行业都占优势。", ["公有制", "国有经济"]),
            kp("k1304", "按劳分配", "按劳分配是社会主义的分配原则，以劳动者向社会提供的劳动为尺度进行个人消费品分配。", .a, .original, nil, ["按劳分配", "劳动"])
        ],
        "n14": [
            kp("k1403", "市场缺陷", "市场调节存在自发性、盲目性、滞后性，公共物品、外部性、垄断等领域需要政府治理。", .s, .boundary, nil, ["市场缺陷", "垄断"]),
            kp("k1404", "财政货币政策", "财政政策和货币政策是宏观调控常用经济手段，要结合扩需求、稳就业、促发展分析传导。", .a, .scene, nil, ["财政政策", "货币政策"])
        ],
        "n15": [
            kp("k1503", "效率与公平", "初次分配和再分配都要兼顾效率与公平，再分配更加注重公平。", .a, .boundary, nil, ["效率", "公平"]),
            kp("k1504", "共同富裕路径", "共同富裕要靠高质量发展做大蛋糕，也要通过合理制度安排分好蛋糕。", .a, .template, nil, ["共同富裕", "分配"])
        ],
        "n16": [
            kp("k1603", "全面从严治党", "全面从严治党关系党的先进性和纯洁性，能提高党的执政能力和领导水平。", .s, .scene, nil, ["从严治党", "执政能力"]),
            kp("k1604", "党的执政方式", "科学执政强调遵循规律，民主执政强调依靠人民，依法执政强调依宪执政、依法治国。", .s, .boundary, nil, ["科学执政", "民主执政", "依法执政"])
        ],
        "n17": [
            kp("k1703", "政协职能", "人民政协履行政治协商、民主监督、参政议政职能，是社会主义协商民主的重要渠道。", .s, .subject, "政协不是国家机关，不行使国家权力。", ["政协", "协商民主"]),
            kp("k1704", "民族区域自治", "民族区域自治是在国家统一领导下，各少数民族聚居地方实行区域自治，自治机关行使自治权。", .a, .boundary, nil, ["民族区域自治", "自治权"])
        ],
        "n18": [
            kp("k1803", "宪法法律至上", "全面依法治国要坚持宪法法律至上，坚持法治国家、法治政府、法治社会一体建设。", .s, .template, nil, ["宪法", "一体建设"]),
            kp("k1804", "司法公正", "公正司法是维护社会公平正义的最后一道防线，司法机关必须依法独立公正行使职权。", .s, .subject, "行政机关不能行使审判权。", ["司法", "公平正义"])
        ],
        "n19": [
            kp("k1903", "规律客观性", "规律是客观的、普遍的，必须尊重客观规律，并发挥主观能动性。", .s, .boundary, "发挥能动性不能违背规律。", ["规律", "能动性"]),
            kp("k1904", "真理具体有条件", "真理是具体的有条件的，追求真理是一个过程，要在实践中认识和发现真理。", .s, .scene, nil, ["真理", "实践"])
        ],
        "n20": [
            kp("k2003", "系统优化", "掌握系统优化方法，要立足整体、统筹全局，优化组合，实现整体功能最大化。", .s, .template, nil, ["系统", "整体"]),
            kp("k2004", "辩证否定", "辩证否定是联系和发展的环节，实质是扬弃，要求树立创新意识。", .a, .original, nil, ["辩证否定", "创新"])
        ],
        "n21": [
            kp("k2103", "价值判断与价值选择", "价值判断和价值选择具有社会历史性、阶级性和主体差异性，正确标准是遵循社会发展规律、站在最广大人民立场。", .s, .template, nil, ["价值判断", "人民立场"]),
            kp("k2104", "改革", "改革是社会主义制度的自我完善和发展，是发展中国特色社会主义的强大动力。", .a, .scene, nil, ["改革", "社会基本矛盾"])
        ],
        "n22": [
            kp("k2203", "文化交流互鉴", "文化交流构成文化发展的重要动力，要面向世界、博采众长，以我为主、为我所用。", .a, .boundary, "交流互鉴不是全盘西化。", ["文化交流", "互鉴"]),
            kp("k2204", "意识形态与核心价值观", "建设文化强国要牢牢掌握意识形态工作领导权，培育和践行社会主义核心价值观。", .a, .original, nil, ["意识形态", "核心价值观"])
        ],
        "n23": [
            kp("k2303", "主权国家权利义务", "主权国家享有独立权、平等权、自卫权、管辖权，也应履行不侵犯别国、不干涉内政等义务。", .a, .subject, nil, ["主权", "权利"]),
            kp("k2304", "经济全球化", "经济全球化主要表现为生产、贸易、金融全球化，要推动普惠、平衡、共赢方向发展。", .a, .scene, nil, ["全球化", "开放"])
        ],
        "n24": [
            kp("k2403", "合同履行", "合同依法成立即具有法律约束力，当事人应全面、诚信履行合同义务。", .a, .original, nil, ["合同", "诚信"]),
            kp("k2404", "劳动者权利", "劳动者享有取得劳动报酬、休息休假、劳动安全卫生保护、社会保险福利等权利。", .a, .subject, nil, ["劳动者", "权利"])
        ],
        "n25": [
            kp("k2503", "证据意识", "打官司就是打证据，证据要真实、合法、关联，日常生活要注意留痕。", .b, .scene, nil, ["证据", "诉讼"]),
            kp("k2504", "诉讼权利", "当事人依法享有委托诉讼代理人、申请回避、上诉等诉讼权利。", .b, .subject, nil, ["诉讼权利", "代理"])
        ],
        "n26": [
            kp("k2603", "复合判断", "联言、选言、假言判断有不同真假规则，做题先还原逻辑连接词。", .b, .boundary, nil, ["联言", "选言", "假言"]),
            kp("k2604", "三段论规则", "三段论要有且只有三个不同项，中项至少周延一次，前提中不周延的项结论中不得周延。", .b, .scene, nil, ["三段论", "中项"])
        ],
        "n27": [
            kp("k2703", "新质生产力映射", "新质生产力常映射创新发展、科技自立自强、现代化产业体系和高质量发展。", .s, .scene, nil, ["新质生产力", "创新"]),
            kp("k2704", "共同体与全球治理映射", "国际热点常映射国家利益、独立自主和平外交政策、人类命运共同体。", .a, .scene, nil, ["全球治理", "国家利益"])
        ],
        "n28": [
            kp("k2803", "原因类模板", "原因类设问按必要性、重要性、意义展开，既要写现实问题，也要写制度优势和结果。", .s, .template, nil, ["原因", "意义"]),
            kp("k2804", "措施类模板", "措施类设问按主体加措施加结果写，多个主体出现时分主体作答。", .s, .template, nil, ["措施", "主体"])
        ]
    ]

    private static func kp(_ id: String,
                           _ title: String,
                           _ detail: String,
                           _ grade: ImportanceGrade,
                           _ type: MemoryCardType,
                           _ pitfall: String? = nil,
                           _ keywords: [String] = []) -> KnowledgePoint {
        KnowledgePoint(id: id,
                       title: title,
                       detail: detail,
                       grade: grade,
                       cardType: type,
                       pitfall: pitfall,
                       keywords: keywords)
    }
}

enum QuestionBank {
    static let all: [PoliticsQuestion] = MainLineData.nodes.flatMap { node in
        MainLineData.coveragePoints(for: node).flatMap { point in
            (0..<questionCount(for: point.grade)).map { variant in
                makeQuestion(node: node, point: point, variant: variant)
            }
        }
    }

    static func questions(topic: PoliticsTopic) -> [PoliticsQuestion] {
        all.filter { $0.topic == topic }
    }

    static func questions(nodeId: String) -> [PoliticsQuestion] {
        all.filter { $0.nodeId == nodeId }
    }

    static func question(id: String) -> PoliticsQuestion? {
        all.first { $0.id == id }
    }

    static func questionCount(for grade: ImportanceGrade) -> Int {
        switch grade {
        case .s: return 4
        case .a: return 3
        case .b: return 2
        case .c: return 1
        }
    }

    private static func makeQuestion(node: LearningNode, point: KnowledgePoint, variant: Int) -> PoliticsQuestion {
        let correct = correctOption(for: point, variant: variant)
        let distractors = distractors(for: point, node: node)
        var options = [correct] + distractors
        let shift = variant % options.count
        options = Array(options[shift..<options.count] + options[0..<shift])
        let answerIndex = options.firstIndex(of: correct) ?? 0
        return PoliticsQuestion(
            id: "q_\(node.id)_\(point.id)_\(variant)",
            nodeId: node.id,
            knowledgeId: point.id,
            topic: node.topic,
            stage: node.stage,
            prompt: prompt(for: point, variant: variant),
            options: options,
            answerIndex: answerIndex,
            explanation: "本题考查 \(point.title)。\(point.detail)" + (point.pitfall.map { " 易错点：\($0)" } ?? ""),
            trapTags: trapTags(for: point),
            weapon: node.weaponUnlocked
        )
    }

    private static func prompt(for point: KnowledgePoint, variant: Int) -> String {
        switch variant % 4 {
        case 0: return "以下关于「\(point.title)」的表述，最准确的是："
        case 1: return "材料题调用「\(point.title)」时，最应注意的是："
        case 2: return "下列说法中，最能避免「\(point.title)」常见失分的是："
        default: return "围绕「\(point.title)」组织答案，正确路径是："
        }
    }

    private static func correctOption(for point: KnowledgePoint, variant: Int) -> String {
        switch point.cardType {
        case .original: return "使用教材规范表述，并结合材料说明其作用或意义。"
        case .boundary: return "先分清概念边界和适用范围，再判断材料是否匹配。"
        case .subject: return "先锁定行为主体，再写该主体依法或依规能够履行的职责。"
        case .scene: return "由材料场景触发对应模块，再用关键词召回相关原理。"
        case .template: return "按设问类型组织为原理句、材料句和结果意义句。"
        }
    }

    private static func distractors(for point: KnowledgePoint, node: LearningNode) -> [String] {
        [
            "只要方向正确，可以用生活化语言替代学科术语。",
            "看到相近关键词，就把 \(node.topic.name) 的全部原理都写上。",
            "优先选择表述绝对、范围最大的选项，因为政治题强调立场鲜明。"
        ]
    }

    private static func trapTags(for point: KnowledgePoint) -> [String] {
        switch point.cardType {
        case .original: return ["术语不准", "偷换表述"]
        case .boundary: return ["范围越界", "概念混淆"]
        case .subject: return ["主体错配", "职责串台"]
        case .scene: return ["材料没贴", "正确无关"]
        case .template: return ["要点缺失", "结构松散"]
        }
    }
}

enum SubjectiveQuestionData {
    static let all: [SubjectiveQuestion] = MainLineData.nodes.flatMap { node in
        MainLineData.coveragePoints(for: node)
            .filter { $0.grade == .s || $0.grade == .a }
            .map { point in
                SubjectiveQuestion(
                    id: "sq_\(node.id)_\(point.id)",
                    nodeId: node.id,
                    knowledgeId: point.id,
                    grade: point.grade,
                    material: material(for: point, node: node),
                    prompt: "结合材料，运用「\(node.topic.name)」知识说明「\(point.title)」的答题要点。",
                    answerPoints: answerPoints(for: point),
                    diagnostics: ["主体是否准确", "术语是否使用教材表达", "材料动作是否贴上", "结果或意义是否写出"]
                )
            }
    }

    static func questions(nodeId: String) -> [SubjectiveQuestion] {
        all.filter { $0.nodeId == nodeId }
    }

    static func questions(knowledgeId: String) -> [SubjectiveQuestion] {
        all.filter { $0.knowledgeId == knowledgeId }
    }

    private static func material(for point: KnowledgePoint, node: LearningNode) -> String {
        let keyword = point.keywords.first ?? point.title
        switch node.topic {
        case .economy:
            return "围绕 \(keyword)，某地通过政策引导、市场竞争和企业创新推动高质量发展。"
        case .politicsLaw:
            return "围绕 \(keyword)，当地党委、人大、政府和群众依法有序参与治理，推动问题解决。"
        case .philosophyCulture:
            return "围绕 \(keyword)，某地坚持从实际出发，在实践探索中统筹多重关系并推动创新。"
        case .legalLife:
            return "围绕 \(keyword)，当事人依法收集证据、选择合法途径维护自身权益。"
        case .international:
            return "围绕 \(keyword)，我国在维护国家利益的同时倡导合作共赢。"
        default:
            return "围绕 \(keyword)，学生在真实情境中作出价值判断并依法承担责任。"
        }
    }

    private static func answerPoints(for point: KnowledgePoint) -> [String] {
        [
            "教材术语：\(point.detail)",
            "材料对应：抓住 \(point.keywords.prefix(2).joined(separator: "、")) 等关键信号。",
            "结果意义：回到题目要求，写出对发展、法治、民主、公平或成长的作用。"
        ]
    }
}


enum BossDuelData {
    static let all: [BossDuel] = [
        BossDuel(
            id: "duel_organs",
            nodeId: "n07",
            title: "国家机关职责表",
            material: "某市人大常委会听取市政府民生实事办理报告，并对法院优化诉讼服务工作开展专题询问。",
            question: "分析材料中不同国家机关的职责定位。",
            standard: SolutionPath(title: "常规解：逐句背机构", steps: ["回忆国家机关名称", "逐一罗列职权", "尝试对应材料"], timeMinutes: 6),
            weaponPath: SolutionPath(title: "武器解：主体职责表", steps: ["人大：监督政府和司法机关工作", "政府：履行行政管理和公共服务职能", "法院：行使审判权、优化司法服务"], timeMinutes: 2),
            weapon: .organDutyTable,
            keyInsight: "材料出现机关名称，先定主体，再写该主体能做什么，避免把人大、政府、司法机关串台。",
            sampleAnswer: ["人大常委会依法行使监督权，听取政府报告、开展专题询问，推动民生实事落实。", "政府作为行政机关履行职能，对民生实事办理负责。", "法院行使审判权并提升诉讼服务，维护公平正义。"]
        ),
        BossDuel(
            id: "duel_market_macro",
            nodeId: "n14",
            title: "市场与宏观调控双轮",
            material: "平台企业无序扩张造成价格歧视和数据垄断，监管部门依法规范平台经营，同时支持企业技术创新。",
            question: "说明如何发挥社会主义市场经济体制优势。",
            standard: SolutionPath(title: "常规解：背市场和政府", steps: ["写市场决定作用", "写政府宏观调控", "补一句创新"], timeMinutes: 7),
            weaponPath: SolutionPath(title: "武器解：经济传导链", steps: ["问题：市场自发性导致垄断和不公平", "政府：依法监管，弥补市场缺陷", "市场：保护公平竞争，激发创新活力"], timeMinutes: 2.5),
            weapon: .economyChain,
            keyInsight: "经济题不要把政府和市场对立起来，按问题、主体、机制、结果写传导链。",
            sampleAnswer: ["发挥市场在资源配置中的决定性作用，保护公平竞争，引导平台企业提升效率和创新能力。", "政府进行科学宏观调控和有效治理，依法规范垄断、价格歧视等行为。", "把有效市场和有为政府结合起来，促进平台经济规范健康持续发展。"]
        ),
        BossDuel(
            id: "duel_party",
            nodeId: "n16",
            title: "党政主体分离",
            material: "地方党委把方向、管大局、保落实，政府随后出台优化营商环境的具体政策，人大依法审议相关法规草案。",
            question: "说明党的领导如何转化为治理效能。",
            standard: SolutionPath(title: "常规解：党的领导万能句", steps: ["写党的领导重要性", "写政府和人大", "结尾写治理"], timeMinutes: 8),
            weaponPath: SolutionPath(title: "武器解：主体定位法", steps: ["党：总揽全局、协调各方", "政府：依法行政、履行经济职能", "人大：依法立法和监督，使主张法定化"], timeMinutes: 3),
            weapon: .subjectLocator,
            keyInsight: "党领导不等于党包办，主观题要写出党支持国家机关依法履职。",
            sampleAnswer: ["党发挥总揽全局、协调各方的领导核心作用，为优化营商环境把方向。", "政府依法行政，制定和落实具体政策，提高公共服务和经济治理水平。", "人大依法行使立法权和监督权，把党的主张通过法定程序转化为国家意志。"]
        ),
        BossDuel(
            id: "duel_rulelaw",
            nodeId: "n18",
            title: "法治四层定位",
            material: "某地完善地方立法，规范行政执法裁量基准，推进公开审判，并开展社区普法。",
            question: "从全面依法治国角度分析材料。",
            standard: SolutionPath(title: "常规解：法治口号堆叠", steps: ["写依法治国", "写法治国家", "写公平正义"], timeMinutes: 6.5),
            weaponPath: SolutionPath(title: "武器解：四层定位", steps: ["地方立法对应科学立法", "裁量基准对应严格执法", "公开审判对应公正司法", "社区普法对应全民守法"], timeMinutes: 2),
            weapon: .ruleOfLawLayers,
            keyInsight: "法治材料通常已经按立法、执法、司法、守法埋点，逐层对应就是得分点。",
            sampleAnswer: ["完善地方立法，推进科学立法，为治理提供良法基础。", "规范行政执法裁量基准，促进严格规范公正文明执法。", "公开审判维护司法公正，社区普法推动全民守法。"]
        ),
        BossDuel(
            id: "duel_contradiction",
            nodeId: "n20",
            title: "矛盾秒杀三问",
            material: "某地推进老旧小区改造，既要保留历史风貌，又要解决停车、管线、安全等突出问题。",
            question: "运用矛盾观说明该地做法。",
            standard: SolutionPath(title: "常规解：矛盾原理全背", steps: ["写矛盾普遍性", "写特殊性", "写主次矛盾", "写两点论"], timeMinutes: 9),
            weaponPath: SolutionPath(title: "武器解：三问定位", steps: ["有不同要求并存：承认矛盾普遍性", "每个小区情况不同：具体问题具体分析", "突出问题优先解决：抓主要矛盾，同时兼顾历史风貌"], timeMinutes: 3),
            weapon: .contradictionThreeQuestions,
            keyInsight: "问做法先找主要矛盾，问性质再看矛盾主要方面；材料中不同对象提示矛盾特殊性。",
            sampleAnswer: ["承认矛盾、分析矛盾，统筹历史风貌保护与居住条件改善。", "坚持具体问题具体分析，根据不同小区实际制定改造方案。", "抓住停车、管线、安全等主要问题，同时兼顾文化保护，坚持两点论和重点论统一。"]
        ),
        BossDuel(
            id: "duel_hot",
            nodeId: "n27",
            title: "热点三层转译",
            material: "围绕新质生产力，各地加强科技创新、产业升级和人才培养，推动经济高质量发展。",
            question: "把材料转化为经济与社会可用答案。",
            standard: SolutionPath(title: "常规解：照抄热点词", steps: ["写新质生产力", "写创新", "写高质量发展"], timeMinutes: 5),
            weaponPath: SolutionPath(title: "武器解：三层转译", steps: ["时政语言：新质生产力", "教材语言：创新发展、供给侧结构、现代化产业体系", "答案语言：创新驱动和实体经济支撑高质量发展"], timeMinutes: 1.8),
            weapon: .hotTopicTranslator,
            keyInsight: "热点不是答案本身，要翻译成教材模块和可采分术语。",
            sampleAnswer: ["坚持创新发展，强化科技创新和人才支撑，培育发展新动能。", "推动产业结构优化升级，建设现代化产业体系。", "把创新成果转化为现实生产力，促进经济高质量发展。"]
        ),
        BossDuel(
            id: "duel_essay",
            nodeId: "n28",
            title: "主观题六步法",
            material: "某村通过基层协商确定公共空间改造方案，村民参与议事、监督资金使用，改造后公共服务和邻里关系明显改善。",
            question: "分析基层治理经验的政治意义。",
            standard: SolutionPath(title: "常规解：民主治理套话", steps: ["写民主", "写基层自治", "写人民参与"], timeMinutes: 7),
            weaponPath: SolutionPath(title: "武器解：六步成答案", steps: ["审设问：意义类", "定模块：基层群众自治", "定主体：村民、基层组织", "切材料：协商、监督、公共服务", "成句：术语+材料+意义"], timeMinutes: 2.5),
            weapon: .essaySixSteps,
            keyInsight: "每个答案句必须同时有教材术语、材料动作和结果意义。",
            sampleAnswer: ["发展基层民主，村民通过协商参与公共事务决策，保障人民依法直接行使民主权利。", "完善基层群众自治，村民监督资金使用，提升基层治理透明度和效能。", "公共服务改善和邻里关系优化，增强群众获得感，推动共建共治共享。"]
        )
    ]

    static func duel(id: String) -> BossDuel? {
        all.first { $0.id == id }
    }
}

enum MemoryData {
    static let all: [MemoryCard] = MainLineData.allKnowledgePoints.map { point in
        MemoryCard(id: "m_\(point.id)",
                   knowledgeId: point.id,
                   type: point.cardType,
                   grade: point.grade,
                   front: prompt(for: point),
                   back: point.detail + (point.pitfall.map { "\n易错：\($0)" } ?? ""),
                   mode: mode(for: point.cardType))
    }

    static func cards(type: MemoryCardType) -> [MemoryCard] {
        all.filter { $0.type == type }
    }

    static func highWeight(limit: Int) -> [MemoryCard] {
        Array(all.sorted { $0.grade > $1.grade }.prefix(limit))
    }

    private static func prompt(for point: KnowledgePoint) -> String {
        switch point.cardType {
        case .original: return "默写教材表述：\(point.title)"
        case .boundary: return "辨析边界：\(point.title)"
        case .subject: return "主体能做什么：\(point.title)"
        case .scene: return "看到哪些材料要想到：\(point.title)"
        case .template: return "按高分模板输出：\(point.title)"
        }
    }

    private static func mode(for type: MemoryCardType) -> RecallMode {
        switch type {
        case .original: return .recite
        case .boundary: return .distinguish
        case .subject: return .distinguish
        case .scene: return .apply
        case .template: return .apply
        }
    }
}

enum MaterialCaseData {
    static let all: [MaterialCase] = [
        MaterialCase(
            id: "mc_platform",
            title: "平台经济反垄断",
            material: "平台企业利用数据和算法设置不合理交易条件，监管部门依法查处并推动平台开放生态。",
            question: "运用经济与社会知识分析治理平台垄断的必要性。",
            subject: "政府、市场、企业",
            action: "依法监管、规范竞争、推动开放",
            object: "平台经济、数据算法、市场秩序",
            goal: "公平竞争、高质量发展、消费者权益",
            knowledgeIds: ["k1401", "k1402"],
            answerSentences: ["市场调节存在自发性等弊端，平台垄断会破坏公平竞争和消费者权益。", "政府进行科学宏观调控和有效治理，依法规范平台经营。", "把有效市场和有为政府结合起来，促进平台经济规范健康发展。"],
            diagnostics: ["主体：政府不能写成直接经营企业", "术语：市场决定作用与宏观调控都要出现"]
        ),
        MaterialCase(
            id: "mc_grassroots",
            title: "基层协商治理",
            material: "社区通过居民议事会协商停车方案，公开收支明细，并邀请居民代表监督施工。",
            question: "说明基层民主实践的意义。",
            subject: "居民、基层群众性自治组织",
            action: "协商、公开、监督",
            object: "社区公共事务",
            goal: "人民当家作主、治理效能",
            knowledgeIds: ["k1701", "k2801"],
            answerSentences: ["基层协商保障居民依法直接行使民主权利，体现全过程人民民主。", "公开收支并接受监督，有利于规范基层治理、提升治理效能。", "居民参与公共事务，形成共建共治共享的社区治理格局。"],
            diagnostics: ["边界：居民参与基层自治，不是直接行使国家权力"]
        ),
        MaterialCase(
            id: "mc_law",
            title: "严格执法与普法",
            material: "某地规范行政处罚自由裁量权，同时把典型案例制作成普法课程进社区。",
            question: "从法治角度分析该地做法。",
            subject: "政府、社会公众",
            action: "规范执法、开展普法",
            object: "行政处罚、社区治理",
            goal: "严格执法、全民守法",
            knowledgeIds: ["k1801", "k1802"],
            answerSentences: ["规范行政处罚裁量权，有利于推进严格规范公正文明执法。", "普法进社区增强公民法治意识，推动全民守法。", "执法和守法协同发力，有利于建设社会主义法治国家。"],
            diagnostics: ["主体：行政执法主体是政府相关部门，不是法院"]
        ),
        MaterialCase(
            id: "mc_culture",
            title: "非遗创新传播",
            material: "地方将传统技艺与数字展陈、文创产品结合，吸引青年参与传承。",
            question: "运用文化知识说明其合理性。",
            subject: "地方、青年、文化机构",
            action: "传承、创新、传播",
            object: "中华优秀传统文化",
            goal: "文化自信、文化发展",
            knowledgeIds: ["k2201", "k2202"],
            answerSentences: ["推动中华优秀传统文化创造性转化、创新性发展，使传统技艺适应时代需求。", "创新传播方式，增强文化吸引力和影响力。", "吸引青年参与传承，有利于坚定文化自信、建设文化强国。"],
            diagnostics: ["范围：不能只写经济价值，要回到文化传承发展"]
        ),
        MaterialCase(
            id: "mc_philosophy",
            title: "老旧小区改造",
            material: "改造方案既保护历史风貌，又优先解决安全隐患、停车困难和管线老化。",
            question: "运用矛盾观分析改造思路。",
            subject: "地方政府、居民",
            action: "统筹、保护、优先解决",
            object: "历史风貌与居住条件",
            goal: "改善民生、协调发展",
            knowledgeIds: ["k2001", "k2002"],
            answerSentences: ["矛盾具有普遍性，要承认并分析保护与改造之间的矛盾。", "坚持具体问题具体分析，根据小区实际制定方案。", "抓住安全隐患等主要矛盾，同时兼顾历史风貌保护，坚持两点论和重点论统一。"],
            diagnostics: ["定位：问做法优先抓主要矛盾，别只写矛盾主要方面"]
        )
    ]
}

enum ConceptGraphData {
    static let nodes: [ConceptNode] = [
        ConceptNode(id: "c_party", title: "党的领导", subtitle: "最本质特征、最大优势", grade: .s, topic: .politicsLaw, triggerWords: ["党委", "领导核心", "把方向"]),
        ConceptNode(id: "c_government", title: "政府", subtitle: "依法行政、履行职能", grade: .s, topic: .politicsLaw, triggerWords: ["监管", "政策", "公共服务"]),
        ConceptNode(id: "c_npc", title: "人大", subtitle: "权力机关、四项职权", grade: .s, topic: .politicsLaw, triggerWords: ["审议", "立法", "监督"]),
        ConceptNode(id: "c_market", title: "市场", subtitle: "决定作用、价格供求竞争", grade: .s, topic: .economy, triggerWords: ["价格", "竞争", "资源配置"]),
        ConceptNode(id: "c_macro", title: "宏观调控", subtitle: "有效政府治理", grade: .s, topic: .economy, triggerWords: ["监管", "财政", "货币"]),
        ConceptNode(id: "c_democracy", title: "全过程人民民主", subtitle: "广泛真实管用", grade: .s, topic: .politicsLaw, triggerWords: ["协商", "参与", "监督"]),
        ConceptNode(id: "c_rulelaw", title: "全面依法治国", subtitle: "立法执法司法守法", grade: .s, topic: .politicsLaw, triggerWords: ["法治", "执法", "司法"]),
        ConceptNode(id: "c_practice", title: "实践与认识", subtitle: "来源、动力、目的、标准", grade: .s, topic: .philosophyCulture, triggerWords: ["探索", "检验", "实践"]),
        ConceptNode(id: "c_contradiction", title: "矛盾观", subtitle: "具体问题具体分析", grade: .s, topic: .philosophyCulture, triggerWords: ["既要", "又要", "突出问题"]),
        ConceptNode(id: "c_culture", title: "文化创新", subtitle: "创造性转化、创新性发展", grade: .a, topic: .philosophyCulture, triggerWords: ["非遗", "传承", "创新"]),
        ConceptNode(id: "c_civil", title: "民事责任", subtitle: "侵权、违约、责任承担", grade: .a, topic: .legalLife, triggerWords: ["合同", "侵权", "赔偿"]),
        ConceptNode(id: "c_logic", title: "逻辑形式", subtitle: "概念、判断、推理", grade: .b, topic: .logicThinking, triggerWords: ["充分", "必要", "推理"])
    ]

    static let edges: [ConceptEdge] = [
        ConceptEdge(id: "e_party_npc", from: "c_party", to: "c_npc", relation: "党支持人大依法履职，使主张法定化"),
        ConceptEdge(id: "e_party_gov", from: "c_party", to: "c_government", relation: "党领导政府依法行政，不代替政府履职"),
        ConceptEdge(id: "e_market_macro", from: "c_market", to: "c_macro", relation: "有效市场与有为政府结合"),
        ConceptEdge(id: "e_democracy_npc", from: "c_democracy", to: "c_npc", relation: "人民代表大会制度保障人民当家作主"),
        ConceptEdge(id: "e_rule_gov", from: "c_rulelaw", to: "c_government", relation: "严格执法主要对应行政机关"),
        ConceptEdge(id: "e_rule_npc", from: "c_rulelaw", to: "c_npc", relation: "科学立法对应立法机关"),
        ConceptEdge(id: "e_practice_hot", from: "c_practice", to: "c_contradiction", relation: "哲学材料先定范围，再选原理"),
        ConceptEdge(id: "e_culture_practice", from: "c_culture", to: "c_practice", relation: "文化创新立足社会实践")
    ]

    static func related(to id: String) -> [ConceptEdge] {
        edges.filter { $0.from == id || $0.to == id }
    }

    static func concept(id: String) -> ConceptNode? {
        nodes.first { $0.id == id }
    }
}

enum WeaponGuideData {
    static let all: [WeaponGuide] = PoliticsWeapon.allCases.map { weapon in
        WeaponGuide(weapon: weapon,
                    tagline: tagline(for: weapon),
                    whenToUse: whenToUse(for: weapon),
                    steps: steps(for: weapon),
                    exampleCaseId: exampleCase(for: weapon))
    }

    static let taughtWeapons = Set(all.map(\.weapon))

    static func guide(for weapon: PoliticsWeapon) -> WeaponGuide? {
        all.first { $0.weapon == weapon }
    }

    private static func tagline(for weapon: PoliticsWeapon) -> String {
        switch weapon {
        case .keywordLocator: return "从材料关键词快速定位模块"
        case .rightDutyPair: return "权利旁边一定找义务"
        case .organDutyTable: return "国家机关不串台"
        case .responsibilityChain: return "谁负责、对谁负责、怎么负责"
        case .questionTranslator: return "把说明、原因、措施翻译成任务"
        case .subjectLocator: return "党、人大、政府、政协、公民各归其位"
        case .materialSlicer: return "主体、行为、对象、目标、知识点五刀切开"
        case .economyChain: return "政策到市场、企业、收入、发展的传导"
        case .politicalSubjectMatrix: return "全过程人民民主和制度体系定位"
        case .ruleOfLawLayers: return "科学立法、严格执法、公正司法、全民守法"
        case .philosophyLocator: return "唯物论、认识论、辩证法、历史唯物主义"
        case .contradictionThreeQuestions: return "问做法、问性质、问差异分别定位"
        case .cultureTemplate: return "传承、创新、交流、强国四格输出"
        case .internationalFilter: return "主权、国家利益、时代主题先过筛"
        case .choiceTrapFilter: return "绝对化、主体错配、因果倒置、无中生有、正确无关"
        case .civilCaseFourSteps: return "主体、权利、侵权/违约、责任"
        case .logicFormFilter: return "概念外延、判断真假、推理形式"
        case .hotTopicTranslator: return "时政语言转教材语言再转答案语言"
        case .essaySixSteps: return "审题、定域、定主体、调知识、贴材料、成答案"
        }
    }

    private static func whenToUse(for weapon: PoliticsWeapon) -> [String] {
        switch weapon {
        case .economyChain: return ["材料出现价格、供求、监管、补贴、消费、企业创新", "设问要求分析经济意义或措施"]
        case .subjectLocator, .politicalSubjectMatrix: return ["材料同时出现党委、人大、政府、政协、公民", "选项把不同主体职责混写"]
        case .ruleOfLawLayers: return ["材料出现立法、执法、司法、普法", "设问限定全面依法治国"]
        case .philosophyLocator, .contradictionThreeQuestions: return ["设问限定哲学原理", "材料出现既要又要、变化发展、实践探索"]
        case .civilCaseFourSteps: return ["案例出现合同、侵权、赔偿、证据", "设问要求依法维权"]
        case .hotTopicTranslator: return ["材料是政策新闻或年度热点", "热点词多但设问要求教材分析"]
        case .essaySixSteps: return ["主观题材料长、设问抽象", "答案容易只背原理不贴材料"]
        default: return ["材料出现「\(weapon.name)」相关关键词", "选项或答案容易发生主体、范围、因果错误"]
        }
    }

    private static func steps(for weapon: PoliticsWeapon) -> [String] {
        switch weapon {
        case .materialSlicer: return ["圈主体", "标行为", "定对象", "找目标", "召回 S/A 级知识点"]
        case .choiceTrapFilter: return ["查绝对词", "查主体职责", "查因果方向", "查材料是否出现", "查是否正确但无关"]
        case .essaySixSteps: return ["审设问", "定模块", "定主体", "召回原理", "贴材料", "写答案句并查遗漏"]
        case .hotTopicTranslator: return ["提取热点词", "映射教材模块", "改写为教材术语", "形成答案句"]
        case .civilCaseFourSteps: return ["定民事主体", "定权利类型", "分侵权或违约", "写责任承担方式"]
        default: return ["识别材料信号", "锁定主体和模块", "调用对应术语", "用材料动作补成答案句"]
        }
    }

    private static func exampleCase(for weapon: PoliticsWeapon) -> String? {
        switch weapon {
        case .organDutyTable: return "duel_organs"
        case .economyChain: return "duel_market_macro"
        case .subjectLocator: return "duel_party"
        case .ruleOfLawLayers: return "duel_rulelaw"
        case .contradictionThreeQuestions: return "duel_contradiction"
        case .hotTopicTranslator: return "duel_hot"
        case .essaySixSteps: return "duel_essay"
        default: return nil
        }
    }
}
