function [correct, miss] = check_answer(istarget, resp, target_key)
    istarget = logical(istarget);
    keys = ['c', 'm'];
    not_target_key = keys(keys ~= target_key);
    if resp == "" % catch empty answers
        correct = 0;
        miss = 1;
    elseif istarget && strcmp(resp, target_key) % correctly identifies target
        correct = 1;
        miss = 0;
    elseif ~istarget && strcmp(resp, not_target_key) % correctly identifies non-targets
        correct = 1;
        miss = 0;
    else % all other cases
        correct = 0;
        miss = 0;
    end
end