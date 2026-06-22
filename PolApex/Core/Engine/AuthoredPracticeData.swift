import Foundation

enum AuthoredQuestionData {
    static let all: [PoliticsQuestion] = [
        q(
            id: "aq_soc_01",
            nodeId: "n11",
            knowledgeId: "k1102",
            topic: .socialism,
            stage: .required,
            prompt: "某地推进共同富裕示范区建设，既鼓励企业创新创造财富，又完善公共服务和帮扶机制。该做法体现中国式现代化的要求是：",
            options: [
                "以资本扩张效率优先，先让少数地区充分富裕",
                "坚持党的领导和人民立场，在高质量发展中促进共同富裕",
                "通过平均分配同步实现全体成员收入完全一致",
                "主要依靠外部市场输入资源解决国内发展问题"
            ],
            answerIndex: 1,
            explanation: "中国式现代化强调共同富裕、高质量发展和以人民为中心。共同富裕不是平均主义，也不是少数人先富后长期固化。",
            trapTags: ["平均主义", "方向错位"],
            weapon: .questionTranslator
        ),
        q(
            id: "aq_soc_02",
            nodeId: "n10",
            knowledgeId: "k1001",
            topic: .socialism,
            stage: .required,
            prompt: "改革开放以来，我国生产力快速发展，生产关系和上层建筑也不断调整完善。对此理解正确的是：",
            options: [
                "社会基本矛盾运动推动社会发展，改革是社会主义制度的自我完善",
                "只要经济总量增长，生产关系无需随实践变化而调整",
                "生产力决定上层建筑，上层建筑对生产力没有反作用",
                "改革开放改变了我国社会主义社会的基本制度性质"
            ],
            answerIndex: 0,
            explanation: "社会发展受生产力与生产关系、经济基础与上层建筑的矛盾运动推动。改革不是改变社会主义根本制度，而是制度自我完善和发展。",
            trapTags: ["否认反作用", "性质误判"],
            weapon: .materialSlicer
        ),
        q(
            id: "aq_soc_03",
            nodeId: "n12",
            knowledgeId: "k1203",
            topic: .socialism,
            stage: .required,
            prompt: "某班围绕新时代十年成就开展探究，既展示科技突破，也展示民生改善和生态治理。最适合归纳的主题是：",
            options: [
                "新时代只需要用经济增速评价发展质量",
                "中国梦本质是国家富强、民族振兴、人民幸福",
                "我国已经跨越社会主义初级阶段的基本国情",
                "人民幸福可以脱离国家发展和民族振兴实现"
            ],
            answerIndex: 1,
            explanation: "中国梦把国家、民族、人民统一起来，材料中的科技、民生、生态都可服务于国家富强、民族振兴、人民幸福。",
            trapTags: ["单一指标", "国情误判"],
            weapon: .questionTranslator
        ),
        q(
            id: "aq_econ_01",
            nodeId: "n14",
            knowledgeId: "k1401",
            topic: .economy,
            stage: .required,
            prompt: "针对平台企业利用算法进行价格歧视、排除竞争，监管部门依法查处，同时鼓励平台开放创新。正确的经济学分析是：",
            options: [
                "政府应直接替代市场决定所有资源配置",
                "市场调节存在自发性，需要把有效市场和有为政府结合起来",
                "平台垄断能够自动提高社会公平，不需要外部监管",
                "宏观调控只适用于国有企业，不适用于平台经济"
            ],
            answerIndex: 1,
            explanation: "市场在资源配置中起决定性作用，但自发性可能导致垄断和不公平。依法监管是弥补市场缺陷、维护公平竞争。",
            trapTags: ["市场万能", "政府替代市场"],
            weapon: .economyChain
        ),
        q(
            id: "aq_econ_02",
            nodeId: "n15",
            knowledgeId: "k1501",
            topic: .economy,
            stage: .required,
            prompt: "某地提高最低工资标准，完善技能培训补贴，并鼓励慈善组织参与困难群体帮扶。这体现的分配思路是：",
            options: [
                "只发挥第三次分配作用，削弱初次分配和再分配",
                "把劳动报酬提高、政府调节和公益帮扶结合起来",
                "取消按要素分配，才能缩小收入差距",
                "收入分配公平就是所有劳动者收入完全相同"
            ],
            answerIndex: 1,
            explanation: "材料同时涉及初次分配中的劳动报酬、再分配中的财政补贴、第三次分配中的公益慈善。公平不是平均主义。",
            trapTags: ["分配层次混淆", "平均主义"],
            weapon: .economyChain
        ),
        q(
            id: "aq_econ_03",
            nodeId: "n13",
            knowledgeId: "k1302",
            topic: .economy,
            stage: .required,
            prompt: "国有资本加大关键领域布局，民营企业在数字服务、专精特新领域快速成长。对此认识正确的是：",
            options: [
                "公有制经济和非公有制经济都是社会主义市场经济的重要组成部分",
                "非公有制经济越发展，公有制主体地位就越会被取消",
                "国有经济控制所有行业，才能体现社会主义市场经济优势",
                "民营企业只能参与生活服务业，不能参与科技创新"
            ],
            answerIndex: 0,
            explanation: "坚持两个毫不动摇，既巩固和发展公有制经济，也鼓励、支持、引导非公有制经济发展。",
            trapTags: ["主体地位误解", "范围绝对化"],
            weapon: .choiceTrapFilter
        ),
        q(
            id: "aq_pol_01",
            nodeId: "n16",
            knowledgeId: "k1602",
            topic: .politicsLaw,
            stage: .required,
            prompt: "地方党委提出基层治理方向，政府出台服务清单，人大依法监督办理情况。下列说法正确的是：",
            options: [
                "党代替国家机关直接行使行政权和监督权",
                "政府对党委负责，人大只负责落实政府工作",
                "党发挥领导核心作用，支持国家机关依法履职",
                "人大和政府都属于党的执行机关，没有独立职责"
            ],
            answerIndex: 2,
            explanation: "党领导一切不等于党包办一切。主观题和选择题都要区分党、人大、政府等主体职责。",
            trapTags: ["主体错配", "党政不分"],
            weapon: .subjectLocator
        ),
        q(
            id: "aq_pol_02",
            nodeId: "n17",
            knowledgeId: "k1703",
            topic: .politicsLaw,
            stage: .required,
            prompt: "政协委员围绕养老服务提交提案，相关部门吸纳建议完善政策。对此认识正确的是：",
            options: [
                "人民政协履行政治协商、民主监督、参政议政职能",
                "政协是国家权力机关，依法行使立法权",
                "政协委员直接决定政府重大行政事项",
                "政协监督属于司法监督，具有强制裁判效力"
            ],
            answerIndex: 0,
            explanation: "人民政协是爱国统一战线组织，是社会主义协商民主的重要渠道和专门协商机构，不是国家机关。",
            trapTags: ["政协性质误判", "职权越界"],
            weapon: .politicalSubjectMatrix
        ),
        q(
            id: "aq_pol_03",
            nodeId: "n18",
            knowledgeId: "k1802",
            topic: .politicsLaw,
            stage: .required,
            prompt: "某地完善地方性法规，规范行政执法裁量基准，推进庭审公开并开展社区普法。最恰当的概括是：",
            options: [
                "材料只体现严格执法，与立法、司法、守法无关",
                "全面依法治国要推进科学立法、严格执法、公正司法、全民守法",
                "只要加强普法，就能替代制度建设和司法公正",
                "依法治国的主体只是司法机关，其他机关不承担法治责任"
            ],
            answerIndex: 1,
            explanation: "材料按立法、执法、司法、守法埋点，适合用法治四层定位逐项对应。",
            trapTags: ["层次漏看", "主体缩小"],
            weapon: .ruleOfLawLayers
        ),
        q(
            id: "aq_phi_01",
            nodeId: "n19",
            knowledgeId: "k1902",
            topic: .philosophyCulture,
            stage: .required,
            prompt: "科研团队经过多年实验修正方案，最终形成盐碱地综合治理技术。该过程说明：",
            options: [
                "认识来源于实践，并在实践中检验和发展",
                "真理一旦形成，就不需要接受实践检验",
                "感性认识比理性认识更可靠，理论总结没有价值",
                "人的认识过程总是直线前进，不会反复"
            ],
            answerIndex: 0,
            explanation: "实践是认识的来源、动力、检验标准和目的。科研反复实验体现认识的反复性、无限性和上升性。",
            trapTags: ["实践地位弱化", "直线论"],
            weapon: .philosophyLocator
        ),
        q(
            id: "aq_phi_02",
            nodeId: "n20",
            knowledgeId: "k2002",
            topic: .philosophyCulture,
            stage: .required,
            prompt: "老旧小区改造既要保留历史风貌，又要解决停车、管线、安全等突出问题。运用矛盾观，最准确的是：",
            options: [
                "只抓历史风貌保护，其他问题都可以忽略",
                "承认矛盾普遍性，坚持具体问题具体分析，抓主要矛盾并兼顾两点",
                "矛盾双方不能共处，必须完全消灭其中一方",
                "主要矛盾和矛盾主要方面含义相同，可以随意替换"
            ],
            answerIndex: 1,
            explanation: "材料有多重关系和突出问题，适合用矛盾普遍性、特殊性、主要矛盾、两点论与重点论分析。",
            trapTags: ["主次混淆", "一点论"],
            weapon: .contradictionThreeQuestions
        ),
        q(
            id: "aq_phi_03",
            nodeId: "n21",
            knowledgeId: "k2103",
            topic: .philosophyCulture,
            stage: .required,
            prompt: "青年志愿者长期参与社区助老服务，在解决群众急难愁盼中锤炼本领。对此理解正确的是：",
            options: [
                "人生价值只能通过个人收入和社会声望衡量",
                "价值判断与价值选择要自觉站在最广大人民立场上",
                "只要有主观善意，就不需要尊重客观规律",
                "个人价值与社会价值必然对立，不能统一"
            ],
            answerIndex: 1,
            explanation: "正确价值判断和价值选择要遵循社会发展规律，站在最广大人民立场上，在劳动和奉献中创造价值。",
            trapTags: ["个人主义", "脱离规律"],
            weapon: .philosophyLocator
        ),
        q(
            id: "aq_cult_01",
            nodeId: "n22",
            knowledgeId: "k2201",
            topic: .philosophyCulture,
            stage: .required,
            prompt: "某地把传统戏曲元素融入校园课程和数字文创产品，推动优秀传统文化走近青年。该做法启示我们：",
            options: [
                "传统文化只有完整复制原有形式才有价值",
                "推动中华优秀传统文化创造性转化、创新性发展",
                "文化创新必须割裂历史传统，全面模仿外来文化",
                "文化发展只需要市场流量，不需要价值引领"
            ],
            answerIndex: 1,
            explanation: "传统文化要守正创新，既保持优秀内核，又结合时代条件和传播方式实现创造性转化、创新性发展。",
            trapTags: ["守旧复古", "全盘西化"],
            weapon: .cultureTemplate
        ),
        q(
            id: "aq_int_01",
            nodeId: "n23",
            knowledgeId: "k2301",
            topic: .international,
            stage: .elective,
            prompt: "我国在气候治理中维护发展权益，同时提出务实合作方案，支持发展中国家能力建设。这表明：",
            options: [
                "维护国家利益与推动国际合作可以统一起来",
                "国家间合作意味着各国根本利益完全一致",
                "国际关系的决定因素是共同价值观，不包括国家利益",
                "发展中国家应放弃自身发展权以承担同等减排责任"
            ],
            answerIndex: 0,
            explanation: "国家利益和国家实力是影响国际关系的决定性因素。我国维护自身正当利益，也推动构建人类命运共同体。",
            trapTags: ["利益同一化", "责任绝对化"],
            weapon: .internationalFilter
        ),
        q(
            id: "aq_law_01",
            nodeId: "n24",
            knowledgeId: "k2402",
            topic: .legalLife,
            stage: .elective,
            prompt: "消费者网购定制商品时，商家未按约定材质制作并拒绝退款。消费者维权首先应把握的是：",
            options: [
                "只要发布差评，就能替代证据收集和法律途径",
                "判断合同约定、违约事实和证据，再依法选择协商、调解或诉讼",
                "定制商品一律不能主张任何违约责任",
                "消费者只能向公安机关报案，民事途径没有作用"
            ],
            answerIndex: 1,
            explanation: "民事案例要先定法律关系和请求权基础，再看证据、责任承担和救济路径。",
            trapTags: ["证据缺失", "救济路径混乱"],
            weapon: .civilCaseFourSteps
        ),
        q(
            id: "aq_logic_01",
            nodeId: "n26",
            knowledgeId: "k2602",
            topic: .logicThinking,
            stage: .elective,
            prompt: "“只有通过资格审核，才能参加面试。”据此可以推出：",
            options: [
                "通过资格审核的人一定参加面试",
                "没有通过资格审核的人不能参加面试",
                "参加面试的人不一定通过资格审核",
                "不参加面试的人一定没有通过资格审核"
            ],
            answerIndex: 1,
            explanation: "“只有 A 才 B”表示 A 是 B 的必要条件，可推出 B 则 A；否定 A 可否定 B。",
            trapTags: ["必要条件误判", "逆否混乱"],
            weapon: .logicFormFilter
        ),
        q(
            id: "aq_hot_01",
            nodeId: "n27",
            knowledgeId: "k2703",
            topic: .sprint,
            stage: .sprint,
            prompt: "发展新质生产力，不能只追求项目数量，还要推进原创技术、产业升级、绿色转型和人才培养。正确理解是：",
            options: [
                "新质生产力等同于传统投资规模扩大",
                "新质生产力以科技创新为核心，推动生产要素创新性配置和产业深度转型",
                "发展新质生产力可以脱离实体经济和制度保障",
                "只要引进国外设备，就自然形成新质生产力"
            ],
            answerIndex: 1,
            explanation: "新质生产力的关键是创新，落点是高质量发展，不是简单扩投资、上项目或贴热点标签。",
            trapTags: ["热点空转", "概念泛化"],
            weapon: .hotTopicTranslator
        ),
        q(
            id: "aq_hot_02",
            nodeId: "n28",
            knowledgeId: "k2802",
            topic: .sprint,
            stage: .sprint,
            prompt: "主观题要求“说明某地做法如何推动高质量发展”，材料包含政策、企业、群众和结果四类信息。最佳作答路径是：",
            options: [
                "先按主体切片，再写机制和结果，形成原理句、材料句、意义句",
                "只摘抄材料，不需要调用教材术语",
                "把所有经济、政治、哲学原理全部罗列上去",
                "只写结论口号，省略主体和机制"
            ],
            answerIndex: 0,
            explanation: "综合题要先翻译设问，再切材料主体和动作，最后形成术语、材料、结果的闭环。",
            trapTags: ["材料堆砌", "原理漫灌"],
            weapon: .essaySixSteps
        ),
        // MARK: - 经济模块新增
        q(
            id: "aq_econ_04",
            nodeId: "n14",
            knowledgeId: "k1406",
            topic: .economy,
            stage: .required,
            prompt: "某地建设现代化产业体系，既发展先进制造业，又推动现代服务业深度融合。从经济生活角度，这样做的传导路径是：",
            options: [
                "实体经济→筑牢现代化经济体系→推动高质量发展",
                "扩大财政支出→直接增加居民收入→实现同步富裕",
                "淘汰传统产业→全部转向虚拟经济→提高经济增速",
                "增加货币投放→刺激消费需求→避免市场竞争"
            ],
            answerIndex: 0,
            explanation: "建设现代化产业体系，着力点是实体经济。实体经济筑牢，才能筑牢现代化经济体系的根基，进而推动高质量发展。",
            trapTags: ["因果倒置", "传导断裂"],
            weapon: .economyChain
        ),
        q(
            id: "aq_econ_05",
            nodeId: "n14",
            knowledgeId: "k1402",
            topic: .economy,
            stage: .required,
            prompt: "中央经济工作会议强调，要发挥市场在资源配置中起决定性作用，更好发挥政府作用。这意味着：",
            options: [
                "政府要减少对市场的所有监管，完全由市场自发调节",
                "既要尊重市场规律，又要科学实施科学宏观调控",
                "市场调节和宏观调控是对立的，二者只能选其一",
                "宏观调控的主要目标是实现政府对经济利益最大化"
            ],
            answerIndex: 1,
            explanation: "社会主义市场经济把市场调节和政府作用有机结合。市场决定性作用和政府作用不是对立关系，而是相辅相成。",
            trapTags: ["非此即彼", "目标错位"],
            weapon: .economyChain
        ),
        q(
            id: "aq_econ_06",
            nodeId: "n13",
            knowledgeId: "k1301",
            topic: .economy,
            stage: .required,
            prompt: "某地推进国企改革，坚持两个毫不动摇，既做强做优做大国有经济，又鼓励支持引导民营经济健康发展。下列理解正确的是：",
            options: [
                "国有经济和民营经济在国民经济中地位完全平等，没有区别",
                "公有制为主体、多种所有制经济共同发展是基本经济制度",
                "民营经济是社会主义经济的重要组成部分",
                "国有经济在所有行业和领域都必须占支配地位"
            ],
            answerIndex: 1,
            explanation: "基本经济制度是公有制为主体、多种所有制经济共同发展。国有经济是主体地位体现在控制力上，不是所有领域都占支配地位。",
            trapTags: ["地位混淆", "范围越界"],
            weapon: .keywordLocator
        ),
        q(
            id: "aq_econ_07",
            nodeId: "n14",
            knowledgeId: "k1405",
            topic: .economy,
            stage: .required,
            prompt: "某地把绿色发展理念，发展绿色产业和绿色消费。下列传导正确的是：",
            options: [
                "绿色产业发展→增加绿色产品供给→引导绿色消费→推动可持续发展",
                "限制传统产业→立即全部关停→经济增速必然下降",
                "绿色消费需求→企业利润必然下降→企业经营困难",
                "增加财政补贴→市场决定作用就会被削弱"
            ],
            answerIndex: 0,
            explanation: "绿色发展是新发展理念之一。发展绿色产业，增加绿色产品供给，引导绿色消费，形成绿色生产生活方式，推动可持续发展。",
            trapTags: ["绝对化", "传导断裂"],
            weapon: .economyChain
        ),
        // MARK: - 政治模块新增
        q(
            id: "aq_pol_04",
            nodeId: "n17",
            knowledgeId: "k1701",
            topic: .politicsLaw,
            stage: .required,
            prompt: "某市建立街道议事会，居民代表、人大代表、政协委员和社区工作者共同参与社区治理。这一做法：",
            options: [
                "扩大了居民的政治权利，增加了新的民主渠道",
                "丰富了基层民主形式，发展全过程人民民主",
                "说明政协委员直接行使国家权力",
                "表明基层群众自治组织性质发生根本改变"
            ],
            answerIndex: 1,
            explanation: "多方参与社区治理，丰富了基层民主实践形式，是全过程人民民主的生动体现。公民政治权利由宪法规定，不能随意扩大。",
            trapTags: ["权利扩大", "主体越位"],
            weapon: .subjectLocator
        ),
        q(
            id: "aq_pol_05",
            nodeId: "n17",
            knowledgeId: "k1702",
            topic: .politicsLaw,
            stage: .required,
            prompt: "全国人大常委会审议通过《黄河保护法草案，听取国务院相关工作报告。这体现了：",
            options: [
                "全国人大常委会行使最高立法权和决定权",
                "人大常委会是我国最高国家权力机关",
                "全国人大常委会行使立法权和监督权",
                "国务院对全国人大常委会负责，受其监督"
            ],
            answerIndex: 2,
            explanation: "审议法律草案行使立法权，听取工作报告行使监督权。注意全国人大才是最高国家权力机关，常委会是其常设机关。",
            trapTags: ["层级混淆", "职权错位"],
            weapon: .organDutyTable
        ),
        q(
            id: "aq_pol_06",
            nodeId: "n18",
            knowledgeId: "k1801",
            topic: .politicsLaw,
            stage: .required,
            prompt: "某省政府推行“一网通办”和“最多跑一次”改革，优化政务服务。政府这样做旨在：",
            options: [
                "弱化政府管理职能，建设服务型政府",
                "提高行政效率，更好为人民服务",
                "扩大政府职权范围，树立政府权威",
                "缩减政府机构，减少行政成本"
            ],
            answerIndex: 1,
            explanation: "政府推进政务服务改革，目的是提高行政效率，建设服务型政府，更好地为人民服务。不是弱化职能或扩大职权。",
            trapTags: ["弱化职能", "职权扩大"],
            weapon: .subjectLocator
        ),
        q(
            id: "aq_pol_07",
            nodeId: "n17",
            knowledgeId: "k1702",
            topic: .politicsLaw,
            stage: .required,
            prompt: "宪法规定，中华人民共和国的一切权力属于人民。人民行使国家权力的机关是全国人民代表大会和地方各级人民代表大会。由此可见：",
            options: [
                "人民直接行使国家权力，直接管理国家事务",
                "人民代表大会制度是我国根本政治制度",
                "人大代表由人民直接选举产生",
                "人民代表大会是我国根本政治制度"
            ],
            answerIndex: 1,
            explanation: "人民通过人民代表大会间接行使国家权力。人民代表大会制度是我国的根本政治制度，人大代表有直接和间接选举产生。",
            trapTags: ["直接间接混淆", "制度与机关混淆"],
            weapon: .keywordLocator
        ),
        q(
            id: "aq_pol_08",
            nodeId: "n17",
            knowledgeId: "k1703",
            topic: .politicsLaw,
            stage: .required,
            prompt: "政协委员围绕生态环境保护议题，开展专题调研，提交提案建议。人民政协：",
            options: [
                "是我国国家权力机关，行使国家权力",
                "履行政治协商、民主监督、参政议政职能",
                "是我国的行政机关，履行政府职能",
                "直接决定国家重大事项"
            ],
            answerIndex: 1,
            explanation: "人民政协是爱国统一战线组织，不是国家机关，不行使国家权力，履行政治协商、民主监督、参政议政职能。",
            trapTags: ["性质混淆", "职能越位"],
            weapon: .subjectLocator
        ),
        // MARK: - 哲学模块新增
        q(
            id: "aq_phi_05",
            nodeId: "n19",
            knowledgeId: "k1901",
            topic: .philosophyCulture,
            stage: .required,
            prompt: "科学家通过天文观测，发现了新的星系，修正了以往对宇宙的认识。这说明：",
            options: [
                "认识的发展是一种圆圈式的循环运动",
                "实践是认识发展的动力，推动认识不断深化",
                "人的认识能力是有限的，无法认识宇宙",
                "真理在发展中不断推翻自身"
            ],
            answerIndex: 1,
            explanation: "实践推动认识发展。认识发展是波浪式前进螺旋式上升，不是圆圈循环。真理不会被推翻，而是不断超越自身。",
            trapTags: ["循环论", "不可知论", "推翻真理"],
            weapon: .philosophyLocator
        ),
        q(
            id: "aq_phi_06",
            nodeId: "n20",
            knowledgeId: "k2002",
            topic: .philosophyCulture,
            stage: .required,
            prompt: "面对复杂国际形势，我国坚持独立自主的和平外交政策，既维护国家利益，又促进共同发展。体现的辩证法道理是：",
            options: [
                "物质决定意识，一切从实际出发",
                "矛盾就是对立统一，要一分为二看问题",
                "事物发展是前进性与曲折性统一",
                "量变必然引起质变"
            ],
            answerIndex: 1,
            explanation: "既维护自身利益又促进共同发展，体现对立统一，一分为二看问题。注意设问限定辩证法，A属于唯物论。",
            trapTags: ["范围越界", "原理不符"],
            weapon: .philosophyLocator
        ),
        q(
            id: "aq_phi_07",
            nodeId: "n21",
            knowledgeId: "k2101",
            topic: .philosophyCulture,
            stage: .required,
            prompt: "新时代青年要树立正确的历史观、民族观、国家观、文化观。从唯物史观角度是因为：",
            options: [
                "社会意识具有相对独立性，先进社会意识促进社会发展",
                "意识对物质具有能动的反作用",
                "价值观决定人生道路的选择",
                "认识具有反复性无限性"
            ],
            answerIndex: 0,
            explanation: "设问限定唯物史观。正确的观念属于先进社会意识，对社会发展起促进作用。B属于唯物论，C属于价值观，D属于认识论。",
            trapTags: ["模块混淆", "范围越界"],
            weapon: .philosophyLocator
        ),
        q(
            id: "aq_phi_08",
            nodeId: "n21",
            knowledgeId: "k2105",
            topic: .philosophyCulture,
            stage: .required,
            prompt: "评价一个人的价值，主要看他：",
            options: [
                "拥有多少物质财富和社会地位",
                "对社会的责任和贡献",
                "满足自身的需要和程度",
                "是否实现了自我价值"
            ],
            answerIndex: 1,
            explanation: "人的价值就在于创造价值，在于对社会的责任和贡献。评价一个人价值的大小，就是看他为社会、为人民贡献了什么。",
            trapTags: ["价值标准颠倒", "自我价值与社会价值混淆"],
            weapon: .philosophyLocator
        ),
        // MARK: - 文化模块新增
        q(
            id: "aq_cul_01",
            nodeId: "n22",
            knowledgeId: "k2203",
            topic: .philosophyCulture,
            stage: .required,
            prompt: "某地保护文化遗产，开展非遗传承活动，让传统文化活起来。这样做是基于：",
            options: [
                "传统文化是文化创新的源泉和动力",
                "文化遗产是一个国家和民族历史文化成就的重要标志",
                "传统文化要全面继承，不能有任何改变",
                "文化继承是文化发展的必然要求"
            ],
            answerIndex: 1,
            explanation: "文化遗产是一个国家和民族历史文化成就的重要标志。社会实践是文化创新的源泉。传统文化要批判继承，不是全面继承。",
            trapTags: ["源泉混淆", "全面继承"],
            weapon: .cultureTemplate
        ),
        q(
            id: "aq_cul_02",
            nodeId: "n22",
            knowledgeId: "k2201",
            topic: .philosophyCulture,
            stage: .required,
            prompt: "某剧团用现代科技赋能传统文化，数字故宫、数字敦煌让文物“活”了下来。这说明：",
            options: [
                "科技是文化创新的根本途径",
                "科学技术进步是推动文化发展的重要因素",
                "传统文化具有相对稳定性和鲜明民族性",
                "文化发展要全部依靠现代科技"
            ],
            answerIndex: 1,
            explanation: "科学技术的进步是推动文化发展的重要因素。社会实践是文化创新的根本途径。“全部”说法绝对化。",
            trapTags: ["根本途径混淆", "绝对化"],
            weapon: .cultureTemplate
        ),
        // MARK: - 国际政治新增
        q(
            id: "aq_int_02",
            nodeId: "n23",
            knowledgeId: "k2302",
            topic: .international,
            stage: .elective,
            prompt: "我国提出全球发展倡议、全球安全倡议、全球文明倡议，推动构建人类命运共同体。这表明我国：",
            options: [
                "在国际事务中发挥主导作用",
                "是维护世界和平与发展的积极因素和坚定力量",
                "把维护各国共同利益作为外交政策出发点",
                "推动国际关系由竞争转向合作"
            ],
            answerIndex: 1,
            explanation: "我国提出三大倡议，推动构建人类命运共同体，表明中国是维护世界和平与发展的积极因素和坚定力量。“主导”说法不准确。维护国家利益是出发点。",
            trapTags: ["主导作用", "出发点错位"],
            weapon: .internationalFilter
        ),
        q(
            id: "aq_int_03",
            nodeId: "n23",
            knowledgeId: "k2303",
            topic: .international,
            stage: .elective,
            prompt: "国家主席指出，中美关系是当今世界最重要的双边关系。中美合则两利、斗则俱伤。这说明：",
            options: [
                "国家利益是国际关系的决定性因素",
                "中美两国的根本利益是一致的",
                "合作与冲突是国际关系的基本形式",
                "我国坚持独立自主的基本立场"
            ],
            answerIndex: 0,
            explanation: "中美合则两利斗则俱伤，说明国家利益是国际关系的决定性因素，共同利益是合作基础，利益对立是冲突根源。",
            trapTags: ["根本利益一致", "基本形式不全"],
            weapon: .internationalFilter
        ),
        // MARK: - 法律生活新增
        q(
            id: "aq_leg_02",
            nodeId: "n24",
            knowledgeId: "k2401",
            topic: .legalLife,
            stage: .elective,
            prompt: "王某在超市购物时，因超市地面湿滑不慎摔倒受伤。关于责任承担，正确的是：",
            options: [
                "王某自己不小心，超市不承担责任",
                "超市未尽到安全保障义务，应当承担侵权责任",
                "超市和王某各承担一半责任，公平原则",
                "只有故意才承担责任，无过错一律不担责"
            ],
            answerIndex: 1,
            explanation: "经营场所经营者未尽到安全保障义务，造成他人损害的，应当承担侵权责任。这是过错推定或无过错责任的情形。",
            trapTags: ["责任主体混淆", "无过错一律不担责"],
            weapon: .civilCaseFourSteps
        ),
        q(
            id: "aq_leg_03",
            nodeId: "n24",
            knowledgeId: "k2403",
            topic: .legalLife,
            stage: .elective,
            prompt: "张某与李某签订房屋买卖合同，张某交付定金后李某反悔。对此正确的是：",
            options: [
                "李某只需返还定金原数即可",
                "李某应当双倍返还定金",
                "合同未实际履行，合同无效",
                "张某可以要求李某继续履行并赔偿违约金"
            ],
            answerIndex: 1,
            explanation: "收受定金的一方不履行约定债务的，应当双倍返还定金。定金罚则：给付方违约无权要求返还，收受方违约双倍返还。",
            trapTags: ["定金罚则混淆", "合同效力误判"],
            weapon: .civilCaseFourSteps
        ),
        // MARK: - 逻辑思维新增
        q(
            id: "aq_log_02",
            nodeId: "n26",
            knowledgeId: "k2601",
            topic: .logicThinking,
            stage: .elective,
            prompt: "所有的金属都是导电体，铜是金属，所以，铜是导电体。这个推理是：",
            options: [
                "归纳推理，从个别到一般",
                "演绎推理，从一般到个别",
                "类比推理，从一般到一般",
                "必然推理，结论必然真"
            ],
            answerIndex: 1,
            explanation: "这是三段论演绎推理，从一般性前提推出个别性结论。演绎推理是必然推理，前提真结论必然真。",
            trapTags: ["推理类型混淆", "推理方向颠倒"],
            weapon: .logicFormFilter
        ),
        // MARK: - 社会主义新增
        q(
            id: "aq_soc_04",
            nodeId: "n10",
            knowledgeId: "k1007",
            topic: .socialism,
            stage: .required,
            prompt: "中国特色社会主义进入新时代，我国社会主要矛盾已经转化为人民日益增长的美好生活需要和不平衡不充分的发展之间的矛盾。这意味着：",
            options: [
                "我国已经跨越了社会主义初级阶段",
                "我国社会主要矛盾变化，没有改变对我国社会主义所处历史阶段的判断",
                "发展不平衡不充分问题已经得到根本解决",
                "我国社会基本矛盾发生了根本性变化"
            ],
            answerIndex: 1,
            explanation: "社会主要矛盾变化，没有改变我国仍处于并将长期处于社会主义初级阶段的基本国情，没有改变我国是世界最大发展中国家的国际地位。",
            trapTags: ["国情误判", "基本矛盾混淆"],
            weapon: .keywordLocator
        ),
        q(
            id: "aq_econ_08",
            nodeId: "n14",
            knowledgeId: "k1406",
            topic: .economy,
            stage: .required,
            prompt: "某制造业企业以人工智能和工业机器人改造生产线，劳动者技能随之升级，产品附加值大幅提高，并带动上下游配套企业协同创新。这一做法表明：",
            options: [
                "只要引入新技术，传统产业就会被自动淘汰",
                "通过科技创新优化劳动者、劳动资料、劳动对象的组合，有利于发展新质生产力、推动高质量发展",
                "新质生产力只关注产值增长，与发展的协调性、可持续性无关",
                "企业创新与上下游配套企业无关，不需要产业链协同"
            ],
            answerIndex: 1,
            explanation: "新质生产力的核心标志是全要素生产率提升，通过科技创新催生新产业新模式新动能，并非简单淘汰传统产业，也离不开产业链协同和发展质量的提升。",
            trapTags: ["新技术等同淘汰传统产业", "忽视全要素生产率"],
            weapon: .economyChain
        ),
        q(
            id: "aq_int_04",
            nodeId: "n23",
            knowledgeId: "k2306",
            topic: .international,
            stage: .elective,
            prompt: "联合国安理会就某地区冲突召开会议，呼吁各方停火止战并推动人道主义援助；同时，世界贸易组织就部分成员之间的贸易争端启动争端解决程序。这表明：",
            options: [
                "国际组织的决议对所有会员国都具有等同于国内法律的强制执行力",
                "联合国和世界贸易组织等国际组织为国际合作和争端解决提供了重要平台",
                "非政府间国际组织可以代表会员国行使国家主权权力",
                "只要存在国际组织，国际冲突和贸易争端就能被彻底消除"
            ],
            answerIndex: 1,
            explanation: "联合国是最具普遍性、代表性和权威性的政府间国际组织，世界贸易组织等国际组织为国际合作、争端解决提供平台，但其决议效力因机构和事项而异，不能等同于国内法律的强制力，更不能说能彻底消除冲突和争端。",
            trapTags: ["国际组织决议效力夸大", "国际组织万能化"],
            weapon: .internationalFilter
        ),
        q(
            id: "aq_leg_04",
            nodeId: "n24",
            knowledgeId: "k2405",
            topic: .legalLife,
            stage: .elective,
            prompt: "甲乙婚后共同经营一家小店，收入用于家庭日常开支。甲去世后未留遗嘱，乙与甲的父母、子女就遗产分配产生争议。依法处理这一争议应：",
            options: [
                "先析出属于乙的夫妻共同财产份额，剩余甲的遗产由配偶、子女、父母作为第一顺序继承人依法继承",
                "店铺收入全部认定为甲的个人财产，与乙无关",
                "乙因是配偶可以单独继承全部遗产，排除子女和父母",
                "没有遗嘱就不能进行遗产分配，必须等待补办遗嘱"
            ],
            answerIndex: 0,
            explanation: "夫妻关系存续期间的经营收入属于夫妻共同财产，应先分割出乙的份额，剩余部分才是甲的遗产；没有遗嘱的，由配偶、子女、父母等第一顺序继承人依法定继承办理，并非某一方可以独占或必须等待遗嘱。",
            trapTags: ["共同财产与个人财产混淆", "法定继承顺序遗漏"],
            weapon: .civilCaseFourSteps
        )
    ]

