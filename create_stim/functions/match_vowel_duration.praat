form Match vowel duration
	word subject_dir
	word vowel
endform

nocheck Remove

final_duration = 300

# Get vowel duration
filename$ = "/Users/letitiaho/src/speeded_vowel_identification_task/create_stim/" + subject_dir$ + "/modified/" + vowel$ + ".wav"
Read from file: filename$
selectObject: "Sound " + vowel$
Copy: vowel$ + "_copy"
selectObject: "Sound " + vowel$ + "_copy"
vowel_start = Get start time
vowel_end = Get end time

# Modify duration
vowel_duration_ms = (vowel_end - vowel_start) * 1000
duration_change = final_duration - vowel_duration_ms
durfactor = final_duration/vowel_duration_ms
selectObject: "Sound " + vowel$ + "_copy"
Lengthen (overlap-add): 60, 300, 'durfactor'

# Save file
Save as WAV file: filename$
