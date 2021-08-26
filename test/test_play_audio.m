% Clear the workspace
clearvars;
close all;
sca;

% Set
stim = 'stim/test_words/clock_f.wav';
[aud, ~] = audioread(stim);
InitializePsychSound(1);
nrchannels = 2;
freq = 44100;
t0 = GetSecs + .001;
ptb.pahandle = PsychPortAudio('Open', [], 1, 1, freq, nrchannels); % TUTORIAL

% % % Tutorial verion
% % PsychPortAudio('FillBuffer', ptb.pahandle, [aud'; aud']);
% % PsychPortAudio('Start', ptb.pahandle, 1, t0, 1);
% % [actualStartTime, ~, ~, estStopTime] = PsychPortAudio('Stop', ptb.pahandle, 1, 1);

% Johns version
PsychPortAudio('FillBuffer', ptb.pahandle, [aud'; aud']);
starttime = PsychPortAudio('Start', ptb.pahandle, 1, t0, 1);
[actualStartTime, ~, ~, estStopTime] = PsychPortAudio('Stop', ptb.pahandle, 1, 1); % NEEDS 1, 1, at the end here