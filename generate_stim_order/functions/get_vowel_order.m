function [vowel_order, istarget, key] = get_vowel_order(n_trials, target_key)
    target_order = get_target_order(n_trials);
    vowel_order = [];
    istarget = [];
    key = [];
    for i = 1:length(target_order)
        [trial_vowel_order, trial_istarget, trial_key] = get_distractor_order(target_order(i), target_key);
        vowel_order = [vowel_order; trial_vowel_order];
        istarget = [istarget; trial_istarget];
        key = [key; trial_key];
    end
end
