function [vowel_order, istarget] = get_vowel_order(n_trials)
    target_order = get_target_order(n_trials);
    vowel_order = [];
    istarget = [];
    for i = 1:length(target_order)
        [trial_vowel_order, trial_istarget] = get_distractor_order(target_order(i));
        vowel_order = [vowel_order; trial_vowel_order];
        istarget = [istarget; trial_istarget];
    end
end
