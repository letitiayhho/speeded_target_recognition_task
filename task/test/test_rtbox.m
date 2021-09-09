%% Set up
cd('~/src/speeded_vowel_identification/')
addpath('task/functions')
PsychJavaTrouble(1);

% Add constants
FS = 44100;
SUBJ_NUM = 0;
BLOCK = 'test';
TRAINING = true; % change training depending on block number

%% Init psychtoolbox
ptb = init_psychtoolbox(FS);

%% Test with same audio each time
stim = 'stim/f1/AH.wav';
fixation(ptb); % show fixation cross to start trial
for s = 1:20
    [rt, resp] = present_stimulus(stim, ptb); % trigger sent here
end
sca