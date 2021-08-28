function give_feedback(stim, ptb)

    fname = regexp(stim, '[a-zA-Z]+.wav', 'match');
    word = fname{1}(1:end-4);
    
    [aud, Fs] = audioread(stim);
    wavdata = zeros(length(aud)+Fs*4,1);
    wavdata(1:length(aud)) = aud;
    aud = [wavdata'; wavdata'];
    PsychPortAudio('FillBuffer', ptb.pahandle, aud);
    
    DrawFormattedText(ptb.window, word, 'center', 'center', 1);
    Screen('Flip', ptb.window);
    
    WaitSecs(.5);
    
    t0 = GetSecs + .001;
    starttime = PsychPortAudio('Start', ptb.pahandle, 1, t0, 1);
    WaitSecs(.001); %length of 1 ms        
    send_trigger(7);         
    WaitSecs(1); 
    endtime = PsychPortAudio('Stop', ptb.pahandle);
    
    % clear screen
    Screen('Flip', ptb.window);
    
    
    WaitSecs(.5);

end