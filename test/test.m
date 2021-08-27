% Clear the workspace and the screen
sca;
close all;
clearvars;

% Add constants
cd('~/src/speeded_target_identification/')
addpath('functions')
addpath('stim/test_words')
Fs = 44100;
ptb = init_psychtoolbox(Fs);
BLOCK = 0;

%% Test present_stimulus.m
% stim = 'stim/test_words/clock_f.wav';
% present_stimulus(stim, BLOCK, ptb); % trigger sent here

%% Test present_stimulus.m multiple times
stim = dir('stim/test_words/*.wav'); % NEED FULL FILE PATH
stim = {stim(:).name};
for s = 1:length(stim)
    fixation(ptb); % shows fixation cross to start trial
    present_stimulus(stim{s}, BLOCK, ptb); % trigger sent here
%     response = ask_for_response(ptb);
%     if training
%         give_feedback(stimuli{s}, ptb); % another trigger (7) sent here
%     end
end

%% End
sca; % screen clear all
close all;
clearvars;
PsychPortAudio('Close'); % clear audio handles