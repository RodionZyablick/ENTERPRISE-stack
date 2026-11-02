🚀 Enterprise Infrastructure & Monitoring Stack🇬🇧 English DocumentationAbout The ProjectThis repository contains a production-ready Enterprise Infrastructure Monitoring, Alerting, and Automated Backup Stack.Key FeaturesResource Monitoring: High-frequency system metric collection (CPU, RAM, Disks, Network) via Node Exporter and Prometheus.Data Visualization: Rich dashboards in Grafana with the grafana-piechart-panel plugin pre-installed.Smart Alerting: Alert management via Alertmanager integrated with Telegram Bot endpoints and inhibition rules to prevent alert spam.S3 Object Storage: High-performance, S3-compatible local object storage powered by SeaweedFS.Automated Deduplicated Backups: Encrypted, versioned backups managed by Restic with scheduled retention policies.🛠️ System Architecture                       +-------------------+
                       |   Node Exporter   | (Port 9100)
                       +---------+---------+
                                 | (scrape)
                                 v
+-------------------+  (scrape) +-------------------+   (alerts)   +-------------------+
|      Grafana      |<----------|    Prometheus     |------------->|   Alertmanager    |
|   (Port 3000)     |           |    (Port 9090)    |              |    (Port 9093)    |
+-------------------+           +-------------------+              +---------+---------+
                                                                             |
                                                                             v
                                                                   [ Telegram Bot API ]

+-------------------+  (S3 API)  +-------------------+
|      Restic       |----------->|     SeaweedFS     |
|   (Backup Engine) |            |   (Port 8333/S3)  |
+-------------------+            +-------------------+
🔗 Service Endpoints & CredentialsServicePurposeURL / EndpointDefault CredentialsGrafanaDashboards & Analyticshttp://localhost:3000admin / adminPrometheusMetrics Database & PromQLhttp://localhost:9090(No Authentication)AlertmanagerAlert Dispatcher & Notificationshttp://localhost:9093(No Authentication)Node ExporterHost System Metricshttp://localhost:9100/metrics(Service)SeaweedFS S3S3 API Endpointhttp://localhost:8333minioadmin / minioadmin123SeaweedFS MasterSeaweedFS Admin UIhttp://localhost:9333(Admin Panel)⚡ Command Reference1. Stack Management (Docker Compose)Start all services in detached mode:docker compose up -d
Check status of all containers:docker compose ps
View real-time logs for all services:docker compose logs -f
View logs for a specific service (e.g., Prometheus):docker compose logs -f prometheus
Stop all services:docker compose down
Stop services and remove all volumes (Reset Data):docker compose down -v
2. Backup & Restore (Restic & SeaweedFS)Run a manual backup:docker compose exec restic /scripts/backup.sh
List all snapshots:docker compose exec restic restic snapshots
Check backup integrity in S3:docker compose exec restic restic check
Run interactive restore:docker compose exec -it restic /scripts/restore.sh
Manually initialize the Restic repository (if needed):docker compose exec restic restic init
3. Testing & DebuggingHigh CPU Load Alert TestSimulate CPU load to trigger the HighCpuLoad rule (>80% CPU load for 5 minutes):PowerShell (Windows):1..4 | ForEach-Object { Start-Job -ScriptBlock { while ($true) {} } }
Stop PowerShell load test:Get-Job | Stop-Job; Get-Job | Remove-Job
Linux / Bash:stress --cpu 4 --timeout 300s
Alertmanager TestSend a manual test alert to verify Telegram integration:curl -H "Content-Type: application/json" -d '[
  {
    "labels": {
      "alertname": "TestManualAlert",
      "severity": "critical",
      "instance": "manual-test"
    },
    "annotations": {
      "summary": "Manual Test Alert",
      "description": "Verifying Telegram Bot notification pipe"
    }
  }
]' http://localhost:9093/api/v1/alerts
🇺🇦 Документація УкраїнськоюПро проєктЦей репозиторій містить готовий виробничий стек (Enterprise Stack) для моніторингу інфраструктури, сповіщення про збої та автоматизованого резервного копіювання (Backup).Ключові можливостіМоніторинг ресурсів: Сбор метрик CPU, RAM, дискового простору та мережі за допомогою Node Exporter та Prometheus.Візуалізація: Інтерактивні дашборди Grafana з попередньо встановленим плагіном grafana-piechart-panel.Алертинг: Оповіщення через Alertmanager з інтеграцією в Telegram-бот та системою пригнічення повторних сповіщень (Inhibition Rules).Сховище бэкапів: Локальне S3-сумісне сховище SeaweedFS (сучасна альтернатива MinIO).Інкрементальні бэкапи: Шифровані резервні копії через Restic з автоматичною ротацією (Retention policy).🛠️ Архітектура системи                       +-------------------+
                       |   Node Exporter   | (Порт 9100)
                       +---------+---------+
                                 | (scrape)
                                 v
