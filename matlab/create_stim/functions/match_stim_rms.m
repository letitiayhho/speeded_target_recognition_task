dirs = dir('subj*/modified/*.wav');
path = {dirs(:).folder};
filename = {dirs(:).name};

% loop over each stim
for i = 1:length(path)
    stim = fullfile(char(path(i)), char(filename(i)));
    fprintf(1, [stim, '\n'])

    % change rms to 0.05
    [y, Fs] = audioread(stim);
    y_new = y*0.05/(rms(y));
    
    % write
    audiowrite(stim, y_new, Fs)
end
