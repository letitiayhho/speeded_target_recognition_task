cd('/Users/letitiaho/src/speeded_vowel_identification_task')
dirs = dir('create_stim/subj*/exemplars/*.wav');
path = {dirs(:).folder};
filename = {dirs(:).name};

% loop over each stim
for i = 1:length(path)
    stim = fullfile(char(path(i)), char(filename(i)));
    fprintf(1, [stim, '\n'])

    % change rms to 0.25
    [y, Fs] = audioread(stim);
    y_new = y*0.25/(rms(y));
    
    % write
    audiowrite(stim, y_new, Fs)
end
