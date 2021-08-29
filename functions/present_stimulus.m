function [stim_start, stim_end, pressed, rt, resp] = present_stimulus(stim, block, ptb)
    % Accepts only 'c' and 'd' key, records only the first key pressed

    % load contents of .wav file into buffer
    [aud, ~] = audioread(stim);
    PsychPortAudio('FillBuffer', ptb.pahandle, [aud'; aud']);
    
    % inter-trial interval
    jitter = rand/5 - .1; % -100 to +100 ms uniform jitter
    WaitSecs(.5 + jitter);

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
%     WaitSecs(1);
        
    % stop audio
    [stim_start, ~, ~, stim_end] = PsychPortAudio('Stop', ptb.pahandle, 1, 1);
   
    % Collect response
    [pressed, rt] = KbQueueCheck;
    resp = KbName(rt);
    [rt, I] = min(rt(rt > 0)); % keep only first response
    resp = char(resp(I));
    KbQueueStop;
    KbQueueRelease;
    ListenChar(0); % renables matlab command window
end