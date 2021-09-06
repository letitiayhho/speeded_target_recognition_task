function [target] = get_target(stim_order)
    target = unique(stim_order.vowel(logical(stim_order.istarget)));
    target = char(target);
end