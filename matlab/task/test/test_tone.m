f=400
Amp=1
fs = 44100;
ts=1/fs;
T=10
t=0:ts:T;
y=sin(2*pi*f*t);
y=y*0.05/(rms(y));
sound(y, fs)