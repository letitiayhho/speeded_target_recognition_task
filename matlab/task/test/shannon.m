% Perceptual Learning Study
% Coded by Shannon Heald - 2012

% Netstation toolbox is used to interact with EGI Netstation software and
% Matlab.  This enables tagging of blocks and events in EEG data.  All
% mentions of Netstation thusly can be commented out if not collecting EEG
% data and code will still work!

% Timing of Audio device is important to this code.  Please make sure you
% have installed the portaudio_x86_with_ASIO.zip file which is a special
% ASIO enabled window sound driver.  MAKE SURE TO READ THE README file
% associated with the driver.  It explains how to use the driver as well as
% the limitations associated with the driver.  IF THERE IS A PROBLEM WITH
% TIMING IT IS LIKELY YOU ARE USING THE ASIO DRIVER INCORRECTLY!


%% Clear everything
    
clear all;
clc;

%% Set preferences

Screen('Preference', 'SkipSyncTests', 1);
Screen('Preference', 'VisualDebugLevel', 3);
Screen('Preference', 'SuppressAllWarnings', 1);


%% Get information about the subject and experimental run


subject=input('Enter the subject number = ');
while ~isnumeric(subject)
    subject=input('Enter the subject number = ');
end;

subject=int2str(subject);
filename=strcat('subj', subject);

pretest=input('Enter test number for pretest = ');
while ~isnumeric(pretest)
    pretest=input('Enter test number for pretest = ');
end;

posttest=input('Enter test number for posttest = ');
while ~isnumeric(posttest)
     posttest=input('Enter test number for posttest = ');
end;

feedbackblock1=input('Enter test number for feedback block 1 = ');
while ~isnumeric(feedbackblock1)
     feedbackblock1=input('Enter test number for feedback block 1 = ');
end;

feedbackblock2=input('Enter test number for feedback block 2 = ');
while ~isnumeric(feedbackblock2)
     feedbackblock2=input('Enter test number for feedback block 2 = ');
end;

feedbackblock3=input('Enter test number for feedback block 3 = ');
while ~isnumeric(feedbackblock3)
     feedbackblock3=input('Enter test number for feedback block 3 = ');
end;

feedbackblock4=input('Enter test number for feedback block 4 = ');
while ~isnumeric(feedbackblock4)
     feedbackblock4=input('Enter test number for feedback block 4 = ');
end;

feedbackblock5=input('Enter test number for feedback block 5 = ');
while ~isnumeric(feedbackblock5)
     feedbackblock5=input('Enter test number for feedback block 5 = ');
end;

feedbackblock6=input('Enter test number for feedback block 6 = ');
while ~isnumeric(feedbackblock6)
     feedbackblock6=input('Enter test number for feedback block 6 = ');
end;

inputfolder='C:\Users\scss\Documents\MATLAB\AudioPerceptualLearningTest\';
outputfolder='C:\Users\scss\Documents\MATLAB\AudioPerceptualLearningTest\';
numoftrials=500;

%% Turn off keyboard so that the code remains untampered with

ListenChar(2)
                  
%% INITIALIZE     

% randomize feed
rand('twister',sum(100*clock)); %#ok<RAND>

% Perform basic initialization of the sound driver:
InitializePsychSound;
WaitSecs(0.5);

%% CONNECTION TO NETSTATION, SYNC and START RECORDING

NetStation('Connect', '10.10.10.2',55513);
NetStation('Synchronize');
NetStation('StartRecording');    

%% DECLARATION of Variables we need for setting up the experiment

% sample rate
Fs=44100;

% colors
backgroundcolor=[0 0 0];
textcolor=[200 200 200];

%% Let's load the files for each experimental block... 

%make the instruction file list

cd(inputfolder);
InstructionFilesList=dir('Instruction*.txt'); 

%make the audio list for each list from the folders provided
AudioListf1=dir('f1\*.wav');
AudioListf2=dir('f2\*.wav');
AudioListf3=dir('f3\*.wav');
AudioListf4=dir('f4\*.wav');
AudioListf5=dir('f5\*.wav');
AudioListf6=dir('f6\*.wav');
AudioListf7=dir('f7\*.wav');
AudioListf8=dir('f8\*.wav');
AudioListf9=dir('f9\*.wav');
AudioListt1=dir('t1\*.wav');
AudioListt2=dir('t2\*.wav');
AudioListt3=dir('t3\*.wav');
AudioListt4=dir('t4\*.wav');


% How many items? This should match the contents of the folders
NbObjectsf(1)=50;
NbObjectst(1)=100;

num_fb   = NbObjectsf(1);
num_test = NbObjectst(1);

%% Let's get info about audio items from each experimental block
%each should have an xls file in each folder - items in xls should be in 
%ABC order as this is how the AudioLists above are read in... 
[~, ~, feedback1data] = xlsread('f1\Feedback1.xls');    
[~, ~, feedback2data] = xlsread('f2\Feedback2.xls'); 
[~, ~, feedback3data] = xlsread('f3\Feedback3.xls'); 
[~, ~, feedback4data] = xlsread('f4\Feedback4.xls'); 
[~, ~, feedback5data] = xlsread('f5\Feedback5.xls'); 
[~, ~, feedback6data] = xlsread('f6\Feedback6.xls'); 
[~, ~, feedback7data] = xlsread('f7\Feedback7.xls'); 
[~, ~, feedback8data] = xlsread('f8\Feedback8.xls'); 
[~, ~, feedback9data] = xlsread('f9\Feedback9.xls'); 
[~, ~, test1data] = xlsread('t1\test1.xls'); 
[~, ~, test2data] = xlsread('t2\test2.xls'); 
[~, ~, test3data] = xlsread('t3\test3.xls'); 
[~, ~, test4data] = xlsread('t4\test4.xls'); 

% feedback 1 read in
for i=1:NbObjectsf(1)
    Filef1(i,1)= feedback1data(i,1); %#ok<*SAGROW>
    Wordf1(i,1)= feedback1data(i,2); %#ok<*SAGROW>
    C1f1(i,1)= feedback1data(i,3);%#ok<*SAGROW>
    C2f1(i,1)= feedback1data(i,4);%#ok<*SAGROW>
    C3f1(i,1)= feedback1data(i,5);%#ok<*SAGROW>
    C4f1(i,1)= feedback1data(i,6);%#ok<*SAGROW>
    C5f1(i,1)= feedback1data(i,7);%#ok<*SAGROW>
    C6f1(i,1)= feedback1data(i,8);%#ok<*SAGROW>
    C7f1(i,1)= feedback1data(i,9);%#ok<*SAGROW>
    C8f1(i,1)= feedback1data(i,10);%#ok<*SAGROW>
    C9f1(i,1)= feedback1data(i,11);%#ok<*SAGROW>
    C10f1(i,1)= feedback1data(i,12);%#ok<*SAGROW>
    C11f1(i,1)= feedback1data(i,13);%#ok<*SAGROW>
    C12f1(i,1)= feedback1data(i,14);%#ok<*SAGROW>
end;

% feedback 2 read in
for i=1:NbObjectsf(1)
    Filef2(i,1)= feedback2data(i,1);
    Wordf2(i,1)= feedback2data(i,2);
    C1f2(i,1)= feedback2data(i,3);
    C2f2(i,1)= feedback2data(i,4);
    C3f2(i,1)= feedback2data(i,5);
    C4f2(i,1)= feedback2data(i,6);
    C5f2(i,1)= feedback2data(i,7);
    C6f2(i,1)= feedback2data(i,8);
    C7f2(i,1)= feedback2data(i,9);
    C8f2(i,1)= feedback2data(i,10);
    C9f2(i,1)= feedback2data(i,11);
    C10f2(i,1)= feedback2data(i,12);
    C11f2(i,1)= feedback2data(i,13);
    C12f2(i,1)= feedback2data(i,14);
end;

% feedback 3 read in
for i=1:NbObjectsf(1)
    Filef3(i,1)= feedback3data(i,1);
    Wordf3(i,1)= feedback3data(i,2);
    C1f3(i,1)= feedback3data(i,3);
    C2f3(i,1)= feedback3data(i,4);
    C3f3(i,1)= feedback3data(i,5);
    C4f3(i,1)= feedback3data(i,6);
    C5f3(i,1)= feedback3data(i,7);
    C6f3(i,1)= feedback3data(i,8);
    C7f3(i,1)= feedback3data(i,9);
    C8f3(i,1)= feedback3data(i,10);
    C9f3(i,1)= feedback3data(i,11);
    C10f3(i,1)= feedback3data(i,12);
    C11f3(i,1)= feedback3data(i,13);
    C12f3(i,1)= feedback3data(i,14);
end;

% feedback 4 read in
for i=1:NbObjectsf(1)
    Filef4(i,1)= feedback4data(i,1);
    Wordf4(i,1)= feedback4data(i,2);
    C1f4(i,1)= feedback4data(i,3);
    C2f4(i,1)= feedback4data(i,4);
    C3f4(i,1)= feedback4data(i,5);
    C4f4(i,1)= feedback4data(i,6);
    C5f4(i,1)= feedback4data(i,7);
    C6f4(i,1)= feedback4data(i,8);
    C7f4(i,1)= feedback4data(i,9);
    C8f4(i,1)= feedback4data(i,10);
    C9f4(i,1)= feedback4data(i,11);
    C10f4(i,1)= feedback4data(i,12);
    C11f4(i,1)= feedback4data(i,13);
    C12f4(i,1)= feedback4data(i,14);
end;

% feedback 5 read in
for i=1:NbObjectsf(1)
    Filef5(i,1)= feedback5data(i,1);
    Wordf5(i,1)= feedback5data(i,2);
    C1f5(i,1)= feedback5data(i,3);
    C2f5(i,1)= feedback5data(i,4);
    C3f5(i,1)= feedback5data(i,5);
    C4f5(i,1)= feedback5data(i,6);
    C5f5(i,1)= feedback5data(i,7);
    C6f5(i,1)= feedback5data(i,8);
    C7f5(i,1)= feedback5data(i,9);
    C8f5(i,1)= feedback5data(i,10);
    C9f5(i,1)= feedback5data(i,11);
    C10f5(i,1)= feedback5data(i,12);
    C11f5(i,1)= feedback5data(i,13);
    C12f5(i,1)= feedback5data(i,14);
end;

% feedback 6 read in
for i=1:NbObjectsf(1)
    Filef6(i,1)= feedback6data(i,1);
    Wordf6(i,1)= feedback6data(i,2);
    C1f6(i,1)= feedback6data(i,3);
    C2f6(i,1)= feedback6data(i,4);
    C3f6(i,1)= feedback6data(i,5);
    C4f6(i,1)= feedback6data(i,6);
    C5f6(i,1)= feedback6data(i,7);
    C6f6(i,1)= feedback6data(i,8);
    C7f6(i,1)= feedback6data(i,9);
    C8f6(i,1)= feedback6data(i,10);
    C9f6(i,1)= feedback6data(i,11);
    C10f6(i,1)= feedback6data(i,12);
    C11f6(i,1)= feedback6data(i,13);
    C12f6(i,1)= feedback6data(i,14);
end;

% feedback 7 read in
for i=1:NbObjectsf(1)
    Filef7(i,1)= feedback7data(i,1);
    Wordf7(i,1)= feedback7data(i,2);
    C1f7(i,1)= feedback7data(i,3);
    C2f7(i,1)= feedback7data(i,4);
    C3f7(i,1)= feedback7data(i,5);
    C4f7(i,1)= feedback7data(i,6);
    C5f7(i,1)= feedback7data(i,7);
    C6f7(i,1)= feedback7data(i,8);
    C7f7(i,1)= feedback7data(i,9);
    C8f7(i,1)= feedback7data(i,10);
    C9f7(i,1)= feedback7data(i,11);
    C10f7(i,1)= feedback7data(i,12);
    C11f7(i,1)= feedback7data(i,13);
    C12f7(i,1)= feedback7data(i,14);
end;

% feedback 8 read in
for i=1:NbObjectsf(1)
    Filef8(i,1)= feedback8data(i,1);
    Wordf8(i,1)= feedback8data(i,2);
    C1f8(i,1)= feedback8data(i,3);
    C2f8(i,1)= feedback8data(i,4);
    C3f8(i,1)= feedback8data(i,5);
    C4f8(i,1)= feedback8data(i,6);
    C5f8(i,1)= feedback8data(i,7);
    C6f8(i,1)= feedback8data(i,8);
    C7f8(i,1)= feedback8data(i,9);
    C8f8(i,1)= feedback8data(i,10);
    C9f8(i,1)= feedback8data(i,11);
    C10f8(i,1)= feedback8data(i,12);
    C11f8(i,1)= feedback8data(i,13);
    C12f8(i,1)= feedback8data(i,14);
end;

% feedback 9 read in
for i=1:NbObjectsf(1)
    Filef9(i,1)= feedback9data(i,1);
    Wordf9(i,1)= feedback9data(i,2);
    C1f9(i,1)= feedback9data(i,3);
    C2f9(i,1)= feedback9data(i,4);
    C3f9(i,1)= feedback9data(i,5);
    C4f9(i,1)= feedback9data(i,6);
    C5f9(i,1)= feedback9data(i,7);
    C6f9(i,1)= feedback9data(i,8);
    C7f9(i,1)= feedback9data(i,9);
    C8f9(i,1)= feedback9data(i,10);
    C9f9(i,1)= feedback9data(i,11);
    C10f9(i,1)= feedback9data(i,12);
    C11f9(i,1)= feedback9data(i,13);
    C12f9(i,1)= feedback9data(i,14);
end;

