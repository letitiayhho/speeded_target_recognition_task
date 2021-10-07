function [block_type, trial_type, talker, istarget, key, target_key, n_trials] = get_talker_order(block)
    [block_type, n_trials] = get_block_type(BLOCK); 
    [trial_type, talkers, n_trials] = get_block_talkers(block_type);   

    while true
    talker = [];
%     istarget = [];
%     key = [];

    % Generate order
    for i = 1:round(n_trials/length(talker1))
        order = randperm(length(talker1));
        talker = [talker; talker1(order)];
%         istarget = [istarget; same(order)];
%         key = [k; key(order)];
    end
    end
    
    % Make sure there aren't more than 4 same or different trials in a row
    if check_repeats(talker)
        break
    end
    end

    function [cont] = check_repeats(same_order)
    for j = 1:length(same_order)-5
        window = j:j+5;
        if (sum(same_order(window)) == 0) || (sum(same_order(window)) == 5)
            % Generate talker order recursively until condition is met
            cont = false;
            return
        end
    end
    cont = true;
    return
end