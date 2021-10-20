function instructions(ptb, block)
    
    if block == 1  
        l = 1:5; % training instructions
    elseif ismember(block, [2 3 4 5])
        l = 6; % instructions before experiment blocks
    elseif block == 0 
        l = 7; % end of block   
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
    ListenChar(0); % reenable typing into matlab
    
end