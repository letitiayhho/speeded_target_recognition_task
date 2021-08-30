function [fullpath, word] = get_filepaths(path)
    all_files = dir(fullfile(path, '*.wav'));
    folder = {all_files(:).folder};
    filename = {all_files(:).name};
    
    fullpath = cell(1, length(all_files));
    word = cell(1, length(all_files));
    
    for i = 1:length(all_files)
        fullpath{i} = char(strcat(folder(i), '/', filename(i)));
        parts = strsplit(filename{i}, '_');
        word{i} = parts{1};
    end
    
end