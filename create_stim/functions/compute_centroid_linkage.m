%% Load formants
cd ~/src/speeded_target_recognition_task/create_stim
data = readtable('all_formants.txt');
    
%% Compute distance by average linkage
female_subjects = ["subj09", "subj15", "subj16", "subj18", "subj19",...
    "subj20", "subj22", "subj23", "subj24"];
data = subset_by_subject(data, female_subjects);
vowels = ["AE", "AH", "EE", "EH", "IH", "OO", "UH"];

% Distances pairwise over all subjects
distances = zeros(length(female_subjects), length(female_subjects), length(vowels));
for i = 1:length(female_subjects)
    for j = 1:length(female_subjects)
        if j > i
            continue
        end
        for k = 1:length(vowels)
            subject_1 = female_subjects(i);
            subject_2 = female_subjects(j);
            vowel = vowels(k);
            points_1 = get_points(data, char(subject_1), vowel);
            points_2 = get_points(data, char(subject_2), vowel);
            d = centroid_linkage(points_1, points_2);
            distances(i, j, k) = d;
        end
    end
end

% Average distance across vowels
distances = mean(distances, 3);

% Remove subject 20 and 19, set 0s to NaN
distances(distances == 0) = NaN;
distances(5, :) = NaN;
distances(6, :) = NaN;
distances(:, 5) = NaN;
distances(:, 6) = NaN;

% Add row and column names
distances = array2table(distances);
distances.Properties.VariableNames = female_subjects;
distances.Properties.RowNames = female_subjects;

function points = get_points(df, subject, vowel)
    df = df(strcmp(df.vowel, vowel), :);
    df = df(strcmp(df.subject, subject), :);
    points = [df.f1, df.f2];
end

function mean_distance = centroid_linkage(cluster1, cluster2)
    a = mean(cluster1, 1);
    b = mean(cluster2, 1);
    mean_distance = distance(a, b);
end