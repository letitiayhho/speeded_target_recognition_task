function [target] = get_target(stim_order, block, rep)
    stim_order = stim_order(stim_order.block == block, :);
    stim_order = stim_order(stim_order.rep == rep, :);
    target = unique(stim_order.vowel(logical(stim_order.istarget)));
    target = char(target);
end