function zero_pad_stim()
    % stim directory
    
    % loop over each stim
    
    % zero pad
    [aud, Fs] = audioread(stim);
    wavdata = zeros(length(aud)+Fs*4,1);
    
    % write
    audiowrite(filename,y,Fs)
end