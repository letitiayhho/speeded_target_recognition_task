function fixation(ptb)
% show fixation cross for 750 ms and then clear

    DrawFormattedText(ptb.window, '+', 'center', 'center', 1);
    Screen('Flip', ptb.window);
    WaitSecs(.75);
    Screen('Flip', ptb.window);
    
end
