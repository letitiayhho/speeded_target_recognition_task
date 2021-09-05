function [full_stim_path] = get_full_stim_path(n_talkers)
    % Get talker order
    talker_order = get_talker_order(n_talkers);

    % Get vowel order
    vowel_order = get_vowel_order();

    % Get full path
    full_stim_paths = fullfile(talker_order, vowel_order);

    % Save to .txt file
%     writematrix(full_stim_paths, 'stim_paths.txt')
end