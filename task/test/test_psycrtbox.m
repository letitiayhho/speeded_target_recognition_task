%% once at beginning
rtbox = PsychRTBox('Open');
PsychRTBox('Start', rtbox);
PsychRTBox('Clear', rtbox); % clear buffer
PsychRTBox('ClockRatio', rtbox); % sync clocks (takes a minute)
PsychRTBox('SyncConstraints', 1, .0005); % demand less than 0.5 ms error

%% on each trial

PsychRTBox('Clear', rtbox, 1); % re-sync RTBox clock

% collect time from RTBox
max_wait = .5;
[t_press, ~, ~] = PsychRTBox('GetSecs', rtbox, max_wait, [], 1);


%% once at end
% close RTBox connection
PsychRTBox('CloseAll');

%% test sync time
tic;
PsychRTBox('Clear', rtbox, 1);
toc

%% test sync time
tic;
RTBox('Clear');
toc



