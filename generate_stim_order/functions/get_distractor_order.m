function [vowel_order, istarget] = choose_distractor_order(target)
    istarget = zeros(1, 16);

    % List of targets and distractors
    possible_distractors = ["AE", "AH", "EE", "EH", "IH", "OO", "UH"];
    
    % Remove target from list of distractors
    possible_distractors(strcmp(possible_distractors, target)) = [];
    
    % First and last vowels are always distractors
    first_half = possible_distractors;
    [vowel_order(1), index] = datasample(possible_distractors, 1);
    first_half(index) = [];
    
    second_half = possible_distractors;
    [vowel_order(16), index] = datasample(possible_distractors, 1);
    second_half(index) = [];
    
    % Find spots for target that are not consecutive
    sample = [first_half, second_half];
    while true
        indexes = randperm(14, 4)+1; % generate 4 random indexes from 2:15
        distances = diff(sort(indexes));
        if sum(distances == 1) == 0
            break
        end
    end
    vowel_order(indexes) = target;
    istarget(indexes) = 1;
    
    % Fill in spots with distractors
    missing_spots = find(ismissing(vowel_order));
    for i = 1:10
        missing_spot = missing_spots(i);
        vowel_order(missing_spot) = sample(i);
    end
    
end
