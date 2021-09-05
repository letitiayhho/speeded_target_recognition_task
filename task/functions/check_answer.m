function [correct] = check_answer(word, resp)
    first_char = word(1);
    
    if first_char == resp
        correct = 1;
    else
        correct = 0;
    end
end