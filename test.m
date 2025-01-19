clear;
clc;

%text = 'Aasdsa Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam lacinia.'
text = 'aaa';
% OFFTOP
% kod Morse'a to 1 dla kropki, 111 dla kreski, 0 pomiędzy nimi, 000
% pomiędzy literami i 00000000 pomiędzy słowami (spacja)

y_binary_Morse = textToBinaryMorse(text);
disp(y_binary_Morse)

% qamOutput = qamCoder(y_binary_Morse, 8);

% qamSignal = ifft(qamOutput);
% 
% re_qamSignal = real(qamSignal);
% im_qamSignal = imag(qamSignal);

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

% figure;
% plot(1:length(ofdm_signal), ofdm_signal);

received_binary = OFDM_Receiver(ofdm_signal, 8, 2, 10);
%disp(y_binary_Morse)
%disp(received_binary)
text_out = binaryMorseToText(received_binary)
% Dodanie zakłócenia

% wrzucenie do Receivera

% dekodowanie an tekst

% text_rev = binaryMorseToText(y_binary_Morse)
% a = 1; % Minimum integer value
% b = 100; % Maximum integer value
% 
% aa = 0.001; % Minimum value
% bb = 0.999; % Maximum value
% tests_number = 100000000
% for i = 1:tests_number
% 
%     order = randi([a, b]);
%     Wn = aa + (bb - aa) * rand;
% 
%     received_binary = OFDM_Receiver(ofdm_signal, 8, 2, 10, order, Wn);
%     text_out = binaryMorseToText(received_binary);
%     %disp(i)
%     if strcmp(text, text_out)
%         disp('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!')
%     end
% end
