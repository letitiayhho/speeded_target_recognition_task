function present_target(ptb, target)

    % show fixation cross for 750 ms and then clear
    DrawFormattedText(ptb.window, target, 'center', 'center', 1);
    Screen('Flip', ptb.window);
    WaitSecs(.75);
    Screen('Flip', ptb.window);
    
end