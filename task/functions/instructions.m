function instructions(ptb, block)
    
    if block == 1  
        l = 1:5; % training instructions
    elseif block == 0
        l = 7; % end of block
    else
        l = 6; % instructions before experiment blocks
    end
    
    ListenChar(-1); % disable typing into matlab window
    
    for i = 1:length(l)
        fpath = ['task/instructions/instructions_' num2str(l(i)) '.txt'];
        txt = load_text_from(fpath);
        % make screen background black
        DrawFormattedText(ptb.window, txt, 'center', 'center', 1);
        Screen('Flip', ptb.window);
        KbPressWait();
    end
    
    fpath = 'task/instructions/wait.txt';
    txt = load_text_from(fpath);
    DrawFormattedText(ptb.window, txt, 'center', 'center', 1);
    Screen('Flip', ptb.window);
    
    ListenChar(0); % reenable typing into matlab
    
end