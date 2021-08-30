%% Set up
cd('~/src/speeded_target_identification/')
addpath('functions')
PsychJavaTrouble(1);

% Add constants
FS = 44100;
SUBJ_NUM = 0;
BLOCK = 'test';
TRAINING = true;

% Init psychtoolbox
ptb = init_psychtoolbox(FS);

%% Test present_stimulus.m multiple times
[fullpath, word] = get_filepaths(fullfile('stim', BLOCK));
fixation(ptb); % shows fixation cross to start trial
for s = 1:length(fullpath)
    [stim_start, stim_end, pressed, rt, resp] = present_stimulus(fullpath{s}, BLOCK, ptb); % trigger sent here
    correct = check_answer(word{s}, resp);
    write_output(SUBJ_NUM, BLOCK, s, word{s}, stim_start, stim_end, pressed, rt, resp, correct);
    if training
        give_feedback(correct, ptb);
    end
end

%% End
sca; % screen clear all
close all;
clearvars;
PsychPortAudio('Close'); % clear audio handles