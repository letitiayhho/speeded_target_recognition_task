from pathlib import Path
import os
import sys
import shutil

def move_exemplars(subject_dir):
    subject_dir = Path(subject_dir)
    with open(subject_dir / "prototypicality_rankings.txt") as f:
        f.readline()  # strip header
        df = [
            line.strip().split(",")
            for line in f.read().strip().split("\n")
        ]

    for row in df:
        vowel, _, _, filename, _, rank = row
        rank = int(rank)
        if rank > 3:
            continue
        if rank <= 3:
            shutil.copy2(
                    subject_dir / "all_vowels" / filename,
                    subject_dir / "exemplars" / f"{vowel}{rank}.wav",
                    )

if __name__ == "__main__":
    subject_number = sys.argv[1]
    move_exemplars(subject_number)
