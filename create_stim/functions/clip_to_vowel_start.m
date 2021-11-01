function clip_to_vowel_start()
    threshold = 0.00001
    cd('/Users/letitiaho/src/speeded_target_recognition_task')
    paths = dir('create_stim/*/modified/*.wav');
    for i = 1:length(paths)
        filepath = fullfile(paths(i).folder, paths(i).name);
        
        % Clip to first sample at threshold
        [y, Fs] = audioread(filepath);
        start_sample = find(y > threshold, 1);
        y(1:start_sample) = [];

        % write
        audiowrite(filepath, y, Fs)
    end
end