+-------------------+  (scrape) +-------------------+   (alerts)   +-------------------+
|      Grafana      |<----------|    Prometheus     |------------->|   Alertmanager    |
|   (Порт 3000)     |           |    (Порт 9090)    |              |    (Порт 9093)    |
+-------------------+           +-------------------+              +---------+---------+
                                                                             |
                                                                             v
                                                                   [ Telegram Bot API ]

+-------------------+  (S3 API)  +-------------------+
|      Restic       |----------->|     SeaweedFS     |
|   (Backup Engine) |            |  (Порт 8333/S3)   |
+-------------------+            +-------------------+
🔗 Порти та веб-інтерфейсиСервісПризначенняURL / EndpointОблікові дані за замовчуваннямGrafanaПанелі візуалізації та графікиhttp://localhost:3000admin / adminPrometheusБаза даних метрик та PromQLhttp://localhost:9090(Без автентифікації)AlertmanagerДиспетчер алертів та сповіщеньhttp://localhost:9093(Без автентифікації)Node ExporterМетрики хост-системиhttp://localhost:9100/metrics(Службовий)SeaweedFS S3S3 API endpointhttp://localhost:8333minioadmin / minioadmin123SeaweedFS MasterПанель управління SeaweedFShttp://localhost:9333(Адмін-панель)⚡ Перелік команд1. Управління стеком (Docker Compose)Запуск усіх сервісів у фоновому режимі:docker compose up -d
Перевірка статусу контейнерів:docker compose ps
Перегляд логів у реальному часі:docker compose logs -f
Перегляд логів конкретного сервісу (наприклад, Prometheus):docker compose logs -f prometheus
Повна зупинка стеку:docker compose down
Зупинка з видаленням Volumes (Очищення даних):docker compose down -v
2. Робота з бэкапами (Restic & SeaweedFS)Ручний запуск бэкапу:docker compose exec restic /scripts/backup.sh
Перегляд усіх збережених знімків (Snapshots):docker compose exec restic restic snapshots
Перевірка цілісності бэкапів у S3:docker compose exec restic restic check
Інтерактивне відновлення з бэкапу:docker compose exec -it restic /scripts/restore.sh
Ручна ініціалізація репозиторію Restic (якщо потрібно):docker compose exec restic restic init
3. Тестування алертингу та навантаженняТест алерту HighCpuLoadДля перевірки спрацьовування правила HighCpuLoad (>80% CPU):PowerShell (Windows):1..4 | ForEach-Object { Start-Job -ScriptBlock { while ($true) {} } }
Зупинка тесту в PowerShell:Get-Job | Stop-Job; Get-Job | Remove-Job
Linux / Bash:stress --cpu 4 --timeout 300s
Тест AlertmanagerНадсилання тестового алерту для перевірки Telegram-бота:curl -H "Content-Type: application/json" -d '[
  {
    "labels": {
      "alertname": "TestManualAlert",
      "severity": "critical",
      "instance": "manual-test"
    },
    "annotations": {
      "summary": "Тестове сповіщення",
      "description": "Перевірка інтеграції з Telegram-ботом"
    }
  }
]' http://localhost:9093/api/v1/alerts
🇷🇺 Документация на РусскомО проектеЭтот репозиторий содержит готовый корпоративный стек (Enterprise Stack) для мониторинга инфраструктуры, алерттинга и автоматизированного резервного копирования.Ключевые возможностиСбор метрик: Мониторинг CPU, RAM, дисков и сети с помощью Node Exporter и Prometheus.Визуализация: Дашборды Grafana с установленным плагином grafana-piechart-panel.Оповещения: Настройка Alertmanager с интеграцией в Telegram-бот и правилами подавления дублирующих алертов.S3 Хранилище: Высокопроизводительное S3-совместимое хранилище SeaweedFS (замена MinIO).Инкрементальный бэкап: Безопасное шифрование и ротация бэкапов через Restic с хранением в S3.🛠️ Архитектура системы                       +-------------------+
                       |   Node Exporter   | (Порт 9100)
                       +---------+---------+
                                 | (scrape)
                                 v
