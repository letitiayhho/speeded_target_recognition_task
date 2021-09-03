% Number of talkers to select
n_talkers = 2;

% Possible talkers
talkers = "talker" + [1:12];

% Select the talkers
talkers = talkers(randi(length(talkers), 1, n_talkers));

% Sample from the talkers 16 times
talker_order = datasample(talkers, 16)