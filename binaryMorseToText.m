function [decodedText] = binaryMorseToText(binaryMorse)
     % Definicja słownika Morse'a z rozszerzonymi znakami specjalnymi
    morseCode = containers.Map( ...
        {'.-', '-...', '-.-.', '-..', '.', '..-.', '--.', '....', '..', '.---', '-.-', '.-..', '--', ...
         '-.', '---', '.--.', '--.-', '.-.', '...', '-', '..-', '...-', '.--', '-..-', '-.--', '--..', ...
         '-----', '.----', '..---', '...--', '....-', '.....', '-....', '--...', '---..', '----.', ...
         '.-.-.-', '--..--', '..--..', '-.-.--', '---...', '-.-.-.', '-.--.', '-.--.-', '.-...', '-...-', '.-.-.', '-....-', '..--.-', '.-..-.', '...-..-', '.--.-.'}, ...
        {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', ...
         'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', ...
         '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '.', ',', '?', ...
         '!', ':', ';', '(', ')', '&', '=', '+', '-', '_', '"', '$', '@'});
    
    % Initializations
    decodedText = ''; % Final decoded text
    currentSymbol = ''; % Temporary storage for Morse symbols
    i = 1;
    
    while i <= length(binaryMorse)
        % Check for long gaps
        if i <= length(binaryMorse) - 6 && isequal(binaryMorse(i:i+6), [0 0 0 0 0 0 0])
            % Long gap (0000000) = space between words
            if ~isempty(currentSymbol)
                decodedText = [decodedText, morseCodeToChar(currentSymbol, morseCode)];
                %decodedText = strcat(decodedText, morseCodeToChar(currentSymbol, morseCode));
                currentSymbol = '';
            end
            decodedText = [decodedText, ' '];
            i = i + 7; % Skip the 0000000 gap
        elseif i <= length(binaryMorse) - 2 && isequal(binaryMorse(i:i+2), [0 0 0])
            % Short gap (000) = space between letters in the same word
            if ~isempty(currentSymbol)
                decodedText = [decodedText, morseCodeToChar(currentSymbol, morseCode)];
                %decodedText = strcat(decodedText, morseCodeToChar(currentSymbol, morseCode));
                currentSymbol = '';
            end
            i = i + 3; % Skip the 000 gap
        elseif binaryMorse(i) == 1
            % Detect dot or dash (1 or 111)
            if i <= length(binaryMorse) - 2 && isequal(binaryMorse(i:i+2), [1 1 1])
                currentSymbol = [currentSymbol, '-'];
                %currentSymbol = strcat(currentSymbol, '-'); % Dash
                i = i + 3; % Skip 111
            else
                currentSymbol = [currentSymbol, '.'];
                %currentSymbol = strcat(currentSymbol, '.'); % Dot
                i = i + 1; % Skip 1
            end
        elseif binaryMorse(i) == 0
            % Single 0 between dot/dash symbols (inside the same letter)
            i = i + 1; % Skip it
        else
            i = i + 1; % Fallback, should not happen
        end
    end

    % Append the last character (if any)
    if ~isempty(currentSymbol)
        decodedText = strcat(decodedText, morseCodeToChar(currentSymbol, morseCode));
    end
end

function char = morseCodeToChar(morseSymbol, morseCode)
    % Convert Morse symbol to character using the map
    if isKey(morseCode, morseSymbol)
        char = morseCode(morseSymbol);
    else
        char = ''; % Return empty for unrecognized symbols
        warning('Unrecognized Morse symbol: %s', morseSymbol);
    end
end