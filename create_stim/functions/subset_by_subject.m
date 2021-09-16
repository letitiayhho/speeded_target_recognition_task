function [df] = subset_by_subject(df, subjects)
    selection = zeros(size(df, 1), 1);
    for i = 1:length(subjects)
        selection = selection + strcmp(df.subject, subjects(i));
    end
    selection = logical(selection);
    df = df(selection, :);
end
