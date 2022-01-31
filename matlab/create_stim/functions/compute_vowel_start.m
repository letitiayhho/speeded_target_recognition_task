% function [start_sample] = compute_vowel_start(threshold)
%     thresholds = 0.00001:0.00001:0.00005;
thresholds = 0.015;

    cd('/Users/letitiaho/src/speeded_target_recognition_task')
    paths = dir('stim/*/*.wav');
    subject = [];
    vowel = [];
    start_sample = [];
    for i = 1:length(paths)
        filepath = fullfile(paths(i).folder, paths(i).name);
        
        % Extract file information
        path_parts = split(paths(i).folder, '/');
        subject = [subject; char(path_parts(end))];
        [~,this_vowel,~]  = fileparts(filepath);
        vowel = [vowel; this_vowel(1:2)];
        
        for j = 1:length(thresholds)
            % Read file and compute frequency spectra
            [y, ~] = audioread(filepath);
            threshold = thresholds(j);
            start_sample(i, j) = find(y > threshold, 1);
        end
    end
figure(1)
histogram(start_sample)
sd = std(start_sample);
sd_secs = sd*(1/441)*10

% end
%% Formatting
start_sample = array2table(start_sample);
% colnames = cellstr(string(thresholds));
colnames = "start_sample";
start_sample.Properties.VariableNames = colnames;
df = addvars(start_sample, subject, vowel, 'Before', 1);

subplot(4, 1, 1)
hist(df.start_sample(strcmp(df.vowel, "AA")));
xlim([0, 400])
subplot(4, 1, 2)
hist(df.start_sample(strcmp(df.vowel, "EH")));
xlim([0, 400])
subplot(4, 1, 3)
hist(df.start_sample(strcmp(df.vowel, "IH")));
xlim([0, 400])
subplot(4, 1, 4)
hist(df.start_sample(strcmp(df.vowel, "OO")));
xlim([0, 400])

subplot(4, 1, 1)
hist(df.start_sample(strcmp(df.subject, "A")));
xlim([0, 400])
subplot(4, 1, 2)
hist(df.start_sample(strcmp(df.subject, "B")));
xlim([0, 400])
subplot(4, 1, 3)
hist(df.start_sample(strcmp(df.subject, "X")));
xlim([0, 400])
subplot(4, 1, 4)
hist(df.start_sample(strcmp(df.subject, "Y")));
xlim([0, 400])

% plot(bcA, countsA, 'r-');
% hold on;
% plot(bcB, countsB, 'g-');
% hold on;
% plot(bcX, countsX, 'c-');
% hold on;
% plot(bcY, countsY, 'b-');
% grid on;