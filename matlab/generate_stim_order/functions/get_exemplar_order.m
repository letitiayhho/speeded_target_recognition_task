function exemplar_order = get_exemplar_order(n_utterances, variation)
    arguments
        n_utterances double
        variation {mustBeMember(variation,["exemplar","NaN"])} = "NaN"
    end

    if strcmp(variation, "exemplar")
        exemplar_order = ones(n_utterances, 1);
    else
        exemplar_order = [];
        for i = 1:floor(n_utterances/3)
            exemplar_order = [exemplar_order; randperm(3)'];
        end
        exemplar_order = [exemplar_order; randperm(3, mod(n_utterances,...
            length(exemplars)))']; % top off the list to make n_utterances total
    end

end