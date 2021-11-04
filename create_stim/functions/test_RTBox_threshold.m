fs = 44100;
template_tone = repmat([-1*ones(1, 441), ones(1, 441)], 1, 50); % 1 sec 50 hz template tone

amplitudes = 0.00001:0.00001:0.001;
tone = [];
for i = 1:length(amplitudes)
	tone = [tone, template_tone*amplitudes(i)]; % 50 hz square wave
end

sound(tone, fs)

% fs = 44100;
% t = repmat(linspace(0,10), 1, 441);
% % t = linspace(0, 1, 20);
% x = square(t);
% % sound(x, fs)
% 
% n = length(x);
% y = fft(x);             % fft
% f = (0:n-1)*(fs/n);     % frequency range
% power = abs(y).^2/n;    % power of the DFT
% 
% figure(1)
% % subplot(2, 2, i)
% plot(f,power)
% title([subject, '/', vowel])
% xlim([0 2000])
% xlabel('Frequency')
% ylabel('Power')