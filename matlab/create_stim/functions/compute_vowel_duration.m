function [secs, file_order] = compute_vowel_duration()
    paths = dir(fullfile('..', 'stim', '*', '*.wav'));
    secs = zeros(length(paths), 1);
    file_order = [];
    for i = 1:length(paths)
        filepath = fullfile(paths(i).folder, paths(i).name);
        info = audioinfo(filepath);
        secs(i) = info.Duration;
        file_order = [file_order; cellstr(filepath)];
    end
end