function v = intervals2idx(intervalStart,intervalStop)
    %intervals2idx converts borders to indices
    % IN:
    %   intervalStart 1D array containing indexes of intervals starts
    %   intervalStop 1D array containing indexes of intervals stops
    % OUT:
    %   v array,which contains subscripts between pairs
    %   intervalStart(n):intervalStop(n)
    % COMMENTS:
    %   is reverse to idx2interval function
    % Example:
    % startIDX = [1,6,11];
    % stopIDX = [3 9 15];
    % subs = intervals2idx(intervalStart,intervalStop);
    v = zeros(1, max(intervalStop)+1);  % An array of zeroes
    v(intervalStart) = 1;              % Place 1 at the starts of the intervals
    v(intervalStop+1) = v(intervalStop+1)-1;  % Add -1 one index after the ends of the intervals
    v = find(cumsum(v));          % Perform a cumulative sum and find the nonzero entries
end

