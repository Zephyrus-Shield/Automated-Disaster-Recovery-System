import sys #Tool to read arguments from the terminal(Inputs)
import hashlib #tool to calculate fingerprint (The scanner)
import os #tool to check file stats (The Ruler)

print("---QUALITY CONTROL STARTED---")

try:
    filename = sys.argv[1]
except IndexError:
    print("Error: No file provided to scan.")
    sys.exit(1)

print(f"Scanning file: {filename}")

#--- CHECK 1: The scale (File Size) ---
file_size = os.path.getsize(filename)

if file_size == 0:
    print("critical error: file is empty(0 bytes)!")
    sys.exit(1)

print(f"File size: {file_size} bytes. (Passed)")

#--- check 2: The deep scan (calculating the hash) ---
print("calculating digital fingerprint...")

#we create an empty hasher machine
hasher = hashlib.sha256()

#we open the file in 'Read binary' mode beacuse it is a zip file, not text.
with open(filename, 'rb') as f:
    #we don't read the whole file at once (it might be 50GB!)
    #we read it in 4KB chunks.
    while chunk := f.read(4096):
        hasher.update(chunk)

#Finalize the calculation
checksum = hasher.hexdigest()
print(f"integrity verified. SHA256: {checksum}")

print("---QUALITY CONTROL FINISHED---")