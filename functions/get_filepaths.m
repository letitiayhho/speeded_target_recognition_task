function [fullpath, filename] = get_filepaths(path)

    all_files = dir(fullfile(path, '*.wav'));
    folders = {all_files(:).folder};
    filename = {all_files(:).name};
    fullpath = {};
    
    for i = 1:length(all_files)
        fullpath{i} = char(strcat(folders(i), '/', filename(i)));
    end
    
end