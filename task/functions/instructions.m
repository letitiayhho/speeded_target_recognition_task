function instructions(ptb, block)
    
    if block == 1  
        l = 1:6; % overall instructions
    elseif block == 2
        l = 2; % instructions before training block 2
    elseif ismember(block, [3 4 5 6])
        l = 8; % instructions before experiment blocks
    elseif block == 0 
        l = 9; % end of block   
    end
    
%     ListenChar(-1); % disable typing into matlab window
    for i = 1:length(l)
        fpath = ['task/instructions/instructions_' num2str(l(i)) '.txt'];
        txt = load_text_from(fpath);
        % make screen background black
        DrawFormattedText(ptb.window, txt, 'center', 'center', 1);
        Screen('Flip', ptb.window);
        KbPressWait();
    end
%     ListenChar(0); % reenable typing into matlab
    
end


function [txt] = load_text_from(fpath)
    txt = importdata(fpath);
    txt = strjoin(txt, '\n');
end