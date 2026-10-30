## Phase 1: Справочники и модель данных

- [x] T-001: Создать справочник «Участки» (наименование, код) (`src/catalogs/Sites.xml`)
  - **FR/NFR**: FR-001, FR-002
  - **Estimate**: 1
  - **Dependencies**: —

- [x] T-002: Создать справочник «Статьи затрат» (код/наименование/тип): 01 — Топливо (fuel), 02 — Материалы (materials), 03 — Электроэнергия (energy), 04 — Оплата труда (labor) (`src/catalogs/Articles.xml`)
  - **FR/NFR**: FR-001, FR-002
  - **Estimate**: 1
  - **Dependencies**: —

- [x] T-003: Создать справочник «Нормы расхода» (участок, статья, норма на единицу выпуска) (`src/catalogs/Norms.xml`)
  - **FR/NFR**: FR-004
  - **ADR**: ADR-001
  - **Estimate**: 2
  - **Dependencies**: T-001, T-002

- [x] T-004: Заполнить демо-данные справочников (1 участок, 4 статьи, нормы по 2 статьям) (`src/data/demo_master_data.xml`)
  - **FR/NFR**: FR-001, FR-004
  - **Estimate**: 1
  - **Dependencies**: T-001, T-002, T-003

## Phase 2: Документы и регистр

- [ ] T-101: Создать регистр накопления «Затраты» (измерения: участок, статья, тип; ресурсы: сумма, количество) (`src/registers/Costs.xml`)
  - **FR/NFR**: FR-001, FR-002, NFR-002
  - **ADR**: ADR-001
  - **Estimate**: 3
  - **Dependencies**: T-001, T-002

- [ ] T-102: Создать документ «План затрат» (участок, период; ТЧ: статья, сумма) (`src/documents/PlanCosts.xml`)
  - **FR/NFR**: FR-001
  - **ADR**: ADR-001
  - **Estimate**: 3
  - **Dependencies**: T-101, T-002

- [ ] T-103: Реализовать движения документа «План затрат» в регистр «Затраты» (тип=План) (`src/documents/PlanCosts.manager.xml`)
  - **FR/NFR**: FR-001, NFR-002
  - **Estimate**: 2
  - **Dependencies**: T-102

- [ ] T-104: Создать документ «Факт затрат» (участок, дата; ТЧ: статья, количество, сумма) (`src/documents/FactCosts.xml`)
  - **FR/NFR**: FR-002
  - **ADR**: ADR-001
  - **Estimate**: 3
  - **Dependencies**: T-101, T-002

- [ ] T-105: Реализовать движения документа «Факт затрат» в регистр «Затраты» (тип=Факт) (`src/documents/FactCosts.manager.xml`)
  - **FR/NFR**: FR-002, NFR-002
  - **Estimate**: 2
  - **Dependencies**: T-104

- [ ] T-106: Создать документ «Выпуск продукции» (участок, период, ед. изм., объём) (`src/documents/Output.xml`)
  - **FR/NFR**: FR-003
  - **Estimate**: 2
  - **Dependencies**: T-001

- [ ] T-107: Реализовать движения документа «Выпуск продукции» в регистр «Затраты» (ресурс quantity) (`src/documents/Output.manager.xml`)
  - **FR/NFR**: FR-003, FR-004
  - **Estimate**: 1
  - **Dependencies**: T-106, T-101

## Phase 3: Отчётность и дашборд

- [ ] T-201: Создать отчёт СКД «План-факт по статьям» (группировка: статья; колонки: план, факт, норматив, отклонение, %) (`src/reports/PlanFact.xml`)
  - **FR/NFR**: FR-005, FR-006, FR-004
  - **ADR**: ADR-001
  - **Estimate**: 5
  - **Dependencies**: T-101, T-003

- [ ] T-202: Настроить условное оформление отчёта (перерасход — красный, экономия — зелёный) (`src/reports/PlanFact.conditional.xml`)
  - **FR/NFR**: FR-005, FR-006
  - **Estimate**: 2
  - **Dependencies**: T-201

- [ ] T-203: Добавить итоговую строку в отчёт план-факт (`src/reports/PlanFact.total.xml`)
  - **FR/NFR**: FR-006
  - **Estimate**: 1
  - **Dependencies**: T-201

- [ ] T-204: Реализовать обработку пустого периода (сообщение «Нет данных») (`src/reports/PlanFact.empty.xml`)
  - **FR/NFR**: FR-006
  - **Estimate**: 1
  - **Dependencies**: T-201

- [ ] T-205: Создать дашборд руководителя (totalPlan, totalFact, totalDeviation, top-3 перерасхода) (`src/reports/Dashboard.xml`)
  - **FR/NFR**: FR-007
  - **Estimate**: 3
  - **Dependencies**: T-201

