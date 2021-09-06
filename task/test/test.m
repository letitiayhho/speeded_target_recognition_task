%% Set up
cd('~/src/speeded_vowel_identification/')
addpath('task/functions')
PsychJavaTrouble(1);

% Add constants
FS = 44100;
SUBJ_NUM = 0;
BLOCK = 'test';
TRAINING = true; % change training depending on block number

%% Load stim_order
stim = readtable('generate_stim_order/output/stim_order.txt');
stim_path = get_filepaths(stim);
target = get_target(stim);

%% Init psychtoolbox
ptb = init_psychtoolbox(FS);

%% Test
fixation(ptb); % show fixation cross to start trial
present_target(ptb, target) % show target
for s = 1:length(stim_path)
    [stim_start, stim_end, pressed, rt, resp] = present_stimulus(stim_path(s), ptb); % trigger sent here
    correct = check_answer(stim.istarget(s), resp);
    write_output(SUBJ_NUM, BLOCK, s, stim.vowel(s), stim_start, stim_end, pressed, rt, resp, correct);
    if TRAINING
        give_feedback(correct, ptb);
    end
end

%% End
sca; % screen clear all
close all;
clearvars;
PsychPortAudio('Close'); % clear audio handles