function [target] = get_target(stim_order)
    target = unique(stim_order.vowel(logical(stim_order.target)));
    target = char(target);
end