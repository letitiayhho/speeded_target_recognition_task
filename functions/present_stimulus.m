function [stim_start, stim_end] = present_stimulus(stim, block, ptb)

    % load contents of .wav file into buffer
    [aud, ~] = audioread(stim);
    PsychPortAudio('FillBuffer', ptb.pahandle, [aud'; aud']);

    % inter-trial interval
    jitter = rand/5 - .1; % -100 to +100 ms uniform jitter
    WaitSecs(.5 + jitter);

    % play audio
    t0 = GetSecs + .001;
%     ListenChar(2); % suppresses typing into matlab command window
    PsychPortAudio('Start', ptb.pahandle, 1, t0, 1);
%     [~, rt, keyCode] = KbCheck;
    
    WaitSecs(.001); %length of 1 ms
%     send_trigger(block); FIX THIS
    WaitSecs(0.5);
    [stim_start, ~, ~, stim_end] = PsychPortAudio('Stop', ptb.pahandle, 1, 1);
    
%     ListenChar(0); % renables matlab command window
end