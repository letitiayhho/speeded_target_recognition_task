function [vowel_order, istarget] = get_vowel_order()
    target_order = choose_target_order();
    vowel_order = [];
    istarget = [];
    for i = 1:length(target_order)
        [vowels, target] = choose_distractor_order(target_order(i));
        vowel_order = [vowel_order, vowels];
        istarget = [istarget, target];
    end
    vowel_order = vowel_order';
    istarget = istarget';
end
