function present_stimulus(stim, block, ptb)
    % load contents of .wav file into buffer
    [aud, ~] = audioread(stim);
    PsychPortAudio('FillBuffer', ptb.pahandle, [aud'; aud']);

    % inter-trial interval
    jitter = rand/5 - .1; % -100 to +100 ms uniform jitter
    WaitSecs(.5 + jitter);

    t0 = GetSecs + .001;
    PsychPortAudio('Start', ptb.pahandle, 1, t0, 1);
    WaitSecs(.001); %length of 1 ms
%     send_trigger(block); FIX THIS
    WaitSecs(1);
    [actualStartTime, ~, ~, estStopTime] = PsychPortAudio('Stop', ptb.pahandle, 1, 1);
end