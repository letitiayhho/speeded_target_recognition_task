%%%%%%%%%%%%%%%%%%%%%%%%% UPDATE THIS SECTION BEFORE EACH SUBJECT/TEST

SUBJ_NUM = 0; % numeric
BLOCK = 1; % numeric
test = false; % logical

%%%%%%%%%%%%%%%%%%%%%%%

%% Set up
cd('~/src/speeded_target_recognition_task')
addpath('generate_stim_order')
addpath('task/functions')
addpath('task/USTCRTBox_003')      
PsychJavaTrouble(1);

% run with psychtoolbox debugger if testing
if test
    PsychDebugWindowConfiguration
    RTBOX = false
end

% set up psychtoolbox and RTBox
FS = 44100;
PTB = init_psychtoolbox(FS);
init_RTBox(RTBOX);

% Load stim order
[STIM, N_TRIALS] = generate_stim_order(SUBJ_NUM, BLOCK);

%% Display instructions
update_instructions(BLOCK)
instructions(PTB, BLOCK);

%% Task
for trial = 1:N_TRIALS
    [trial_stim, path, istarget, target] = get_trial_stim(STIM, trial);

    WaitSecs(2)
    fixation(PTB); % show fixation cross to start trial
    present_target(PTB, target) % show target

    % loop through all stim in trial
    for v = 1:length(path)
        [rt, resp] = present_stimulus(path(v), PTB); % trigger sent here
        correct = check_answer(istarget(v), resp);
        write_output(SUBJ_NUM, BLOCK, trial_stim(v,:), rt, resp, correct);
        if BLOCK == 1
            give_feedback(correct, PTB);
        end
    end
end

%% end block
instructions(PTB, 0) 

sca; % screen clear all
close all;
clearvars;
PsychPortAudio('Close'); % clear audio handles
