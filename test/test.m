%% Set up
cd('~/src/speeded_target_identification/')
addpath('functions')
addpath('stim/test_words')
PsychJavaTrouble(1);

% Add constants
FS = 44100;
SUBJ_NUM = 0;
BLOCK = 0;
ptb = init_psychtoolbox(FS);
TRAINING = true;

%% Test present_stimulus.m once
% stim = get_filepaths('stim/test_words');
% fixation(ptb);
% present_stimulus(stim{1}, BLOCK, ptb); % trigger sent here
% response = ask_for_response(ptb);
% fprintf(response)

%% Test present_stimulus.m multiple times
stim = get_filepaths('stim/test_words');
fixation(ptb); % shows fixation cross to start trial
for s = 1:length(stim)
    [stim_start, stim_end, pressed, rt, resp] = present_stimulus(stim{s}, BLOCK, ptb); % trigger sent here
    write_output(SUBJ_NUM, BLOCK, s, stim{s}, stim_start, stim_end, pressed, rt, resp);
end

%% End
sca; % screen clear all
close all;
clearvars;
PsychPortAudio('Close'); % clear audio handles