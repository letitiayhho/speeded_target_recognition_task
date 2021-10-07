#!/usr/bin/env python3

from pathlib import Path
import sys
import shutil

def move_exemplars():
    with open('functions/exemplars.txt', 'r') as f:
        f.readline() # strip header
        for line in f:
            line = line.strip().split(",")
            subject_dir, original_fn, exemplar_fn = line
            original_fp = Path(subject_dir, "modified", original_fn)
            exemplar_fp = Path(subject_dir, "exemplars", exemplar_fn)
            print("source: ", str(original_fp))
            print("destination: ", str(exemplar_fp))
            try:
                shutil.copy2(
                        original_fp,
                        exemplar_fp
                        )
            except:
                print("File does not exist")

if __name__ == "__main__":
    if len(sys.argv) != 1:
        print(__doc__)
        sys.exit(1)
    move_exemplars()
