%% Set up
cd('~/src/speeded_target_identification/')
addpath('functions')
addpath('stim/test_words')

% Constants
Fs = 44100;
BLOCK = 0;
ptb = init_psychtoolbox(Fs);
[fullpath, filename] = get_filepaths('stim/test_words');
training = true;

for s = 1:length(stim)
    [stim_start, stim_end, pressed, rt, resp] = present_stimulus(fullpath{1}, BLOCK, ptb); % trigger sent here
    if training
        give_feedback(filename{1}, resp, ptb);
    end
end

sca;