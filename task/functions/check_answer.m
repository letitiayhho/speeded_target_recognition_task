function [correct] = check_answer(istarget, resp)
    istarget = logical(istarget);

    if istarget && strcmp(resp, "4") % correctly identifies target
        correct = 1;
    elseif istarget && isnan(resp) % miss a target
        correct = 0;
    elseif ~istarget && isnan(resp) % correctly skips non-targets
        correct = 1;
    else % all other cases
        correct = 0;
    end
end