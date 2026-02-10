LOG_FILE="/var/log/myapp.log"
MAX_SIZE=10485760  # 10 MB

FILE_SIZE=$(stat -c%s "$LOG_FILE")
if [ "$FILE_SIZE" -ge "$MAX_SIZE" ]; then
    echo "Log file is too large. Rotating..."
    mv "$LOG_FILE" "$LOG_FILE.old"
    touch "$LOG_FILE"
else
    echo "Log file size is acceptable."
fi
