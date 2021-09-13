%%%%%%%%%%%%%%%%%%%%%%%%% UPDATE THIS SECTION BEFORE EACH SUBJECT/TEST

SUBJ_NUM = 0; % numeric
BLOCK = 2; % numeric
RTBOX = false; % logical
       
%%%%%%%%%%%%%%%%%%%%%%%
      
PsychDebugWindowConfiguration

%% Set up
cd('~/src/speeded_vowel_identification/')
addpath('task/functions')
addpath('task/USTCRTBox_003')      
PsychJavaTrouble(1);

% other constants      
FS = 44100;
IS_TRAINING = BLOCK == 1 || BLOCK == 2; % change training depending on block number

% set up psychtoolbox and RTBox
init_RTBox(RTBOX);
% PTB = init_psychtoolbox(FS);

% Load stim order
stim_file = ['generate_stim_order/output/', num2str(SUBJ_NUM), '_stim_order.txt'];
STIM = readtable(stim_file);

%% Display instructions
% instructions(PTB, BLOCK);

%% Task
% loop through all reps in block
n_reps = get_n_reps(STIM, BLOCK);

for rep = 1:n_reps
    [vowels, paths, target] = get_rep_stim(STIM, BLOCK, rep);

    % loop through all stim in rep
%     fixation(PTB); % show fixation cross to start trial
%     present_target(PTB, target) % show target
% 
    for v = 1:length(stim_path)
        fprintf(1, [paths(v)+ '\n'])
        fprintf(1, [vowels(v, :), '\n'])
%         [rt, resp] = present_stimulus(stim_path(v), PTB); % trigger sent here
%         correct = check_answer(STIM.istarget(v), resp);
%         write_output(SUBJ_NUM, BLOCK, v, STIM.vowel(v), rt, resp, correct);
%         if IS_TRAINING
%             give_feedback(correct, PTB);
%         end
    end
end

%% end block
% instructions(PTB, 0)

sca; % screen clear all
close all;
% clearvars;
PsychPortAudio('Close'); % clear audio handles
