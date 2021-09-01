% Load data
cd ~/src/speeded_target_identification/stim/vowels/
raw = tdfread('S_20/subj20-1.txt');

% Create a data frame with f1 and f2
vowel = cellstr(raw.Type);
f1 = raw.f1;
f2 = raw.f2;
df = table(vowel, f1, f2);
vowels = unique(vowel);
clear raw vowel f1 f2

% Identify the mean f1 and f2 for each vowel, the prototype
prototype = grpstats(df, 'vowel');
% mean_f1 = zeros(length(vowels), 1);
% mean_f2 = zeros(length(vowels), 1);
% for i = 1:length(vowels)
%    vowel = vowels(i);
%    vowel_f1 = df.f1(strcmp(df.vowel, vowel),:);
%    vowel_f2 = df.f2(strcmp(df.vowel, vowel),:);
%     mean_f1(i) = mean(vowel_f1);
%     mean_f2(i) = mean(vowel_f2);
% end
% mean_formants = table(vowels, mean_f1, mean_f2);

% Find distance between each utterance and the prototype


% Rank the utterances by distance

