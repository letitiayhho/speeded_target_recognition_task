function rt = present_stimulus(stim, ptb)

    % start collecting response
    ListenChar(2);
    Priority(2);

    % load audio buffer
    [aud, ~] = audioread(stim);
    PsychPortAudio('FillBuffer', ptb.pahandle, [aud'; aud']);
    PsychPortAudio('Stop', ptb.pahandle) % this makes 'start' faster

    % show accepting response
    DrawFormattedText(ptb.window, 'x', 'center', 'center', 1);
    Screen('Flip', ptb.window);
    
    % play audio
    RTBox('clear'); % clear buffer and sync clocks before stimulus onset
    stim_start = PsychPortAudio('Start', ptb.pahandle, 1, 0, 1);

    % stop audio
    PsychPortAudio('Stop', ptb.pahandle, 1, 1); % SEE IF NEEDED

    % collect response
    timeout = 0.5;
    rt = RTBox(timeout);
    rt = rt - stim_start;
    if numel(rt) > 1 % more than one response
        ind = find(rt>0, 1); % find first actual response
        rt = rt(ind); 
    end
        
    % wait till end of trial
    if rt > 0
        WaitSecs(0.5-rt)
    else
        rt = "nan";
    end
    
    %     while ~time_out
%         if isempty(rt)
%         end
        % WAIT FOR HOWEVER MUCH TIME IS LEFT 0.5-RT
%         if isempty(rt) % prevent a second response from being recorded
%             [this_rt, ~] = RTBox('sound', 0.5);
%         end
%         if ~isempty(this_rt)
%             rt = this_rt;
%         end
%         GetSecs
%         stim_start
%         elapsed_time = GetSecs - stim_start
%         time_out = elapsed_time > 0.5
% %     end
% 
%     % check response
%     if isempty(rt) % no response
%         rt = "nan";
%     end

    % end of accepting response
    Screen('Flip', ptb.window);
    ListenChar(0); % renables matlab command window
    Priority(0);

end