+-------------------+  (scrape) +-------------------+   (alerts)   +-------------------+
|      Grafana      |<----------|    Prometheus     |------------->|   Alertmanager    |
|   (Порт 3000)     |           |    (Порт 9090)    |              |    (Порт 9093)    |
+-------------------+           +-------------------+              +---------+---------+
                                                                             |
                                                                             v
                                                                   [ Telegram Bot API ]

+-------------------+  (S3 API)  +-------------------+
|      Restic       |----------->|     SeaweedFS     |
|   (Backup Engine) |            |  (Порт 8333/S3)   |
+-------------------+            +-------------------+
🔗 Порты и веб-интерфейсыСервисНазначениеURL / EndpointУчетные данные по умолчаниюGrafanaПанели визуализации и графикиhttp://localhost:3000admin / adminPrometheusБаза данных метрик и PromQLhttp://localhost:9090(Без аутентификации)AlertmanagerДиспетчер алертов и уведомленийhttp://localhost:9093(Без аутентификации)Node ExporterМетрики хост-системыhttp://localhost:9100/metrics(Служебный)SeaweedFS S3S3 API endpointhttp://localhost:8333minioadmin / minioadmin123SeaweedFS MasterПанель управления SeaweedFShttp://localhost:9333(Админ-панель)⚡ Перечень команд1. Управление стеком (Docker Compose)Запуск всех сервисов в фоновом режиме:docker compose up -d
Просмотр статуса всех контейнеров:docker compose ps
Просмотр логов в реальном времени:docker compose logs -f
Просмотр логов конкретного сервиса (например, Prometheus):docker compose logs -f prometheus
Полная остановка стека:docker compose down
Остановка с удалением всех Volumes (Сброс данных):docker compose down -v
2. Работа с бэкапами (Restic & SeaweedFS)Запуск бэкапа вручную:docker compose exec restic /scripts/backup.sh
Просмотр всех созданных снимков (Snapshots):docker compose exec restic restic snapshots
Проверка целостности бэкапов в S3:docker compose exec restic restic check
Интерактивное восстановление из бэкапа:docker compose exec -it restic /scripts/restore.sh
Ручная инициализация репозитория Restic (если требуется):docker compose exec restic restic init
3. Тестирование и отладкаТест нагрузки CPU (Проверка HighCpuLoad)Для проверки срабатывания правила HighCpuLoad (>80% CPU):PowerShell (Windows):1..4 | ForEach-Object { Start-Job -ScriptBlock { while ($true) {} } }
Остановка теста в PowerShell:Get-Job | Stop-Job; Get-Job | Remove-Job
Linux / Bash:stress --cpu 4 --timeout 300s
Тест отправки уведомления в AlertmanagerОтправка тестового алерта напрямую в Alertmanager для проверки бота Telegram:curl -H "Content-Type: application/json" -d '[
  {
    "labels": {
      "alertname": "TestManualAlert",
      "severity": "critical",
      "instance": "manual-test"
    },
    "annotations": {
      "summary": "Тестовое сообщение",
      "description": "Проверка работы интеграции с Telegram"
    }
  }
]' http://localhost:9093/api/v1/alerts
