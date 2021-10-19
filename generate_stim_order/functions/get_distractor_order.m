function [vowel_order, istarget] = choose_distractor_order(target)
    istarget = zeros(16, 1);

    % List of targets and distractors
    possible_distractors = ["AA", "EH", "IH", "OO"];
    
    % Remove target from list of distractors
    possible_distractors(strcmp(possible_distractors, target)) = [];
    
    % First and last vowels are always distractors
    while true
        vowel_order = datasample(possible_distractors, 16)';
        if check_repeats(vowel_order, 3)
            break
        end
    end
    
    % Find spots for target that are not consecutive
    while true
        indexes = randperm(14, 4)+1; % generate 4 random indexes from 2:15
        distances = diff(sort(indexes));
        if sum(distances == 1) == 0
            break
        end
    end
    vowel_order(indexes, 1) = target;
    istarget(indexes) = 1;
end
