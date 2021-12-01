function [secs, file_order] = compute_vowel_spectra()
    cd('/Users/letitiaho/src/speeded_target_recognition_task')
    paths = dir('stim/*/*.wav');
    secs = zeros(length(paths), 1);
    file_order = [];
    for i = 1:3
        filepath = fullfile(paths(i).folder, paths(i).name);
        
        % Extract file information
        path_parts = split(paths(i).folder, '/');
        subject = char(path_parts(end));
        [~,vowel,~]  = fileparts(filepath);
        vowel = vowel(1:2);
        
        % Read file and compute frequency spectra
        [y, fs] = audioread(filepath);
        n = length(y);          % number of samples
        y = fft(y);             % fft
        f = (0:n-1)*(fs/n);     % frequency range
        power = abs(y).^2/n;    % power of the DFT
        
        figure(1)
        subplot(2, 2, i)
        plot(f,power)
        title([subject, '/', vowel])
        xlim([0 2000])
        xlabel('Frequency')
        ylabel('Power')
        
%         subplot(2, 2, i+2)
%         spectrogram(y, 100, 1, 10000, fs, 'yaxis');
%         title(files(i))
    end
end