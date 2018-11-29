function gx_spline = splineEMT(gx_cont,nSplines, subsampleFactor)
    time = [1:numel(gx_cont)];
    notNaNtime=time(~isnan(gx_cont)); % find all retained time points
    nKnots=round(numel(notNaNtime).*subsampleFactor); % define number of knots for each spline
    gx_spline = nan(nSplines,numel(time));
    for iRep =1:nSplines
        knots = sort(notNaNtime(randperm(numel(notNaNtime),nKnots))); % define knots position for a given subsample
        % interpolate only in knots range (no extrapolation)
        range_idx = [knots(1):knots(end)];
        time_interp = time(range_idx);
        s= interp1(knots,gx_cont(knots),time_interp,'pchip');
        s_int = nan(1,numel(time));
        s_int(range_idx) = s;
        %
        gx_spline(iRep,:) = s_int;
    end
end

