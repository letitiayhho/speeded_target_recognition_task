function [stim_start, stim_end, pressed, rt, resp] = present_stimulus(stim, block, ptb)
    % Accepts only 'c' and 'd' key, records only the first key pressed

    % load contents of .wav file into buffer
    [aud, ~] = audioread(stim);
    PsychPortAudio('FillBuffer', ptb.pahandle, [aud'; aud']);
    
    % inter-trial interval
    jitter = rand/5 - .1; % -100 to +100 ms uniform jitter
    WaitSecs(.5 + jitter);

    % start collecting response
    ListenChar(2);
    keyList = zeros(256, 1);
    keyList(6:7) = 1;
    kbQueueCreate(ptb.keyboard, keyList);
    KbQueueCreate;
    KbQueueStart;
%     RestrictKeysForKbCheck([6, 7]); % test this, doesn't work
    
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
    [pressed, firstPress] = KbQueueCheck;
    rt = firstPress;
    resp = KbName(firstPress);
    KbQueueStop;
    KbQueueRelease;
    ListenChar(0); % renables matlab command window
end