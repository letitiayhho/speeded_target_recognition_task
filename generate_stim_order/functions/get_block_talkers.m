function [talkers] = get_block_talkers(vowel_space, blocked)
    if strcmp(vowel_space, "training")
        talkers = ["A", "A"; "B", "B"; "A", "B"; "A", "B";...
            "X", "X"; "Y", "Y"; "X", "Y"; "X", "Y"];
    elseif strcmp(vowel_space, "s") && strcmp(blocked, "b")
        talkers = ["A", "A"; "B", "B"];
    elseif strcmp(vowel_space, "s") && strcmp(blocked, "m")
        talkers = ["A", "B"];
    elseif strcmp(vowel_space, "d") && strcmp(blocked, "b")
        talkers = ["X", "X"; "Y", "Y"];
    elseif strcmp(vowel_space, "d") && strcmp(blocked, "m")
        talkers = ["X", "Y"];
    end
    
%     blocked = talkers(:,1) == talkers(:,2);
%     trial_types = num2str(blocked);
%     trial_types(blocked) = "b";
%     trial_types(~blocked) = "m";
end