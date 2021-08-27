%% Set up
cd('~/src/speeded_target_identification/')
addpath('functions')
addpath('stim/test_words')

% Add constants
Fs = 44100;
BLOCK = 0;
ptb = init_psychtoolbox(Fs);

%% Test present_stimulus.m once
% stim = get_filepaths('stim/test_words');
% fixation(ptb);
% present_stimulus(stim{1}, BLOCK, ptb); % trigger sent here

%% Test present_stimulus.m multiple times
stim = get_filepaths('stim/test_words');
for s = 1:length(stim)
%     % Break if ESC is pressed
%     [keyIsDown, keysecs, keyCode] = KbCheck;
%     if keyCode(KBName('escape'))
%         SCREEN('CloseAll');
%         break;
%     end
    
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