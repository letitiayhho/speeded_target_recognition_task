function [stim_start, rt] = present_stimulus(stim, ptb)

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
        this_rt = RTBox(); % RTBox('sound', timeout) removed, FIX
        timeout = GetSecs - stim_start > 0.5;
        if ~isempty(this_rt)
            rt = this_rt
        end
    end
%     rt = RTBox(timeout); % RTBox('sound', timeout) removed, FIX

    % check response
    if isempty(rt) % no response
        rt = "nan";
    else 
        rt = rt - stim_start; %  response time
    end
    if numel(rt) > 1 % more than 1 response
        ind = find(rt>0,1); % use 1st proper rt
        rt = rt(ind);
    end

    % end of accepting response
    Screen('Flip', ptb.window);
    ListenChar(0); % renables matlab command window
    Priority(0);

end