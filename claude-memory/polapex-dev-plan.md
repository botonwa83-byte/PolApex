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
- Next: deepen terminology accuracy tracking and add more hand-authored S-tier material cases/Boss duels.
