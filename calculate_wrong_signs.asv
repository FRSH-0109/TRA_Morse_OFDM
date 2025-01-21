function mistake_count = calculate_wrong_signs(received_data, correct_data)
%CALCULATE_WRONG_SIGNS Functions calculate how many mistakes are in
% received data
%   Detailed explanation goes here
mistake_count = 0; % Inicjacja licznika

% Sprawdzenie czy dane są równej długości
if length(received_data) ~= length(correct_data)
    mistake_count = "Incorrect data sizes";
    return
elseif isequal(received_data, correct_data) % Sprawdzamy czy sygnały są identyczne
    mistake_count = 0; % Jeśli tak to wszystkie bity są poprawne
    return
else
    % Zliczenie błędnych bitów
    for i=1:length(received_data)
        if received_data(i) ~= correct_data(i)
            mistake_count = mistake_count + 1;
        end
    end
end

