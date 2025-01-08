clear;
clc;

text = 'Aasdsa'

% OFFTOP
% kod Morse'a to 1 dla kropki, 111 dla kreski, 0 pomiędzy nimi, 000
% pomiędzy literami i 00000000 pomiędzy słowami (spacja)


y_binary_Morse = textToBinaryMorse(text);

qamOutput = qamCoder(y_binary_Morse, 2);

qamSingal = ifft(qamOutput, width(qamOutput), 1);

plot(qamSingal)
% stairs(y_binary_Morse)
% ylim([-0.5, 1.5])

%ofdm_signal = OFDM_Transmitter(y_binary_Morse, 2, 10);

% text_rev = binaryMorseToText(y_binary_Morse)
