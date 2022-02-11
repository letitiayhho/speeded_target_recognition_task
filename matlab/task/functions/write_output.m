function write_output(subject, block, version, stim, rt, pilot)

    % get output filename for this subject and black
    filename = ['subj', num2str(subject), 'block', num2str(block), char(version), '.csv'];
    if pilot
        fpath = fullfile('data', 'pilot', filename);
    else
        fpath = fullfile('data', 'experiment', filename);
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
        f = fopen(fpath, 'a'); % if file already exists then just append
        fprintf(f, row); 
        fclose(f);
    end

end