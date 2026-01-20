#!/bin/bash

# --- assigning variables

#1. the source: create a dummy folder to test this.
SOURCE_DIR="$HOME/interview_prep/important_data"

#2. the destination: where the zipped files go.
BACKUP_DIR="$HOME/interview_prep/backups"

#3. Time stamp:
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

#4. the final name:
BACKUP_FILE="$BACKUP_DIR/backup_$TIMESTAMP.tar.gz"

# --- VERIFICATION(Testing the inputs) ---
echo "Target: $SOURCE_DIR"
echo "Saving to: $BACKUP_FILE"

# --- LOGIC GATE 1: The autobuilder (ensures destination exists)---
#we don't ask "does it exist?". We just say "MAKE SURE IT EXISTS."
mkdir -p "$BACKUP_DIR"

#WE CHECK IF THE SOURCE IS MISSING. If yes -> STOP.
if [ ! -d "$SOURCE_DIR" ]; then
    echo "CRITICAL ERROR: Source directory $SOURCE_DIR not found!"
    exit 1

fi

mkdir -p ~/interview_prep/important_data
touch ~/interview_prep/important_data/secret_file.txt

#--- The engine (compression) ---

echo "compressing the data..."

#Run the compression tool
# -c = create new archive
# -z = zip (compress it)
# -f = File (Write to a file)
tar -zcvf "$BACKUP_FILE" "$SOURCE_DIR"

# --- quality control checks

if [ $? -eq 0 ]; then
    echo "Back-up successful: $BACKUP_FILE"
else
    echo "Backup FAILED!"
    exit 1
fi

echo "handing over to QC"

python3 verify_backup.py "$BACKUP_FILE"

#--- final system check ---

if [ $? -eq 0 ]; then
    echo "process complete"
else
    echo "process failed"
    exit 1
fi