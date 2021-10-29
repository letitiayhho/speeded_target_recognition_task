function ptb = init_psychtoolbox(Fs)

    PsychDefaultSetup(2);

    %% Display set up
    Screen('Preference', 'SkipSyncTests', 1);
    Screen('Preference', 'SuppressAllWarnings', 1);
    Screen('Preference','VisualDebugLevel', 0);
    ptb.scrn = max(Screen('screens')); %picks screen to use
    
    [window, ~] = PsychImaging('OpenWindow', ptb.scrn, 0);
        
    Screen('TextSize', window, 32);
    ptb.window = window;
    
    %% Keyboard setup
    ptb.keyboard = GetKeyboardIndices;
    
    %% Audio set up
    InitializePsychSound(1); % argument of 1 gets you really nice latencies   
    ptb.pahandle = PsychPortAudio('Open', [], [], 3, Fs, 2); % MIGHT HAVE TO ADJUST THIS

    if ismac % since this can cause trouble on other platforms
        Priority(9); % tell the computer we're important
    end
    
    % timing of first sound stimulus tends to be bad, so get out of the way
    % by playing a silent stimulus
    Sound = zeros(4*Fs,1);
    wavedata = [ Sound'; Sound'];
    PsychPortAudio('FillBuffer', ptb.pahandle, wavedata);
    t0 = GetSecs + .001;
    starttime = PsychPortAudio('Start', ptb.pahandle, 1, t0, 1);
    WaitSecs(1); 
    endtime = PsychPortAudio('Stop', ptb.pahandle, 1, 1);
      
end
