%% Load formants
cd ~/src/speeded_vowel_identification/create_stim
all_formants = readtable('all_formants.txt');

%% Plot vowel space of all subjects
% plot_vowel_space(all_formants.f2, all_formants.f1, all_formants.vowel)

%% Plot vowel space of select subjects
female_subjects = ["subj09", "subj15", "subj16", "subj18", "subj19",...
    "subj20", "subj22", "subj23", "subj24"];
female_formants = subset_by_subject(all_formants, female_subjects);
% plot_vowel_space(female_formants.f2, female_formants.f1, female_formants.subject)
%     % CHANGE df.vowel to df.subject to group by subject vs vowel
    
%% Compute distance by average linkage
vowels = ["AE", "AH", "EE", "EH", "IH", "OO", "UH"];

% Distances pairwise over all subjects
distances = zeros(length(female_subjects), length(female_subjects), length(vowels));
for i = 1:length(female_subjects)
    for j = 1:length(female_subjects)
        if j >= i
            continue
        end
        for k = 1:length(vowels)
            subject_1 = female_subjects(i);
            subject_2 = female_subjects(j);
            vowel = vowels(k);
            points_1 = get_points(female_formants, char(subject_1), vowel);
            points_2 = get_points(female_formants, char(subject_2), vowel);
            d = average_linkage(points_1, points_2);
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

function mean_distance = average_linkage(cluster1, cluster2)
    % Pairwise distance between vowels for each subject
    distances = [];
    for i = 1:length(cluster1)
        for j = 1:length(cluster2)
            a = cluster1(i, :);
            b = cluster2(j, :);
            distances = [distances, distance(a, b)];
        end
    end
    mean_distance = mean(distances);
end