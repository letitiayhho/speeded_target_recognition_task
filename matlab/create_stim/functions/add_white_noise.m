function add_white_noise()
    cd('/Users/letitiaho/src/speeded_target_recognition_task')
    paths = dir('create_stim/*/modified/*.wav');
    for i = 1
        filepath = fullfile(paths(i).folder, paths(i).name);

        % add white gaussian noise
        [y, fs] = audioread(filepath);
        out = awgn(y, 40);

        % write
        audiowrite(filepath, out, fs)
    end
end