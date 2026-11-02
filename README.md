# 🏢 Enterprise Infrastructure: Monitoring & Backup Stack

![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![Prometheus](https://img.shields.io/badge/Prometheus-E6522C?style=for-the-badge&logo=prometheus&logoColor=white)
![Grafana](https://img.shields.io/badge/Grafana-F46800?style=for-the-badge&logo=grafana&logoColor=white)
![MinIO/SeaweedFS](https://img.shields.io/badge/S3_Storage-SeaweedFS-blue?style=for-the-badge)

Комплексный стек для мониторинга инфраструктуры, отправки алертов и резервного копирования данных в S3-совместимое хранилище.

---

## 🌐 Мова / Язык / Language
- [🇺🇦 Українська](#-українська)
- [🇷🇺 Русский](#-русский)
- [🇬🇧 English](#-english)

---

## 🇺🇦 Українська

### 📖 Про проект
Цей проект демонструє навички системного адміністратора з побудови відмовостійкої інфраструктури. Він включає моніторинг серверів, візуалізацію даних, систему сповіщень та автоматизоване резервне копіювання.

### 🏗️ Архітектура
- **Prometheus**: Збирає метрики з серверів та сервісів.
- **Node Exporter**: Агент, що збирає метрики апаратного забезпечення (CPU, RAM, Диск).
- **Alertmanager**: Отримує алерти від Prometheus і надсилає їх у Telegram.
- **Grafana**: Візуалізує метрики у вигляді красивих дашбордів.
- **SeaweedFS**: S3-сумісне сховище для зберігання бекапів.
- **Restic**: Інструмент для інкрементального шифрованого резервного копіювання в S3.

### 🚀 Швидкий старт
1. Переконайтеся, що Docker Desktop запущено.
2. Виконайте команду в терміналі:
   ```bash
   docker compose up -d
Зачекайте 1-2 хвилини, поки всі контейнери запустяться.

🔗 Доступи та Сервіси
Сервіс	URL	Логін / Пароль
Grafana	http://localhost:3000	admin / admin
Prometheus	http://localhost:9090	-
Alertmanager	http://localhost:9093	-
SeaweedFS (S3)	http://localhost:8888	-
Node Exporter	http://localhost:9100/metrics	-
🧪 Як тестувати
1. Перевірка збору метрик:

Відкрийте Prometheus -> Status -> Targets. Усі цілі (5 шт.) повинні мати статус UP.

2. Перевірка резервного копіювання (Restic):

bash
# Створити тестовий файл
echo "Test backup" > restic/backup-data/test.txt
# Запустити бекап
docker compose exec restic /scripts/backup.sh
# Перевірити наявність снапшотів
docker compose exec restic restic snapshots
3. Перевірка Алертів (Симуляція падіння):

bash
# Зупинити Node Exporter
docker stop node-exporter
Зачекайте 2 хвилини. Відкрийте Prometheus -> Alerts. Алерт InstanceDown стане червоним (Firing).

Поверніть сервіс: docker start node-exporter.

🛠️ Корисні команди
docker compose ps — статус контейнерів.

docker compose logs -f <service> — логи (наприклад, grafana).

docker compose down — зупинити стек (дані збережуться).

docker compose down -v — зупинити та видалити всі дані.

🇷🇺 Русский
📖 О проекте
Этот проект демонстрирует навыки системного администратора по построению отказоустойчивой инфраструктуры. Он включает мониторинг серверов, визуализацию данных, систему оповещений и автоматизированное резервное копирование.

🏗️ Архитектура
Prometheus: Собирает метрики с серверов и сервисов.

Node Exporter: Агент, собирающий метрики железа (CPU, RAM, Диск).

Alertmanager: Получает алерты от Prometheus и отправляет их в Telegram.

Grafana: Визуализирует метрики в виде красивых дашбордов.

SeaweedFS: S3-совместимое хранилище для бэкапов.

Restic: Инструмент для инкрементального шифрованного резервного копирования в S3.

🚀 Быстрый старт
Убедитесь, что Docker Desktop запущен.

Выполните команду в терминале:

bash
docker compose up -d
Подождите 1-2 минуты, пока все контейнеры запустятся.

🔗 Доступы и Сервисы
Сервис	URL	Логин / Пароль
Grafana	http://localhost:3000	admin / admin
Prometheus	http://localhost:9090	-
Alertmanager	http://localhost:9093	-
SeaweedFS (S3)	http://localhost:8888	-
Node Exporter	http://localhost:9100/metrics	-
🧪 Как тестировать
1. Проверка сбора метрик:

Откройте Prometheus -> Status -> Targets. Все цели (5 шт.) должны быть в статусе UP.

2. Проверка резервного копирования (Restic):

bash
# Создать тестовый файл
echo "Test backup" > restic/backup-data/test.txt
# Запустить бэкап
docker compose exec restic /scripts/backup.sh
# Проверить наличие снапшотов
docker compose exec restic restic snapshots
3. Проверка Алертов (Симуляция падения):

bash
# Остановить Node Exporter
docker stop node-exporter
Подождите 2 минуты. Откройте Prometheus -> Alerts. Алерт InstanceDown станет красным (Firing).

Верните сервис: docker start node-exporter.

🛠️ Полезные команды
docker compose ps — статус контейнеров.

docker compose logs -f <service> — логи (например, grafana).

docker compose down — остановить стек (данные сохранятся).

docker compose down -v — остановить и удалить все данные.

🇬🇧 English
📖 About the Project
This project demonstrates sysadmin skills in building a resilient infrastructure. It includes server monitoring, data visualization, an alerting system, and automated backups.

🏗️ Architecture
Prometheus: Scrapes metrics from servers and services.

Node Exporter: Agent that collects hardware metrics (CPU, RAM, Disk).

Alertmanager: Receives alerts from Prometheus and routes them to Telegram.

Grafana: Visualizes metrics into beautiful dashboards.

SeaweedFS: S3-compatible storage for backups.

Restic: Incremental encrypted backup tool for S3.

🚀 Quick Start
Ensure Docker Desktop is running.

Run the command in the terminal:

bash
docker compose up -d
Wait 1-2 minutes for all containers to start.

🔗 Access & Services
Service	URL	Login / Password
Grafana	http://localhost:3000	admin / admin
Prometheus	http://localhost:9090	-
Alertmanager	http://localhost:9093	-
SeaweedFS (S3)	http://localhost:8888	-
Node Exporter	http://localhost:9100/metrics	-
🧪 How to Test
1. Check Metrics Collection:

Open Prometheus -> Status -> Targets. All targets (5 items) should be UP.

2. Test Backup (Restic):

bash
# Create test file
echo "Test backup" > restic/backup-data/test.txt
# Run backup
docker compose exec restic /scripts/backup.sh
# Check snapshots
docker compose exec restic restic snapshots
3. Test Alerts (Failure Simulation):

bash
# Stop Node Exporter
docker stop node-exporter
Wait 2 minutes. Open Prometheus -> Alerts. The InstanceDown alert will turn red (Firing).

Bring it back: docker start node-exporter.

🛠️ Useful Commands
docker compose ps — container status.

docker compose logs -f <service> — logs (e.g., grafana).

docker compose down — stop the stack (data is preserved).

docker compose down -v — stop and delete all data.

📊 Налаштування Grafana / Настройка Grafana / Grafana Setup
Зайдіть в Grafana (http://localhost:3000).

Перейдіть у Connections -> Data sources (Prometheus вже додано).

Натисніть + -> Import dashboard.

Введіть ID 1860 (Node Exporter Full).

Натисніть Load та Import. Готово!

🔔 Налаштування Telegram / Настройка Telegram / Telegram Setup
Щоб отримувати алерти в Telegram:

Створіть бота через @BotFather і отримайте токен.

Дізнайтеся свій chat_id (наприклад, через бота @userinfobot).

Відкрийте alertmanager/alertmanager.yml і замініть:

bot_token: 'YOUR_BOT_TOKEN'

chat_id: YOUR_CHAT_ID

Перезапустіть Alertmanager: docker compose restart alertmanager.
