function [SwitchTime, Percept,crossingDirection,thresholdCrossed] = getReversals(splineVel, splineVelThreshold)
Switches = [];
% find crosses of upper threshold
tcrossings1 = find([0 diff(sign(splineVel(2,:)-splineVelThreshold))]); 
thresholdCrossed1 = ones(1,numel(tcrossings1));
crossingDirection1 = sign(splineVel(2,tcrossings1)-splineVel(2,tcrossings1-1));
% find crosses of lower threshold
tcrossings2 = find([0 diff(sign(splineVel(2,:)+splineVelThreshold))]);
thresholdCrossed2 = -ones(1,numel(tcrossings2));
crossingDirection2 = sign(splineVel(2,tcrossings2)-splineVel(2,tcrossings2-1));
% merge crossings
tcrossings = [tcrossings1,tcrossings2];
crossingDirection = [crossingDirection1,crossingDirection2];
thresholdCrossed = [thresholdCrossed1,thresholdCrossed2];
% find intervals, where all charachteristic curves are negative
allNegative = sum(splineVel<=-splineVelThreshold)==3;
idx = allNegative==1; 
intervalStart = find([idx(1), diff(idx)==1]); 
intervalStop = find([diff(idx)==-1, idx(end)]);
% for each interval find the closest left and right lower threshold crosses
for iInterval = 1:numel(intervalStart)
   idx = (tcrossings<=intervalStart(iInterval))... % find threshold crosses on the left from interval
       &(crossingDirection==-1)&(thresholdCrossed==-1); % subset only downward crosses of lower threshold
   idx = find(idx,1,'last'); % choose the nearest crossing
   Switches = [Switches;[tcrossings(idx),crossingDirection(idx),thresholdCrossed(idx)]];
   idx = (tcrossings>=intervalStop(iInterval))...% find threshold crosses on the right from interval
       &(crossingDirection==1)&(thresholdCrossed==-1);% subset only upward crosses of lower threshold
   idx = find(idx,1,'first');% choose the nearest crossing
   Switches = [Switches;[tcrossings(idx),crossingDirection(idx),thresholdCrossed(idx)]];
end

% find intervals, where all charachteristic curves are positive
allPositive = sum(splineVel>=splineVelThreshold)==3;
idx = allPositive==1; 
intervalStart = find([idx(1), diff(idx)==1]); 
intervalStop = find([diff(idx)==-1, idx(end)]);
% for each interval find the closest left and right upper threshold crosses
for iInterval = 1:numel(intervalStart)
   idx = (tcrossings<=intervalStart(iInterval))...% find threshold crosses on the left from interval
       &(crossingDirection==1)&(thresholdCrossed==1);% subset only upward crosses of upper threshold
   idx = find(idx,1,'last');% choose the nearest crossing
   Switches = [Switches;[tcrossings(idx),crossingDirection(idx),thresholdCrossed(idx)]];
   idx = (tcrossings>=intervalStop(iInterval))...% find threshold crosses on the right from interval
       &(crossingDirection==-1)&(thresholdCrossed==1);% subset only downward crosses of lower threshold
   idx = find(idx,1,'first');% choose the nearest crossing
   Switches = [Switches;[tcrossings(idx),crossingDirection(idx),thresholdCrossed(idx)]];
end

Switches = unique(Switches,'rows');
thresholdCrossed = Switches(:,2);
crossingDirection = Switches(:,2);
SwitchTime = Switches(:,1);
Percept = sign(Switches(:,2)+Switches(:,3));

end

