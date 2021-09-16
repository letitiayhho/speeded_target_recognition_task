%% Get f1 and f2 values of all subjects
cd ~/src/speeded_vowel_identification/create_stim
subjects = dir('subj*');
all_formants = table();
for i = 1:length(subjects)
    subject_dir = subjects(i).name;
    raw = readtable(fullfile(subject_dir, subject_dir + "-1.txt"), 'ReadVariableNames', true);

    subject = cellstr(repmat(subject_dir, 70, 1));
    vowel = cellstr(raw.Type);
    f1 = raw.f1;
    f2 = raw.f2;
    all_formants = [all_formants; table(subject, vowel, f1, f2)];
end
clear subject_dir raw subject vowel f1 f2

%% Plot vowel space of all subjects
gscatter(all_formants.f2, all_formants.f1, all_formants.vowel)
ylim([0, 1400])
xlim([0, 3500])
set(gcf,'Position',[100 100 1000 800])

%% Plot vowel space of select subjects
formants_subset = subset_by_subject(all_formants, {'subj9', 'subj15', 'subj16',...
    'subj18', 'subj19', 'subj20', 'subj22', 'subj23', 'subj24'});
gscatter(formants_subset.f2, formants_subset.f1, formants_subset.vowel)
    % CHANGE df.vowel to df.subject to group by subject vs vowel
ylim([0, 1400])
xlim([0, 3500])
set(gcf,'Position',[100 100 1000 800])

function [df] = subset_by_subject(df, subjects)
    selection = zeros(size(df, 1), 1);
    for i = 1:length(subjects)
        selection = selection + strcmp(df.subject, subjects(i));
    end
    selection = logical(selection);
    df = df(selection, :);
end

