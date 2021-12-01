%% Init RTBox
RTBox('UntilTimeout', false); % Open RT box if hasn't
RTBox('clear');
RTBox('enable', 'sound');
RTBox('DebounceInterval', 0);
Priority(1); % prioritize timing
RTBox('ButtonNames', {'1', '2', '3', '4'})

%% Create square-wave signal with increasing amplitude
fs = 44100;
template_tone = repmat([-1*ones(1, 441), ones(1, 441)], 1, 50); % 1 sec 50 hz template tone

amplitudes = 0.00001:0.00001:0.001;
tone = [];
for i = 1:length(amplitudes)
	tone = [tone, template_tone*amplitudes(i)]; % 50 hz square wave
end

%% Start RTBox recording
timeout = length(tone)/fs;
RTBox('sound', timeout);

%% Play tone
sound(tone, fs)


