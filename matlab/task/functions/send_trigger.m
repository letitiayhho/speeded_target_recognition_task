function [t0] = send_trigger(event_num)
% Sends TTL pulse with event number (1-16) over RTBox to pycorder

    t0 = RTBox('TTL', get_trigger(event_num));

end

function sv = get_trigger(desiredvalue)
% Converts PyCorder Triggers S1-S16 to trigger codes sent through RTBox

    dv = desiredvalue;
    pin(1) = 64;
    pin(2) = 32;
    pin(3) = 16;
    pin(4) = 8;

    switch dv
        case 1
            sv = pin(1);
        case 2
            sv = pin(2);
        case 3
            sv = pin(1)+pin(2);
        case 4
            sv = pin(3);
        case 5
            sv = pin(1)+pin(3);
        case 6
            sv = pin(2)+pin(3);
        case 7
            sv = pin(1)+pin(2)+pin(3);
        case 8;
            sv = pin(4);
        case 9;
            sv = pin(1)+pin(4);
        case 10
            sv = pin(2)+pin(4);
        case 11;
            sv = pin(1)+pin(2)+pin(4);
        case 12
            sv = pin(3)+pin(4);
        case 13
            sv = pin(1)+pin(3)+pin(4);
        case 14
            sv = pin(2)+pin(3)+pin(4);
        case 15
            sv = pin(1)+pin(2)+pin(3)+pin(4);
        case 16
            sv = pin(1)+pin(1)+pin(2)+pin(3)+pin(4);
        otherwise
            error('Trigger Value Exceeds Limits (1-16)');
    end

end