function fixation(ptb)

    % show fixation cross for 1 sec and then clear
    DrawFormattedText(ptb.window, '+', 'center', 'center', 1);
    Screen('Flip', ptb.window);
    WaitSecs(1)
    Screen('Flip', ptb.window);
    
end
