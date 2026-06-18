# PolApex Development Memory

## Objective

Build **PolApex · 政治登顶** as an independent Apex family app in `trae_projects/polapex`.

- Bundle id: `com.polapex.app`
- IAP product id: `com.polapex.app.full_unlock`
- Tech stack: SwiftUI / iOS 16 / Swift 5 / XcodeGen
- Product core: knowledge coverage + weighted memory + answer-output loop
- Current phase: **P1 spine + weighted coverage MVP complete**

## Development Rules

1. Keep PolApex independent from ChemApex. Do not put PolApex files under `chemapex`.
2. Follow `../APEX_APP_开发范式.md`.
3. Each phase must be independently buildable and verifiable.
4. Reuse Apex family patterns where practical: DesignSystem, ThemeColors semantics, ReviewScheduler shape, paywall/promo structure, readable width, StoreKit naming.
5. Self-build the political-science heart: weighted memory, concept graph, material slicer, answer factory, subject matrix, weapon guides.
6. Content red lines: no fabricated exam source, no vague slogans as answers, no promise of “no memorization full marks”, timestamp sourced current-politics material.
7. Visual baseline now follows `../chemapex/ChemApex`: dynamic light/dark colors, warm paper background, rounded card surfaces, lava accent, and user-selectable appearance with default "跟随系统".

## Phase Plan

### P0 Skeleton

Goal: create a buildable independent SwiftUI app shell.

- [x] `project.yml` for XcodeGen
- [x] `PolApex/App/PolApexApp.swift`
- [x] `PolApex/App/RootView.swift`
- [x] `Core/Renderer/DesignSystem.swift`
- [x] `Core/Renderer/ThemeColors.swift`
- [x] `Core/Models/Stage.swift`
- [x] 4-tab shell: 登顶之路 / 答案工厂 / 概念星图 / 更多
- [x] App icon placeholder asset
- [x] `PolApexTests/PolApexTests.swift`
- [x] `PolApex.storekit`
- [x] Generate Xcode project
- [x] Run build/test

### P1 Spine

Goal: implement the main learning spine and monetization boundary.

- [x] Politics topic/weapon/knowledge models
- [x] 28-node mainline data
- [x] knowledge importance model
- [x] progress manager
- [x] node detail page
- [x] PurchaseManager + paywall + free-tier policy constants
- [x] PromoView
- [x] tests for unique ids, references, free-tier policy

### P1.5 Weighted Gaokao Coverage

Goal: ensure every political knowledge point has practice and priority.

- [x] 112-point initial exam catalog: junior DaoFa, required high-school politics, selective compulsory, sprint
- [x] importance split: S 36 / A 48 / B 26 / C 2
- [x] weighted generated choice practice: S 4, A 3, B 2, C 1, total 342
- [x] S/A subjective practice, total 84
- [x] coverage dashboard in app
- [x] tests guaranteeing every knowledge point has weighted questions and S/A subjective practice

### P2 Weighted Memory Engine

Goal: make political memorization concrete and adaptive.

- [x] five memory card types: 原话 / 边界 / 主体 / 场景 / 模板
- [x] weighted review intervals for S/A/B/C points
- [x] recall modes: 认得出 / 背得出 / 分得清 / 用得上
- [x] high-weight daily queue
- [x] local review state manager with correct/wrong counts, level, next due date
- [x] Smart Review UI: due queue, card reveal, remembered/forgotten recording
- [ ] terminology accuracy tracking
- [ ] tests for interval transitions and due-card ordering

### P2.5 First Expansion Modules

Goal: add high-impact political-score modules beyond the spine.

- [x] Choice trap drill range: 12 hand-authored traps covering 主体错配 / 绝对化 / 因果倒置 / 范围越界 / 无中生有 / 正确无关
- [x] Political subject matrix: 10 subjects covering party, NPC, government, CPPCC, court, procuratorate, citizen, enterprise, market, grassroots autonomy
- [x] Answer template library: 6 templates for 原因 / 措施 / 意义 / 体现 / 哲学 / 评析
- [x] New module entry cards on 答案工厂 and 更多
- [x] Integrity tests for trap drills, subject matrix, templates, review state

### P2.6 Content Depth Remediation

Goal: fix the "empty shell knowledge point" problem by turning each high-value point into a recitable, distinguishable, and answer-ready study unit.

Audit finding:

- Current `KnowledgePoint.detail` is mostly one sentence, suitable for card previews but too thin for a memorization-heavy political-science app.
- Choice questions, subjective questions, and memory cards all reuse the same `detail`, so practice volume looks large but content depth repeats.
- Material cases and concept graph are useful, but coverage is narrow compared with the 112-point catalog.
- Existing tests validate counts, references, and non-empty fields, but do not validate explanation depth.

Remediation requirements:

