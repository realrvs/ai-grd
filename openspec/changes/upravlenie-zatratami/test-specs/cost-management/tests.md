## Test Suite: cost-management

### TC-001: Успешный ввод плана затрат
- **Type**: Functional
- **Covers**: FR-001
- **Priority**: P0
#### Steps
1. Given пользователь с ролью «Руководитель участка» открыл документ «План затрат»
2. When пользователь выбирает участок «Участок-1», период «2026-03», статью «Топливо», сумму 100000 и проводит документ
3. Then документ проведён, запись в регистре «Затраты» с типом «План» создана
#### Data
- Input: {site: "Участок-1", period: "2026-03", article: "fuel", amount: 100000}
- Expected Output: {status: "posted", registerRecord: {type: "План", amount: 100000}}

### TC-002: Ввод плана без обязательных полей
- **Type**: Functional
- **Covers**: FR-001
- **Priority**: P0
#### Steps
1. Given пользователь открыл документ «План затрат»
2. When пользователь оставляет поле «Статья затрат» пустым и пытается провести
3. Then проведение блокируется, выводится сообщение с перечнем незаполненных полей
#### Data
- Input: {site: "Участок-1", period: "2026-03", article: null, amount: 100000}
- Expected Output: {status: "blocked", message: "Заполните обязательные поля: Статья затрат"}

### TC-003: Успешный ввод факта затрат
- **Type**: Functional
- **Covers**: FR-002
- **Priority**: P0
#### Steps
1. Given пользователь открыл документ «Факт затрат»
2. When пользователь вводит дату 2026-03-15, участок «Участок-1», статью «Топливо», количество 500, сумму 25000 и проводит
3. Then документ проведён, запись в регистре с типом «Факт» создана
#### Data
- Input: {date: "2026-03-15", site: "Участок-1", article: "fuel", quantity: 500, amount: 25000}
- Expected Output: {status: "posted", registerRecord: {type: "Факт", amount: 25000}}

### TC-004: Отрицательная сумма факта
- **Type**: Functional
- **Covers**: FR-002, NFR-SEC-001
- **TM Ref**: TM-01
- **Priority**: P1 (security)
#### Steps
1. Given пользователь открыл документ «Факт затрат»
2. When пользователь вводит сумму −1000 и пытается провести
3. Then проведение блокируется, сообщение «Сумма должна быть положительной», движений в регистре нет
#### Data
- Input: {amount: -1000}
- Expected Output: {status: "blocked", message: "Сумма должна быть положительной", registerRecords: 0}

### TC-005: Успешный ввод выпуска продукции
- **Type**: Functional
- **Covers**: FR-003
- **Priority**: P0
#### Steps
1. Given пользователь открыл документ «Выпуск продукции»
2. When пользователь выбирает участок «Участок-1», период «2026-03», ед. изм. «тонны», объём 5000 и проводит
3. Then документ проведён, запись выпуска создана
#### Data
- Input: {site: "Участок-1", period: "2026-03", unit: "тонны", volume: 5000}
- Expected Output: {status: "posted", volume: 5000}

### TC-006: Нулевой выпуск продукции
- **Type**: Functional
- **Covers**: FR-003
- **Priority**: P1
#### Steps
1. Given пользователь вводит объём выпуска 0
2. When пользователь пытается провести документ
3. Then проведение блокируется, сообщение «Объём выпуска должен быть положительным»
#### Data
- Input: {volume: 0}
- Expected Output: {status: "blocked", message: "Объём выпуска должен быть положительным"}

### TC-007: Расчёт норматива по статье
- **Type**: Integration
- **Covers**: FR-004
- **Priority**: P1
#### Steps
1. Given в справочнике «Нормы расхода» задана норма 0.05 л/т для статьи «Топливо» на «Участке-1»; введён выпуск 5000 т
2. When пользователь формирует отчёт план-факт за период
3. Then норматив = 0.05 × 5000 = 250 л, отображается в отчёте
#### Data
- Input: {norm: 0.05, volume: 5000}
- Expected Output: {normative: 250}

### TC-008: Норматив при отсутствии нормы
- **Type**: Integration
- **Covers**: FR-004
- **Priority**: P2
#### Steps
1. Given для статьи «Электроэнергия» норма не задана
2. When пользователь формирует отчёт
3. Then норматив отображается как «н/д», отчёт формируется без ошибок
#### Data
- Input: {article: "energy", norm: null}
- Expected Output: {normative: null, status: "report_formed"}

### TC-009: Расчёт отклонения — перерасход
- **Type**: Functional
- **Covers**: FR-005
- **Priority**: P0
#### Steps
1. Given план по статье «Топливо» = 100000, факт = 115000
2. When пользователь формирует отчёт план-факт
3. Then отклонение = +15000, % = 15.0, строка подсвечена красным
#### Data
- Input: {plan: 100000, fact: 115000}
- Expected Output: {deviation: 15000, deviationPercent: 15.0, highlight: "red"}

### TC-010: Расчёт отклонения — экономия
- **Type**: Functional
- **Covers**: FR-005
- **Priority**: P0
#### Steps
1. Given план по статье «Материалы» = 50000, факт = 48000
2. When пользователь формирует отчёт
3. Then отклонение = −2000, % = −4.0, строка подсвечена зелёным
#### Data
- Input: {plan: 50000, fact: 48000}
- Expected Output: {deviation: -2000, deviationPercent: -4.0, highlight: "green"}

