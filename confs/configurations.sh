#!/bin/bash

# Diretório de logs do Apache
LOG_DIR="/var/log/httpd/"

# Diretório compartilhado onde os logs serão salvos
DEST_DIR="/mnt/diocleciano/logs/"

# Nome do arquivo de log (pode variar dependendo da configuração)
LOG_FILE="access_log"

# Comando para copiar os logs
cp "$LOG_DIR$LOG_FILE" "$DEST_DIR$LOG_FILE_$(date +\%Y\%m\%d_\%H\%M\%S)"


