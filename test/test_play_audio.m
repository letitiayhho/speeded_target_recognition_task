%% Set up

% Clear the workspace
clearvars;
close all;
sca;

% Constants
cd('~/src/speeded_target_identification/')
addpath('functions')
addpath('stim/test_words')
Fs = 44100;

% Load stim
stim = 'clock_f.wav';
[aud, ~] = audioread(stim);

%% Test init_psychtoolbox()

% Initialize sound with init_psychtoolbox()
ptb = init_psychtoolbox(Fs);

% Innards of init_psychtoolbox
% InitializePsychSound(1);
% nrchannels = 2;
% ptb.pahandle = PsychPortAudio('Open', [], 1, 1, Fs, nrchannels); % TUTORIAL

%% Tutorial verion
% % PsychPortAudio('FillBuffer', ptb.pahandle, [aud'; aud']);
% % PsychPortAudio('Start', ptb.pahandle, 1, t0, 1);
% % [actualStartTime, ~, ~, estStopTime] = PsychPortAudio('Stop', ptb.pahandle, 1, 1);

%% Johns version
PsychPortAudio('FillBuffer', ptb.pahandle, [aud'; aud']);
t0 = GetSecs + .001;
starttime = PsychPortAudio('Start', ptb.pahandle, 1, t0, 1);
[actualStartTime, ~, ~, estStopTime] = PsychPortAudio('Stop', ptb.pahandle, 1, 1); % NEEDS 1, 1, at the end here

%% End
sca; % screen clear all
close all;
clearvars;