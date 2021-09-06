sca;
close all;
clearvars;
PsychPortAudio('Close'); % clear audio handles

%% Set up
cd('~/src/speeded_vowel_identification/')
addpath('task/functions')

% Constants
Fs = 44100;
BLOCK = 0;
SUBJ_NUM = 0;
ptb = init_psychtoolbox(Fs);
training = true;

%% Test one
stim = 'stim/f1/OO.wav';
target = 1;
[stim_start, stim_end, pressed, rt, resp] = present_stimulus(stim, BLOCK, ptb); % trigger sent here
correct = check_answer(target, resp);

%% Test multiple
% stim = readtable('generate_stim_order/output/stim_order.txt');
% stim_path = get_filepaths(stim);
% target = get_target(stim);
% 
% for s = 1:length(stim_path)
%     [stim_start, stim_end, pressed, rt, resp] = present_stimulus(stim_path(s), BLOCK, ptb); % trigger sent here
%     correct = check_answer(stim.target(s), resp);
%     write_output(SUBJ_NUM, BLOCK, s, stim.vowel(s), stim_start, stim_end, pressed, rt, resp, correct);
% %     if training
%         give_feedback(correct, ptb);
%     end
% end

% test check_answer and give_feedback with correct answer
% test with incorrect answer
% test with impossible answer
% test write_ouput

sca;