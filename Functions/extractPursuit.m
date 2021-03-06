function gx = extractPursuit(gx,displaySize,timeKernel,velThreshold,aThreshold)
    gx_filtered =  filterEMT(gx, displaySize,timeKernel);
    gx(isnan(gx_filtered)) = nan; 
    time = [1:numel(gx)];
    % find velocity curve
    v = diff(gx_filtered);
    t = time(1:end-1)+diff(time)./2;
    gx_vel = interp1(t,v,time);
    % find acceleration curve
    a = diff(gx_vel);
    gx_a = interp1(t,a,time);
    % find fast segments
    idx = or(abs(gx_vel)>=velThreshold, abs(gx_a)>=aThreshold); % find fast segments 
    % remove fast segments
    gx(idx) = nan;
    % find slow segments intervals
    [slowStart, slowStop] = idx2intervals(~isnan(gx),1);
    slowDuration = slowStop-slowStart;
    % exclude short pursuits
    shortPhases = find(slowDuration<timeKernel); 
    idx = intervals2idx(slowStart(shortPhases),slowStop(shortPhases));
    gx(idx) = nan;
end

