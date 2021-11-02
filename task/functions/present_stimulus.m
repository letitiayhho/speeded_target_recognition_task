function rt = present_stimulus(stim, ptb)

    % start collecting response
    Priority(2);

    % load audio buffer
    [aud, ~] = audioread(stim);
    PsychPortAudio('FillBuffer', ptb.pahandle, [aud'; aud']);
    PsychPortAudio('Stop', ptb.pahandle); % this makes 'start' faster
    
    % control soa
    soa = 0.75;
    WaitSecs(soa-toc); 
    tic;
    
    % play audio
    RTBox('clear'); % clear buffer and sync clocks before stimulus onset
    PsychPortAudio('Start', ptb.pahandle, 1, 0, 1);

    % collect response
    timeout = 0.5;
    [rt, ~] = RTBox('sound', timeout);
    if numel(rt) > 1 % more than one response
        ind = find(rt>0, 1); % find first actual response
        rt = rt(ind); 
    end
        
    % wait till end of trial
    if rt > 0
        WaitSecs(0.5-rt);
    else
        rt = "nan";
    end

    % end of accepting response
    Priority(0);

end