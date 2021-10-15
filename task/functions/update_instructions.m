function update_instructions(block, target_key)
    % Identify the key for different pairs
    keys = ['c', 'm'];
    not_target_key = keys(keys ~= target_key);
    block = num2str(block-1);

    %% Instructions_2.txt
    % Load instructions and replace "same" with "different"
    txt = load_text_from('task/instructions/instructions_2_template.txt');
    txt = regexprep(txt, '<target_key>', target_key);
    txt = regexprep(txt, '<not_target_key>', not_target_key);

    % Update txt file
    fileID = fopen('task/instructions/instructions_2.txt','w');
    fprintf(fileID, txt);
    fclose(fileID);
    
    %% Instructions_7.txt
    % Load instructions and replace "same" with "different"
    txt = load_text_from('task/instructions/instructions_7_template.txt');
    txt = regexprep(txt, '<target_key>', target_key);
    txt = regexprep(txt, '<not_target_key>', not_target_key);

    % Update txt file
    fileID = fopen('task/instructions/instructions_7.txt','w');
    fprintf(fileID, txt);
    fclose(fileID);
    
    %% Instructions_8.txt
    % Load instructions and replace "same" with "different"
    txt = load_text_from('task/instructions/instructions_8_template.txt');
    txt = regexprep(txt, '<target_key>', target_key);
    txt = regexprep(txt, '<not_target_key>', not_target_key);
    txt = regexprep(txt, '<block>', block);

    % Update txt file
    fileID = fopen('task/instructions/instructions_8.txt','w');
    fprintf(fileID, txt);
    fclose(fileID);
end