#!/usr/bin/env python3
"""
takes prototypicality_rankings.txt for
each subject and moves exemplars to 
subj#/exemplars/<filename>_rank.wav
"""

from pathlib import Path
import os
import sys
import shutil

def add_rank_to_vowel_filename():
    root = Path.cwd()
    for subject_dir in root.iterdir():
        if not subject_dir.is_dir():
            continue
        if not subject_dir.name.startswith("subj"):
            continue
        with open(subject_dir / "prototypicality_rankings.txt") as f:
            f.readline()  # strip header
            df = [
                line.strip().split(",")
                for line in f.read().strip().split("\n")
            ]

        for row in df:
            vowel, _, _, filename, _, rank = row
            rank = int(rank)
            output_filename = f"{Path(filename).stem}_{rank}.wav"
            try:
                shutil.move(
                        subject_dir / "modified" / filename,
                        subject_dir / "modified" / output_filename,
                        )
                print(f"Renaming {subject_dir.parent.name}/modified/{filename} to {output_filename}")
            except:
                print(f"File {subject_dir}/modified/{filename} does not exist, it was removed for being too short")

if __name__ == "__main__":
    if len(sys.argv) != 1:
        print(__doc__)
        sys.exit(1)
    add_rank_to_vowel_filename()
