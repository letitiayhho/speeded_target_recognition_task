function [stim_start, stim_end, pressed, rt, resp] = present_stimulus(stim, block, ptb)
    % Accepts only 'c' and 'd' key, records only the first key pressed

    % load contents of .wav file into buffer
    [aud, ~] = audioread(stim);
    PsychPortAudio('FillBuffer', ptb.pahandle, [aud'; aud']);

    % start collecting response
    keyList = zeros(256, 1); % allow only certain keys
    keyList(6:7) = 1;
    KbQueueCreate(ptb.keyboard, keyList);
    ListenChar(2);
    KbQueueStart;
    
    % play audio
    t0 = GetSecs + .001;
    PsychPortAudio('Start', ptb.pahandle, 1, t0, 1);
    
    % send trigger
%     WaitSecs(.001); %length of 1 ms
%     send_trigger(block); FIX THIS
   
    % Collect response
    [pressed, rt] = KbQueueCheck;
    resp = KbName(rt);
    [rt, I] = min(rt(rt > 0)); % keep only first response
    resp = char(resp(I));
    
    % stop audio
    [stim_start, ~, ~, stim_end] = PsychPortAudio('Stop', ptb.pahandle, 1, 1);
    
    % inter-trial interval with jitter
    WaitSecs(.2 + rand()*.2); % wait between 200 and 400 ms
    KbQueueStop;
    KbQueueRelease;
    ListenChar(0); % renables matlab command window
    
end