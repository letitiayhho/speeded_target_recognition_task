function rt = present_stimulus(stim, ptb)

    % start collecting response
    ListenChar(2);
    RTBox('clear');
    Priority(1);

    % load audio buffer
    [aud, ~] = audioread(stim);
    PsychPortAudio('FillBuffer', ptb.pahandle, [aud'; aud']);

    % show accepting response
    DrawFormattedText(ptb.window, 'x', 'center', 'center', 1);
    Screen('Flip', ptb.window);
    
    % play audio
    stim_start = PsychPortAudio('Start', ptb.pahandle, 1, 0, 1);

    % stop audio
    PsychPortAudio('Stop', ptb.pahandle, 1, 1);

    % collect response
    timeout = 0;
    rt = [];
    while ~timeout
        if isempty(rt) % prevent a second response from being recorded
            [this_rt, ~] = RTBox('sound', 0.5);
        end
        if ~isempty(this_rt)
            rt = this_rt;
        end
        timeout = GetSecs - stim_start > 0.5;
    end

    % check response
    if isempty(rt) % no response
        rt = "nan";
    end

    % end of accepting response
    Screen('Flip', ptb.window);
    ListenChar(0); % renables matlab command window
    Priority(0);

end