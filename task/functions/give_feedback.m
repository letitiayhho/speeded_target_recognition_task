function give_feedback(correct, ptb)
    
    if correct
        feedback = 'correct';
    else
        feedback = 'incorrect';
    end
        
    DrawFormattedText(ptb.window, feedback, 'center', 'center', 1);
    Screen('Flip', ptb.window);
    WaitSecs(.5);
    Screen('Flip', ptb.window);

end