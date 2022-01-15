%%%%%%%%%%%%%%%%%%%%%%%%% UPDATE THIS SECTION BEFORE EACH SUBJECT/TEST

SUBJ_NUM = 2; % numeric
VARIATION = "NaN"; % either "NaN", "male", or "exemplar"
PILOT = true; % logical
TEST = false; % logical

%%%%%%%%%%%%%%%%%%%%%%%

%% Set up
cd('C:\Users\Nusbaum Lab\Desktop\speeded_target_recognition_task')
addpath('generate_stim_order')
addpath('task/functions')
addpath('task/USTCRTBox_003')   
PsychJavaTrouble(1);
isWindowsAdmin;

if TEST
    RTBOX = false;
else
    RTBOX = true;
end

% set up psychtoolbox and RTBox
FS = 44100;
PTB = init_psychtoolbox(FS);
init_RTBox(RTBOX);

%% Loop over blocks
BLOCKS = 1:9;

for BLOCK = BLOCKS
    % Load stim order
    [STIM, N_TRIALS] = generate_stim_order(SUBJ_NUM, BLOCK, VARIATION);

    %% Display instructions
    update_instructions(BLOCK)
    instructions(PTB, BLOCK);

    %% Task
    for trial = 1:N_TRIALS
        [trial_stim, path, istarget, target] = get_trial_stim(STIM, trial);

        WaitSecs(2);
        fixation(PTB); % show fixation cross to start trial
        present_target(PTB, target); % show target
        tic;

        % loop through all stim in trial
        DrawFormattedText(PTB.window, 'x', 'center', 'center', 1);
        Screen('Flip', PTB.window);
        for v = 1:length(path) 
            rt = present_stimulus(path(v), PTB); % trigger sent here
            write_output(SUBJ_NUM, BLOCK, trial_stim(v,:), rt, PILOT);
            if BLOCK == 1
                correct = check_answer(istarget(v), rt);
                give_feedback(correct, PTB);
            end
        end
        Screen('Flip', PTB.window);
    end

    %% end block
    instructions(PTB, 0) 
end

sca; % screen clear all
close all;
clearvars;
PsychPortAudio('Close'); % clear audio handles
clear all;
