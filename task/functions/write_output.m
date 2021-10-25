function write_output(subject, block, stim, stim_start, rt, correct)

    % get output filename for this subject and black
    fpath = fullfile('task', 'output', ['subj', num2str(subject), 'block' num2str(block) '.csv']);

    % create data frame
    row = [stim, table(stim_start, rt, correct)];
    row = strjoin(table2array(row), ',');
    row = strcat('\n', row);
    
    if ~(exist(fpath, 'file') == 2) % ~isfile(fpath) in later versions
        cols = strjoin([stim.Properties.VariableNames, 'stim_start,rt,correct'], ',');
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