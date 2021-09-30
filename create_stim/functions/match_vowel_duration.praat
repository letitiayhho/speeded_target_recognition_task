form Match vowel duration
	sentence vowel
	positive final_duration 300
endform

# Get vowel duration
filename$ = "/Users/letitiaho/src/speeded_vowel_identification_task/create_stim/subj21/all_vowels/" + vowel$ + ".wav"
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
selectObject: "Sound " + vowel$ + "_copy_1"
Save as WAV file: "/Users/letitiaho/Desktop/EE5lengthened.wav"
