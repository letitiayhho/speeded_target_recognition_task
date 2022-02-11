function write_output(subject, block, stim, rt, pilot, version)

    % get output filename for this subject and black
    if pilot
        fpath = fullfile('data', 'pilot', ['subj', num2str(subject), 'block', num2str(block), version, '.csv']);
    else
        fpath = fullfile('data', 'experiment', ['subj', num2str(subject), 'block', num2str(block), version, '.csv']);
    end

    % create data frame
    row = [stim, table(rt)];
    row = strjoin(table2array(row), ',');
    row = strcat('\n', row);
    
    if ~(exist(fpath, 'file') == 2) % ~isfile(fpath) in later versions
        cols = strjoin([stim.Properties.VariableNames, 'rt'], ',');
        row = strcat(cols, row);
        f = fopen(fpath, 'wt'); 
        fprintf(f, row);
        fclose(f);
    else
        warning('File already exists')
        fpath = insertBefore(fpath, '.csv', '_1');
        f = fopen(fpath, 'a');
        fprintf(f, row); 
        fclose(f);
    end

end