function [correct] = check_answer(istarget, resp)
    istarget = logical(istarget);

    if istarget && strcmp(resp, "m") % correctly identifies target
        correct = 1;
    elseif istarget && strcmp(resp, "NaN") % miss a target
        correct = 0;
    elseif ~istarget && strcmp(resp, "NaN") % correctly skips non-targets
        correct = 1;
    else % all other cases
        correct = 0;
    end
end