# Automated-Disaster-Recovery-System
Automated Disaster Recovery System: A Bash and Python–based backup verification system designed to eliminate unreliable manual backups. Bash manages safe, repeatable backup operations, while Python verifies data integrity using SHA256 checksums. Fully automated, idempotent, and verifiable for reliable disaster recovery.
Problem Statement: Manual backups are unreliable. A missed or corrupted backup during a disaster means data loss.

Problem Interpretation: We need a system that is Automated (runs without humans), Idempotent (safe to run multiple times), and Verifiable (checks data integrity).

Solution Planning:

Bash: Acts as the "Manager." It handles file operations (tar/gzip) and directory safety checks.

Python: Acts as the "Auditor." It calculates SHA256 checksums to verify the file is not corrupted.

Integration: Bash triggers Python and waits for an Exit Code (0 or 1) to determine final success.

Usage:
Run the bash script to start the process via; ./backup_script
If permission issue occurs, resolve via; chmod a+x backup_script
