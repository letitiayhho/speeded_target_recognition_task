from pathlib import Path
import shutil

def move_exemplars():
    with open('functions/exemplars.txt', 'r') as f:
        f.readline() # strip header
        for line in f:
            line = line.strip().split(",")
            original_fp, exemplar_fp = line
            print("source: ", str(original_fp))
            print("destination: ", str(exemplar_fp))
            try:
                shutil.copy2(
                        original_fp,
                        exemplar_fp
                        )
            except:
                print("File does not exist")
