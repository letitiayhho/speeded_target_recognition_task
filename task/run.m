%%%%%%%%%%%%%%%%%%%%%%%%% UPDATE THIS SECTION BEFORE EACH SUBJECT/TEST

SUBJ_NUM = 0; % numeric
BLOCK = 2; % numeric
RTBOX = false; % logical

%%%%%%%%%%%%%%%%%%%%%%%
      
PsychDebugWindowConfiguration

%% Set up
cd('~/src/speeded_vowel_identification_task')
addpath('generate_stim_order')
addpath('task/functions')
addpath('task/USTCRTBox_003')      
PsychJavaTrouble(1);

% other constants      
FS = 44100;
IS_TRAINING = BLOCK == 1 || BLOCK == 2; % change training depending on block number

% set up psychtoolbox and RTBox
% init_RTBox(RTBOX);
% PTB = init_psychtoolbox(FS);

% Load stim order
[STIM, N_TRIALS, TRIAL_TYPE, TARGET_KEY] = generate_stim_order(SUBJ_NUM, BLOCK);

%% Display instructions
% instructions(PTB, BLOCK);

%% Task
for trial = 1:N_TRIALS
    [vowel, path, trial_type, target, istarget] = get_trial_stim(STIM, BLOCK, trial);
% 
%     % loop through all stim in trial
%     WaitSecs(2)
%     fixation(PTB); % show fixation cross to start trial
%     present_target(PTB, target) % show target
% 
%     for v = 1:length(path)
%         [rt, resp] = present_stimulus(path(v), PTB); % trigger sent here
%         correct = check_answer(istarget(v), resp);
%         write_output(SUBJ_NUM, BLOCK, trial, TRIAL_TYPE(v), v, vowel(v, :), target, rt, resp, correct);
%         if IS_TRAINING
%             give_feedback(correct, PTB);
%         end
%     end
end

%% end block
% instructions(PTB, 0) 

sca; % screen clear all
close all;
clearvars;
PsychPortAudio('Close'); % clear audio handles
