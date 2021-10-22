% function write_output(subject, block, block_type, trial, trial_type, token, vowel, target, istarget, rt, resp, correct)
function write_output(subject, block, stim, rt, resp, correct)

    % get output filename for this subject and black
    fpath = ['task/output/subj' num2str(subject) 'block' num2str(block) '.csv'];

    % create data frame
    if ~isnan(resp)
        resp = string(resp);
    end
    row = [stim, table(rt, resp, correct)];
    row = strjoin(table2array(row), ',');
    row = strcat('\n', row);
    
    if ~(exist(fpath, 'file') == 2) % ~isfile(fpath) in later versions
        cols = strjoin([stim.Properties.VariableNames, 'rt,resp,correct'], ',');
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