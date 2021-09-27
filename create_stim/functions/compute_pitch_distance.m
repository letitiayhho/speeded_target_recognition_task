%% Load formants
cd ~/src/speeded_vowel_identification/create_stim
all_formants = readtable('all_formants.txt');

%% Plot pitches of all subjects
plot_pitches(all_formants.f0, all_formants.subject)

%% Plot pitches of female subjects
female_subjects = ["subj09", "subj15", "subj16", "subj18", "subj19",...
    "subj20", "subj22", "subj23", "subj24"];
female_formants = subset_by_subject(all_formants, female_subjects);
plot_pitches(female_formants.f0, female_formants.subject)
    
%% Compute distance by average linkage
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
            points_1 = get_points(female_formants, char(subject_1), vowel);
            points_2 = get_points(female_formants, char(subject_2), vowel);
            d = average_linkage(points_1, points_2);
            distances(i, j, k) = d;
        end
    end
end

% Average distance across vowels
distances = mean(distances, 3);

function points = get_points(df, subject, vowel)
    df = df(strcmp(df.vowel, vowel), :);
    df = df(strcmp(df.subject, subject), :);
    points = df.f0;
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