% test 1 read in
for i=1:NbObjectst(1)
    Filet1(i,1)= test1data(i,1);
    Wordt1(i,1)= test1data(i,2);
    C1t1(i,1)= test1data(i,3);
    C2t1(i,1)= test1data(i,4);
    C3t1(i,1)= test1data(i,5);
    C4t1(i,1)= test1data(i,6);
    C5t1(i,1)= test1data(i,7);
    C6t1(i,1)= test1data(i,8);
    C7t1(i,1)= test1data(i,9);
    C8t1(i,1)= test1data(i,10);
    C9t1(i,1)= test1data(i,11);
    C10t1(i,1)= test1data(i,12);
    C11t1(i,1)= test1data(i,13);
    C12t1(i,1)= test1data(i,14);
end;

% test 2 read in
for i=1:NbObjectst(1)
    Filet2(i,1)= test2data(i,1);
    Wordt2(i,1)= test2data(i,2);
    C1t2(i,1)= test2data(i,3);
    C2t2(i,1)= test2data(i,4);
    C3t2(i,1)= test2data(i,5);
    C4t2(i,1)= test2data(i,6);
    C5t2(i,1)= test2data(i,7);
    C6t2(i,1)= test2data(i,8);
    C7t2(i,1)= test2data(i,9);
    C8t2(i,1)= test2data(i,10);
    C9t2(i,1)= test2data(i,11);
    C10t2(i,1)= test2data(i,12);
    C11t2(i,1)= test2data(i,13);
    C12t2(i,1)= test2data(i,14);
end;

% test 3 read in
for i=1:NbObjectst(1)
    Filet3(i,1)= test3data(i,1);
    Wordt3(i,1)= test3data(i,2);
    C1t3(i,1)= test3data(i,3);
    C2t3(i,1)= test3data(i,4);
    C3t3(i,1)= test3data(i,5);
    C4t3(i,1)= test3data(i,6);
    C5t3(i,1)= test3data(i,7);
    C6t3(i,1)= test3data(i,8);
    C7t3(i,1)= test3data(i,9);
    C8t3(i,1)= test3data(i,10);
    C9t3(i,1)= test3data(i,11);
    C10t3(i,1)= test3data(i,12);
    C11t3(i,1)= test3data(i,13);
    C12t3(i,1)= test3data(i,14);
end;

% test 4 read in
for i=1:NbObjectst(1)
    Filet4(i,1)= test4data(i,1);
    Wordt4(i,1)= test4data(i,2);
    C1t4(i,1)= test4data(i,3);
    C2t4(i,1)= test4data(i,4);
    C3t4(i,1)= test4data(i,5);
    C4t4(i,1)= test4data(i,6);
    C5t4(i,1)= test4data(i,7);
    C6t4(i,1)= test4data(i,8);
    C7t4(i,1)= test4data(i,9);
    C8t4(i,1)= test4data(i,10);
    C9t4(i,1)= test4data(i,11);
    C10t4(i,1)= test4data(i,12);
    C11t4(i,1)= test4data(i,13);
    C12t4(i,1)= test4data(i,14);
end;

%% Now let's make a huge structure that has all the info about the audio
% files in the experiment so we can randomize it all together... 

% make a large structure for feedback 1
for i=1:NbObjectsf(1)
    AudioInfof1(i,1).name= AudioListf1(i,1).name;
    AudioInfof1(i,1).filename= Filef1(i,1);
    AudioInfof1(i,1).word = Wordf1(i,1);
    AudioInfof1(i,1).c1= C1f1(i,1);
    AudioInfof1(i,1).c2= C2f1(i,1);
    AudioInfof1(i,1).c3= C3f1(i,1);
    AudioInfof1(i,1).c4= C4f1(i,1);
    AudioInfof1(i,1).c5= C5f1(i,1);
    AudioInfof1(i,1).c6= C6f1(i,1);
    AudioInfof1(i,1).c7= C7f1(i,1);
    AudioInfof1(i,1).c8= C8f1(i,1);
    AudioInfof1(i,1).c9= C9f1(i,1);
    AudioInfof1(i,1).c10= C10f1(i,1);
    AudioInfof1(i,1).c11= C11f1(i,1);
    AudioInfof1(i,1).c12= C12f1(i,1);    
end;

% make a large structure for feedback 2
for i=1:NbObjectsf(1)
    AudioInfof2(i,1).name= AudioListf2(i,1).name;
    AudioInfof2(i,1).filename= Filef2(i,1);
    AudioInfof2(i,1).word = Wordf2(i,1);
    AudioInfof2(i,1).c1= C1f2(i,1);
    AudioInfof2(i,1).c2= C2f2(i,1);
    AudioInfof2(i,1).c3= C3f2(i,1);
    AudioInfof2(i,1).c4= C4f2(i,1);
    AudioInfof2(i,1).c5= C5f2(i,1);
    AudioInfof2(i,1).c6= C6f2(i,1);
    AudioInfof2(i,1).c7= C7f2(i,1);
    AudioInfof2(i,1).c8= C8f2(i,1);
    AudioInfof2(i,1).c9= C9f2(i,1);
    AudioInfof2(i,1).c10= C10f2(i,1);
    AudioInfof2(i,1).c11= C11f2(i,1);
    AudioInfof2(i,1).c12= C12f2(i,1);    
end;

% make a large structure for feedback 3
for i=1:NbObjectsf(1)
    AudioInfof3(i,1).name= AudioListf3(i,1).name;
    AudioInfof3(i,1).filename= Filef3(i,1);
    AudioInfof3(i,1).word = Wordf3(i,1);
    AudioInfof3(i,1).c1= C1f3(i,1);
    AudioInfof3(i,1).c2= C2f3(i,1);
    AudioInfof3(i,1).c3= C3f3(i,1);
    AudioInfof3(i,1).c4= C4f3(i,1);
    AudioInfof3(i,1).c5= C5f3(i,1);
    AudioInfof3(i,1).c6= C6f3(i,1);
    AudioInfof3(i,1).c7= C7f3(i,1);
    AudioInfof3(i,1).c8= C8f3(i,1);
    AudioInfof3(i,1).c9= C9f3(i,1);
    AudioInfof3(i,1).c10= C10f3(i,1);
    AudioInfof3(i,1).c11= C11f3(i,1);
    AudioInfof3(i,1).c12= C12f3(i,1);    
end;

% make a large structure for feedback 4
for i=1:NbObjectsf(1)
    AudioInfof4(i,1).name= AudioListf4(i,1).name;
    AudioInfof4(i,1).filename= Filef4(i,1);
    AudioInfof4(i,1).word = Wordf4(i,1);
    AudioInfof4(i,1).c1= C1f4(i,1);
    AudioInfof4(i,1).c2= C2f4(i,1);
    AudioInfof4(i,1).c3= C3f4(i,1);
    AudioInfof4(i,1).c4= C4f4(i,1);
    AudioInfof4(i,1).c5= C5f4(i,1);
    AudioInfof4(i,1).c6= C6f4(i,1);
    AudioInfof4(i,1).c7= C7f4(i,1);
    AudioInfof4(i,1).c8= C8f4(i,1);
    AudioInfof4(i,1).c9= C9f4(i,1);
    AudioInfof4(i,1).c10= C10f4(i,1);
    AudioInfof4(i,1).c11= C11f4(i,1);
    AudioInfof4(i,1).c12= C12f4(i,1);    
end;

% make a large structure for feedback 5
for i=1:NbObjectsf(1)
    AudioInfof5(i,1).name= AudioListf5(i,1).name;
    AudioInfof5(i,1).filename= Filef5(i,1);
    AudioInfof5(i,1).word = Wordf5(i,1);
    AudioInfof5(i,1).c1= C1f5(i,1);
    AudioInfof5(i,1).c2= C2f5(i,1);
    AudioInfof5(i,1).c3= C3f5(i,1);
    AudioInfof5(i,1).c4= C4f5(i,1);
    AudioInfof5(i,1).c5= C5f5(i,1);
    AudioInfof5(i,1).c6= C6f5(i,1);
    AudioInfof5(i,1).c7= C7f5(i,1);
    AudioInfof5(i,1).c8= C8f5(i,1);
    AudioInfof5(i,1).c9= C9f5(i,1);
    AudioInfof5(i,1).c10= C10f5(i,1);
    AudioInfof5(i,1).c11= C11f5(i,1);
    AudioInfof5(i,1).c12= C12f5(i,1);    
end;

% make a large structure for feedback 6
for i=1:NbObjectsf(1)
    AudioInfof6(i,1).name= AudioListf6(i,1).name;
    AudioInfof6(i,1).filename= Filef6(i,1);
    AudioInfof6(i,1).word = Wordf6(i,1);
    AudioInfof6(i,1).c1= C1f6(i,1);
    AudioInfof6(i,1).c2= C2f6(i,1);
    AudioInfof6(i,1).c3= C3f6(i,1);
    AudioInfof6(i,1).c4= C4f6(i,1);
    AudioInfof6(i,1).c5= C5f6(i,1);
    AudioInfof6(i,1).c6= C6f6(i,1);
    AudioInfof6(i,1).c7= C7f6(i,1);
    AudioInfof6(i,1).c8= C8f6(i,1);
    AudioInfof6(i,1).c9= C9f6(i,1);
    AudioInfof6(i,1).c10= C10f6(i,1);
    AudioInfof6(i,1).c11= C11f6(i,1);
    AudioInfof6(i,1).c12= C12f6(i,1);    
end;

% make a large structure for feedback 7
for i=1:NbObjectsf(1)
    AudioInfof7(i,1).name= AudioListf7(i,1).name;
    AudioInfof7(i,1).filename= Filef7(i,1);
    AudioInfof7(i,1).word = Wordf7(i,1);
    AudioInfof7(i,1).c1= C1f7(i,1);
    AudioInfof7(i,1).c2= C2f7(i,1);
    AudioInfof7(i,1).c3= C3f7(i,1);
    AudioInfof7(i,1).c4= C4f7(i,1);
    AudioInfof7(i,1).c5= C5f7(i,1);
    AudioInfof7(i,1).c6= C6f7(i,1);
    AudioInfof7(i,1).c7= C7f7(i,1);
    AudioInfof7(i,1).c8= C8f7(i,1);
    AudioInfof7(i,1).c9= C9f7(i,1);
    AudioInfof7(i,1).c10= C10f7(i,1);
    AudioInfof7(i,1).c11= C11f7(i,1);
    AudioInfof7(i,1).c12= C12f7(i,1);    
end;

% make a large structure for feedback 8
for i=1:NbObjectsf(1)
    AudioInfof8(i,1).name= AudioListf8(i,1).name;
    AudioInfof8(i,1).filename= Filef8(i,1);
    AudioInfof8(i,1).word = Wordf8(i,1);
    AudioInfof8(i,1).c1= C1f8(i,1);
    AudioInfof8(i,1).c2= C2f8(i,1);
    AudioInfof8(i,1).c3= C3f8(i,1);
    AudioInfof8(i,1).c4= C4f8(i,1);
    AudioInfof8(i,1).c5= C5f8(i,1);
    AudioInfof8(i,1).c6= C6f8(i,1);
    AudioInfof8(i,1).c7= C7f8(i,1);
    AudioInfof8(i,1).c8= C8f8(i,1);
    AudioInfof8(i,1).c9= C9f8(i,1);
    AudioInfof8(i,1).c10= C10f8(i,1);
    AudioInfof8(i,1).c11= C11f8(i,1);
    AudioInfof8(i,1).c12= C12f8(i,1);    
end;

% make a large structure for feedback 9
for i=1:NbObjectsf(1)
    AudioInfof9(i,1).name= AudioListf9(i,1).name;
    AudioInfof9(i,1).filename= Filef9(i,1);
    AudioInfof9(i,1).word = Wordf9(i,1);
    AudioInfof9(i,1).c1= C1f9(i,1);
    AudioInfof9(i,1).c2= C2f9(i,1);
    AudioInfof9(i,1).c3= C3f9(i,1);
    AudioInfof9(i,1).c4= C4f9(i,1);
    AudioInfof9(i,1).c5= C5f9(i,1);
    AudioInfof9(i,1).c6= C6f9(i,1);
    AudioInfof9(i,1).c7= C7f9(i,1);
    AudioInfof9(i,1).c8= C8f9(i,1);
    AudioInfof9(i,1).c9= C9f9(i,1);
    AudioInfof9(i,1).c10= C10f9(i,1);
    AudioInfof9(i,1).c11= C11f9(i,1);
    AudioInfof9(i,1).c12= C12f9(i,1);    
end;

% make a large structure for test 1
for i=1:NbObjectst(1)
    AudioInfot1(i,1).name= AudioListt1(i,1).name;
    AudioInfot1(i,1).filename= Filet1(i,1);
    AudioInfot1(i,1).word = Wordt1(i,1);
    AudioInfot1(i,1).c1= C1t1(i,1);
    AudioInfot1(i,1).c2= C2t1(i,1);
    AudioInfot1(i,1).c3= C3t1(i,1);
    AudioInfot1(i,1).c4= C4t1(i,1);
    AudioInfot1(i,1).c5= C5t1(i,1);
    AudioInfot1(i,1).c6= C6t1(i,1);
    AudioInfot1(i,1).c7= C7t1(i,1);
    AudioInfot1(i,1).c8= C8t1(i,1);
    AudioInfot1(i,1).c9= C9t1(i,1);
    AudioInfot1(i,1).c10= C10t1(i,1);
    AudioInfot1(i,1).c11= C11t1(i,1);
    AudioInfot1(i,1).c12= C12t1(i,1);    
end;

