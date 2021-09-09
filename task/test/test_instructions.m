PsychDebugWindowConfiguration
 
%% Set up
cd('~/src/speeded_vowel_identification/')
addpath('task/functions')
addpath('task/USTCRTBox_003')      
PsychJavaTrouble(1);

% Constants
FS = 44100;
RTBOX = false;

init_RTBox(RTBOX);
PTB = init_psychtoolbox(FS);
instructions(PTB, 0)

sca 

% %%%%%%%%%%%%%%%%%%%%%%%%% UPDATE THIS SECTION BEFORE EACH SUBJECT/TEST
% 
% SUBJ_NUM = 0; % numeric
% BLOCK = 1; % numeric
% 
% %%%%%%%%%%%%%%%%%%%%%%%
% %% Set up
% cd('~/src/speeded_vowel_identification/')
% addpath('task/functions')
% PsychJavaTrouble(1);
% 
% % Constants
% FS = 44100;
% IS_TRAINING = BLOCK == 1 || BLOCK == 2; % change training depending on block number
% 
% % Init psychtoolbox
% PTB = init_psychtoolbox(FS);
% 
% % Load stim order
% stim_file = ['generate_stim_order/output/', num2str(SUBJ_NUM), '_stim_order.txt'];
% STIM = readtable(stim_file);
% 
% %% Display instructions
% instructions(PTB, BLOCK);
% 
% sca