## Phase 4: Безопасность (валидация, роли, аудит)

- [ ] T-301: Реализовать валидацию суммы > 0 и обязательных полей в документе «План затрат» (`src/documents/PlanCosts.validation.xml`)
  - **FR/NFR**: NFR-SEC-001
  - **TM Ref**: TM-01
  - **ADR**: ADR-002
  - **Estimate**: 2
  - **Dependencies**: T-102

- [ ] T-302: Реализовать валидацию суммы > 0 и обязательных полей в документе «Факт затрат» (`src/documents/FactCosts.validation.xml`)
  - **FR/NFR**: NFR-SEC-001
  - **TM Ref**: TM-01
  - **ADR**: ADR-002
  - **Estimate**: 2
  - **Dependencies**: T-104

- [ ] T-303: Реализовать валидацию объёма > 0 в документе «Выпуск продукции» (`src/documents/Output.validation.xml`)
  - **FR/NFR**: FR-003
  - **Estimate**: 1
  - **Dependencies**: T-106

- [ ] T-304: Включить запись событий проведения в журнал регистрации для трёх документов (`src/configuration/audit.xml`)
  - **FR/NFR**: NFR-SEC-002, NFR-003
  - **TM Ref**: TM-02
  - **ADR**: ADR-003
  - **Estimate**: 2
  - **Dependencies**: T-103, T-105, T-107

- [ ] T-305: Создать роль «Руководитель участка» с правами на ввод плана/факта/выпуска и просмотр отчётов (`src/roles/SiteManager.xml`)
  - **FR/NFR**: FR-008, NFR-SEC-003
  - **TM Ref**: TM-03
  - **ADR**: ADR-004
  - **Estimate**: 2
  - **Dependencies**: T-102, T-104, T-106, T-201, T-205

- [ ] T-306: Создать роль «Администратор» с правами на справочники/нормы и просмотр отчётов, без права ввода факта (`src/roles/Admin.xml`)
  - **FR/NFR**: FR-008, NFR-SEC-003
  - **TM Ref**: TM-03
  - **ADR**: ADR-004
  - **Estimate**: 2
  - **Dependencies**: T-003, T-201, T-205

- [ ] T-307: Настроить права ролей на объекты конфигурации (справочники, документы, отчёты) (`src/roles/Rights.xml`)
  - **FR/NFR**: FR-008, NFR-SEC-003
  - **TM Ref**: TM-03
  - **ADR**: ADR-004
  - **Estimate**: 3
  - **Dependencies**: T-305, T-306

## Phase 5: Тестирование и подготовка к защите

- [ ] T-401: Прогнать функциональные тесты TC-001…TC-013 (`tests/functional.md`)
  - **FR/NFR**: FR-001…FR-007
  - **Estimate**: 3
  - **Dependencies**: T-103, T-105, T-107, T-202, T-203, T-204, T-205

- [ ] T-402: Прогнать security-тесты TC-004, TC-014, TC-017, TC-020, TC-021 (`tests/security.md`)
  - **FR/NFR**: NFR-SEC-001…003
  - **TM Ref**: TM-01, TM-02, TM-03
  - **Estimate**: 2
  - **Dependencies**: T-301, T-302, T-304, T-305, T-306, T-307

- [ ] T-403: Прогнать тесты производительности и атомарности TC-015, TC-016, TC-019 (`tests/nfr.md`)
  - **FR/NFR**: NFR-001, NFR-002, NFR-005
  - **Estimate**: 2
  - **Dependencies**: T-201, T-103, T-105

- [ ] T-404: Подготовить демо-сценарий защиты (план → факт → отклонение → решение), 3–5 минут (`docs/demo-scenario.md`)
  - **FR/NFR**: FR-005, FR-006, FR-007
  - **Estimate**: 3
  - **Dependencies**: T-401

- [ ] T-405: Подготовить слайды защиты: проблема, «как есть/как должно быть», архитектура, демо, эффект, ограничения (`docs/slides.md`)
  - **FR/NFR**: FR-001…FR-008, NFR-001…NFR-005
  - **Estimate**: 3
  - **Dependencies**: T-404

- [ ] T-406: Отрепетировать ответы на вопросы жюри (методика себестоимости, косвенные затраты, масштаб) (`docs/qa-prep.md`)
  - **FR/NFR**: FR-005, FR-006
  - **Estimate**: 2
  - **Dependencies**: T-405

- [ ] T-407: Снять резервную копию базы перед защитой (`backup/` — вне репозитория)
  - **FR/NFR**: NFR-005
  - **Estimate**: 1
  - **Dependencies**: T-401, T-402, T-403
