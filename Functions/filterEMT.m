function gx_filtered = filterEMT(gx, displaySize,timeKernel)

% remove and propogate off-scale events
    gx_clean = removeOffscale(gx,displaySize,timeKernel);
% filter 'clean' EMT
    forwardFilter  = conv(gx_clean,ones(timeKernel,1)./timeKernel,'same');
    flip_gx = fliplr(gx_clean); % flip signal from left to right
    backwardFilter = conv(flip_gx,ones(timeKernel,1)./timeKernel,'same'); % moving average
    flip_backwardFilter = fliplr(backwardFilter); % flip filtered signal from left to right
    gx_filtered = mean([forwardFilter;flip_backwardFilter]);
end
