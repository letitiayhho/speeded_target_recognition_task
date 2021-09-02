from pathlib import Path
import os
import sys
import shutil

def move_exemplars(subject_number):
    subject_dir = Path("S_" + subject_number)
    with open(subject_dir / "prototypicality_rankings.txt") as f:
        f.readline()  # strip header
        df = [
            line.strip().split(",")
            for line in f.read().strip().split("\n")
        ]

    for row in df:
        vowel, _, _, _, rank, filename = row
        if rank != "1":
            continue
        shutil.copy2(
            subject_dir / filename,
            subject_dir / "exemplars" / f"{vowel}.wav",
        )

if __name__ == "__main__":
    subject_number = sys.argv[1]
    move_exemplars(subject_number)
