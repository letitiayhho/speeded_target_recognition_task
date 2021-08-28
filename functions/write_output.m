function write_output(subject, block, trial, stim, stim_start, stim_end, pressed, rt, resp)

    % get output filename for this subject and black
    fpath = ['output/subj' num2str(subject) 'block' num2str(block) '.csv'];

    stim = split(stim, '/');
    word = char(stim(end));
    row = {num2str(subject), num2str(block), num2str(trial), word,...
        num2str(stim_start), num2str(stim_end), num2str(pressed),...
        num2str(rt), num2str(resp)};
    row = strjoin(row, ',');
    row = ['\n' row];
    
    if ~(exist(fpath, 'file') == 2) % ~isfile(fpath) in later versions
        cols = 'subject,block,trial,word,stim_start,stim_end,pressed,rt,resp';
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