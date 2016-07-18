%%Test

num_params = 1;

Fs = 1000;            % Sampling frequency
T = 1/Fs;             % Sampling period
L = 1000;             % Length of signal
t = (0:L-1)*T;

rawdata = 0.7*sin(2*pi*50*t) + sin(2*pi*120*t);

colors = winter(num_params);

L = size(rawdata,2);

if(mod(L,2)==1)
    rawdata = rawdata(:,1:end-1);
    L = L-1;
end

hold on;
for i=1:1:num_params
    Y = fft(rawdata(i,:));
    P2 = abs(Y/L);
    f = (0:(L/2));

    P1 = P2(1:L/2+1);

    P1(2:end-1) = 2*P1(2:end-1);
    plot(f,P1,'Color',colors(i,:));
end
title('Single-Sided Amplitude Spectrum of X(t)');
xlabel('f (Hz)');
ylabel('|P1(f)|');
%axis([0 0.2 -inf inf]);
hold off;