% make a large structure for test 2
for i=1:NbObjectst(1)
    AudioInfot2(i,1).name= AudioListt2(i,1).name;
    AudioInfot2(i,1).filename= Filet2(i,1);
    AudioInfot2(i,1).word = Wordt2(i,1);
    AudioInfot2(i,1).c1= C1t2(i,1);
    AudioInfot2(i,1).c2= C2t2(i,1);
    AudioInfot2(i,1).c3= C3t2(i,1);
    AudioInfot2(i,1).c4= C4t2(i,1);
    AudioInfot2(i,1).c5= C5t2(i,1);
    AudioInfot2(i,1).c6= C6t2(i,1);
    AudioInfot2(i,1).c7= C7t2(i,1);
    AudioInfot2(i,1).c8= C8t2(i,1);
    AudioInfot2(i,1).c9= C9t2(i,1);
    AudioInfot2(i,1).c10= C10t2(i,1);
    AudioInfot2(i,1).c11= C11t2(i,1);
    AudioInfot2(i,1).c12= C12t2(i,1);    
end;

% make a large structure for test 3
for i=1:NbObjectst(1)
    AudioInfot3(i,1).name= AudioListt3(i,1).name;
    AudioInfot3(i,1).filename= Filet3(i,1);
    AudioInfot3(i,1).word = Wordt3(i,1);
    AudioInfot3(i,1).c1= C1t3(i,1);
    AudioInfot3(i,1).c2= C2t3(i,1);
    AudioInfot3(i,1).c3= C3t3(i,1);
    AudioInfot3(i,1).c4= C4t3(i,1);
    AudioInfot3(i,1).c5= C5t3(i,1);
    AudioInfot3(i,1).c6= C6t3(i,1);
    AudioInfot3(i,1).c7= C7t3(i,1);
    AudioInfot3(i,1).c8= C8t3(i,1);
    AudioInfot3(i,1).c9= C9t3(i,1);
    AudioInfot3(i,1).c10= C10t3(i,1);
    AudioInfot3(i,1).c11= C11t3(i,1);
    AudioInfot3(i,1).c12= C12t3(i,1);    
end;

% make a large structure for test 4
for i=1:NbObjectst(1)
    AudioInfot4(i,1).name= AudioListt4(i,1).name;
    AudioInfot4(i,1).filename= Filet4(i,1);
    AudioInfot4(i,1).word = Wordt4(i,1);
    AudioInfot4(i,1).c1= C1t4(i,1);
    AudioInfot4(i,1).c2= C2t4(i,1);
    AudioInfot4(i,1).c3= C3t4(i,1);
    AudioInfot4(i,1).c4= C4t4(i,1);
    AudioInfot4(i,1).c5= C5t4(i,1);
    AudioInfot4(i,1).c6= C6t4(i,1);
    AudioInfot4(i,1).c7= C7t4(i,1);
    AudioInfot4(i,1).c8= C8t4(i,1);
    AudioInfot4(i,1).c9= C9t4(i,1);
    AudioInfot4(i,1).c10= C10t4(i,1);
    AudioInfot4(i,1).c11= C11t4(i,1);
    AudioInfot4(i,1).c12= C12t4(i,1);    
end;

%% Now let's randomize each lists

% RANDOMIZE the audio list f1    
rAudioInfof1 = AudioInfof1;
[nrows,ncols]=size(rAudioInfof1);              %#ok<*NASGU> % get size of input matrix
cnt = 10*nrows;                             % enough times
while (cnt > 0)
    pos1 = 1+fix(nrows*rand);               % get first random row
    pos2 = 1+fix(nrows*rand);               % get second random row
    tmp = rAudioInfof1(pos1,:);               % save first row
    rAudioInfof1(pos1,:) = rAudioInfof1(pos2,:);% swap second into first
    rAudioInfof1(pos2,:) = tmp;               % move first into second
    cnt=cnt-1;
end;
finalrAudioInfof1 = rAudioInfof1;                 % return randomised table


% RANDOMIZE the audio list f2    
rAudioInfof2 = AudioInfof2;
[nrows,ncols]=size(rAudioInfof2);             % get size of input matrix
cnt = 10*nrows;                             % enough times
while (cnt > 0)
    pos1 = 1+fix(nrows*rand);               % get first random row
    pos2 = 1+fix(nrows*rand);               % get second random row
    tmp = rAudioInfof2(pos1,:);               % save first row
    rAudioInfof2(pos1,:) = rAudioInfof2(pos2,:);% swap second into first
    rAudioInfof2(pos2,:) = tmp;               % move first into second
    cnt=cnt-1;
end;
finalrAudioInfof2 = rAudioInfof2;                 % return randomised table

% RANDOMIZE the audio list f3    
rAudioInfof3 = AudioInfof3;
[nrows,ncols]=size(rAudioInfof3);             % get size of input matrix
cnt = 10*nrows;                             % enough times
while (cnt > 0)
    pos1 = 1+fix(nrows*rand);               % get first random row
    pos2 = 1+fix(nrows*rand);               % get second random row
    tmp = rAudioInfof3(pos1,:);               % save first row
    rAudioInfof3(pos1,:) = rAudioInfof3(pos2,:);% swap second into first
    rAudioInfof3(pos2,:) = tmp;               % move first into second
    cnt=cnt-1;
end;
finalrAudioInfof3 = rAudioInfof3;                 % return randomised table

% RANDOMIZE the audio list f4    
rAudioInfof4 = AudioInfof4;
[nrows,ncols]=size(rAudioInfof4);             % get size of input matrix
cnt = 10*nrows;                             % enough times
while (cnt > 0)
    pos1 = 1+fix(nrows*rand);               % get first random row
    pos2 = 1+fix(nrows*rand);               % get second random row
    tmp = rAudioInfof4(pos1,:);               % save first row
    rAudioInfof4(pos1,:) = rAudioInfof4(pos2,:);% swap second into first
    rAudioInfof4(pos2,:) = tmp;               % move first into second
    cnt=cnt-1;
end;
finalrAudioInfof4 = rAudioInfof4;                 % return randomised table

% RANDOMIZE the audio list f5    
rAudioInfof5 = AudioInfof5;
[nrows,ncols]=size(rAudioInfof5);             % get size of input matrix
cnt = 10*nrows;                             % enough times
while (cnt > 0)
    pos1 = 1+fix(nrows*rand);               % get first random row
    pos2 = 1+fix(nrows*rand);               % get second random row
    tmp = rAudioInfof5(pos1,:);               % save first row
    rAudioInfof5(pos1,:) = rAudioInfof5(pos2,:);% swap second into first
    rAudioInfof5(pos2,:) = tmp;               % move first into second
    cnt=cnt-1;
end;
finalrAudioInfof5=rAudioInfof5;                 % return randomised table

% RANDOMIZE the audio list f6    
rAudioInfof6 = AudioInfof6;
[nrows,ncols]=size(rAudioInfof6);             % get size of input matrix
cnt = 10*nrows;                             % enough times
while (cnt > 0)
    pos1 = 1+fix(nrows*rand);               % get first random row
    pos2 = 1+fix(nrows*rand);               % get second random row
    tmp = rAudioInfof6(pos1,:);               % save first row
    rAudioInfof6(pos1,:) = rAudioInfof6(pos2,:);% swap second into first
    rAudioInfof6(pos2,:) = tmp;               % move first into second
    cnt=cnt-1;
end;
finalrAudioInfof6=rAudioInfof6;                 % return randomised table

% RANDOMIZE the audio list f7    
rAudioInfof7 = AudioInfof7;
[nrows,ncols]=size(rAudioInfof7);             % get size of input matrix
cnt = 10*nrows;                             % enough times
while (cnt > 0)
    pos1 = 1+fix(nrows*rand);               % get first random row
    pos2 = 1+fix(nrows*rand);               % get second random row
    tmp = rAudioInfof7(pos1,:);               % save first row
    rAudioInfof7(pos1,:) = rAudioInfof7(pos2,:);% swap second into first
    rAudioInfof7(pos2,:) = tmp;               % move first into second
    cnt=cnt-1;
end;
finalrAudioInfof7=rAudioInfof7;                 % return randomised table

% RANDOMIZE the audio list f8    
rAudioInfof8 = AudioInfof8;
[nrows,ncols]=size(rAudioInfof8);             % get size of input matrix
cnt = 10*nrows;                             % enough times
while (cnt > 0)
    pos1 = 1+fix(nrows*rand);               % get first random row
    pos2 = 1+fix(nrows*rand);               % get second random row
    tmp = rAudioInfof8(pos1,:);               % save first row
    rAudioInfof8(pos1,:) = rAudioInfof8(pos2,:);% swap second into first
    rAudioInfof8(pos2,:) = tmp;               % move first into second
    cnt=cnt-1;
end;
finalrAudioInfof8=rAudioInfof8;                 % return randomised table

% RANDOMIZE the audio list f9    
rAudioInfof9 = AudioInfof9;
[nrows,ncols]=size(rAudioInfof9);             % get size of input matrix
cnt = 10*nrows;                             % enough times
while (cnt > 0)
    pos1 = 1+fix(nrows*rand);               % get first random row
    pos2 = 1+fix(nrows*rand);               % get second random row
    tmp = rAudioInfof9(pos1,:);               % save first row
    rAudioInfof9(pos1,:) = rAudioInfof9(pos2,:);% swap second into first
    rAudioInfof9(pos2,:) = tmp;               % move first into second
    cnt=cnt-1;
end;
finalrAudioInfof9=rAudioInfof9;                 % return randomised table

% RANDOMIZE the audio list t1    
rAudioInfot1 = AudioInfot1;
[nrows,ncols]=size(rAudioInfot1);             % get size of input matrix
cnt = 10*nrows;                             % enough times
while (cnt > 0)
    pos1 = 1+fix(nrows*rand);               % get first random row
    pos2 = 1+fix(nrows*rand);               % get second random row
    tmp = rAudioInfot1(pos1,:);               % save first row
    rAudioInfot1(pos1,:) = rAudioInfot1(pos2,:);% swap second into first
    rAudioInfot1(pos2,:) = tmp;               % move first into second
    cnt=cnt-1;
end;
finalrAudioInfot1=rAudioInfot1;                 % return randomised table

% RANDOMIZE the audio list t2    
rAudioInfot2 = AudioInfot2;
[nrows,ncols]=size(rAudioInfot2);             % get size of input matrix
cnt = 10*nrows;                             % enough times
while (cnt > 0)
    pos1 = 1+fix(nrows*rand);               % get first random row
    pos2 = 1+fix(nrows*rand);               % get second random row
    tmp = rAudioInfot2(pos1,:);               % save first row
    rAudioInfot2(pos1,:) = rAudioInfot2(pos2,:);% swap second into first
    rAudioInfot2(pos2,:) = tmp;               % move first into second
    cnt=cnt-1;
end;
finalrAudioInfot2=rAudioInfot2;                 % return randomised table

% RANDOMIZE the audio list t3    
rAudioInfot3 = AudioInfot3;
[nrows,ncols]=size(rAudioInfot3);             % get size of input matrix
cnt = 10*nrows;                             % enough times
while (cnt > 0)
    pos1 = 1+fix(nrows*rand);               % get first random row
    pos2 = 1+fix(nrows*rand);               % get second random row
    tmp = rAudioInfot3(pos1,:);               % save first row
    rAudioInfot3(pos1,:) = rAudioInfot3(pos2,:);% swap second into first
    rAudioInfot3(pos2,:) = tmp;               % move first into second
    cnt=cnt-1;
end;
finalrAudioInfot3=rAudioInfot3;                 % return randomised table

% RANDOMIZE the audio list t4    
rAudioInfot4 = AudioInfot4;
[nrows,ncols]=size(rAudioInfot4);             % get size of input matrix
cnt = 10*nrows;                             % enough times
while (cnt > 0)
    pos1 = 1+fix(nrows*rand);               % get first random row
    pos2 = 1+fix(nrows*rand);               % get second random row
    tmp = rAudioInfot4(pos1,:);               % save first row
    rAudioInfot4(pos1,:) = rAudioInfot4(pos2,:);% swap second into first
    rAudioInfot4(pos2,:) = tmp;               % move first into second
    cnt=cnt-1;
end;
finalrAudioInfot4=rAudioInfot4;                 % return randomised table

%% Let's organize the data into one REALLY large structure now that it is 
% randomized. 

% Let's preallocate space for our large stucture
GLOBALAUDIOINFOT=cell(num_test,4);
GLOBALAUDIOINFOF=cell(num_fb,9);

% Large Sturcture for test blocks
for i=1:num_test
    GLOBALAUDIOINFOT{i,1}=finalrAudioInfot1(i);
    GLOBALAUDIOINFOT{i,2}=finalrAudioInfot2(i);
    GLOBALAUDIOINFOT{i,3}=finalrAudioInfot3(i);
    GLOBALAUDIOINFOT{i,4}=finalrAudioInfot4(i);
end

% Large Structure for feedback blocks
for i=1:num_fb
    GLOBALAUDIOINFOF{i,1}=finalrAudioInfof1(i);
    GLOBALAUDIOINFOF{i,2}=finalrAudioInfof2(i);
    GLOBALAUDIOINFOF{i,3}=finalrAudioInfof3(i);
    GLOBALAUDIOINFOF{i,4}=finalrAudioInfof4(i);
    GLOBALAUDIOINFOF{i,5}=finalrAudioInfof5(i);
    GLOBALAUDIOINFOF{i,6}=finalrAudioInfof6(i);
    GLOBALAUDIOINFOF{i,7}=finalrAudioInfof7(i);
    GLOBALAUDIOINFOF{i,8}=finalrAudioInfof8(i);
    GLOBALAUDIOINFOF{i,9}=finalrAudioInfof9(i);
end

