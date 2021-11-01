% function [start_sample] = compute_vowel_start(threshold)
    thresholds = 0.00001:0.00001:0.00005;

    cd('/Users/letitiaho/src/speeded_target_recognition_task')
    paths = dir('stim_copy/*/*.wav');
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
    start_sample = array2table(start_sample);

% end
    %% Formatting
    colnames = cellstr(string(thresholds));
    start_sample.Properties.VariableNames = colnames;
    df = addvars(start_sample, subject, vowel, 'Before', 1);
