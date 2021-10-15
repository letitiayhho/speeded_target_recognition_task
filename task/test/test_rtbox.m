PsychDebugWindowConfiguration

%% Set up
cd('~/src/speeded_target_recognition_task/')
addpath('task/functions')
addpath('task/USTCRTBox_003')      
PsychJavaTrouble(1);

% Add constants
FS = 44100;
SUBJ_NUM = 0;
BLOCK = 'test';
RTBOX = true;
TRAINING = true; % change training depending on block number

% set up psychtoolbox and RTBox
init_RTBox(RTBOX);
ptb = init_psychtoolbox(FS);

%% Test with same audio each time
stim = 'stim/f1/AH.wav';
fixation(ptb); % show fixation cross to start trial
for s = 1:100
    [rt, resp] = present_stimulus(stim, ptb); % trigger sent here
end
sca