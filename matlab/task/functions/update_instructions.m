function update_instructions(block)
    % Insert correct block number into instructions
    txt = load_text_from('task/instructions/instructions_6_template.txt');
    block = num2str(block-1);
    txt = regexprep(txt, '<block>', block);

    % Update txt file
    fileID = fopen('task/instructions/instructions_6.txt','w');
    fprintf(fileID, txt);
    fclose(fileID);
end
