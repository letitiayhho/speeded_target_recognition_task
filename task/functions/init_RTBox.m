function init_RTBox(rtbox)
% sets up RTBox for sending well-timed triggers over TTL

    if ~rtbox
        RTBox('fake', 1);
    end

    RTBox('UntilTimeout', false); % Open RT box if hasn't
    RTBox('clear');
    RTBox('DebounceInterval', 0);
    Priority(1); % prioritize timing
    RTBox('TTLWidth', 0.00056); % need if sending multiple consecutively

end