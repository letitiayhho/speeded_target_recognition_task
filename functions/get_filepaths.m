function [filepaths] = get_filepaths(path)

    all_files = dir(fullfile(path, '*.wav'));
    folders = {all_files(:).folder};
    names = {all_files(:).name};
    filepaths = {};
    
    for i = 1:length(all_files)
        filepaths{i} = char(strcat(folders(i), '/', names(i)));
    end
    
end