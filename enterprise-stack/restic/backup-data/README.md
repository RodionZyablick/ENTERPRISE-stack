# Backup Data Directory

Разместите здесь файлы/директории, которые нужно резервировать.

Restic будет бэкапить всё содержимое этой директории в MinIO S3 bucket `backups`.

Расписание: запуск `backup.sh` вручную через:
docker exec -it restic /scripts/backup.sh