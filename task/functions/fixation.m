function fixation(ptb)

    % show fixation cross for 1 sec and then clear
    DrawFormattedText(ptb.window, '+', 'center', 'center', 1);
    Screen('Flip', ptb.window);
    KbPressWait();
    Screen('Flip', ptb.window);
    
end
