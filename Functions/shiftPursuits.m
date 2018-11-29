function gx_cont = shiftPursuits(gx,timeKernel)
    % find slow segments
    [slowStart, slowStop] = idx2intervals(~isnan(gx),1);
    % prepare to shift
    gx_cont = gx; % gx_cont would contain continious shifted record
    % prepare fmincom solver
    options = optimoptions('fmincon','Display','off','Algorithm','active-set');
    warning off

    for iPhase = 1:(numel(slowStart)-1)
        % find left 50 ms segment
        leftX =  [(slowStop(iPhase)-timeKernel):slowStop(iPhase)];
        leftY = gx_cont(leftX);
        % find right 50 ms segment
        rightX = [slowStart(iPhase+1):(slowStart(iPhase+1)+timeKernel)]; % find right segment
        rightY = gx_cont(rightX);
        % initial offset
        offset0=leftY(end)-rightY(1);
        % find best offset
        model=@(offset) fitOffset(leftX,rightX,leftY,rightY,offset);
        newOffset = fmincon(model,offset0,[],[],[],[],[],[],[],options);
        % offset right slow phase
        gx_cont(slowStart(iPhase+1):slowStop(iPhase+1))= gx_cont(slowStart(iPhase+1):slowStop(iPhase+1))+newOffset;
    end
        warning on

end

