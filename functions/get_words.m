function [word] = get_words(stim)
    path = 'stim/test_words';
    all_files = dir(fullfile(path, '*.wav'));
    word = {all_files(:).name};
%     words = cell(1, length(names));
%     for i = 1:length(names)
%         word = strsplit(names{i}, '_');
%         words{i} = word{1};
%     end
end