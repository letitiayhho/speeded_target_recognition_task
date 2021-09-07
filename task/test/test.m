%%%%%%%%%%%%%%%%%%%%%%%%% UPDATE THIS SECTION BEFORE EACH SUBJECT/TEST

SUBJ_NUM = 0; % numeric
BLOCK = 1; % numeric

%%%%%%%%%%%%%%%%%%%%%%%
%% Set up
cd('~/src/speeded_vowel_identification/')
addpath('task/functions')
PsychJavaTrouble(1);

% Constants
FS = 44100;
IS_TRAINING = BLOCK == 1 || BLOCK == 2; % change training depending on block number

% Init psychtoolbox
PTB = init_psychtoolbox(FS);

% Load stim order
stim_file = ['generate_stim_order/output/', num2str(SUBJ_NUM), '_stim_order.txt'];
STIM = readtable(stim_file);

%% Display instructions
instructions(PTB, BLOCK);

%% Task
% loop through all reps in block
n_reps = max(STIM.rep);
for rep = 1:n_reps
    stim_path = get_filepaths(STIM, BLOCK, rep);
    target = get_target(STIM, BLOCK, rep);

    % loop through all stim in rep
    fixation(PTB); % show fixation cross to start trial
    present_target(PTB, target) % show target

    for v = 1:length(stim_path)
        [rt, resp] = present_stimulus(stim_path(v), PTB); % trigger sent here
        correct = check_answer(STIM.istarget(v), resp);
        write_output(SUBJ_NUM, BLOCK, v, STIM.vowel(v), rt, resp, correct);
        if IS_TRAINING
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
