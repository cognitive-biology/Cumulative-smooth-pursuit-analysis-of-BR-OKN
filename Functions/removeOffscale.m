
function gx = removeOffscale(gx,displaySize,timeKernel)
    gx(or(gx<displaySize(1),gx>displaySize(2)))=nan; % remove off-scale events
    [gapStart, gapStop] = idx2intervals(isnan(gx),1); % find gaps
    % extend gaps
    gapStart = gapStart - timeKernel;
    gapStop = gapStop + timeKernel;
    % check that we are in range from 1 to track duration
    gapStart(gapStart<1) = 1;
    gapStop(gapStop>numel(gx)) = numel(gx);
    % remove possible duplicates
    gapStart = unique(gapStart);
    gapStop  = unique(gapStop);
    % remove adjoining parts
    idx = intervals2idx(gapStart,gapStop);
    gx(idx) = nan; 
end
