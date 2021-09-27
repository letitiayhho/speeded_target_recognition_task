%% Get f1 and f2 values of all subjects
cd ~/src/speeded_vowel_identification/create_stim
subjects = dir('subj*');
all_formants = table();

for i = 1:length(subjects)
    subject_dir = subjects(i).name;
    raw = readtable(fullfile(subject_dir, subject_dir + "-1.txt"), 'ReadVariableNames', true);
    
    % Swamp "subj9" for "subj09"
    if strcmp(subject_dir, "subj9")
        subject_dir = "subj09";
    end
    
    subject = cellstr(repmat(subject_dir, size(raw, 1), 1));
    vowel = cellstr(raw.Type);
    f0 = raw.f0;
    f1 = raw.f1;
    f2 = raw.f2;
    f3 = raw.f3;
    all_formants = [all_formants; table(subject, vowel, f0, f1, f2, f3)];
    
    % Remove nans
    all_formants = all_formants(~any(ismissing(all_formants),2),:);
    
    % Sort by subject
    all_formants = sortrows(all_formants);
end
writetable(all_formants, 'all_formants.txt')


