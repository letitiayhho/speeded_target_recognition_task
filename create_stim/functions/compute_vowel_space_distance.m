%% Load formants
cd ~/src/speeded_vowel_identification/create_stim
all_formants = readtable('all_formants.txt');

%% Plot vowel space of all subjects
% plot_vowel_space(all_formants.f2, all_formants.f1, all_formants.vowel)

%% Plot vowel space of select subjects
female_subjects = {'subj9', 'subj15', 'subj16', 'subj18', 'subj19',...
    'subj20', 'subj22', 'subj23', 'subj24'};
female_formants = subset_by_subject(all_formants, female_subjects);
% plot_vowel_space(female_formants.f2, female_formants.f1, female_formants.subject)
%     % CHANGE df.vowel to df.subject to group by subject vs vowel
    
%% Compute distance by average linkage


% do it pairwise over all subjects
% subject_1 = {'subj24'};
% subject_9 = get_points(female_formants, 'subj9', 'IH');
% distances = [];
% for subject_1 = female_subjects
%     for subject_2 = female_subjects
%         points_1 = get_points(female_formants, char(subject_1), 'IH');
%         points_2 = get_points(female_formants, char(subject_2), 'IH');
%         d = average_linkage(points_1, points_2);
%         distances = [distances, d];
%     end
% end
% distances = reshape(distances, 9, 9);


% x = [0, sqrt(2)/2; 0, sqrt(2)/2]';
% average_linkage(x, x)
% subj9 = get_points(female_formants, 'subj9', 'IH');
% subj15 = get_points(female_formants, 'subj15', 'IH');
% subj16 = get_points(female_formants, 'subj16', 'IH');
% 
% distances1 = average_linkage(subj9, subj9);
% distances2 = average_linkage(subj9, subj16);
% distances3 = average_linkage(subj15, subj16);

% average linkage of a talkers utterance with itself is a measure of
% variance

% mean_distance = centroid_linkage(subj9, subj9)
% mean_distance = centroid_linkage(subj9, subj15)

function points = get_points(df, subject, vowel)
    df = df(strcmp(df.vowel, vowel), :);
    df = df(strcmp(df.subject, subject), :);
    points = [df.f1, df.f2];
end

function mean_distance = centroid_linkage(cluster1, cluster2)
    a = mean(cluster1, 1);
    b = mean(cluster2, 1);
    mean_distance = distance(a, b)
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