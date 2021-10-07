function exemplar_order = get_exemplar_order(n_trials)
    exemplars = (1:3)';
    exemplar_order = [];
    for i = 1:floor(n_trials/length(exemplars))
        exemplar_order = [exemplar_order; randperm(3)'];
    end
    exemplar_order = [exemplar_order; randperm(3, mod(n_trials, length(exemplars)))'];
end