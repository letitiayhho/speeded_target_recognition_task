sca;
close all;
clearvars;
PsychPortAudio('Close'); % clear audio handles

%% Set up
cd('~/src/speeded_vowel_identification/')
addpath('task/functions')

% Constants
Fs = 44100;
stim = 'stim/f1/OO.wav';

% Init psychtoolbox
ptb = init_psychtoolbox(Fs);

%% Test wow so this WORKED, nothing changed, will test again... okay, it works also without KeyList
% Saved a stable version below, will now debug with this
% load contents of .wav file into buffer
    [aud, ~] = audioread(stim);
    PsychPortAudio('FillBuffer', ptb.pahandle, [aud'; aud']);

    % inter-trial interval
    jitter = rand/5 - .1; % -100 to +100 ms uniform jitter
    WaitSecs(.5 + jitter);

    % start collecting response
    KbQueueCreate(ptb.keyboard);
    ListenChar(2);
    KbQueueStart;

    % play audio
    t0 = GetSecs + .001;
    PsychPortAudio('Start', ptb.pahandle, 1, t0, 1);

    % stop audio
    [stim_start, ~, ~, stim_end] = PsychPortAudio('Stop', ptb.pahandle, 1, 1);

    % Collect response
    [pressed, rt] = KbQueueCheck;
    resp = KbName(rt);
    [rt, I] = min(rt(rt > 0)); % keep only first response
    resp = char(resp(I));

    % Wait
    WaitSecs(.2 + rand()*.2);
    KbQueueStop;
    KbQueueRelease;
    ListenChar(0); % renables matlab command window

%% A version that works
% 
% % load contents of .wav file into buffer
% [aud, ~] = audioread(stim);
% PsychPortAudio('FillBuffer', ptb.pahandle, [aud'; aud']);
% 
% % inter-trial interval
% jitter = rand/5 - .1; % -100 to +100 ms uniform jitter
% WaitSecs(.5 + jitter);
% 
% % start collecting response
% % keyList = zeros(256, 1); % allow only certain keys
% % keyList(6:7) = 1;
% % KbQueueCreate(ptb.keyboard, keyList);
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
% WaitSecs(0.250);
% KbQueueStop;
% KbQueueRelease;
% ListenChar(0); % renables matlab command window

%% Test
% 
% % load contents of .wav file into buffer
% [aud, ~] = audioread(stim);
% PsychPortAudio('FillBuffer', ptb.pahandle, [aud'; aud']);
% 
% % show response accepting
% % DrawFormattedText(ptb.window, 'x', 'center', 'center', 1);
% % Screen('Flip', ptb.window);
% 
% % start collecting response
% KbQueueCreate(ptb.keyboard);
% ListenChar(2); % disables matlab command window
% KbQueueStart;
% 
% % Collect response
% [pressed, rt] = KbQueueCheck;
% resp = KbName(rt);
% [rt, I] = min(rt(rt > 0)); % keep only first respotnse
% resp = char(resp(I));
% 
% % play audio
% t0 = GetSecs + .001;
% PsychPortAudio('Start', ptb.pahandle, 1, t0, 1);
% 
% WaitSecs(3)
% 
% % stop audio
% [stim_start, ~, ~, stim_end] = PsychPortAudio('Stop', ptb.pahandle, 1, 1);
% 
% % inter-trial interval with jitter
% WaitSecs(.2 + rand()*.2); % wait between 200 and 400 ms
% KbQueueStop;
% KbQueueRelease;
% ListenChar(0); % renables matlab command window
% 
% % end of accepting response
% % Screen('Flip', ptb.window);

sca