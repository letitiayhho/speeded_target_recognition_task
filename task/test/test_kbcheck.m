%% Set up
cd('~/src/speeded_target_identification/')
addpath('functions')
addpath('stim/test_words')

% Constants
Fs = 44100;
stim = 'clock_f.wav';

% Init psychtoolbox
ptb = init_psychtoolbox(Fs);

%% Play audio
[aud, ~] = audioread(stim);
PsychPortAudio('FillBuffer', ptb.pahandle, [aud'; aud']);
ListenChar(2); % suppresses typing into matlab command window
PsychPortAudio('Start', ptb.pahandle, 1, 0, 1);

% collect response
[pressed, rt, resp] = KbCheck; % test with GetKeyboardIndices
PsychPortAudio('Stop', ptb.pahandle, 1, 1);
ListenChar(0);
fprintf([num2str(pressed), '\n'])
fprintf([num2str(rt), '\n'])
fprintf([num2str(find(resp)), '\n'])

%% End
sca; % screen clear all
close all;
% clearvars;
PsychPortAudio('Close'); % clear audio handles