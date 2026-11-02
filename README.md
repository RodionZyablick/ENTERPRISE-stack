ENTERPRISE-stack
# 🏢 Enterprise Infrastructure: Prometheus + Grafana + Alertmanager + S3 + Restic

![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![Prometheus](https://img.shields.io/badge/Prometheus-E6522C?style=for-the-badge&logo=prometheus&logoColor=white)
![Grafana](https://img.shields.io/badge/Grafana-F46800?style=for-the-badge&logo=grafana&logoColor=white)
![Restic](https://img.shields.io/badge/Backup-Restic-blue?style=for-the-badge)

Комплексный стек для мониторинга инфраструктуры, отправки алертов и резервного копирования данных в S3-совместимое хранилище. Проект создан для демонстрации навыков системного администрирования, работы с Docker, мониторинга и обеспечения отказоустойчивости.

---

## 📖 О проекте (RU)
Этот проект демонстрирует навыки системного администратора по построению отказоустойчивой инфраструктуры. Он включает в себя:
- **Мониторинг** (сбор метрик CPU, RAM, дисков).
- **Визуализацию** (дашборды в Grafana).
- **Оповещения** (мгновенные алерты в Telegram при падении сервисов или перегрузке).
- **Резервное копирование** (автоматический бэкап данных в S3-хранилище с шифрованием).

### 🏗️ Архитектура и компоненты
* **Prometheus** — центральный сервер мониторинга, собирает метрики.
* **Node Exporter** — агент на хосте, отдает метрики «железа» (процессор, память, диски).
* **Alertmanager** — принимает алерты от Prometheus, группирует их и отправляет в Telegram.
* **Grafana** — веб-интерфейс для визуализации метрик в виде графиков и дашбордов.
* **SeaweedFS** — быстрое S3-совместимое хранилище (заменило MinIO, так как MinIO удалил публичные образы). Используется для хранения бэкапов.
* **Restic** — утилита для инкрементального, дедуплицированного и зашифрованного резервного копирования.

---

## 🚀 Быстрый старт (Запуск)

1. Убедитесь, что **Docker Desktop** запущен (в трее должна быть зеленая точка).
2. Откройте терминал в папке с проектом (где лежит `docker-compose.yml`).
3. Запустите стек в фоновом режиме:
   ```bash
   docker compose up -d
Проверьте, что все контейнеры запустились (статус должен быть Up или healthy):

bash
docker compose ps
(Первый запуск может занять 1-2 минуты, пока скачиваются образы).

🔗 Доступы к сервисам и ссылки
Сервис	URL в браузере	Логин / Пароль
Grafana (Дашборды)	http://localhost:3000	admin / admin
Prometheus (Метрики)	http://localhost:9090	-
Alertmanager (Алерты)	http://localhost:9093	-
SeaweedFS (S3 / Файлы)	http://localhost:8888	-
Node Exporter (Сырые метрики)	http://localhost:9100/metrics	-
🧪 Как тестировать систему
Чтобы убедиться, что всё работает как надо, выполните эти шаги.

Тест 1: Проверка сбора метрик
Откройте Prometheus (http://localhost:9090).

В верхнем меню выберите Status -> Targets.

Результат: Вы должны увидеть список целей (prometheus, node-exporter, grafana, alertmanager, seaweedfs). Напротив каждой должно быть написано UP (зеленым цветом).

Тест 2: Настройка красивого дашборда в Grafana
Откройте Grafana (http://localhost:3000). Войдите (admin/admin) и смените пароль.

В левом меню нажмите + (Create) -> Import dashboard.

В поле Import via grafana.com введите число 1860 (это официальный дашборд Node Exporter Full) и нажмите Load.

Внизу выберите источник данных Prometheus и нажмите Import.

Результат: Вы увидите красивые графики загрузки CPU, памяти и дисков вашего компьютера в реальном времени.

Тест 3: Проверка резервного копирования (Restic)
Создайте тестовый файл в папке для бэкапов (в терминале):

powershell
echo "Тестовый бэкап" > restic/backup-data/test.txt
Запустите скрипт бэкапа внутри контейнера:

bash
docker compose exec restic /scripts/backup.sh
Проверьте, что снапшот (снимок) создался:

bash
docker compose exec restic restic snapshots
Результат: В таблице появится ID снапшота и время его создания. Бэкап успешно улетел в S3 (SeaweedFS).

Тест 4: Симуляция падения сервера и проверка алертов
Остановите агент, собирающий метрики (симулируем падение сервера):

bash
docker stop node-exporter
Подождите 2 минуты (в конфиге alert.rules.yml указано условие срабатывания for: 2m).

Откройте Prometheus -> Alerts. Алерт InstanceDown загорится красным (Firing).

Откройте Alertmanager (http://localhost:9093). Алерт пришел туда.

(Если вы настроили Telegram-бота, вам в чат придет сообщение о падении).

Верните сервер в строй:

bash
docker start node-exporter
Через пару минут алерт погаснет.

🛠️ Полезные команды управления
Посмотреть статус контейнеров:

bash
docker compose ps
Посмотреть логи конкретного сервиса (в реальном времени):

bash
docker compose logs -f grafana
# Выход из логов: Ctrl + C
Перезапустить один контейнер (например, после правки конфига):

bash
docker restart prometheus
Остановить всю систему (данные и бэкапы сохранятся):

bash
docker compose down
Полностью удалить систему и стереть все данные (сброс до заводских настроек):

bash
docker compose down -v
🔔 Настройка Telegram для алертов
По умолчанию алерты уходят «в никуда», чтобы система не спамила вас при тестах. Чтобы получать их в реальный Telegram:

Создайте бота через @BotFather в Telegram и получите Bot Token.

Узнайте свой Chat ID (например, через бота @userinfobot).

Откройте файл alertmanager/alertmanager.yml.

Найдите строки и замените их на свои данные:

yaml
bot_token: 'ВАШ_ТОКЕН_БОТА'
chat_id: ВАШ_CHAT_ID
Перезапустите Alertmanager:

bash
docker compose restart alertmanager
🇬🇧 English Summary
Enterprise Infrastructure Stack — a Docker Compose project that demonstrates monitoring, alerting, and backup automation.

Prometheus scrapes metrics.

Node Exporter provides system metrics (CPU, RAM, Disk).

Grafana visualizes data (Import dashboard ID 1860).

Alertmanager routes alerts to Telegram.

SeaweedFS provides S3-compatible storage.

Restic creates encrypted backups of restic/backup-data into the S3 bucket.

Quick Start
bash
docker compose up -d
Access:

Grafana: http://localhost:3000 (admin / admin)

Prometheus: http://localhost:9090

Alertmanager: http://localhost:9093

SeaweedFS S3 Console: http://localhost:8888

Testing Backup
bash
echo "Test" > restic/backup-data/test.txt
docker compose exec restic /scripts/backup.sh
docker compose exec restic restic snapshots
Testing Alerts
bash
docker stop node-exporter
# wait 2 minutes, check http://localhost:9090/alerts
docker start node-exporter
