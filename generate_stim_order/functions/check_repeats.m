function [cont] = check_repeats(seq, n)
    for k = 1:length(seq)-n
        window = k:k+n;
        if length(unique(seq(window))) == 1
            % returns false if 3 consecutive items are the same
            % use in while loop to continue looping until generated
            % sequence has no long repeats
            cont = false;
            return
        end
    end
    cont = true;
end