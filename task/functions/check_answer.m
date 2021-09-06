function [correct] = check_answer(istarget, resp)
    istarget = logical(istarget);
    if resp == "" % catch empty answers
        correct = 0;
    elseif istarget && resp == 't' % correctly identifies target
        correct = 1;
    elseif not(istarget) && resp == 'n' % correctly identifies non-targets
        correct = 1;
    else % all other cases
        correct = 0;
    end
end