### TC-011: Формирование отчёта план-факт за период
- **Type**: E2E
- **Covers**: FR-006, NFR-001
- **Priority**: P0
#### Steps
1. Given за период «2026-03» по «Участку-1» введены план и факт по 4 статьям
2. When пользователь формирует отчёт «План-факт»
3. Then таблица содержит все 4 статьи, итоговую строку, время формирования ≤ 3 с
#### Data
- Input: {site: "Участок-1", period: "2026-03"}
- Expected Output: {rows: 4, totalRow: true, timeMs: ≤3000}

### TC-012: Пустой период в отчёте
- **Type**: Functional
- **Covers**: FR-006
- **Priority**: P1
#### Steps
1. Given за период «2026-04» данных нет
2. When пользователь формирует отчёт
3. Then сообщение «Нет данных за выбранный период», таблица не формируется
#### Data
- Input: {period: "2026-04"}
- Expected Output: {message: "Нет данных за выбранный период", rows: 0}

### TC-013: Отображение дашборда с топ-3 перерасхода
- **Type**: E2E
- **Covers**: FR-007
- **Priority**: P1
#### Steps
1. Given за период есть план/факт по 4 статьям, перерасход по 3 из них
2. When пользователь открывает дашборд и выбирает участок/период
3. Then отображаются totalPlan, totalFact, totalDeviation, topOverruns (3 статьи)
#### Data
- Input: {site: "Участок-1", period: "2026-03"}
- Expected Output: {totalPlan: number, totalFact: number, totalDeviation: number, topOverruns: 3}

### TC-014: Доступ администратора к вводу факта
- **Type**: Security
- **Covers**: FR-008, NFR-SEC-003
- **TM Ref**: TM-03
- **Priority**: P1
#### Steps
1. Given пользователь вошёл с ролью «Администратор»
2. When пользователь пытается открыть документ «Факт затрат» на запись
3. Then доступ блокируется, сообщение о недостаточных правах
#### Data
- Input: {role: "Администратор", action: "open_fact_document_for_write"}
- Expected Output: {status: "forbidden", message: "Недостаточно прав"}

### TC-015: Производительность отчёта на 10 000 записей
- **Type**: Performance
- **Covers**: NFR-001
- **Priority**: P1
#### Steps
1. Given в регистре «Затраты» 10 000 записей за период
2. When пользователь формирует отчёт «План-факт»
3. Then время формирования ≤ 3 с
#### Data
- Input: {records: 10000}
- Expected Output: {timeMs: ≤3000}

### TC-016: Атомарность проведения при ошибке
- **Type**: Integration
- **Covers**: NFR-002
- **Priority**: P1
#### Steps
1. Given документ «Факт затрат» содержит одну корректную и одну некорректную строку
2. When пользователь проводит документ
3. Then ни одна запись регистра не сохраняется, сообщение об ошибке
#### Data
- Input: {rows: [{amount: 1000}, {amount: -500}]}
- Expected Output: {status: "blocked", registerRecords: 0}

### TC-017: Фиксация проведения в журнале регистрации
- **Type**: Security
- **Covers**: NFR-003, NFR-SEC-002
- **TM Ref**: TM-02
- **Priority**: P1
#### Steps
1. Given пользователь провёл документ «Факт затрат»
2. When администратор открывает журнал регистрации
3. Then в журнале есть запись о проведении с пользователем, временем и типом события
#### Data
- Input: {action: "post_fact_document"}
- Expected Output: {journalEntry: {user: "user1", event: "Проведение", timestamp: "..."}}

### TC-018: Ввод строки факта за 4 действия
- **Type**: Functional
- **Covers**: NFR-004
- **Priority**: P2
#### Steps
1. Given пользователь открыл документ «Факт затрат» с предзаполненными датой и участком
2. When пользователь выбирает статью, вводит сумму и проводит
3. Then строка сохранена не более чем за 4 действия
#### Data
- Input: {prefilled: ["date", "site"]}
- Expected Output: {actions: 4, status: "posted"}

### TC-019: Запуск на учебной версии 1С
- **Type**: Integration
- **Covers**: NFR-005
- **Priority**: P1
#### Steps
1. Given развёрнута учебная версия 1С:Предприятие 8.3
2. When пользователь выполняет демо-сценарий (план → факт → отчёт)
3. Then все функции доступны без ошибок лицензирования
#### Data
- Input: {environment: "1C educational 8.3"}
- Expected Output: {status: "ok", errors: 0}

### TC-020: Блокировка суммы ≤ 0 при проведении (security)
- **Type**: Security
- **Covers**: NFR-SEC-001
- **TM Ref**: TM-01
- **Priority**: P1
#### Steps
1. Given документ «Факт затрат» с суммой 0
2. When пользователь пытается провести
3. Then проведение блокируется, сообщение, движений нет
#### Data
- Input: {amount: 0}
- Expected Output: {status: "blocked", message: "Сумма должна быть положительной"}

### TC-021: Проверка прав роли «Руководитель» на справочники
- **Type**: Security
- **Covers**: NFR-SEC-003
- **TM Ref**: TM-03
- **Priority**: P1
#### Steps
1. Given пользователь с ролью «Руководитель участка»
2. When пользователь пытается изменить справочник «Нормы расхода»
3. Then доступ заблокирован
#### Data
- Input: {role: "Руководитель", action: "edit_norms"}
- Expected Output: {status: "forbidden"}
