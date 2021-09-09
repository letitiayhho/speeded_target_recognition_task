function write_output(subject, block, trial, vowel, rt, resp, correct)

    % get output filename for this subject and black
    fpath = ['task/output/subj' num2str(subject) 'block' num2str(block) '.csv'];

    row = {num2str(subject), num2str(block), num2str(trial), char(vowel),...
        num2str(rt), num2str(resp), num2str(correct)};
    row = strjoin(row, ',');
    row = ['\n' row];
    
    if ~(exist(fpath, 'file') == 2) % ~isfile(fpath) in later versions
        cols = 'subject,block,trial,vowel,rt,resp,correct';
        row = [cols row];
        f = fopen(fpath, 'wt'); 
        fprintf(f, row);
        fclose(f);
    else
        f = fopen(fpath, 'a');
        fprintf(f, row); 
        fclose(f);
    end

end