# Context

## Threat Model
- **Методология:** STRIDE (минимальная, baseline)
- **Обоснование:** security_context = {"baseline": true}
- **Ключевые угрозы:** TM-01 (High), TM-02 (Medium), TM-03 (Medium)

## Принятые ADR
- ADR-001: 1С:Предприятие 8.3 (учебная версия) — Accepted
- ADR-002: Валидация на уровне документов 1С — Accepted (TM-01, NFR-SEC-001)
- ADR-003: Встроенный журнал регистрации 1С — Accepted (TM-02, NFR-SEC-002)
- ADR-004: Модель ролей «Руководитель»/«Администратор» — Accepted (TM-03, NFR-SEC-003)

## Согласованные endpoints
- POST /api/v1/costs/plan
- POST /api/v1/costs/fact
- GET /api/v1/costs/plan-fact
- GET /api/v1/costs/dashboard
- (design-only, в MVP не реализуются)

## Открытые вопросы
- [x] **Статьи затрат:** fuel → код 01, materials → 02, energy → 03, labor → 04
- [x] **Период планирования:** месяц (YYYY-MM) — соответствует API-контракту и отчётности 1С
- [x] **База норматива:** тонны (норма задаётся на 1 т; расстояние учтено в значении нормы)
- [x] **«Динамика затрат по периодам»:** не нужен в MVP — достаточно план-факт + дашборд; тренды → Phase 2

## Пропущенные артефакты
- (пока нет)

## Сгенерированные артефакты
- proposal.md — DONE
- specs/cost-management/spec.md — DONE (FR-001…FR-008, NFR-001…NFR-005)
- design.md — DONE
- threat-model.md — DONE (TM-01…TM-03, NFR-SEC-001…003)
- adr/ADR-001…ADR-004 — DONE
- api-contract.yaml — DONE
- test-specs/cost-management/tests.md — DONE (TC-001…TC-021)
- tasks.md — DONE (T-001…T-407, 28 задач)
- apply.md — DONE (M-001…M-004, feature flags, canary, rollback)
- NFR-SEC — покрыты задачами и security-тестами
