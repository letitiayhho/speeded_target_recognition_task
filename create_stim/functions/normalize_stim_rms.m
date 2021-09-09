% NORMALIZE BEFORE ZERO PADDING

dirs = dir('create_stim/subj*/exemplars/*.wav');
path = {dirs(:).folder};
filename = {dirs(:).name};

% loop over each stim
for i = 1:length(path)
    stim = fullfile(char(path(i)), char(filename(i)));
    fprintf(1, [stim, '\n'])

    % zero pad
    [y, Fs] = audioread(stim);
    y_new = y*1/(rms(y));
    
    % write
    audiowrite(stim, y_new, Fs)
end