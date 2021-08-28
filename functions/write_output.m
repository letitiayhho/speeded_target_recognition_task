function write_output(subject, block, trial, stim, resp)

    % get output filename for this subject and black
    fpath = ['output/subj' num2str(subject) 'block' num2str(block) '.csv'];

    fname = regexp(stim, '[a-zA-Z]+.wav', 'match');
    word = fname{1}(1:end-4);
    row = {num2str(subject), num2str(block), num2str(trial), word, resp};
    row = strjoin(row, ',');
    row = ['\n' row];
    
    if ~(exist(fpath, 'file') == 2) % ~isfile(fpath) in later versions
        cols = 'subject,block,trial,word,response';
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