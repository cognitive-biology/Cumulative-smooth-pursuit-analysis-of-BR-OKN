function [intervalStart, intervalStop] = idx2intervals(x, val)
    %idx2intervals converts indices of define value to borders
    % IN:
    %   x   : 1D array 
    %   val : one number, repeated intervals of which we need to detect
    % OUT:
    %   intervalStart 1D array containing indexes of intervals starts
    %   intervalStop 1D array containing indexes of intervals stops
    % COMMENTS:
    %   is reverse to interval2idx function
    % Example:
    % x = [1 2 3 4 4 4 4 5 6 7];
    % [intervalStart, intervalStop] = findChunkBorders(x, 4);
    idx = (x==val);
    intervalStart = find([idx(1), diff(idx)==1]);
    intervalStop = find([diff(idx)==-1, idx(end)]);

end

