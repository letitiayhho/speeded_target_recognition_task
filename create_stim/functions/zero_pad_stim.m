% NORMALIZE BEFORE ZERO PADDING

cd('/Users/letitiaho/src/speeded_target_recognition_task')
dirs = dir('create_stim/subj*/exemplars/*.wav');
path = {dirs(:).folder};
filename = {dirs(:).name};

% loop over each stim
for i = 1:length(path)
    stim = fullfile(char(path(i)), char(filename(i)));
    fprintf(1, [stim, '\n'])

    % zero pad
    [y, Fs] = audioread(stim);
    y_new = zeros(Fs/2,1);
    y_new(1:length(y)) = y;

    % write
    audiowrite(stim, y_new, Fs)
end