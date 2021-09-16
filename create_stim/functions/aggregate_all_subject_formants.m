%% Get f1 and f2 values of all subjects
cd ~/src/speeded_vowel_identification/create_stim
subjects = dir('subj*');
all_formants = table();

for i = 1:length(subjects)
    subject_dir = subjects(i).name;
    raw = readtable(fullfile(subject_dir, subject_dir + "-1.txt"), 'ReadVariableNames', true);

    subject = cellstr(repmat(subject_dir, size(raw, 1), 1));
    vowel = cellstr(raw.Type);
    f1 = raw.f1;
    f2 = raw.f2;
    all_formants = [all_formants; table(subject, vowel, f1, f2)];
end
writetable(all_formants, 'all_formants.txt')


