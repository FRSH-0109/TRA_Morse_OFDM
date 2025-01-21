function received_binary = OFDM_Receiver(received_signal_re, received_signal_im, n, A, fc)
%OFDM_RECEIVER Function reprezents the OFDM modulation receiver

% re_carrier = A.*sin((2*pi*(1/fc))*(1:length(received_signal)));
% im_carrier = A.*cos((2*pi*(1/fc))*(1:length(received_signal)));

fs = 1e6; % Sampling frequency

% modulated_re = received_signal.*re_carrier;
% modulated_im = received_signal.*im_carrier;

% [num, dem] = butter(10, fc*2/fs, "low");
modulated_re = received_signal_re; % amdemod(received_signal, fc, fs, 0, 0, num, dem);
modulated_im = received_signal_im; % amdemod(received_signal, fc, fs, pi/2,0, num, dem);

re_filtered = modulated_re;
im_filtered = modulated_im;

% Low-pass filter to remove double-frequency components
% Use MATLAB's built-in lowpass function
% re_filtered = lowpass(modulated_re, fc/2, fs); % In-phase component
% im_filtered = lowpass(modulated_im, fc/2, fs); % Quadrature component


% % Wykres do testów
% figure();
% plot(1:length(re_carrier), re_carrier);
% legend('re carier rx ');
% 
% figure();
% plot(1:length(received_signal), received_signal);
% legend('received_signal rx');
% figure();
% plot(1:length(modulated_re), modulated_re);
% legend('re modulated rx');

% figure();
% plot(1:length(modulated_re), modulated_re);
% hold on;
% plot(1:length(re_carrier), re_carrier);
% legend("modulated re", "re carrier");

% figure(4);
% plot(1:length(modulated_im), modulated_im);
% hold on;
% plot(1:length(im_carrier), im_carrier);
% legend("modulated im", "im carrier");

% Parametry
order = 10; % do sprawk - 50, 100, 800
Wn = 0.5; % do sprawka - 0.025, 0.03, 0.0275

% Zaprojektowanie filtru
% b = fir1(order, Wn, 'low');
% 
% % Wyświetlanie wyników
% 
% figure(5);
% freqz(b, 1, 1000);
% 
% re_filtered = filter(b, 1, modulated_re);
% im_filtered = filter(b, 1, modulated_im);

% re_filtered = lowpass(modulated_re, 100, 1000);
% im_filtered = lowpass(modulated_im, 100, 1000);

% re_filtered = modulated_re;
% im_filtered = modulated_im;

% Wykres do testów
% figure(6);
% plot(1:length(modulated_re), modulated_re);
% hold on;
% plot(1:length(re_filtered), re_filtered);
% legend("modulated re", "re filtered");
% 
% figure(7);
% plot(1:length(modulated_im), modulated_im);
% hold on;
% plot(1:length(im_filtered), im_filtered);
% legend("modulated im", "im filtered");

filtered_signal = complex(re_filtered, im_filtered);
signal_sizes = [n, round(length(filtered_signal) / n)];
filtered_frames = reshape(filtered_signal, signal_sizes);

fft_bins = fft(filtered_frames, n, 1);
%disp(fft_bins)

received_binary = qamDecoder(fft_bins);

%received_binary = "01001110 01100101 01110110 01100101 01110010 00100000 01000111 01101111 01101110 01101110 01100001 00100000 01000111 01101001 01110110 01100101 00100000 01011001 01101111 01110101 00100000 01010101 01110000";
end

