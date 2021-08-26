% Clear the workspace and the screen
sca;
close all;
clearvars;

% Add constants
addpath('functions');
addpath('stim');
FS = 44100;
nrchannels = 2;
% ptb = init_psychtoolbox(FS);
BLOCK = 0;

%% Test present_stimulus.m
stim = 'stim/test_words/clock_f.wav';
ptb.pahandle = PsychPortAudio('Open', [], 1, 1, FS, nrchannels);
present_stimulus(stim, BLOCK, ptb); % trigger sent here

% %% Test trial
% % stimuli = ('stim/test_words/');
% fixation(ptb); % shows fixation cross to start trial
% pahandle = PsychPortAudio('Open', [], 1, 1, FS, nrchannels);
% % for s = start_trial:length(stimuli)
%     present_stimulus(stimuli{s}, BLOCK, ptb); % trigger sent here
% %     response = ask_for_response(ptb);
% %     write_output(SUBJ_NUM, BLOCK, s, stimuli{s}, response);
% % end

%% End
sca; % screen clear all
PsychPortAudio('Close'); % clear audio handles