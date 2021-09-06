function [vowel_order, istarget] = choose_target_for_each_trial(target)
    % List of targets and distractors
    possible_distractors = ["AE", "AH", "EE", "EH", "IH", "OO", "UH"];

    % Remove target from list of distractors
    possible_distractors(strcmp(possible_distractors, target)) = [];

    % Pick 16 distractors
    distractors = possible_distractors(randi(length(possible_distractors), 1, 16));

    % Replace 4 random distractors with the target
    distractors(datasample(1:16, 4)) = target;
    vowel_order = distractors';
    
    % Generate istarget
    istarget = vowel_order == target;
end
