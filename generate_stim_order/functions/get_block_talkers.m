function [talkers, trial_types] = get_block_talkers(block_type)
    if strcmp(block_type, "training")
        talkers = ["A", "A"; "B", "B"; "A", "B"; "A", "B";...
            "X", "X"; "Y", "Y"; "X", "Y"; "X", "Y"];
    elseif strcmp(block_type, "same")
        talkers = ["A", "A"; "B", "B"; "A", "B"; "A", "B"];
    elseif strcmp(block_type, "different")
        talkers = ["X", "X"; "Y", "Y"; "X", "Y"; "X", "Y"];
    end
    
    blocked = talkers(:,1) == talkers(:,2);
    trial_types = num2str(blocked);
    trial_types(blocked) = "b";
    trial_types(~blocked) = "m";
end