%% We made a lot of useless variables recently - so let's clear variables we no longer need
clear finalrAudioInfof1 finalrAudioInfof2 finalrAudioInfof3 finalrAudioInfof4 ...
    finalrAudioInfof5 finalrAudioInfof6 finalrAudioInfof7 finalrAudioInfof8 ...
    finalrAudioInfof9 finalrAudioInfot1 finalrAudioInfot2 finalrAudioInfot3 ...
    finalrAudioInfot4

clear rAudioInfof1 rAudioInfof2 rAudioInfof3 rAudioInfof4 rAudioInfof5 rAudioInfof6...
    rAudioInfof7 rAudioInfof8 rAudioInfof9 rAudioInfot1 rAudioInfot2 rAudioInfot3 ...
    rAudioInfot4

clear AudioInfof1 AudioInfof2 AudioInfof3 AudioInfof4 AudioInfof5 AudioInfof6...
    AudioInfof7 AudioInfof8 AudioInfof9 AudioInfot1 AudioInfot2 AudioInfot3 ...
    AudioInfot4

clear C1f1 C2f1 C3f1 C4f1 C5f1 C6f1 C7f1 C8f1 C9f1 C10f1 C11f1 C12f1 ...
    C1f2 C2f2 C3f2 C4f2 C5f2 C6f2 C7f2 C8f2 C9f2 C10f2 C11f2 C12f2 ...
    C1f3 C2f3 C3f3 C4f3 C5f3 C6f3 C7f3 C8f3 C9f3 C10f3 C11f3 C12f3 ...
    C1f4 C2f4 C3f4 C4f4 C5f4 C6f4 C7f4 C8f4 C9f4 C10f4 C11f4 C12f4 ...
    C1f5 C2f5 C3f5 C4f5 C5f5 C6f5 C7f5 C8f5 C9f5 C10f5 C11f5 C12f5 ...
    C1f6 C2f6 C3f6 C4f6 C5f6 C6f6 C7f6 C8f6 C9f6 C10f6 C11f6 C12f6 ...
    C1f7 C2f7 C3f7 C4f7 C5f7 C6f7 C7f7 C8f7 C9f7 C10f7 C11f7 C12f7 ...
    C1f8 C2f8 C3f8 C4f8 C5f8 C6f8 C7f8 C8f8 C9f8 C10f8 C11f8 C12f8 ...
    C1f9 C2f9 C3f9 C4f9 C5f9 C6f9 C7f9 C8f9 C9f9 C10f9 C11f9 C12f9 ...
    C1t1 C2t1 C3t1 C4t1 C5t1 C6t1 C7t1 C8t1 C9t1 C10t1 C11t1 C12t1 ...
    C1t2 C2t2 C3t2 C4t2 C5t2 C6t2 C7t2 C8t2 C9t2 C10t2 C11t2 C12t2 ...
    C1t3 C2t3 C3t3 C4t3 C5t3 C6t3 C7t3 C8t3 C9t3 C10t3 C11t3 C12t3 ...
    C1t4 C2t4 C3t4 C4t4 C5t4 C6t4 C7t4 C8t4 C9t4 C10t4 C11t4 C12t4 ...
    
clear Filef1 Wordf1 Filef2 Wordf2 Filef3 Wordf3 Filef4 Wordf4 Filef5 Wordf5 ...
    Filef6 Wordf6 Filef7 Wordf7 Filef8 Wordf8 Filef9 Wordf9 Filet1 Wordt1 ...
    Filet2 Wordt2 Filet3 Wordt3 Filet4 Wordt4

clear feedback1data feedback2data feedback3data feedback4data feedback5data...
    feedback6data feedback7data feedback8data feedback9data test1data test2data...
    test3data test4data

clear AudioListf1 AudioListf2 AudioListf3 AudioListf4 AudioListf5 AudioListf6 AudioListf7...
    AudioListf8 AudioListf9 AudioListt1 AudioListt2 AudioListt3 AudioListt4

%% Preliminary settings
% Let's preallocate where data will be stores and later saved
WordData=cell(sum(numoftrials),12);
xlswrite(filename,WordData);

% Wait for release of all keys on keyboard:
KbReleaseWait;

% open the audio device
pahandle = PsychPortAudio('Open', [], [], 1, Fs, 2);

% Set the first trial to be number 1
TrialNum = 1;


try
%%  GENERAL INSTRUCTIONS

% We inserted a Try function here incase there are problems in running the
% screen function.  This helps us get back to the matlab prompt if a
% problem is encountered without crashing Matlab!!!

% Open PTB and set screen to background color
HideCursor;
backgroundcolor=[0 0 0];
textcolor=[200 200 200];
Screen('Preference', 'ConserveVRAM', 4096);
[w rect]=Screen('OpenWindow',1,1);  %setting second arg to '1' for dual monitors, '0' if using single monitor
theX=rect(3)/2;                     %use as X value for vis stim
theY=rect(4)/2;                     %use as Y value for vis stim
Screen('FillRect', w, backgroundcolor,rect);
Screen('Flip',w);
'launching PTB= ok';

% load instructions
clear Instructionlines;
Instructionlines=importdata ([inputfolder InstructionFilesList(1).name]);
Instruction_Display(w,theX,theY,backgroundcolor,textcolor,Instructionlines);

clear Instructionlines;
Instructionlines=importdata ([inputfolder InstructionFilesList(2).name]);
Instruction_Display(w,theX,theY,backgroundcolor,textcolor,Instructionlines);

clear Instructionlines;
Instructionlines=importdata ([inputfolder InstructionFilesList(3).name]);
Instruction_Display(w,theX,theY,backgroundcolor,textcolor,Instructionlines);

clear Instructionlines;
Instructionlines=importdata ([inputfolder InstructionFilesList(4).name]);
Instruction_Display(w,theX,theY,backgroundcolor,textcolor,Instructionlines);

clear Instructionlines;
Instructionlines=importdata ([inputfolder InstructionFilesList(5).name]);
Instruction_Display(w,theX,theY,backgroundcolor,textcolor,Instructionlines);

% reset screen
Screen('FillRect',w,backgroundcolor);
Screen('Flip',w);

%% Tell Netstation the next block is beginning

tstart = GetSecs;
NetStation('Event' ,'STAR' , tstart, 1, 'STAR'); 

%% PreTest

% load wav files via GLOBALAUDIOINFO
    
for j=1:NbObjectst(1)
    [rsynth Fs]= wavread([inputfolder 't' num2str(pretest) '/' GLOBALAUDIOINFOT{j,pretest}.name]);

    WAVWord{j,1}= zeros(length(rsynth)+Fs*4,1);
    WAVWord{j,1}(1:length(rsynth))=rsynth;

    [WAVWord{j,2}] = GLOBALAUDIOINFOT{j,pretest}.name;
    [WAVWord{j,3}] = GLOBALAUDIOINFOT{j,pretest}.filename;
    [WAVWord{j,4}] = GLOBALAUDIOINFOT{j,pretest}.word;
    [WAVWord{j,5}] = GLOBALAUDIOINFOT{j,pretest}.c1;
    [WAVWord{j,6}] = GLOBALAUDIOINFOT{j,pretest}.c2;
    [WAVWord{j,7}] = GLOBALAUDIOINFOT{j,pretest}.c3;
    [WAVWord{j,8}] = GLOBALAUDIOINFOT{j,pretest}.c4;
    [WAVWord{j,9}] = GLOBALAUDIOINFOT{j,pretest}.c5;
    [WAVWord{j,10}] = GLOBALAUDIOINFOT{j,pretest}.c6;
    [WAVWord{j,11}] = GLOBALAUDIOINFOT{j,pretest}.c7;
    [WAVWord{j,12}] = GLOBALAUDIOINFOT{j,pretest}.c8;
    [WAVWord{j,13}] = GLOBALAUDIOINFOT{j,pretest}.c9;
    [WAVWord{j,14}] = GLOBALAUDIOINFOT{j,pretest}.c10;
    [WAVWord{j,15}] = GLOBALAUDIOINFOT{j,pretest}.c11;
    [WAVWord{j,16}] = GLOBALAUDIOINFOT{j,pretest}.c12;
end;

