#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <input_file> <archive_file>"
    exit 1
fi

INPUT_FILE="$1"
ARCHIVE_FILE="$2"
RECENT_LOGS="recent.log"

# Size to keep (30 MB)
SIZE_TO_KEEP=$((30 * 1024 * 1024))

FILE_SIZE=$(stat -c%s "$INPUT_FILE")

if (( FILE_SIZE > SIZE_TO_KEEP )); then
    BYTES_TO_ARCHIVE=$((FILE_SIZE - SIZE_TO_KEEP))

    # Move old logs to archive file
    head -c $((FILE_SIZE - SIZE_TO_KEEP)) "$INPUT_FILE" > "$ARCHIVE_FILE"

    # Move recent logs to recent file
    tail -c "$SIZE_TO_KEEP" "$INPUT_FILE" > "$RECENT_LOGS"

    # Swap input file with recent file
    mv "$RECENT_LOGS" "$INPUT_FILE"
else
    echo "File smaller than $SIZE_TO_KEEP MB, nothing to do."
fi
