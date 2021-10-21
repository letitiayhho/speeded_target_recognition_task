function [rt, resp] = present_stimulus(stim, ptb)

    [aud, ~] = audioread(stim);
    PsychPortAudio('FillBuffer', ptb.pahandle, [aud'; aud']);

    % show response accepting
    DrawFormattedText(ptb.window, 'x', 'center', 'center', 1);
    Screen('Flip', ptb.window);
    
    % start collecting response
    ListenChar(2)
    KbQueueCreate(ptb.keyboard);
    KbQueueStart;
    resp_start = GetSecs;

    % play audio
    PsychPortAudio('Start', ptb.pahandle, 1, resp_start, 1);

    % stop audio
    [stim_start, ~, ~, ~] = PsychPortAudio('Stop', ptb.pahandle, 1, 1);

    % collect response
    pressed = 0;
    times_up = 0;
    rt = 0;
    while ~times_up % ~pressed
        [pressed, this_rt] = KbQueueCheck(); %check response
        times_up = GetSecs - resp_start > 0.5;
        if pressed
            rt = this_rt;
        end
    end
    
    if sum(rt) > 0
        keylist = KbName(rt);
        [rt, I] = min(rt(rt > 0)); % keep only first response
        resp = char(keylist(I));
        rt = rt - stim_start;
    else
        resp = "NaN";
        rt = "NaN";
    end

    % end of accepting response
    ListenChar(0); % renables matlab command window
    Screen('Flip', ptb.window);

end