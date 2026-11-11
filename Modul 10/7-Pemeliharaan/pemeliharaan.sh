#!/bin/bash

# NOTE: Kami sengaja pakai format .sh sebab dapat lebih mudah dibaca serta dapat langsung dijalankan di terminal MacOS, Linux dan Windows (Windows via git bash atau WSL).

# OPERASI BACKUP

mysqldump --skip-lock-tables --routines --add-drop-table --disable-keys --extended-insert --single-transaction -u root --host=localhost --port=3306 praktikum_modul10 > praktikum_modul10_backup.sql
# Output pada CLI / DBeaver:

# Dump database int file:///E:/Tugas/Basis-data/DB-KELOMPOK8/Modul%2010/backup_modul10.sql
# Task “MYSQL dump’ started at Tue Nov 11 08:54:43 WIB 2026
# Task “MYSQL dump’ finished at Tue Nov 11 08:55:12 WIB 2026


# OPERASI RESTORE

# 1. Buat database kosong (jika belum ada)
mysql -u root -e "CREATE DATABASE IF NOT EXISTS praktikum_modul10;"

# 2. Restore data dari file SQL ke database
mysql -u --host=localhost --port=3306 root praktikum_modul10 < praktikum_modul10_backup.sql

