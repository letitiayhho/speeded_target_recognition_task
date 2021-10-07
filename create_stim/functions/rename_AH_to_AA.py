from pathlib import Path
import shutil

def rename_AH_to_AA():
    root = Path.cwd()
    for subject_dir in root.iterdir():
        if not subject_dir.is_dir():
            continue
        if not subject_dir.name.startswith("subj"):
            continue

        exemplar_dir = subject_dir / "exemplars"
        for exemplar in exemplar_dir.iterdir():
            if exemplar.suffix != ".wav":
                continue
            if "AH" in exemplar.name:
                new_name = exemplar.name.replace("H", "A")
                print(f"Replacing {exemplar.name} with {new_name}")
                shutil.move(
                        subject_dir / "exemplars" / exemplar.name,
                        subject_dir / "exemplars" / new_name
                        )

