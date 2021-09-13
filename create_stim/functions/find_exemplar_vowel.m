function find_exemplar_vowel(subject_number)
    % Load data
    cd ~/src/speeded_vowel_identification/create_stim/
    subject_dir = "subj" + subject_number;
    raw = readtable(fullfile(subject_dir, subject_dir + "-1.txt"), 'ReadVariableNames', true);

    % Create a data frame with f1 and f2
    vowel = cellstr(raw.Type);
    f1 = raw.f1;
    f2 = raw.f2;
    df = table(vowel, f1, f2);
    vowels = unique(vowel, 'stable');
    clear raw vowel f1 f2
    
    % Identify the mean f1 and f2 for each vowel, the prototype
    prototypes = grpstats(df, 'vowel');
    
    % Construct filename
    order = repmat([""; num2str((1:9)')], 7, 1);
    df.filename = strcat(char(df.vowel), order, ".wav");
    
    % Drop rows containing NaN
    df(any(ismissing(df),2), :) = [];

    % Find distance between each utterance and the prototype
    df.d = zeros(size(df, 1), 1);
    for i = 1:size(df, 1)
        % get the points
        utterance = df(i, :);
        prototype = prototypes(strcmp(prototypes.vowel, utterance.vowel),:);

        % compute distance
        x = [utterance.f1, utterance.f2];
        y = [prototype.mean_f1, prototype.mean_f2];
        df.d(i) = sum((x-y).^2).^0.5;
    end

    % Rank the utterances by distance
    rank = [];
    for i = 1:size(vowels, 1)
        distances = df.d(strcmp(df.vowel, vowels(i)),:);
        rank = [rank; tiedrank(distances)];
    end
    df.rank = rank;

    % Save
    writetable(df, fullfile(subject_dir, 'prototypicality_rankings.txt'))
end
