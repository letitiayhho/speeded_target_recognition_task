function response = ask_for_response(ptb)

    ListenChar(-1); % suppresses typing into matlab command window
    response = Ask(ptb.window, 'Type your response: ', 1, 0, ...
        'GetChar', 'center', 'center');
    ListenChar(0); % renables matlab command window
    
end