function [outputMorse] = textToBinaryMorse(text)
    % Definicja słownika Morse'a z rozszerzonymi znakami specjalnymi
    morseCode = containers.Map( ...
        {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', ...
         'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', ...
         '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '.', ',', '?', ...
         '!', ':', ';', '(', ')', '&', '=', '+', '-', '_', '"', '$', '@'}, ...
        {'.-', '-...', '-.-.', '-..', '.', '..-.', '--.', '....', '..', '.---', '-.-', '.-..', '--', ...
         '-.', '---', '.--.', '--.-', '.-.', '...', '-', '..-', '...-', '.--', '-..-', '-.--', '--..', ...
         '-----', '.----', '..---', '...--', '....-', '.....', '-....', '--...', '---..', '----.', ...
         '.-.-.-', '--..--', '..--..', '-.-.--', '---...', '-.-.-.', '-.--.', '-.--.-', '.-...', '-...-', '.-.-.', '-....-', '..--.-', '.-..-.', '...-..-', '.--.-.'});
    
    % Dodanie spacji jako 0000000 między słowami
    spaceCode = '0000'; % tylko 4 zera po 3 są już stawiane po literze

    % Zamiana tekstu na wielkie litery
    text = upper(text);
    
    % Tworzenie sygnału Morse'a jako tablicy binarnej
    outputMorse = [];
    for i = 1:length(text)
        if text(i) == ' ' % Spacja między słowami
            % Dodaj odstęp między słowami
            outputMorse = [outputMorse, str2num(spaceCode')']; % Zamiana na binarną reprezentację
        elseif isKey(morseCode, text(i))
            % Zamień znak na kod Morse'a
            morseSymbol = morseCode(text(i)); % Pobranie kodu Morse'a
            binarySymbol = morseToBinary(morseSymbol); % Zamiana na binarną tablicę
            outputMorse = [outputMorse, binarySymbol, 0, 0, 0]; % Dodanie odstępu między literami
        else
            %warning('Znak "%s" nie został znaleziony w mapie Morse`a.', text(i));
        end
    end
    
    % Usuń nadmiarowe odstępy po ostatnim znaku
    if length(outputMorse) > 3
        outputMorse = outputMorse(1:end-3); % Usuń ostatnie 000 po znaku
    end
end

function binaryOutput = morseToBinary(morseSymbol)
    % Konwertuje ciąg Morse'a na tablicę binarną
    % '.' = 1, '-' = 111, odstęp wewnątrz litery = 0
    binaryOutput = [];
    for i = 1:length(morseSymbol)
        if morseSymbol(i) == '.'
            binaryOutput = [binaryOutput, 1];
        elseif morseSymbol(i) == '-'
            binaryOutput = [binaryOutput, 1, 1, 1];
        end
        % Dodaj odstęp (0) między elementami wewnątrz litery
        if i < length(morseSymbol)
            binaryOutput = [binaryOutput, 0];
        end
    end
end