clear;
clc;

text = 'Aasdsa'

% OFFTOP
% kod Morse'a to 1 dla kropki, 111 dla kreski, 0 pomiędzy nimi, 000
% pomiędzy literami i 00000000 pomiędzy słowami (spacja)

y_binary_Morse = textToBinaryMorse(text);

qamOutput = qamCoder(y_binary_Morse, 8);

qamSignal = ifft(qamOutput);

re_qamSignal = real(qamSignal);
im_qamSignal = imag(qamSignal);

% plot(qamSignal);
% for i=1:width(re_qamSignal)
%     figure;
%     signal_to_plot = re_qamSignal(:, i);
%     plot(1:length(signal_to_plot), signal_to_plot);
% end
% 
% for i=1:width(im_qamSignal)
%     figure;
%     signal_to_plot = im_qamSignal(:, i);
%     plot(1:length(signal_to_plot), signal_to_plot);
% end

% stairs(y_binary_Morse)
% ylim([-0.5, 1.5])

ofdm_signal = OFDM_Transmitter(y_binary_Morse, 8, 2, 10);
% Dodanie zakłócenia

% wrzucenie do Receivera

% dekodowanie an tekst

% text_rev = binaryMorseToText(y_binary_Morse)