- [ ] Extend knowledge data from one-line detail to structured explanation fields: must-recite lines, plain explanation, answer template, trigger scenes, confusion pairs, common traps, sample answer sentences, recite checklist.
- [ ] Prioritize S/A points first, especially 党的领导、人大、政府、政协、公民、全过程人民民主、依法治国、市场与宏观调控、基本经济制度、实践与认识、矛盾观、文化创新、国家利益、民事责任、主观题模板.
- [ ] Update node detail UI so a knowledge point shows 必背原文 / 白话理解 / 答题模板 / 易混辨析 / 材料触发 / 高分答案句 / 扣分提醒 / 默写清单.
- [ ] Split memory-card backs by card type so 原话卡背原文、边界卡背易混、主体卡背职责、场景卡背触发、模板卡背输出句.
- [ ] Replace generated subjective answer points with structured knowledge explanation where available.
- [ ] Add content quality tests: S points must have enough must-recite lines, sample answer sentences, and traps; high-priority points must not rely only on `detail`.

Acceptance target for first implementation pass:

- [x] At least 20 S-level points have deep structured explanations.
- [x] S-level deep points each include at least 3 must-recite lines, 2 sample answer sentences, and 2 common traps or confusion notes.
- [x] Node detail and review cards visibly use the deeper content.
- [x] Tests fail if S-level content regresses to one-line shells.
- [x] All 36 S-level points now have structured deep explanations and are guarded by tests.
- [x] First A-level remediation wave: 22 high-frequency A points have structured deep explanations and are guarded by tests.
- [x] All 48 A-level points now have structured deep explanations and are guarded by tests.

### P3 Concept Graph

Goal: build the political knowledge map.

- [ ] concept graph model
- [ ] subject responsibility graph
- [ ] confusion edge data
- [ ] weighted heat rendering
- [ ] graph/list hybrid UI
- [ ] tests for valid node/edge references

### P4 Answer Factory

Goal: train material-question output.

- [ ] MaterialSlice model
- [ ] subject/action/object/goal detection rules
- [ ] six-step essay workflow
- [ ] answer sentence templates
- [ ] diagnostic tags: 主体错配 / 范围越界 / 因果倒置 / 术语不准 / 材料没贴
- [ ] short-answer practice UI

### P5 Weapon Library

Goal: implement method coaching and boss dual-solution cases.

- [ ] 12 MVP weapons
- [ ] weapon guide pages: when to use / steps / boss duel / practice
- [ ] choice-question trap filter
- [ ] philosophy locator
- [ ] economy chain
- [ ] contradiction three questions
- [ ] 20 boss duel cases
- [ ] tests for boss references and answer validity

### P6 Content Coverage

Goal: fill initial junior + senior mandatory + elective content.

- [ ] junior law/nation/growth points
- [ ] high school mandatory 1-4 points
- [ ] selective compulsory 1-3 points
- [ ] reverse-generated training items per knowledge point
- [ ] coverage dashboard
- [ ] tests for minimum coverage by importance grade

### P7 Emotional Hooks

Goal: add stories without losing exam relevance.

- [ ] thinkers / legal figures / governance stories
- [ ] archive list and detail pages
- [ ] every story ends with linked exam points
- [ ] tests for linked knowledge ids

### P8 Release Prep

Goal: prepare for App Store submission.

- [ ] final 1024 icon flattened without alpha
- [ ] StoreKit scheme configuration
- [ ] docs: index / privacy / terms / support
- [ ] iPad readable width validation
- [ ] launch screenshots checklist
- [ ] release checklist package
- [ ] full `xcodebuild test`

## Current Progress

