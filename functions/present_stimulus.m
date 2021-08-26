function present_stimulus(stim, block, ptb)

    % load contents of .wav file into buffer
    [aud, Fs] = audioread(stim);
    wavdata = zeros(length(aud)+Fs*4,1);
    wavdata(1:length(aud)) = aud;
    aud = [wavdata'; wavdata'];
    PsychPortAudio('FillBuffer', ptb.pahandle, aud);

    % inter-trial interval
    jitter = rand/5 - .1; % -100 to +100 ms uniform jitter
    WaitSecs(.5 + jitter);
    
    t0 = GetSecs + .001;
    starttime = PsychPortAudio('Start', ptb.pahandle, 1, t0, 1);
    WaitSecs(.001); %length of 1 ms        
    send_trigger(block);         
    WaitSecs(1); 
    endtime = PsychPortAudio('Stop', ptb.pahandle);
    

end