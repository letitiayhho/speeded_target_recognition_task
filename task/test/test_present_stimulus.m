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
stim = 'stim/f1/OO.wav';
ptb = init_psychtoolbox(Fs);

[stim_start, stim_end, pressed, rt, resp] = present_stimulus(stim, ptb)
% 
% %% Test current script
% [aud, ~] = audioread(stim);
% PsychPortAudio('FillBuffer', ptb.pahandle, [aud'; aud']);
% 
% % inter-trial interval
% jitter = rand/5 - .1; % -100 to +100 ms uniform jitter
% WaitSecs(.5 + jitter);
% 
% % start collecting response
% KbQueueCreate(ptb.keyboard);
% ListenChar(2);
% KbQueueStart;
% 
% % play audio
% t0 = GetSecs + .001;
% PsychPortAudio('Start', ptb.pahandle, 1, t0, 1);
% 
% % stop audio
% [stim_start, ~, ~, stim_end] = PsychPortAudio('Stop', ptb.pahandle, 1, 1);
% 
% % Collect response
% [pressed, rt] = KbQueueCheck;
% resp = KbName(rt);
% [rt, I] = min(rt(rt > 0)); % keep only first response
% resp = char(resp(I));
% 
% % Wait
% WaitSecs(.2 + rand()*.2);
% KbQueueStop;
% KbQueueRelease;
% ListenChar(0); % renables matlab command window

%% Test final version
% [aud, ~] = audioread(stim);
% ptb = init_psychtoolbox(Fs);
% [stim_start, stim_end, pressed, rt, resp] = present_stimulus(stim, BLOCK, ptb);
% fprintf(1, resp)

%% Test init_psychtoolbox()

% Initialize sound with init_psychtoolbox()
% ptb = init_psychtoolbox(Fs);

% Innards of init_psychtoolbox
% InitializePsychSound(1);
% nrchannels = 2;
% ptb.pahandle = PsychPortAudio('Open', [], 1, 1, Fs, nrchannels); % TUTORIAL

%% Test present_stimulus()
% Tutorial verion
% % PsychPortAudio('FillBuffer', ptb.pahandle, [aud'; aud']);
% % PsychPortAudio('Start', ptb.pahandle, 1, t0, 1);
% % [actualStartTime, ~, ~, estStopTime] = PsychPortAudio('Stop', ptb.pahandle, 1, 1);

% Johns version
% [stim_start, stim_end, pressed, rt, resp] = present_stimulus(stim, BLOCK, ptb);
% fprintf(1, resp)

% Innards of Johns versionttttt
% PsychPortAudio('FillBuffer', ptb.pahandle, [aud'; aud']);
% t0 = GetSecs + .001;
% starttime = PsychPortAudio('Start', ptb.pahandle, 1, t0, 1);
% [actualStartTime, ~, ~, estStopTime] = PsychPortAudio('Stop', ptb.pahandle, 1, 1); % NEEDS 1, 1, at the end here

%% End
sca; % screen clear all
% close all;
% clearvars;