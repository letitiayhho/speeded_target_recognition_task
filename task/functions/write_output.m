function write_output(subject, block, stim, rt, pilot)

    % get output filename for this subject and black
    if pilot
        fpath = fullfile('task', 'pilot', ['subj', num2str(subject), 'block', num2str(block), '.csv']);
    else
        fpath = fullfile('task', 'output', ['subj', num2str(subject), 'block', num2str(block), '.csv']);
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
        f = fopen(fpath, 'a');
        fprintf(f, row); 
        fclose(f);
    end

end