% Pretest is now starting... 
for i=1:(NbObjectst(1))
    
    % create the wavedata
    wavedata= ...
        [ WAVWord{i,1}' ; ...
        WAVWord{i,1}' ];

    % define trial specific information
    Trialspecificname=WAVWord{i,2};
    Trialspecificfilename=WAVWord{i,3};
    Trialspecificword=WAVWord{i,4};
    for k = 1:size(WAVWord,2)-3
        PossWords(1,k) = WAVWord{i,k+3};
    end


    % Fill the audio playback buffer with the audio data 'wavedata':
    PsychPortAudio('FillBuffer', pahandle, wavedata);

    % Fixation step for 1 secs
    Screen('TextSize', w, 32);
    Screen('Drawtext', w, '+', theX,theY,255);
    Screen('Flip',w);
    WaitSecs(1);

    % Clear screen and wait for 1/2 sec before playing the sound
    Screen('Flip',w);      
    WaitSecs(.5);

    % Wait for release of all keys on keyboard:
    KbReleaseWait;
    
    % Synchronize NetStation and then play the sound!!
    NetStation('Synchronize');
    t1 = GetSecs + 1;
    starttime = PsychPortAudio('Start', pahandle, 1, t1, 1);
   
    WaitSecs(1);
    
    % Stop playback:
    PsychPortAudio('Stop', pahandle);
    
    % Set Text size for when subjects respond
    Screen('TextSize',w,32);
    
    % Hide Cursor and then Get Cursor ready then flip to see it.
    HideCursor;
    Screen('DrawText', w, '_', theX,theY,255);
    Screen('Flip', w);
    
    % Set keys so subjects can actually type
    keylist=zeros(256,1);
    keylist(65:90)=1;
    keylist(KbName('return'))=1;
    keylist(KbName('backspace'))=1;
    KbQueueCreate([],keylist);

    % Collect Response
    returnPressed=0;
    enteredText=[];

    while returnPressed==0
        KbQueueFlush;
        KbQueueStart;
        pressed=0;
        while pressed==0;
            [pressed firstpressed]=KbQueueCheck;
        end
        [a response]=max(firstpressed);
        if strcmp(KbName(response),'return');
        returnPressed=1;
        elseif strcmp(KbName(response),'backspace') && ~isempty(enteredText);
            if length(enteredText)>1;    
                enteredText=enteredText(1:length(enteredText)-1);
            else
                enteredText=[];
            end
        else
            enteredText=[enteredText KbName(response)];
        end
        if ~isempty(enteredText);
            Screen('DrawText', w, [enteredText '_'], theX,theY,255);
            Screen('Flip', w);
        else
            Screen('Flip',w);
        end
    end


   % Save Response, check if correct
   Trialspecificresponse = enteredText;

    TF = strncmp(Trialspecificresponse,PossWords,6);
    if find(TF==1)~=0
        condition='C';
    else
        condition='M';
    end
    
   % Send appropriate tag to Netstation
   switch condition
     case 'C'
        NetStation('Event' ,'ST1C' ,starttime, 1, 'ST1C', i);      
	 case 'M'
        NetStation('Event' ,'ST1M' ,starttime, 1, 'ST1M', i);
   end;
   
    % Show Progress in other monitor
    disp(TrialNum);
    disp(Trialspecificword);
    disp(enteredText);
    disp(condition);
    disp(starttime);
    disp(t1);

    % Write Data for Trial to Global Data Sheet to save
    WordData{TrialNum,1}= subject;
    WordData{TrialNum,2}= TrialNum;
    WordData{TrialNum,3}= ['t' num2str(pretest)];
    WordData{TrialNum,4}= Trialspecificname;
    WordData{TrialNum,5}= char(Trialspecificfilename);
    WordData{TrialNum,6}= char(Trialspecificword);
    WordData{TrialNum,7}= char(Trialspecificresponse);
    WordData{TrialNum,8}= starttime; %initial onset of word
    WordData{TrialNum,10}=t1;
    WordData{TrialNum,12}= char(condition);
    
    % Increment trial index
    TrialNum=TrialNum + 1;

    %isi
    WaitSecs(.5);
end;


%% Let's end this block
drawnow;

% Save data so far
xlswrite(filename,WordData);

% Clear the audio buffer
clear WAVWord wavedata

% Clear the screen
Screen('FillRect', w, backgroundcolor);
Screen('Flip',w);

% Send a tag to Netstation saying that the block is over!
WaitSecs(3);
tstart = GetSecs;
NetStation('Event' ,'ENDS' , tstart, 1, 'ENDS'); 

%% AWESOME BREAK for our subject!

RestrictKeysForKbCheck(8);
%Break instructions
clear Instructionlines;
Instructionlines = importdata ([inputfolder InstructionFilesList(6).name]);
Instruction_Display(w,theX,theY,backgroundcolor,textcolor,Instructionlines);

%% Send info that the next block is starting to Netstation
% So set the clock and place the tag 
tstart = GetSecs;
NetStation('Event' ,'STAR' , tstart, 1, 'STAR'); 

%% Feedback Block 1

% load wav files via GLOBALAUDIOINFO

for j=1:NbObjectsf(1)
    [rsynth Fs]= wavread([inputfolder 'f' num2str(feedbackblock1) '/' GLOBALAUDIOINFOF{j,feedbackblock1}.name]);    

    WAVWord{j,1}= zeros(length(rsynth)+Fs*4,1);
    WAVWord{j,1}(1:length(rsynth))=rsynth;

    [WAVWord{j,2}] = GLOBALAUDIOINFOF{j,feedbackblock1}.name;
    [WAVWord{j,3}] = GLOBALAUDIOINFOF{j,feedbackblock1}.filename;
    [WAVWord{j,4}] = GLOBALAUDIOINFOF{j,feedbackblock1}.word;
    [WAVWord{j,5}] = GLOBALAUDIOINFOF{j,feedbackblock1}.c1;
    [WAVWord{j,6}] = GLOBALAUDIOINFOF{j,feedbackblock1}.c2;
    [WAVWord{j,7}] = GLOBALAUDIOINFOF{j,feedbackblock1}.c3;
    [WAVWord{j,8}] = GLOBALAUDIOINFOF{j,feedbackblock1}.c4;
    [WAVWord{j,9}] = GLOBALAUDIOINFOF{j,feedbackblock1}.c5;
    [WAVWord{j,10}] = GLOBALAUDIOINFOF{j,feedbackblock1}.c6;
    [WAVWord{j,11}] = GLOBALAUDIOINFOF{j,feedbackblock1}.c7;
    [WAVWord{j,12}] = GLOBALAUDIOINFOF{j,feedbackblock1}.c8;
    [WAVWord{j,13}] = GLOBALAUDIOINFOF{j,feedbackblock1}.c9;
    [WAVWord{j,14}] = GLOBALAUDIOINFOF{j,feedbackblock1}.c10;
    [WAVWord{j,15}] = GLOBALAUDIOINFOF{j,feedbackblock1}.c11;
    [WAVWord{j,16}] = GLOBALAUDIOINFOF{j,feedbackblock1}.c12; 
end;


% Block is now starting... 
for i=1:(NbObjectsf(1))
   
    drawnow;

    % create the wavedata
    wavedata= ...
        [ WAVWord{i,1}' ; ...
        WAVWord{i,1}' ];

    % define trial specific information
    Trialspecificname=WAVWord{i,2};
    Trialspecificfilename=WAVWord{i,3};
    Trialspecificword=WAVWord{i,4};
    for k = 1:size(WAVWord,2)-3
        PossWords(1,k) = WAVWord{i,k+3};
    end

    % Fill the audio playback buffer with the audio data 'wavedata':
    PsychPortAudio('FillBuffer', pahandle, wavedata);

    % Fixation step for 1 secs
    Screen('TextSize', w, 32);
    Screen('Drawtext', w, '+', theX,theY,255);
    Screen('Flip',w);
    WaitSecs(1);

    % Clear screen and wait for 1/2 sec before playing the sound
    Screen('Flip',w);        
    WaitSecs(.5);

    % Wait for release of all keys on keyboard:
    KbReleaseWait;
    
     
    % Synchronize NetStation
    NetStation('Synchronize');
    t1 = GetSecs + 1;
    starttime = PsychPortAudio('Start', pahandle, 1, t1, 1);
    
    WaitSecs(1);
    
    % Stop playback:
    PsychPortAudio('Stop', pahandle);
    
    % Set Text size for when subjects respond
    Screen('TextSize',w,32);
    
    % Hide Cursor and then Get Cursor ready then flip to see it.
    HideCursor;
    Screen('DrawText', w, '_', theX,theY,255);
    Screen('Flip', w);
    
    % Set keys so subjects can actually type
    keylist=zeros(256,1);
    keylist(65:90)=1;
    keylist(KbName('return'))=1;
    keylist(KbName('backspace'))=1;
    KbQueueCreate([],keylist);

    % Collect Response
    returnPressed=0;
    enteredText=[];

    while returnPressed==0
        KbQueueFlush;
        KbQueueStart;
        pressed=0;
        while pressed==0;
            [pressed firstpressed]=KbQueueCheck;
        end
        [a response]=max(firstpressed);
        if strcmp(KbName(response),'return');
        returnPressed=1;
        elseif strcmp(KbName(response),'backspace') && ~isempty(enteredText);
            if length(enteredText)>1;    
                enteredText=enteredText(1:length(enteredText)-1);
            else
                enteredText=[];
            end
        else
            enteredText=[enteredText KbName(response)]; %#ok<*AGROW>
        end
        if ~isempty(enteredText);
            Screen('DrawText', w, [enteredText '_'], theX,theY,255);
            Screen('Flip', w);
        else
            Screen('Flip',w);
        end
    end


   % Save Response, check if correct
   Trialspecificresponse = enteredText;

    TF = strncmp(Trialspecificresponse,PossWords,6);
    if find(TF==1)~=0
        condition='C';
    else
        condition='M';
    end
    
   % Send appropriate Tag to Netstation 
    switch condition
     case 'C'
        NetStation('Event' ,'SF1C' ,starttime, 1, 'SF1C', i);      
     case 'M'
        NetStation('Event' ,'SF1M' ,starttime, 1, 'SF1M', i);
    end;  
    
    % Show Progress in other monitor
    disp(TrialNum);
    disp(Trialspecificword);
    disp(enteredText);
    disp(condition);
    disp(starttime);
    disp(t1);
    
    
    % This is a feedback block so we need feedback
    
    % Netstation Synch
    NetStation('Synchronize'); 
    t2 = GetSecs + 1;
    
    % Give feedback and show it
    Screen('FillRect',w,backgroundcolor);
    Screen('Flip',w);
    WaitSecs(.5);
    Screen('DrawText', w, char(Trialspecificword), theX,theY,255); 
    Screen('Flip', w);
    
    % Play word again as well 
    starttime2 = PsychPortAudio('Start', pahandle, 1, t2, 1);
   
    % Send tag to Netstation that feedback event occurred
    NetStation('Event' ,'FEF1' ,starttime2, 1, 'FEF1', i);
    WaitSecs(1);
    
    % Clear screen 
    Screen('FillRect', w, backgroundcolor);
    Screen('Flip',w);
    
    % Stop playback:
    PsychPortAudio('Stop', pahandle);
    
    % Write Data for Trial to Global Data Sheet to save
    WordData{TrialNum,1}= subject;
    WordData{TrialNum,2}= TrialNum;
    WordData{TrialNum,3}= ['f' num2str(feedbackblock1)];
    WordData{TrialNum,4}= Trialspecificname;
    WordData{TrialNum,5}= char(Trialspecificfilename);
    WordData{TrialNum,6}= char(Trialspecificword);
    WordData{TrialNum,7}= char(Trialspecificresponse);
    WordData{TrialNum,8}= starttime; % initial onset of word
    WordData{TrialNum,9}= starttime2; % onset of feedback word
    WordData{TrialNum,10}= t1;
    WordData{TrialNum,11}= t2;
    WordData{TrialNum,12}= char(condition);
  
    % Increment trial index
    TrialNum=TrialNum + 1;

    %isi
    WaitSecs(.5);
end;


%% Let's end this block
drawnow;

% Save data so far
xlswrite(filename,WordData);

% Clear the audio buffer
clear WAVWord wavedata

% Clear the screen
Screen('FillRect', w, backgroundcolor);
Screen('Flip',w);

% Send a tag to Netstation saying that the block is over!
WaitSecs(3);
tstart = GetSecs;
NetStation('Event' ,'ENDS' , tstart, 1, 'ENDS'); 

%% AWESOME BREAK for our subject!

RestrictKeysForKbCheck(8);
%Break instructions   
clear Instructionlines;
Instructionlines = importdata ([inputfolder InstructionFilesList(7).name]);
Instruction_Display(w,theX,theY,backgroundcolor,textcolor,Instructionlines);

%% Tell Netstation the next block is beginning
tstart = GetSecs;
NetStation('Event' ,'STAR' , tstart, 1, 'STAR'); 

%% Feedback Block 2

% load wav files via GLOBALAUDIOINFO

for j=1:NbObjectsf(1)
    [rsynth Fs]= wavread([inputfolder 'f' num2str(feedbackblock2) '/' GLOBALAUDIOINFOF{j,feedbackblock2}.name]);    

    WAVWord{j,1}= zeros(length(rsynth)+Fs*4,1);
    WAVWord{j,1}(1:length(rsynth))=rsynth;

    [WAVWord{j,2}] = GLOBALAUDIOINFOF{j,feedbackblock2}.name;
    [WAVWord{j,3}] = GLOBALAUDIOINFOF{j,feedbackblock2}.filename;
    [WAVWord{j,4}] = GLOBALAUDIOINFOF{j,feedbackblock2}.word;
    [WAVWord{j,5}] = GLOBALAUDIOINFOF{j,feedbackblock2}.c1;
    [WAVWord{j,6}] = GLOBALAUDIOINFOF{j,feedbackblock2}.c2;
    [WAVWord{j,7}] = GLOBALAUDIOINFOF{j,feedbackblock2}.c3;
    [WAVWord{j,8}] = GLOBALAUDIOINFOF{j,feedbackblock2}.c4;
    [WAVWord{j,9}] = GLOBALAUDIOINFOF{j,feedbackblock2}.c5;
    [WAVWord{j,10}] = GLOBALAUDIOINFOF{j,feedbackblock2}.c6;
    [WAVWord{j,11}] = GLOBALAUDIOINFOF{j,feedbackblock2}.c7;
    [WAVWord{j,12}] = GLOBALAUDIOINFOF{j,feedbackblock2}.c8;
    [WAVWord{j,13}] = GLOBALAUDIOINFOF{j,feedbackblock2}.c9;
    [WAVWord{j,14}] = GLOBALAUDIOINFOF{j,feedbackblock2}.c10;
    [WAVWord{j,15}] = GLOBALAUDIOINFOF{j,feedbackblock2}.c11;
    [WAVWord{j,16}] = GLOBALAUDIOINFOF{j,feedbackblock2}.c12; 
end;


% Block is now starting...
for i=1:(NbObjectsf(1))
    
    drawnow;
    
    % create the wavedata
    wavedata= ...
        [ WAVWord{i,1}' ; ...
        WAVWord{i,1}' ];

    % define trial specific information
    Trialspecificname=WAVWord{i,2};
    Trialspecificfilename=WAVWord{i,3};
    Trialspecificword=WAVWord{i,4};
    for k = 1:size(WAVWord,2)-3
        PossWords(1,k) = WAVWord{i,k+3};
    end

    % Fill the audio playback buffer with the audio data 'wavedata':
    PsychPortAudio('FillBuffer', pahandle, wavedata);

    % Fixation step for 1 secs
    Screen('TextSize', w, 32);
    Screen('Drawtext', w, '+', theX,theY,255);
    Screen('Flip',w);
    WaitSecs(1);

    % Clear screen and wait for 1/2 sec before playing the sound
    Screen('Flip',w);        
    WaitSecs(.5);

    % Wait for release of all keys on keyboard:
    KbReleaseWait;
    
      
    % Synchronize NetStation
    NetStation('Synchronize');
    t1 = GetSecs + 1;
    starttime = PsychPortAudio('Start', pahandle, 1, t1, 1);
    
    WaitSecs(1);
    
    % Stop playback:
    PsychPortAudio('Stop', pahandle);
    
    % Set Text size for when subjects respond
    Screen('TextSize',w,32);
    
    % Hide Cursor and then Get Cursor ready then flip to see it.
    HideCursor;
    Screen('DrawText', w, '_', theX,theY,255);
    Screen('Flip', w);
    
    % Set keys so subjects can actually type
    keylist=zeros(256,1);
    keylist(65:90)=1;
    keylist(KbName('return'))=1;
    keylist(KbName('backspace'))=1;
    KbQueueCreate([],keylist);

    % Collect Response
    returnPressed=0;
    enteredText=[];

    while returnPressed==0
        KbQueueFlush;
        KbQueueStart;
        pressed=0;
        while pressed==0;
            [pressed firstpressed]=KbQueueCheck;
        end
        [a response]=max(firstpressed);
        if strcmp(KbName(response),'return');
        returnPressed=1;
        elseif strcmp(KbName(response),'backspace') && ~isempty(enteredText);
            if length(enteredText)>1;    
                enteredText=enteredText(1:length(enteredText)-1);
            else
                enteredText=[];
            end
        else
            enteredText=[enteredText KbName(response)];
        end
        if ~isempty(enteredText);
            Screen('DrawText', w, [enteredText '_'], theX,theY,255);
            Screen('Flip', w);
        else
            Screen('Flip',w);
        end
    end

    % Save Response, check if correct
    Trialspecificresponse = enteredText;

    TF = strncmp(Trialspecificresponse,PossWords,6);
    if find(TF==1)~=0
        condition='C';
    else
        condition='M';
    end
    
    % Send appropriate Tag to Netstation
    switch condition
     case 'C'
        NetStation('Event' ,'SF2C' ,starttime, 1, 'SF2C', i);      
     case 'M'
        NetStation('Event' ,'SF2M' ,starttime, 1, 'SF2M', i);
    end;
   
    %Show Progress
    disp(TrialNum);
    disp(Trialspecificword);
    disp(enteredText);
    disp(condition);
    disp(starttime);
    disp(t1);
    
    
    % This is a feedback block so we need feedback
    
    % Netstation Synch
    NetStation('Synchronize');
    t2 = GetSecs + 1;
    
    % Give feedback and show it
    Screen('FillRect',w,backgroundcolor);
    Screen('Flip',w);
    WaitSecs(.5);
    Screen('DrawText', w, char(Trialspecificword), theX,theY,255); 
    Screen('Flip', w);
    
    % Play word again as well
    starttime2 = PsychPortAudio('Start', pahandle, 1, t2, 1);
    
    % Send tag to Netstation that feedback event occurred
    NetStation('Event' ,'FEF2' ,starttime2, 1, 'FEF2', i);
    WaitSecs(1);
    
    % Clear screen 
    Screen('FillRect', w, backgroundcolor);
    Screen('Flip',w);
    
    % Stop playback:
    PsychPortAudio('Stop', pahandle);
    
    % Write Data for Trial to Global Data Sheet to save
    WordData{TrialNum,1}= subject;
    WordData{TrialNum,2}= TrialNum;
    WordData{TrialNum,3}= ['f' num2str(feedbackblock2)];
    WordData{TrialNum,4}= Trialspecificname;
    WordData{TrialNum,5}= char(Trialspecificfilename);
    WordData{TrialNum,6}= char(Trialspecificword);
    WordData{TrialNum,7}= char(Trialspecificresponse);
    WordData{TrialNum,8}= starttime; % initial onset of word
    WordData{TrialNum,9}= starttime2; % onset of feedback word
    WordData{TrialNum,10}= t1;  
    WordData{TrialNum,11}= t2; 
    WordData{TrialNum,12}= char(condition);
    
    % Increment trial index
    TrialNum=TrialNum + 1;

    % isi
    WaitSecs(.5);
end;

%% Let's end this block 
drawnow;

% Save data so far
xlswrite(filename,WordData);

% clear audio buffer
clear WAVWord wavedata

% clear the screen
Screen('FillRect', w, backgroundcolor);
Screen('Flip',w);

% Send a tag to Netstation saying that the block is over!
WaitSecs(3);
tstart = GetSecs;
NetStation('Event' ,'ENDS' , tstart, 1, 'ENDS'); 

%% AWESOME BREAK for our subject!

RestrictKeysForKbCheck(8);
%Break instructions   
clear Instructionlines;
Instructionlines = importdata ([inputfolder InstructionFilesList(8).name]);
Instruction_Display(w,theX,theY,backgroundcolor,textcolor,Instructionlines);

%% Tell Netsation that the next block is beginning
tstart = GetSecs;
NetStation('Event' ,'STAR' , tstart, 1, 'STAR'); 

%% Feedback Block 3

% load wav files via GLOBALAUDIOINFO

for j=1:NbObjectsf(1)
    [rsynth Fs]= wavread([inputfolder 'f' num2str(feedbackblock3) '/' GLOBALAUDIOINFOF{j,feedbackblock3}.name]);    

    WAVWord{j,1}= zeros(length(rsynth)+Fs*4,1);
    WAVWord{j,1}(1:length(rsynth))=rsynth;

    [WAVWord{j,2}] = GLOBALAUDIOINFOF{j,feedbackblock3}.name;
    [WAVWord{j,3}] = GLOBALAUDIOINFOF{j,feedbackblock3}.filename;
    [WAVWord{j,4}] = GLOBALAUDIOINFOF{j,feedbackblock3}.word;
    [WAVWord{j,5}] = GLOBALAUDIOINFOF{j,feedbackblock3}.c1;
    [WAVWord{j,6}] = GLOBALAUDIOINFOF{j,feedbackblock3}.c2;
    [WAVWord{j,7}] = GLOBALAUDIOINFOF{j,feedbackblock3}.c3;
    [WAVWord{j,8}] = GLOBALAUDIOINFOF{j,feedbackblock3}.c4;
    [WAVWord{j,9}] = GLOBALAUDIOINFOF{j,feedbackblock3}.c5;
    [WAVWord{j,10}] = GLOBALAUDIOINFOF{j,feedbackblock3}.c6;
    [WAVWord{j,11}] = GLOBALAUDIOINFOF{j,feedbackblock3}.c7;
    [WAVWord{j,12}] = GLOBALAUDIOINFOF{j,feedbackblock3}.c8;
    [WAVWord{j,13}] = GLOBALAUDIOINFOF{j,feedbackblock3}.c9;
    [WAVWord{j,14}] = GLOBALAUDIOINFOF{j,feedbackblock3}.c10;
    [WAVWord{j,15}] = GLOBALAUDIOINFOF{j,feedbackblock3}.c11;
    [WAVWord{j,16}] = GLOBALAUDIOINFOF{j,feedbackblock3}.c12; 
end;

% Block is now starting...
for i=1:(NbObjectsf(1))
    
    drawnow;
    
    % create the wavedata
    wavedata= ...
        [ WAVWord{i,1}' ; ...
        WAVWord{i,1}' ];

    % define trial specific information
    Trialspecificname=WAVWord{i,2};
    Trialspecificfilename=WAVWord{i,3};
    Trialspecificword=WAVWord{i,4};
    for k = 1:size(WAVWord,2)-3
        PossWords(1,k) = WAVWord{i,k+3};
    end

    % Fill the audio playback buffer with the audio data 'wavedata':
    PsychPortAudio('FillBuffer', pahandle, wavedata)

    % Fixation step for 1 secs
    Screen('TextSize', w, 32);
    Screen('Drawtext', w, '+', theX,theY,255);
    Screen('Flip',w);
    WaitSecs(1);

    % Clear screen and wait for 1/2 sec before playing the sound
    Screen('Flip',w);        
    WaitSecs(.5);

    % Wait for release of all keys on keyboard:
    KbReleaseWait;
    
      
    % Synchronize NetStation
    NetStation('Synchronize');
    t1 = GetSecs + 1;
    starttime = PsychPortAudio('Start', pahandle, 1, t1, 1);
    
    WaitSecs(1);
    
    % Stop playback:
    PsychPortAudio('Stop', pahandle);
    
    % Set Text size for when subjects respond
    Screen('TextSize',w,32);
    
    % Hide Cursor and then Get Cursor ready then flip to see it.
    HideCursor;
    Screen('DrawText', w, '_', theX,theY,255);
    Screen('Flip', w);
    
    % Set keys so subjects can actually type
    keylist=zeros(256,1);
    keylist(65:90)=1;
    keylist(KbName('return'))=1;
    keylist(KbName('backspace'))=1;
    KbQueueCreate([],keylist);

    % Collect Response
    returnPressed=0;
    enteredText=[];

    while returnPressed==0
        KbQueueFlush;
        KbQueueStart;
        pressed=0;
        while pressed==0;
            [pressed firstpressed]=KbQueueCheck;
        end
        [a response]=max(firstpressed);
        if strcmp(KbName(response),'return');
        returnPressed=1;
        elseif strcmp(KbName(response),'backspace') && ~isempty(enteredText);
            if length(enteredText)>1;    
                enteredText=enteredText(1:length(enteredText)-1);
            else
                enteredText=[];
            end
        else
            enteredText=[enteredText KbName(response)];
        end
        if ~isempty(enteredText);
            Screen('DrawText', w, [enteredText '_'], theX,theY,255);
            Screen('Flip', w);
        else
            Screen('Flip',w);
        end
    end
    

    % Save Response, check if correct
    Trialspecificresponse = enteredText;

    TF = strncmp(Trialspecificresponse,PossWords,6);
    if find(TF==1)~=0
        condition='C';
    else
        condition='M';
    end   
    
    % Send appropriate Tag to Netstation
    switch condition
     case 'C'
        NetStation('Event' ,'SF3C' ,starttime, 1, 'SF3C', i);      
     case 'M'
        NetStation('Event' ,'SF3M' ,starttime, 1, 'SF3M', i);
    end;
        
    % Show Progress on other monitor
    disp(TrialNum);
    disp(Trialspecificword);
    disp(enteredText);
    disp(condition);
    disp(starttime);
    disp(t1);
    
    % This is a feedback block so we need feedback
    
    % Netstation synch
    NetStation('Synchronize');
    t2=GetSecs +1;
    
    % Give feedback and show it
    Screen('FillRect',w,backgroundcolor);
    Screen('Flip',w);
    WaitSecs(.5);
    Screen('DrawText', w, char(Trialspecificword), theX,theY,255); 
    Screen('Flip', w);
    
    % Play word again as well
    starttime2 = PsychPortAudio('Start', pahandle, 1, t2, 1);
    
    % Send tag to Netation that feedback event occurred
    NetStation('Event' ,'FEF3' ,starttime2, 1, 'FEF3', i);
    WaitSecs(1);
    
    % Clear screen 
    Screen('FillRect', w, backgroundcolor);
    Screen('Flip',w);
    
    % Stop playback:
    PsychPortAudio('Stop', pahandle);
    
    % Write Data for Trial to Global Data Sheet to save
    WordData{TrialNum,1}= subject;
    WordData{TrialNum,2}= TrialNum;
    WordData{TrialNum,3}= ['f' num2str(feedbackblock3)];
    WordData{TrialNum,4}= Trialspecificname;
    WordData{TrialNum,5}= char(Trialspecificfilename);
    WordData{TrialNum,6}= char(Trialspecificword);
    WordData{TrialNum,7}= char(Trialspecificresponse);
    WordData{TrialNum,8}= starttime; % initial onset of word
    WordData{TrialNum,9}= starttime2; % onset of feedback word
    WordData{TrialNum,10}= t1; % initial onset of word
    WordData{TrialNum,11}= t2; % onset of feedback word
    WordData{TrialNum,12}= char(condition);
    
    % Increment trial index
    TrialNum=TrialNum + 1;

    % ISI
    WaitSecs(.5);
end;

%% Let's end this block
drawnow;

% Save data so far
xlswrite(filename,WordData);

% Clear the audio buffer
clear WAVWord wavedata

% Clear the screen
Screen('FillRect', w, backgroundcolor);
Screen('Flip',w);

% Send a tag to Netstation saying the block is over!
WaitSecs(3);
tstart = GetSecs;
NetStation('Event' ,'ENDS' , tstart, 1, 'ENDS'); 

%% AWESOME BREAK for our subject

RestrictKeysForKbCheck(8);
%Break instructions   
clear Instructionlines;
Instructionlines = importdata ([inputfolder InstructionFilesList(9).name]);
Instruction_Display(w,theX,theY,backgroundcolor,textcolor,Instructionlines);

%% Tell Netstation the next block is beginning
tstart = GetSecs;
NetStation('Event' ,'STAR' , tstart, 1, 'STAR'); 


%% Feedback Block 4

% load wav files via GLOBALAUDIOINFO

for j=1:NbObjectsf(1)
    [rsynth Fs]= wavread([inputfolder 'f' num2str(feedbackblock4) '/' GLOBALAUDIOINFOF{j,feedbackblock4}.name]);    

    WAVWord{j,1}= zeros(length(rsynth)+Fs*4,1);
    WAVWord{j,1}(1:length(rsynth))=rsynth;

    [WAVWord{j,2}] = GLOBALAUDIOINFOF{j,feedbackblock4}.name;
    [WAVWord{j,3}] = GLOBALAUDIOINFOF{j,feedbackblock4}.filename;
    [WAVWord{j,4}] = GLOBALAUDIOINFOF{j,feedbackblock4}.word;
    [WAVWord{j,5}] = GLOBALAUDIOINFOF{j,feedbackblock4}.c1;
    [WAVWord{j,6}] = GLOBALAUDIOINFOF{j,feedbackblock4}.c2;
    [WAVWord{j,7}] = GLOBALAUDIOINFOF{j,feedbackblock4}.c3;
    [WAVWord{j,8}] = GLOBALAUDIOINFOF{j,feedbackblock4}.c4;
    [WAVWord{j,9}] = GLOBALAUDIOINFOF{j,feedbackblock4}.c5;
    [WAVWord{j,10}] = GLOBALAUDIOINFOF{j,feedbackblock4}.c6;
    [WAVWord{j,11}] = GLOBALAUDIOINFOF{j,feedbackblock4}.c7;
    [WAVWord{j,12}] = GLOBALAUDIOINFOF{j,feedbackblock4}.c8;
    [WAVWord{j,13}] = GLOBALAUDIOINFOF{j,feedbackblock4}.c9;
    [WAVWord{j,14}] = GLOBALAUDIOINFOF{j,feedbackblock4}.c10;
    [WAVWord{j,15}] = GLOBALAUDIOINFOF{j,feedbackblock4}.c11;
    [WAVWord{j,16}] = GLOBALAUDIOINFOF{j,feedbackblock4}.c12; 
end;

% Block is now starting...
for i=1:(NbObjectsf(1))
    
    drawnow;
    
    % create the wavedata
    wavedata= ...
        [ WAVWord{i,1}' ; ...
        WAVWord{i,1}' ];

    % define trial specific information
    Trialspecificname=WAVWord{i,2};
    Trialspecificfilename=WAVWord{i,3};
    Trialspecificword=WAVWord{i,4};
    for k = 1:size(WAVWord,2)-3
        PossWords(1,k) = WAVWord{i,k+3};
    end

    % Fill the audio playback buffer with the audio data 'wavedata':
    PsychPortAudio('FillBuffer', pahandle, wavedata);

    % Fixation step for 1 secs
    Screen('TextSize', w, 32);
    Screen('Drawtext', w, '+', theX,theY,255);
    Screen('Flip',w);
    WaitSecs(1);

    % Clear screen and wait for 1/2 sec before playing the sound
    Screen('Flip',w);        
    WaitSecs(.5);

    % Wait for release of all keys on keyboard:
    KbReleaseWait;
    
    
    % Synchronize NetStation
    NetStation('Synchronize');
    t1 = GetSecs + 1;
    starttime = PsychPortAudio('Start', pahandle, 1, t1, 1);
    
    WaitSecs(1);
    
    % Stop playback:
    PsychPortAudio('Stop', pahandle);
    
    % Set Text size for when subjects respond
    Screen('TextSize',w,32);
    
    % Hide Cursor and then Get Cursor ready then flip to see it.
    HideCursor;
    Screen('DrawText', w, '_', theX,theY,255);
    Screen('Flip', w);
    
    % Set keys so subjects can actually type
    keylist=zeros(256,1);
    keylist(65:90)=1;
    keylist(KbName('return'))=1;
    keylist(KbName('backspace'))=1;
    KbQueueCreate([],keylist);

    % Collect Response
    returnPressed=0;
    enteredText=[];

    while returnPressed==0
        KbQueueFlush;
        KbQueueStart;
        pressed=0;
        while pressed==0;
            [pressed firstpressed]=KbQueueCheck;
        end
        [a response]=max(firstpressed);
        if strcmp(KbName(response),'return');
        returnPressed=1;
        elseif strcmp(KbName(response),'backspace') && ~isempty(enteredText);
            if length(enteredText)>1;    
                enteredText=enteredText(1:length(enteredText)-1);
            else
                enteredText=[];
            end
        else
            enteredText=[enteredText KbName(response)];
        end
        if ~isempty(enteredText);
            Screen('DrawText', w, [enteredText '_'], theX,theY,255);
            Screen('Flip', w);
        else
            Screen('Flip',w);
        end
    end   

    
    % Save Response
    Trialspecificresponse = enteredText;
    
    TF = strncmp(Trialspecificresponse,PossWords,6);
    if find(TF==1)~=0
        condition='C';
    else
        condition='M';
    end
    
    % Send appropriate Tag to Netstation
    switch condition
     case 'C'
        NetStation('Event' ,'SF4C' ,starttime, 1, 'SF4C', i);      
	 case 'M'
        NetStation('Event' ,'SF4M' ,starttime, 1, 'SF4M', i);
    end; 
    
    %Show Progress in other monitor
    disp(TrialNum);
    disp(Trialspecificword);
    disp(enteredText);
    disp(condition);
    disp(starttime);
    disp(t1);
    
    % This is a feedback block so we need feedback
    
    % Netstation Synch
    NetStation('Synchronize');
    t2 = GetSecs +1;
    
    % Give feedback and show it
    Screen('FillRect',w,backgroundcolor);
    Screen('Flip',w);
    WaitSecs(.5);
    Screen('DrawText', w, char(Trialspecificword), theX,theY,255); 
    Screen('Flip', w);
    
    % Play word again as well
    starttime2 = PsychPortAudio('Start', pahandle, 1, t2, 1);
    
    % Send tag to Netstation that feedback event occurred
    NetStation('Event' ,'FEF4' ,starttime2, 1, 'FEF4', i);
    WaitSecs(1);
    
    % Clear screen 
    Screen('FillRect', w, backgroundcolor);
    Screen('Flip',w);
    
    % Stop playback:
    PsychPortAudio('Stop', pahandle);

    % Write Data for Trial to Global Data Sheet to save
    WordData{TrialNum,1}= subject;
    WordData{TrialNum,2}= TrialNum;
    WordData{TrialNum,3}= ['f' num2str(feedbackblock4)];
    WordData{TrialNum,4}= Trialspecificname;
    WordData{TrialNum,5}= char(Trialspecificfilename);
    WordData{TrialNum,6}= char(Trialspecificword);
    WordData{TrialNum,7}= char(Trialspecificresponse);
    WordData{TrialNum,8}= starttime; % initial onset of word
    WordData{TrialNum,9}= starttime2; % onset of feedback word
    WordData{TrialNum,10}= t1;  
    WordData{TrialNum,11}= t2;
    WordData{TrialNum,12}= char(condition);
   
    % Increment trial index
    TrialNum=TrialNum + 1;

    % ISI
    WaitSecs(.5);
end;

%% Lets end this block
drawnow;

% Save data so far
xlswrite(filename,WordData);

% Clear WavWord Buffer
clear WAVWord wavedata

% Clear the screen
Screen('FillRect', w, backgroundcolor);
Screen('Flip',w);

% Send tag to Netstation saying that the block is over!
WaitSecs(3);
tstart = GetSecs;
NetStation('Event' ,'ENDS' , tstart, 1, 'ENDS'); 

%% AWESOME BREAK for our subject!

RestrictKeysForKbCheck(8);
%Break instructions   
clear Instructionlines;
Instructionlines = importdata ([inputfolder InstructionFilesList(10).name]);
Instruction_Display(w,theX,theY,backgroundcolor,textcolor,Instructionlines);

%% Tell Netstation that next block is beginning
tstart = GetSecs;
NetStation('Event' ,'STAR' , tstart, 1, 'STAR'); 

%% Feedback Block 5

% load wav files for t1 via final - now randomized - Audio List order

for j=1:NbObjectsf(1)
    [rsynth Fs]= wavread([inputfolder 'f' num2str(feedbackblock5) '/' GLOBALAUDIOINFOF{j,feedbackblock5}.name]);    

    WAVWord{j,1}= zeros(length(rsynth)+Fs*4,1);
    WAVWord{j,1}(1:length(rsynth))=rsynth;

    [WAVWord{j,2}] = GLOBALAUDIOINFOF{j,feedbackblock5}.name;
    [WAVWord{j,3}] = GLOBALAUDIOINFOF{j,feedbackblock5}.filename;
    [WAVWord{j,4}] = GLOBALAUDIOINFOF{j,feedbackblock5}.word;
    [WAVWord{j,5}] = GLOBALAUDIOINFOF{j,feedbackblock5}.c1;
    [WAVWord{j,6}] = GLOBALAUDIOINFOF{j,feedbackblock5}.c2;
    [WAVWord{j,7}] = GLOBALAUDIOINFOF{j,feedbackblock5}.c3;
    [WAVWord{j,8}] = GLOBALAUDIOINFOF{j,feedbackblock5}.c4;
    [WAVWord{j,9}] = GLOBALAUDIOINFOF{j,feedbackblock5}.c5;
    [WAVWord{j,10}] = GLOBALAUDIOINFOF{j,feedbackblock5}.c6;
    [WAVWord{j,11}] = GLOBALAUDIOINFOF{j,feedbackblock5}.c7;
    [WAVWord{j,12}] = GLOBALAUDIOINFOF{j,feedbackblock5}.c8;
    [WAVWord{j,13}] = GLOBALAUDIOINFOF{j,feedbackblock5}.c9;
    [WAVWord{j,14}] = GLOBALAUDIOINFOF{j,feedbackblock5}.c10;
    [WAVWord{j,15}] = GLOBALAUDIOINFOF{j,feedbackblock5}.c11;
    [WAVWord{j,16}] = GLOBALAUDIOINFOF{j,feedbackblock5}.c12; 
end;


% Block is now starting...
for i=1:(NbObjectsf(1))
    
    drawnow;
    
    % create the wavedata
    wavedata= ...
        [ WAVWord{i,1}' ; ...
        WAVWord{i,1}' ];

    % define trial specific information
    Trialspecificname=WAVWord{i,2};
    Trialspecificfilename=WAVWord{i,3};
    Trialspecificword=WAVWord{i,4};
    for k = 1:size(WAVWord,2)-3
        PossWords(1,k) = WAVWord{i,k+3};
    end

    % Fill the audio playback buffer with the audio data 'wavedata':
    PsychPortAudio('FillBuffer', pahandle, wavedata);

    % Fixation step for 1 secs
    Screen('TextSize', w, 32);
    Screen('Drawtext', w, '+', theX,theY,255);
    Screen('Flip',w);
    WaitSecs(1);

    % Clear screen and wait for 1/2 sec before playing the sound
    Screen('Flip',w);        
    WaitSecs(.5);

    % Wait for release of all keys on keyboard:
    KbReleaseWait;
    
    
    % Synchronize NetStation
    NetStation('Synchronize');
    t1 = GetSecs + 1;
    starttime = PsychPortAudio('Start', pahandle, 1, t1, 1);
   
    WaitSecs(1);
    
    % Stop playback:
    PsychPortAudio('Stop', pahandle);
    
    % Set Text size for when subjects respond
    Screen('TextSize',w,32);
    
    % Hide Cursor and then Get Cursor ready then flip to see it.
    HideCursor;
    Screen('DrawText', w, '_', theX,theY,255);
    Screen('Flip', w);
    
    % Set keys so subjects can actually type
    keylist=zeros(256,1);
    keylist(65:90)=1;
    keylist(KbName('return'))=1;
    keylist(KbName('backspace'))=1;
    KbQueueCreate([],keylist)

    % Collect Response
    returnPressed=0;
    enteredText=[];

    while returnPressed==0
        KbQueueFlush;
        KbQueueStart;
        pressed=0;
        while pressed==0;
            [pressed firstpressed]=KbQueueCheck;
        end
        [a response]=max(firstpressed);
        if strcmp(KbName(response),'return');
        returnPressed=1;
        elseif strcmp(KbName(response),'backspace') && ~isempty(enteredText);
            if length(enteredText)>1;    
                enteredText=enteredText(1:length(enteredText)-1);
            else
                enteredText=[];
            end
        else
            enteredText=[enteredText KbName(response)];
        end
        if ~isempty(enteredText);
            Screen('DrawText', w, [enteredText '_'], theX,theY,255);
            Screen('Flip', w);
        else
            Screen('Flip',w);
        end
    end
    
    
    % Save Response, check if correct
    Trialspecificresponse = enteredText;
   
    TF = strncmp(Trialspecificresponse,PossWords,6);
    if find(TF==1)~=0
        condition='C';
    else
        condition='M';
    end
    
    % Send appropriate Tag to Netstation
    switch condition
     case 'C'
        NetStation('Event' ,'SF5C' ,starttime, 1, 'SF5C', i);      
	 case 'M'
        NetStation('Event' ,'SF5M' ,starttime, 1, 'SF5M', i);
    end;
    
    %Show Progress in other monitor
    disp(TrialNum);
    disp(Trialspecificword);
    disp(enteredText);
    disp(condition);
    disp(starttime);
    disp(t1);
    
    
    % This is a feedback block so we need feedback
    
    % Netstation Synch
    NetStation('Synchronize');
    t2 = GetSecs + 1;
    
    % Give feedback and show it
    Screen('FillRect',w,backgroundcolor);
    Screen('Flip',w);
    WaitSecs(.5);
    Screen('DrawText', w, char(Trialspecificword), theX,theY,255); 
    Screen('Flip', w);
    
    % Play word again as well
    starttime2 = PsychPortAudio('Start', pahandle, 1, t2, 1);
    
    % Send tag to Netstation that feedback event occurred
    NetStation('Event' ,'FEF5' ,starttime2, 1, 'FEF5', i);
    WaitSecs(1);
    
    % Clear screen 
    Screen('FillRect', w, backgroundcolor);
    Screen('Flip',w);
    
    % Stop playback:
    PsychPortAudio('Stop', pahandle);
    
    % Write Data for Trial to Global Data Sheet to save
    WordData{TrialNum,1}= subject;
    WordData{TrialNum,2}= TrialNum;
    WordData{TrialNum,3}= ['f' num2str(feedbackblock5)];
    WordData{TrialNum,4}= Trialspecificname;
    WordData{TrialNum,5}= char(Trialspecificfilename);
    WordData{TrialNum,6}= char(Trialspecificword);
    WordData{TrialNum,7}= char(Trialspecificresponse);
    WordData{TrialNum,8}= starttime; % initial onset of word
    WordData{TrialNum,9}= starttime2; % onset of feedback word
    WordData{TrialNum,10}= t1;  
    WordData{TrialNum,11}= t2;
    WordData{TrialNum,12}= char(condition);
    
    % Increment trial index
    TrialNum=TrialNum + 1;

    % ISI
    WaitSecs(.5);
end;

%% Let's end this block
drawnow;

% Save data so far
xlswrite(filename,WordData);

% Clear audio buffer
clear WAVWord wavedata

% Clear the screen
Screen('FillRect', w, backgroundcolor);
Screen('Flip',w);

% Send a tag to Netstation saying that the block is over!
WaitSecs(3);
tstart = GetSecs;
NetStation('Event' ,'ENDS' , tstart, 1, 'ENDS'); 

%% AWESOME BREAK for our subject!
RestrictKeysForKbCheck(8);

%Break instructions   
clear Instructionlines;
Instructionlines = importdata ([inputfolder InstructionFilesList(11).name]);
Instruction_Display(w,theX,theY,backgroundcolor,textcolor,Instructionlines);

%% Tell Netstation the next block is beginning
tstart = GetSecs;
NetStation('Event' ,'STAR' , tstart, 1, 'STAR'); 

%% Feedback Block 6

% load wav files via GLOBALAUDIOINFO

for j=1:NbObjectsf(1)
    [rsynth Fs]= wavread([inputfolder 'f' num2str(feedbackblock6) '/' GLOBALAUDIOINFOF{j,feedbackblock6}.name]);    

    WAVWord{j,1}= zeros(length(rsynth)+Fs*4,1);
    WAVWord{j,1}(1:length(rsynth))=rsynth;

    [WAVWord{j,2}] = GLOBALAUDIOINFOF{j,feedbackblock6}.name;
    [WAVWord{j,3}] = GLOBALAUDIOINFOF{j,feedbackblock6}.filename;
    [WAVWord{j,4}] = GLOBALAUDIOINFOF{j,feedbackblock6}.word;
    [WAVWord{j,5}] = GLOBALAUDIOINFOF{j,feedbackblock6}.c1;
    [WAVWord{j,6}] = GLOBALAUDIOINFOF{j,feedbackblock6}.c2;
    [WAVWord{j,7}] = GLOBALAUDIOINFOF{j,feedbackblock6}.c3;
    [WAVWord{j,8}] = GLOBALAUDIOINFOF{j,feedbackblock6}.c4;
    [WAVWord{j,9}] = GLOBALAUDIOINFOF{j,feedbackblock6}.c5;
    [WAVWord{j,10}] = GLOBALAUDIOINFOF{j,feedbackblock6}.c6;
    [WAVWord{j,11}] = GLOBALAUDIOINFOF{j,feedbackblock6}.c7;
    [WAVWord{j,12}] = GLOBALAUDIOINFOF{j,feedbackblock6}.c8;
    [WAVWord{j,13}] = GLOBALAUDIOINFOF{j,feedbackblock6}.c9;
    [WAVWord{j,14}] = GLOBALAUDIOINFOF{j,feedbackblock6}.c10;
    [WAVWord{j,15}] = GLOBALAUDIOINFOF{j,feedbackblock6}.c11;
    [WAVWord{j,16}] = GLOBALAUDIOINFOF{j,feedbackblock6}.c12; 
end;


% Block is now starting
for i=1:(NbObjectsf(1))
   
    drawnow;
    
    % create the wavedata
    wavedata= ...
        [ WAVWord{i,1}' ; ...
        WAVWord{i,1}' ];

    % define trial specific information
    Trialspecificname=WAVWord{i,2};
    Trialspecificfilename=WAVWord{i,3};
    Trialspecificword=WAVWord{i,4};
    for k = 1:size(WAVWord,2)-3
        PossWords(1,k) = WAVWord{i,k+3};
    end

    % Fill the audio playback buffer with the audio data 'wavedata':
    PsychPortAudio('FillBuffer', pahandle, wavedata);

    % Fixation step for 1 secs
    Screen('TextSize', w, 32);
    Screen('Drawtext', w, '+', theX,theY,255);
    Screen('Flip',w);
    WaitSecs(1);

    % Clear screen and wait for 1/2 sec before playing the sound
    Screen('Flip',w);      
    WaitSecs(.5);

    % Wait for release of all keys on keyboard:
    KbReleaseWait;
    
    % Synchronize NetStation
    NetStation('Synchronize');
    t1 = GetSecs + 1;
    starttime = PsychPortAudio('Start', pahandle, 1, t1, 1);
    
    WaitSecs(1);
    
    % Stop playback:
    PsychPortAudio('Stop', pahandle);
    
    % Set Text size for when subjects respond
    Screen('TextSize',w,32);
    
    % Hide Cursor and then Get Cursor ready then flip to see it.
    HideCursor
    Screen('DrawText', w, '_', theX,theY,255);
    Screen('Flip', w);
    
    % Set keys so subjects can actually type
    keylist=zeros(256,1);
    keylist(65:90)=1;
    keylist(KbName('return'))=1;
    keylist(KbName('backspace'))=1;
    KbQueueCreate([],keylist);

    % Collect Response
    returnPressed=0;
    enteredText=[];

    while returnPressed==0
        KbQueueFlush;
        KbQueueStart;
        pressed=0;
        while pressed==0;
            [pressed firstpressed]=KbQueueCheck;
        end
        [a response]=max(firstpressed);
        if strcmp(KbName(response),'return');
        returnPressed=1;
        elseif strcmp(KbName(response),'backspace') && ~isempty(enteredText);
            if length(enteredText)>1;    
                enteredText=enteredText(1:length(enteredText)-1);
            else
                enteredText=[];
            end
        else
            enteredText=[enteredText KbName(response)];
        end
        if ~isempty(enteredText);
            Screen('DrawText', w, [enteredText '_'], theX,theY,255);
            Screen('Flip', w);
        else
            Screen('Flip',w)
        end
    end


    % Save Response
    Trialspecificresponse = enteredText;
  
    TF = strncmp(Trialspecificresponse,PossWords,6);
    if find(TF==1)~=0
        condition='C';
    else
        condition='M';
    end
    
    % Send appropriate Tag to Netstation
    switch condition
     case 'C'
        NetStation('Event' ,'SF6C' ,starttime, 1, 'SF6C', i);      
	 case 'M'
        NetStation('Event' ,'SF6M' ,starttime, 1, 'SF6M', i);
    end;
    
    %Show Progress in other monitor
    disp(TrialNum);
    disp(Trialspecificword);
    disp(enteredText);
    disp(condition);
    disp(starttime);
    disp(t1);
    
    
    % This is a feedback Block so we need feedback
    
    % Netstation Synch
    NetStation('Synchronize');
    t2 = GetSecs + 1;
    
    % Give feedback and show it
    Screen('FillRect',w,backgroundcolor);
    Screen('Flip',w);
    WaitSecs(.5);
    Screen('DrawText', w, char(Trialspecificword), theX,theY,255); 
    Screen('Flip', w);
    
    % Play word again as well
    starttime2 = PsychPortAudio('Start', pahandle, 1, t2, 1);
    NetStation('Event' ,'FEF6' ,starttime2, 1, 'FEF6', i);
    WaitSecs(1);
    
    % Clear screen 
    Screen('FillRect', w, backgroundcolor);
    Screen('Flip',w);
    
    % Stop playback:
    PsychPortAudio('Stop', pahandle);
    
    % Write Data for Trial to Global Data Sheet to save
    WordData{TrialNum,1}= subject;
    WordData{TrialNum,2}= TrialNum;
    WordData{TrialNum,3}= ['f' num2str(feedbackblock6)];
    WordData{TrialNum,4}= Trialspecificname;
    WordData{TrialNum,5}= char(Trialspecificfilename);
    WordData{TrialNum,6}= char(Trialspecificword);
    WordData{TrialNum,7}= char(Trialspecificresponse);
    WordData{TrialNum,8}= starttime; % initial onset of word
    WordData{TrialNum,9}= starttime2; % onset of feedback word
    WordData{TrialNum,10}= t1;  
    WordData{TrialNum,11}= t2;
    WordData{TrialNum,12}= char(condition);
    
    % Increment trial index
    TrialNum=TrialNum + 1;

    % ISI
    WaitSecs(.5);
end;


%% Let's end this block
drawnow;

% Save data so far
xlswrite(filename,WordData);

% Clear audio buffer
clear WAVWord wavedata

% Clear the screen
Screen('FillRect', w, backgroundcolor);
Screen('Flip',w);

% Send a tag to Netstation saying that the block is over!
WaitSecs(3);
tstart = GetSecs;
NetStation('Event' ,'ENDS' , tstart, 1, 'ENDS'); 

%% AWESOME BREAK for our subject

RestrictKeysForKbCheck(8);
%Break instructions   
clear Instructionlines;
Instructionlines = importdata ([inputfolder InstructionFilesList(12).name]);
Instruction_Display(w,theX,theY,backgroundcolor,textcolor,Instructionlines);

%% Tell Netstation the next block is beginning
tstart = GetSecs;
NetStation('Event' ,'STAR' , tstart, 1, 'STAR'); 

%% PostTest

% load wav files via GLOBALAUDIOINFO
    
for j=1:NbObjectst(1)
    [rsynth Fs]= wavread([inputfolder 't' num2str(posttest) '/' GLOBALAUDIOINFOT{j,posttest}.name]);

    WAVWord{j,1}= zeros(length(rsynth)+Fs*4,1);
    WAVWord{j,1}(1:length(rsynth))=rsynth;

    [WAVWord{j,2}] = GLOBALAUDIOINFOT{j,posttest}.name;
    [WAVWord{j,3}] = GLOBALAUDIOINFOT{j,posttest}.filename;
    [WAVWord{j,4}] = GLOBALAUDIOINFOT{j,posttest}.word;
    [WAVWord{j,5}] = GLOBALAUDIOINFOT{j,posttest}.c1;
    [WAVWord{j,6}] = GLOBALAUDIOINFOT{j,posttest}.c2;
    [WAVWord{j,7}] = GLOBALAUDIOINFOT{j,posttest}.c3;
    [WAVWord{j,8}] = GLOBALAUDIOINFOT{j,posttest}.c4;
    [WAVWord{j,9}] = GLOBALAUDIOINFOT{j,posttest}.c5;
    [WAVWord{j,10}] = GLOBALAUDIOINFOT{j,posttest}.c6;
    [WAVWord{j,11}] = GLOBALAUDIOINFOT{j,posttest}.c7;
    [WAVWord{j,12}] = GLOBALAUDIOINFOT{j,posttest}.c8;
    [WAVWord{j,13}] = GLOBALAUDIOINFOT{j,posttest}.c9;
    [WAVWord{j,14}] = GLOBALAUDIOINFOT{j,posttest}.c10;
    [WAVWord{j,15}] = GLOBALAUDIOINFOT{j,posttest}.c11;
    [WAVWord{j,16}] = GLOBALAUDIOINFOT{j,posttest}.c12;
end;


% Post test is now starting... 
for i=1:(NbObjectst(1))
    
    drawnow;
    
    % create the wavedata
    wavedata= ...
        [ WAVWord{i,1}' ; ...
        WAVWord{i,1}' ];

    % define trial specific information
    Trialspecificname=WAVWord{i,2};
    Trialspecificfilename=WAVWord{i,3};
    Trialspecificword=WAVWord{i,4};
    for k = 1:size(WAVWord,2)-3
        PossWords(1,k) = WAVWord{i,k+3};
    end

    % Fill the audio playback buffer with the audio data 'wavedata':
    PsychPortAudio('FillBuffer', pahandle, wavedata);

    % Fixation step for 1 secs
    Screen('TextSize', w, 32);
    Screen('Drawtext', w, '+', theX,theY,255);
    Screen('Flip',w);
    WaitSecs(1);

    % Clear screen and wait for 1/2 sec before playing the sound
    Screen('Flip',w);        
    WaitSecs(.5);

    % Wait for release of all keys on keyboard:
    KbReleaseWait;
    
    % Synchronize NetStation
    NetStation('Synchronize');
    t1 = GetSecs + 1;
    starttime = PsychPortAudio('Start', pahandle, 1, t1, 1);
    
    WaitSecs(1);
    
    % Stop playback:
    PsychPortAudio('Stop', pahandle);
    
    % Set Text size for when subjects respond
    Screen('TextSize',w,32);
    
    % Hide Cursor and then Get Cursor ready then flip to see it.
    HideCursor;
    Screen('DrawText', w, '_', theX,theY,255);
    Screen('Flip', w);
    
    % Set keys so subjects can actually type
    keylist=zeros(256,1);
    keylist(65:90)=1;
    keylist(KbName('return'))=1;
    keylist(KbName('backspace'))=1;
    KbQueueCreate([],keylist);

    % Collect Response
    returnPressed=0;
    enteredText=[];

    while returnPressed==0
        KbQueueFlush;
        KbQueueStart;
        pressed=0;
        while pressed==0;
            [pressed firstpressed]=KbQueueCheck;
        end
        [a response]=max(firstpressed);
        if strcmp(KbName(response),'return');
        returnPressed=1;
        elseif strcmp(KbName(response),'backspace') && ~isempty(enteredText);
            if length(enteredText)>1;    
                enteredText=enteredText(1:length(enteredText)-1);
            else
                enteredText=[];
            end
        else
            enteredText=[enteredText KbName(response)];
        end
        if ~isempty(enteredText);
            Screen('DrawText', w, [enteredText '_'], theX,theY,255);
            Screen('Flip', w);
        else
            Screen('Flip',w);
        end
    end

    % Save Response, check if correct
    Trialspecificresponse = enteredText;
    
    TF = strncmp(Trialspecificresponse,PossWords,6);
    if find(TF==1)~=0
        condition='C';
    else
        condition='M';
    end
    
    % Send apprpriate tag to Netstation
    switch condition
     case 'C'
        NetStation('Event' ,'ST2C' ,starttime, 1, 'ST2C', i);      
	 case 'M'
        NetStation('Event' ,'ST2M' ,starttime, 1, 'ST2M', i);
    end;
    
    %Show Progress in other monitor
    disp(TrialNum);
    disp(Trialspecificword);
    disp(enteredText);
    disp(condition);
    disp(starttime);
    disp(t1);

    % Write Data for Trial to Global Data Sheet to save
    WordData{TrialNum,1}= subject;
    WordData{TrialNum,2}= TrialNum;
    WordData{TrialNum,3}= ['t' num2str(posttest)];
    WordData{TrialNum,4}= Trialspecificname;
    WordData{TrialNum,5}= char(Trialspecificfilename);
    WordData{TrialNum,6}= char(Trialspecificword);
    WordData{TrialNum,7}= char(Trialspecificresponse);
    WordData{TrialNum,8}= starttime; %initial onset of word
    WordData{TrialNum,10} = t1;
    WordData{TrialNum,12}= char(condition);
    
    % Increment trial index
    TrialNum=TrialNum + 1;
    
    % ISI
    WaitSecs(.5);
    
end;


%% Let's end this block
drawnow;

% Save data so far
xlswrite(filename,WordData);

% Clear audio buffer
clear WAVWord wavedata

% Clear the screen
Screen('FillRect', w, backgroundcolor);
Screen('Flip',w);

% Send a tag to Netstation saying that the block is over!
WaitSecs(3);
tstart = GetSecs;
NetStation('Event' ,'ENDS' , tstart, 1, 'ENDS'); 


%% The Experiment is basically over - Let's close things down

% Close the audio device and WAIT
PsychPortAudio('Close', pahandle);
WaitSecs(.5);    

% Closing instructions
RestrictKeysForKbCheck(8);
clear Instructionlines;
Instructionlines = importdata ([inputfolder InstructionFilesList(13).name]);
Instruction_Display(w,theX,theY,backgroundcolor,textcolor,Instructionlines);
drawnow;

% Close log file
status = fclose('all');

% Closing the PTB screen
Screen('Close',w);

% Stop Recording
NetStation('StopRecording');
NetStation('Disconnect');

% Write Data to Excel Sheet and show on other monitor that it was a
% success!
xlswrite(filename,WordData);
disp('done writing excel file!');


catch ME
    Screen('CloseAll');
    ShowCursor;
    psychrethrow(psychlasterror);
    ListenChar(1);
    didicatch='yes';
    drawnow;
end
% Close the screenview and go back to Matlab
Screen('CloseAll');

% Allow the keyboard to type again
ListenChar(1);     