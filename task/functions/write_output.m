function write_output(subject, block, block_type, trial, trial_type, token, vowel, target, istarget, rt, resp, correct)

    % get output filename for this subject and black
    fpath = ['task/output/subj' num2str(subject) 'block' num2str(block) '.csv'];

    row = {num2str(subject), num2str(block), char(block_type), num2str(trial),...
        char(trial_type), num2str(token), char(vowel), target, num2str(istarget),...
        num2str(rt), num2str(resp), num2str(correct)};
    row = strjoin(row, ',');
    row = ['\n' row];
    
    if ~(exist(fpath, 'file') == 2) % ~isfile(fpath) in later versions
        cols = 'subject,block,block_type,trial,trial_type,token,vowel,target,istarget,rt,resp,correct';
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