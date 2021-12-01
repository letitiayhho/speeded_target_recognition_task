#!/usr/bin/env python3

"""
Usage:
    aggregate_raw_data <pilot/experiment>
"""

import os
import sys
import glob
import pandas as pd
from pathlib import Path

def main(mode) -> None:

    read_path = 'raw_data/' + mode + '/*.csv'
    all_filenames = [i for i in glob.glob(read_path)]
    print(all_filenames)

    combined_csv = pd.concat([pd.read_csv(f) for f in all_filenames])

    write_path = 'intermediate_data/' + mode + '.csv'
    combined_csv.to_csv(write_path, index=False, encoding='utf-8-sig')

if __name__ == "__main__":
    os.chdir("/Users/letitiaho/src/speeded_target_recognition_data_processing")
    if len(sys.argv) != 2:
        print(__doc__)
        sys.exit(1)
    mode = str(sys.argv[1])
    main(mode)
