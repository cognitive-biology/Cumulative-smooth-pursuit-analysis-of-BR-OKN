function splineVel = getVelocity(gx_spline)
time = [1:size(gx_spline,2)];
v = diff(gx_spline,[],2); % numerical velocity
v = quantile(v,[0.025,0.5,0.975]); %  quantiles of numerical velocities

% interpolate to correct numerical differentiation shift
t = time(1:end-1)+diff(time)./2;
splineVel = interp1(t,v',time)';
end

