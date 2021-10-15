function give_feedback(correct, miss, ptb)
    
    if correct
        feedback = 'correct';
    elseif miss
        feedback = 'no answer recorded';
    else
        feedback = 'incorrect';
    end
        
    DrawFormattedText(ptb.window, feedback, 'center', 'center', 1);
    Screen('Flip', ptb.window);
    WaitSecs(.5);
    Screen('Flip', ptb.window);

end