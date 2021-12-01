function present_target(ptb, target)

    % show fixation cross for 1 sec and then clear
    DrawFormattedText(ptb.window, target, 'center', 'center', 1);
    Screen('Flip', ptb.window);
    WaitSecs(2);
    Screen('Flip', ptb.window);
    
end