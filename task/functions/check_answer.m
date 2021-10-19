function [correct, miss] = check_answer(istarget, resp)
    istarget = logical(istarget);

    if istarget && strcmp(resp, "m") % correctly identifies target
        correct = 1;
        miss = 0;
    elseif istarget % miss a target
        correct = 0;
        miss = 1;
    elseif ~istarget && strcmp(resp, "") % correctly skips non-targets
        correct = 1;
        miss = 0;
    else % all other cases
        correct = 0;
        miss = 0;
    end
end