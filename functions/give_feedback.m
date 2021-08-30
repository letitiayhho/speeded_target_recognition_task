function give_feedback(word, resp, ptb)

    first_char = word(1);
    fprintf(1, ['response: ', resp, '\n'])
    fprintf(1, ['answer: ', first_char, '\n'])
    
    if first_char == resp
        answer = 'correct';
    else
        answer = 'incorrect';
    end
    
    fprintf(1, [answer, '\n'])
    
    DrawFormattedText(ptb.window, answer, 'center', 'center', 1);
    Screen('Flip', ptb.window);
    WaitSecs(.5);
    Screen('Flip', ptb.window);

end