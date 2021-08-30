function [correct] = check_answer(word, resp)
    first_char = word(1);
    fprintf(1, ['response: ', resp, '\n']) %% REMOVE
    fprintf(1, ['answer: ', first_char, '\n']) %% REMOVE
    
    if first_char == resp
        correct = 1;
    else
        correct = 0;
    end
end