    static func questions(topic: PoliticsTopic) -> [PoliticsQuestion] {
        all.filter { $0.topic == topic }
    }

    private static func q(id: String,
                          nodeId: String,
                          knowledgeId: String,
                          topic: PoliticsTopic,
                          stage: Stage,
                          prompt: String,
                          options: [String],
                          answerIndex: Int,
                          explanation: String,
                          trapTags: [String],
                          weapon: PoliticsWeapon) -> PoliticsQuestion {
        PoliticsQuestion(
            id: id,
            nodeId: nodeId,
            knowledgeId: knowledgeId,
            topic: topic,
            stage: stage,
            prompt: prompt,
            options: options,
            answerIndex: answerIndex,
            explanation: explanation,
            trapTags: trapTags,
            weapon: weapon
        )
    }
}

enum AuthoredSubjectiveQuestionData {
    static let all: [SubjectiveQuestion] = [
        sq(
            id: "asq_econ_01",
            nodeId: "n14",
            knowledgeId: "k1401",
            grade: .s,
            questionType: .measure,
            score: 12,
            material: "某平台企业依靠流量优势设置不合理交易条件，部分商家被迫二选一。监管部门依法开展反垄断执法，推动平台公开规则，同时支持企业把算法用于提升物流效率和服务质量。",
            prompt: "结合材料，运用社会主义市场经济体制知识，说明如何促进平台经济规范健康持续发展。",
            answerPoints: [
                "市场在资源配置中起决定性作用，平台企业应通过公平竞争提升效率和创新能力。",
                "市场调节存在自发性等局限，垄断和不公平交易需要依法治理。",
                "政府要实行科学宏观调控和有效治理，完善规则、严格执法，维护统一开放、竞争有序的市场体系。",
                "把有效市场和有为政府结合起来，既规范平台经营，又激发数字经济创新活力。"
            ],
            diagnostics: ["是否同时写市场和政府", "是否点出市场缺陷", "是否贴合平台垄断材料", "是否写出规范与发展统一"]
        ),
        sq(
            id: "asq_econ_02",
            nodeId: "n15",
            knowledgeId: "k1504",
            grade: .a,
            questionType: .significance,
            score: 12,
            material: "某县发展特色产业吸纳就业，提高技能人才待遇；财政资金重点投向教育、医疗和养老；社会组织参与困难家庭帮扶，村集体收益按规则惠及农户。",
            prompt: "结合材料，说明该县推进共同富裕的经济路径。",
            answerPoints: [
                "通过产业发展和高质量就业扩大居民收入来源，夯实共同富裕的物质基础。",
                "完善按劳分配为主体、多种分配方式并存的分配制度，提高劳动报酬比重。",
                "发挥再分配调节作用，优化公共服务供给，促进基本公共服务均等化。",
                "引导第三次分配和集体经济收益共享，形成先富带后富、共建共享的格局。"
            ],
            diagnostics: ["是否区分三次分配", "是否避免平均主义", "是否写产业基础", "是否回扣共同富裕"]
        ),
        sq(
            id: "asq_pol_01",
            nodeId: "n16",
            knowledgeId: "k1602",
            grade: .s,
            questionType: .materialAnalysis,
            score: 12,
            material: "某市党委围绕营商环境改革作出部署，人大完善相关法规并开展监督，政府推出企业服务清单，法院建立涉企纠纷快速办理机制。",
            prompt: "结合材料，说明党的领导如何转化为治理效能。",
            answerPoints: [
                "中国共产党发挥总揽全局、协调各方的领导核心作用，为改革把方向、谋全局。",
                "坚持党的领导、人民当家作主、依法治国有机统一，通过法定程序把党的主张转化为制度安排。",
                "人大依法立法和监督，政府依法行政，司法机关公正司法，各主体在党的领导下依法履职。",
                "把政治优势转化为制度优势和治理效能，提升营商环境法治化、便利化水平。"
            ],
            diagnostics: ["是否区分党人大政府法院", "是否避免党包办", "是否写法定程序", "是否写治理效能"]
        ),
        sq(
            id: "asq_pol_02",
            nodeId: "n17",
            knowledgeId: "k1703",
            grade: .s,
            questionType: .measure,
            score: 12,
            material: "围绕社区养老服务，政协委员开展调研并提交提案，街道组织居民议事会充分听取意见，相关部门吸纳建议后完善助餐、日托和上门服务。",
            prompt: "结合材料，说明社会主义协商民主在基层治理中的作用。",
            answerPoints: [
                "人民政协履行政治协商、民主监督、参政议政职能，为公共决策建言献策。",
                "协商民主能够拓宽群众有序政治参与渠道，汇集民意、集中民智。",
                "基层协商推动多元主体围绕公共问题充分沟通，促进决策科学化、民主化。",
                "协商成果转化为治理措施，有利于解决群众急难愁盼，提升基层治理效能。"
            ],
            diagnostics: ["是否说明政协不是国家机关", "是否写群众参与", "是否写协商到治理转化", "是否贴养老服务材料"]
        ),
        sq(
            id: "asq_phi_01",
            nodeId: "n20",
            knowledgeId: "k2002",
            grade: .s,
            questionType: .evaluation,
            score: 14,
            material: "某地推进老旧小区改造，先调研不同小区的房龄、人口结构和安全隐患，再优先解决管线老化、消防通道堵塞等突出问题，同时保留历史建筑风貌。",
            prompt: "运用矛盾观，分析该地老旧小区改造的合理性。",
            answerPoints: [
                "矛盾具有普遍性，要承认矛盾、分析矛盾，统筹居住改善与风貌保护。",
                "矛盾具有特殊性，要坚持具体问题具体分析，根据不同小区情况制定方案。",
                "主要矛盾在事物发展中处于支配地位，要优先解决管线、安全等突出问题。",
                "坚持两点论和重点论统一，在抓重点的同时兼顾历史风貌和居民多样需求。"
            ],
            diagnostics: ["是否区分主要矛盾与矛盾主要方面", "是否写具体问题具体分析", "是否贴材料细节", "是否有两点论重点论"]
        ),
        sq(
            id: "asq_culture_01",
            nodeId: "n22",
            knowledgeId: "k2201",
            grade: .a,
            questionType: .significance,
            score: 14,
            material: "某博物馆把馆藏文物故事开发为数字展览、研学课程和文创产品，并邀请青年创作者用短视频讲述文物背后的家国情怀。",
            prompt: "结合材料，说明如何推动中华优秀传统文化传承发展。",
            answerPoints: [
                "坚持守正创新，坚定文化自信，挖掘中华优秀传统文化的思想价值和时代价值。",
                "推动创造性转化、创新性发展，使传统文化与现代传播、教育和消费场景结合。",
                "坚持以人民为中心，丰富高质量文化供给，增强青年对中华文化的认同。",
                "把社会效益放在首位、社会效益和经济效益相统一，传播正向价值。"
            ],
            diagnostics: ["是否写双创", "是否避免复古主义", "是否贴数字展览材料", "是否写价值引领"]
        ),
        sq(
            id: "asq_phi_02",
            nodeId: "n19",
            knowledgeId: "k1902",
            grade: .s,
            questionType: .materialAnalysis,
            score: 14,
            material: "科研团队在盐碱地治理中多次试验失败，随后根据不同土壤含盐量调整方案，并把成熟技术推广到农业生产一线。",
            prompt: "运用实践和认识的关系，说明科研团队取得突破的原因。",
            answerPoints: [
                "实践是认识的来源和动力，真实治理难题推动科研团队开展探索。",
                "实践是检验认识真理性的唯一标准，多次试验使方案不断修正完善。",
                "认识具有反复性、无限性和上升性，科研突破是在实践反复中逐步形成的。",
                "认识的目的在于指导实践，成熟技术推广到生产一线服务农业发展。"
            ],
            diagnostics: ["是否完整写实践四作用", "是否写认识反复上升", "是否贴失败修正", "是否写回生产应用"]
        ),
        sq(
            id: "asq_sprint_01",
            nodeId: "n27",
            knowledgeId: "k2703",
            grade: .s,
            questionType: .significance,
            score: 14,
            material: "某省布局未来产业，不只建设园区，还支持基础研究、关键核心技术攻关、数字化改造、绿色能源应用和高技能人才培养。",
            prompt: "结合材料，说明发展新质生产力对推动高质量发展的意义。",
            answerPoints: [
                "新质生产力以科技创新为核心，能够催生新产业、新模式、新动能。",
                "关键技术攻关和基础研究有利于提高自主创新能力，增强产业链供应链韧性。",
                "数字化改造和绿色能源应用推动生产要素创新性配置，促进产业结构优化升级。",
                "人才培养为高质量发展提供智力支持，使创新成果转化为现实生产力。"
            ],
            diagnostics: ["是否抓住科技创新核心", "是否避免只写项目数量", "是否写产业和绿色转型", "是否回扣高质量发展"]
        ),
        sq(
            id: "asq_sprint_02",
            nodeId: "n28",
            knowledgeId: "k2802",
            grade: .s,
            questionType: .openInquiry,
            score: 14,
            material: "某道综合题材料共四段：第一段写国家战略部署，第二段写企业技术创新，第三段写群众就业增收，第四段写生态和社会效益。设问要求分析“该地做法如何体现高质量发展”。",
            prompt: "请示范这类综合题的拆题和组织答案路径。",
            answerPoints: [
                "先翻译设问，明确任务是分析做法与高质量发展之间的关系，而不是泛泛评价成就。",
                "按主体和材料层次切片：国家政策、企业创新、群众共享、生态社会效益分别找动作。",
                "每个要点写成原理句、材料句、结果句，避免只摘材料或只背口号。",
                "最后回扣高质量发展，把创新、协调、绿色、开放、共享等关键词与材料对应。"
            ],
            diagnostics: ["是否先审设问", "是否按材料分层", "是否形成术语材料结果闭环", "是否避免原理漫灌"]
        ),
        sq(
            id: "asq_econ_03",
            nodeId: "n15",
            knowledgeId: "k1502",
            grade: .s,
            questionType: .significance,
            score: 12,
            material: "某地坚持把发展经济着力点放在实体经济上，推动制造业高端化、智能化、绿色化转型，建设现代化产业体系。同时深化要素市场化改革，构建全国统一大市场。",
            prompt: "结合材料，运用经济生活知识，说明建设现代化产业体系对推动高质量发展的意义。",
            answerPoints: [
                "实体经济是一国经济的立身之本，是财富创造的根本源泉，是国家强盛的重要支柱。",
                "推动制造业转型升级，有利于深化供给侧结构性改革，提高供给体系质量和效率。",
                "构建全国统一大市场，发挥市场决定性作用，促进资源优化配置和要素自由流动。",
                "建设现代化产业体系，筑牢现代化经济体系根基，为高质量发展提供坚实支撑。"
            ],
            diagnostics: ["是否点出实济地位", "是否结合供给侧改革", "是否写市场作用", "是否回扣高质量发展"]
        ),
        sq(
            id: "asq_econ_04",
            nodeId: "n27",
            knowledgeId: "k2702",
            grade: .s,
            questionType: .measure,
            score: 12,
            material: "新质生产力成为经济热词。某地布局人工智能、生物制造、量子科技等未来产业，加大基础研究投入，推动创新链产业链资金链人才链深度融合。",
            prompt: "结合材料，说明应如何以新质生产力推动高质量发展。",
            answerPoints: [
                "坚持创新驱动发展，把科技自立自强作为国家发展的战略支撑，加大基础研究投入。",
                "推动产业结构优化升级，培育壮大战略性新兴产业和未来产业，构建现代化产业体系。",
                "深化体制机制改革，促进创新链产业链资金链人才链深度融合，优化资源配置。",
                "把发挥市场决定性作用和更好发挥政府作用结合起来，为新质生产力营造良好环境。"
            ],
            diagnostics: ["是否抓住科技创新核心", "是否写产业升级", "是否结合改革和制度保障", "是否避免只喊口号"]
        ),
        sq(
            id: "asq_pol_04",
            nodeId: "n17",
            knowledgeId: "k1701",
            grade: .s,
            questionType: .significance,
            score: 10,
            material: "某社区建立居民议事厅，凡涉及居民切身利益的重要事项都通过议事会讨论决定。人大代表、政协委员、社区工作者和居民代表共同参与，形成民事民议、民事民办、民事民管的基层治理格局。",
            prompt: "结合材料，说明发展全过程人民民主对基层治理的意义。",
            answerPoints: [
                "全过程人民民主是最广泛、最真实、最管用的民主，保障人民当家作主。",
                "基层群众自治是人民当家作主的有效途径，保障居民直接行使民主权利。",
                "多方参与基层治理，汇聚民智民意，提高决策的科学性和民主性。",
                "激发基层活力，化解矛盾纠纷，提升基层治理效能，构建共建共治共享格局。"
            ],
            diagnostics: ["是否体现全过程人民民主特点", "是否区分直接间接民主", "是否写治理效能", "是否结合材料多层主体"]
        ),
        sq(
            id: "asq_pol_05",
            nodeId: "n18",
            knowledgeId: "k1802",
            grade: .a,
            questionType: .measure,
            score: 10,
            material: "某省政府深化放管服改革，编制行政许可事项清单，推进政务服务标准化、规范化、便利化，推行一网通办、跨省通办，让企业和群众少跑腿、好办事。",
            prompt: "结合材料，说明政府应如何推进法治政府建设，提升治理能力。",
            answerPoints: [
                "政府要坚持为人民服务宗旨和对人民负责原则，不断提高行政效率和服务水平。",
                "坚持依法行政，法定职责必须为、法无授权不可为，规范行政权力运行。",
                "深化放管服改革，转变政府职能，建设服务型政府，优化营商环境。",
                "推进政务公开，自觉接受监督，提高政府公信力和执行力。"
            ],
            diagnostics: ["是否写宗旨原则", "是否体现依法行政要求", "是否区分管理和服务", "是否回扣治理能力"]
        ),
        sq(
            id: "asq_pol_06",
            nodeId: "n17",
            knowledgeId: "k1701",
            grade: .a,
            questionType: .materialAnalysis,
            score: 10,
            material: "十三届全国人大常委会在立法工作中广泛征求社会各界意见，深入开展调研，召开座谈会、听证会，让立法更好体现人民意志。同时加强对法律实施情况的监督检查。",
            prompt: "结合材料，说明全国人大常委会是如何坚持以人民为中心的。",
            answerPoints: [
                "全国人大常委会是全国人大的常设机关，行使立法权和监督权等职权。",
                "坚持科学立法、民主立法、依法立法，拓宽公民有序参与立法途径。",
                "加强法律监督，确保法律有效实施，维护人民群众合法权益。",
                "坚持民主集中制原则，使立法和监督工作更好体现人民意志、保障人民权益。"
            ],
            diagnostics: ["是否区分全国人大和常委会", "是否写立法和监督两项职权", "是否体现人民当家作主", "是否结合材料做法"]
        ),
        sq(
            id: "asq_phi_05",
            nodeId: "n20",
            knowledgeId: "k2002",
            grade: .s,
            questionType: .materialAnalysis,
            score: 12,
            material: "我国在推进共同富裕过程中，既要不断把蛋糕做大，又要把蛋糕分好。各地从实际出发，因地制宜探索有效路径，不搞齐步走、一刀切，鼓励各地大胆探索、先行先试。",
            prompt: "结合材料，运用矛盾观分析我国推进共同富裕的做法。",
            answerPoints: [
                "矛盾就是对立统一，要坚持一分为二、全面看问题。做大蛋糕和分好蛋糕是对立统一的关系。",
                "矛盾具有特殊性，要坚持具体问题具体分析。各地因地制宜、不搞一刀切，体现对矛盾特殊性的把握。",
                "矛盾普遍性和特殊性相互联结，要坚持共性与个性具体历史的统一。鼓励先行先试、探索路径，体现了普遍指导与具体实践结合。",
                "坚持两点论和重点论统一，在推动高质量发展中促进共同富裕。"
            ],
            diagnostics: ["是否选对矛盾观范围", "是否结合材料对应原理", "是否避免原理罗列", "是否坚持方法论对应"]
        ),
        sq(
            id: "asq_phi_06",
            nodeId: "n19",
            knowledgeId: "k1902",
            grade: .a,
            questionType: .evaluation,
            score: 10,
            material: "有人认为，真理是主观见之于客观的活动，只要经过实践检验的认识就是真理。也有人认为，真理具有客观性，真理面前人人平等。",
            prompt: "结合材料，运用认识论知识，对上述观点加以评析。",
            answerPoints: [
                "实践是主观见之于客观的活动，是检验认识真理性的唯一标准。但经过实践检验的认识不一定是真理。",
                "真理是标志主观同客观相符合的哲学范畴，是人们对客观事物及其规律的正确反映。真理最基本的属性是客观性。",
                "由于人们的立场、观点和方法不同，对同一个确定的对象会产生多种不同认识。但其中只能有一种正确认识。",
                "认识具有反复性、无限性和上升性，真理在发展中不断超越自身，但真理只有一个，真理面前人人平等。"
            ],
            diagnostics: ["是否抓住真理客观性", "是否区分实践和真理概念", "是否评析两种观点", "是否体现认识发展"]
        ),
        sq(
            id: "asq_cul_01",
            nodeId: "n22",
            knowledgeId: "k2201",
            grade: .a,
            questionType: .measure,
            score: 10,
            material: "故宫博物院推出数字故宫、数字文物库，让沉睡的文物活起来。河南卫视中国节日系列节目运用AR、VR等技术，让传统文化焕发新生，受到年轻人喜爱。",
            prompt: "结合材料，运用文化生活知识，说明如何推动中华优秀传统文化创造性转化、创新性发展。",
            answerPoints: [
                "立足社会实践，反映时代要求，为传统文化注入新的时代内涵。",
                "推动文化内容形式、体制机制、传播手段创新，增强文化吸引力和感染力。",
                "发挥科技进步对文化发展的推动作用，运用现代信息技术促进文化传播。",
                "坚持以人民为中心的创作导向，满足人民群众日益增长的精神文化需求。"
            ],
            diagnostics: ["是否写实践基础", "是否结合科技作用", "是否区分双创内涵", "是否回扣文化发展"]
        ),
        sq(
            id: "asq_int_02",
            nodeId: "n23",
            knowledgeId: "k2302",
            grade: .s,
            questionType: .significance,
            score: 10,
            material: "中国提出全球发展倡议、全球安全倡议、全球文明倡议，推动构建人类命运共同体。中国积极参与全球治理体系改革和建设，推动世界朝着更加公正合理的方向发展。",
            prompt: "结合材料，说明中国推动构建人类命运共同体的时代价值。",
            answerPoints: [
                "国家利益是国际关系的决定性因素，共同利益是国家合作的基础。构建人类命运共同体符合各国共同利益。",
                "和平与发展是当今时代主题。构建人类命运共同体顺应时代潮流，有利于世界和平与发展。",
                "中国是负责任大国，在国际事务中发挥建设性作用，为全球治理贡献中国智慧和中国方案。",
                "推动国际关系民主化，推动全球治理体系改革，建设持久和平、共同繁荣的和谐世界。"
            ],
            diagnostics: ["是否结合国家利益", "是否体现时代主题", "是否写中国担当", "是否回扣命运共同体"]
        ),
        sq(
            id: "asq_leg_02",
            nodeId: "n25",
            knowledgeId: "k2502",
            grade: .a,
            questionType: .materialAnalysis,
            score: 10,
            material: "甲在网上购买了一台电子产品，收到后发现存在质量问题，要求商家退货退款。商家以已拆封为由拒绝退货，双方产生纠纷。甲准备通过法律途径维护自身权益。",
            prompt: "结合材料，分析消费者应如何依法维护自身合法权益。",
            answerPoints: [
                "消费者依法享有安全消费的权利、知情权、自主选择权和公平交易权等权利。产品质量问题侵害了消费者合法权益。",
                "经营者应当保证消费者安全消费的权利，对可能危及人身财产安全的商品和服务作出真实说明和明确警示。",
                "消费者可以通过与经营者协商和解、请求消费者协会调解、向有关行政部门投诉等途径维权。",
                "消费者可以通过仲裁或者诉讼等方式解决纠纷，维护自身合法权益。"
            ],
            diagnostics: ["是否明确消费者权利", "是否区分多种维权途径", "是否结合材料中的情形", "是否体现依法维权"]
        ),
        sq(
            id: "asq_sprint_03",
            nodeId: "n28",
            knowledgeId: "k2803",
            grade: .s,
            questionType: .openInquiry,
            score: 14,
            material: "高考政治主观题常出现这样的设问：结合材料并运用政治生活知识，分析在推进某项工作中各主体是如何发挥作用的。材料通常包含党、政府、人大、政协、公民等多个主体的信息。",
            prompt: "请示范主体定位法在多主体政治主观题中的应用方法。",
            answerPoints: [
                "第一步：定主体。通读材料，逐一标出材料中的政治主体，如党、政府、人大、政协、公民、司法机关等。",
                "第二步：定职权。回忆每个主体的性质、地位和职权，确保术语准确，不混淆主体职能。",
                "第三步：定关系。分析各主体之间的关系，如党的领导、人大与政府的关系、政协的作用等，体现政治生活的内在逻辑。",
                "第四步：组答案。每个主体单独成点，按照主体+做法+结果的结构组织答案，最后可以总结各主体协调配合形成合力。"
            ],
            diagnostics: ["是否先抓主体", "是否准确调用各主体术语", "是否体现主体间关系", "是否形成答题闭环"]
        ),
        sq(
            id: "asq_econ_05",
            nodeId: "n14",
            knowledgeId: "k1406",
            grade: .s,
            questionType: .measure,
            score: 12,
            material: "某地围绕新能源汽车、生物医药等领域布局未来产业，支持企业开展关键核心技术攻关，同时推动传统制造业数字化、智能化改造，带动现代化产业体系建设和劳动者技能升级。",
            prompt: "结合材料，运用经济发展知识，说明该地应如何加快形成新质生产力、推动高质量发展。",
            answerPoints: [
                "加快科技创新，突破关键核心技术，培育新能源汽车、生物医药等新产业新模式新动能，提升全要素生产率。",
                "发展新质生产力不能忽视传统产业，要以科技创新推动传统制造业数字化、智能化转型升级。",
                "巩固壮大实体经济根基，加快建设现代化产业体系，统筹质的有效提升和量的合理增长。",
                "重视劳动者技能培育，实现劳动者、劳动资料、劳动对象优化组合，为高质量发展提供人才支撑。"
            ],
            diagnostics: ["是否点出新质生产力核心标志", "是否兼顾新产业和传统产业升级", "是否落到现代化产业体系", "是否贴合材料中的产业领域"]
        ),
        sq(
            id: "asq_int_03",
            nodeId: "n23",
            knowledgeId: "k2306",
            grade: .a,
            questionType: .materialAnalysis,
            score: 10,
            material: "联合国安理会就某地区局势召开紧急会议，多个会员国推动通过人道主义援助决议；与此同时，世界贸易组织就贸易争端启动磋商机制，相关成员通过多边规则寻求解决方案。",
            prompt: "结合材料，运用国际组织相关知识，说明国际组织在国际事务中发挥的作用及其局限。",
            answerPoints: [
                "联合国是最具普遍性、代表性和权威性的政府间国际组织，安理会决议有利于协调各方推动人道主义援助。",
                "世界贸易组织等国际组织为成员国提供多边规则和争端解决机制，便利国际经贸合作。",
                "国际组织发挥作用受主权国家意愿和国际力量对比制约，其决议效力因机构和事项而异，不能等同于国内法律的强制力。",
                "我国坚定支持多边主义，维护以联合国为核心的国际体系和以国际法为基础的国际秩序。"
            ],
            diagnostics: ["是否区分政府间和非政府间国际组织", "是否写出国际组织的局限性", "是否结合材料中的具体机构", "是否落到我国支持多边主义的立场"]
        ),
        sq(
            id: "asq_leg_03",
            nodeId: "n24",
            knowledgeId: "k2405",
            grade: .a,
            questionType: .materialAnalysis,
            score: 10,
            material: "甲乙结婚后共同经营一家网店，店铺收入用于家庭日常开支并部分存为家庭积蓄。甲因意外去世且未留遗嘱，乙与甲的父母就家庭财产和遗产分配产生分歧。",
            prompt: "结合材料，运用婚姻家庭与继承知识，说明应如何依法处理甲乙的家庭财产和遗产分配问题。",
            answerPoints: [
                "夫妻在婚姻关系存续期间共同经营所得的收入和积蓄，除有约定外，应认定为夫妻共同财产。",
                "处理遗产前应先析出乙的夫妻共同财产份额，剩余部分才属于甲的个人遗产。",
                "甲未留遗嘱，应按法定继承办理，由配偶、子女、父母等第一顺序继承人依法定顺序继承遗产。",
                "家庭成员对财产和遗产分配存在分歧的，应通过协商、调解或诉讼等合法途径解决，不得自行处置或激化矛盾。"
            ],
            diagnostics: ["是否先区分共同财产和个人遗产", "是否准确说出法定继承顺序", "是否提示合法解决途径", "是否贴合材料中的家庭经营情形"]
        )
    ]

    static func questions(topic: PoliticsTopic) -> [SubjectiveQuestion] {
        all.filter { MainLineData.node(id: $0.nodeId)?.topic == topic }
    }

    private static func sq(id: String,
                           nodeId: String,
                           knowledgeId: String,
                           grade: ImportanceGrade,
                           questionType: SubjectiveQuestionType,
                           score: Int,
                           material: String,
                           prompt: String,
                           answerPoints: [String],
                           diagnostics: [String]) -> SubjectiveQuestion {
        SubjectiveQuestion(
            id: id,
            nodeId: nodeId,
            knowledgeId: knowledgeId,
            grade: grade,
            questionType: questionType,
            score: score,
            material: material,
            prompt: prompt,
            answerPoints: answerPoints,
            diagnostics: diagnostics
        )
    }
}
