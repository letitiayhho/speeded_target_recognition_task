% function [start_sample] = compute_vowel_start(threshold)

    cd('/Users/letitiaho/src/speeded_target_recognition_task')
    paths = dir('stim/*.wav');
    subject = [];
    vowel = [];
    start_sample = [];
    for i = 2
%     for i = 1:length(paths)
        filepath = fullfile(paths(i).folder, paths(i).name);
        
        % Extract file information
        path_parts = split(paths(i).folder, '/');
        subject = [subject; char(path_parts(end))];
        [~,this_vowel,~]  = fileparts(filepath);
        vowel = [vowel; this_vowel(1:2)];
        
        % Read file and compute frequency spectra
        [y, ~] = audioread(filepath);
        [peaks, locs] = findpeaks(abs(y));
        i = locs(locs > 92)
        
%             start_sample(i, j) = find(y > threshold, 1);
    end
%     start_sample = array2table(start_sample);

% end
    %% Formatting
%     colnames = cellstr(string(thresholds));
%     start_sample.Properties.VariableNames = colnames;
%     df = addvars(start_sample, subject, vowel, 'Before', 1);
get_samples_to_zero(240, 44100)

function samples_to_zero = get_samples_to_zero(f0, fs)
    samples_to_zero = round(fs/f0)/2;
end

