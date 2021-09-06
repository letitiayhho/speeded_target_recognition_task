function [rt, resp] = present_stimulus(stim, ptb)

    [aud, ~] = audioread(stim);
    PsychPortAudio('FillBuffer', ptb.pahandle, [aud'; aud']);

    % show response accepting
    DrawFormattedText(ptb.window, 'x', 'center', 'center', 1);
    Screen('Flip', ptb.window);
    
    % start collecting response
    KbQueueCreate(ptb.keyboard);
    ListenChar(2);
    KbQueueStart;

    % play audio
    t0 = GetSecs + .001;
    PsychPortAudio('Start', ptb.pahandle, 1, t0, 1);
    
    % send trigger
    WaitSecs(.001); %length of 1 ms        
    RTBox('TTL', 255)

    % stop audio
    PsychPortAudio('Stop', ptb.pahandle, 1, 1);

    % Collect response
    [~, rt] = KbQueueCheck;
    keylist = KbName(rt);
    [rt, I] = min(rt(rt > 0)); % keep only first response
    resp = char(keylist(I));
    rt = rt - stim_start;

    % Wait
    WaitSecs(.2 + rand()*.2);
    KbQueueStop;
    KbQueueRelease;
    ListenChar(0); % renables matlab command window

    % end of accepting response
    Screen('Flip', ptb.window);

end