- 2026-06-15: Created independent project directory `polapex`.
- 2026-06-15: Created product design `PLAN.md`.
- 2026-06-15: Created this development memory file.
- 2026-06-18: Implemented independent SwiftUI/XcodeGen app shell, StoreKit config, theme, icon, four tabs.
- 2026-06-18: Implemented 28-node political learning spine, 112 weighted knowledge points, generated 342 weighted choice questions and 84 S/A subjective questions.
- 2026-06-18: Implemented material slicer, answer factory, concept graph, weapon library, boss duels, progress manager, paywall/free tier, coverage tests.
- 2026-06-18: Generated `PolApex.xcodeproj`; `xcodebuild ... test` on iPhone 17 simulator passed 8 tests, 0 failures.
- 2026-06-18: First expansion completed: smart review module, choice trap drill range, political subject matrix, answer template library.
- 2026-06-18: Regenerated `PolApex.xcodeproj`; `xcodebuild ... test` on iPhone 17 simulator passed 12 tests, 0 failures.
- 2026-06-18: Audited knowledge content depth. Found the app has adequate coverage counts but many knowledge points are one-line shells; added P2.6 content-depth remediation plan.
- 2026-06-18: Implemented structured `KnowledgeExplanation`, node-detail deep study cards, deep memory-card backs, deep subjective answer points, and content-quality tests.
- 2026-06-18: Completed S-level remediation: all 36 S-level knowledge points now have must-recite lines, plain explanations, answer templates, trigger scenes, confusions/traps, sample answer sentences, and recite checklists. `xcodebuild ... test` passed 14 tests, 0 failures.
- 2026-06-18: Completed first A-level remediation wave: 22 high-frequency A points across junior law/democracy/nation, socialism, economy, culture, international relations, and legal life now have structured deep explanations. `xcodebuild ... test` passed 15 tests, 0 failures.
- 2026-06-18: Completed A-level remediation: all 48 A-level knowledge points now have must-recite lines, plain explanations, answer templates, trigger scenes, confusions/traps, sample answer sentences, and recite checklists. Tests now require every S/A point to have deep content. `xcodebuild ... test` passed 15 tests, 0 failures.
- 2026-06-18: Migrated PolApex visual baseline to match `../chemapex/ChemApex`: dynamic `UIColor`-backed ThemeColors, ChemApex-style card surface/radius/shadow, lava tab accent, App-level `AppearanceManager`, and "更多 > 外观" picker with 跟随系统/浅色/深色. Default remains follow system. `xcodebuild ... test` passed 15 tests, 0 failures.
- 2026-06-18: Product-structure remediation after module-linking audit: added `PracticeLinker` so weapons, Boss duels, material cases, trap drills, subject matrix, and answer templates all link back to choice/subjective practice; expanded subjective generation from S/A to S/A/B so logic and legal-life modules have主观题; added node full-practice-id checks and expansion-module practice-link tests.
- 2026-06-18: IAP value remediation: added `PremiumContentPlan`, rewrote paywall around six purchasable pillars, surfaced free-vs-full boundaries, and reorganized 答案工厂 into a study loop: 提分闭环 / 完整版价值 / 方法训练区 / 材料切片 / Boss 双解 / 主观题 / 记忆 / 覆盖数据. `xcodebuild ... test` passed 17 tests, 0 failures.
- 2026-06-18: Content breadth expansion wave: Boss Duel expanded from 7 to 15 cases, covering Chinese modernization, distribution/common prosperity, CPPCC, practice/knowledge, people/value choice, culture, international relations, and civil law in addition to existing organs/market/party/rule-law/contradiction/hot/essay. Material cases expanded from 5 to 15, adding new quality productive forces, distribution, party-led rule-of-law governance, CPPCC eldercare, public hearing, national security, contract dispute, labor overtime, global climate governance, and core-values network governance.
- 2026-06-18: Added tests requiring at least 15 Boss duels and 15 material cases, unique ids, valid node/knowledge references, 3+ solution/answer steps, and non-empty diagnostics. `xcodebuild ... test` passed 18 tests, 0 failures.
- 2026-06-18: Added Gaokao-ratio practice calibration: `ExamPracticeBlueprint` models the common new-Gaokao political elective structure as 16 single-choice questions / 48 points and 4 non-choice questions / 52 points, with province-level variation noted in UI copy. Added `ExamPracticeData` six套高考比例套练, training-page entry, set detail UI, topic slots, and tests enforcing 16+4 structure plus economy/politics-law/philosophy-culture/sprint subjective coverage. Premium value copy now highlights ratio-based套练 instead of raw question volume. `xcodebuild ... test` passed 19 tests, 0 failures.
- 2026-06-18: Corrected practice expansion direction after audit: do not judge Gaokao alignment by raw question count. Added `SubjectiveQuestionType` and per-question score, split generated/authored practice pools, added authored high-school style questions, and made exam套练 prefer authored items while enforcing 48-point choice + 52-point non-choice score weight. Non-choice pool now covers measures, material analysis, significance, evaluation, and open inquiry, with UI chips showing type and score. Added tests for authored question validity, non-choice type coverage, and 52-point non-choice total. `xcodebuild ... test` passed 20 tests, 0 failures.
- 2026-06-18: Final weak-point audit found the IAP plumbing already worked, but the purchase module lacked ChemApex-level value clarity. Reworked `PremiumContentPlan` and `PaywallView` to mirror ChemApex's hero + benefit rows + one-time unlock CTA while using PolApex-specific assets: Gaokao-ratio套练, non-choice question type pool, material answer factory, subject matrix, weapon library, Boss dual solutions, and review loop. Updated `PolApex.storekit` product copy, added DEBUG local unlock toggle, and added premium-plan tests requiring 48/52 and non-choice type messaging. `xcodebuild ... test` passed 21 tests, 0 failures.
- Next: continue adding questions by topic, but prioritize non-choice题型广度 and分值权重 first: every new wave should add fewer choice questions and more material/措施/意义/评析/开放探究题, keep `ExamPracticeBlueprint` passing, and keep IAP value copy focused on purchasable training assets instead of raw content counts.
