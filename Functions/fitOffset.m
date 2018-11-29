function res=fitOffset(x1,x2,y1,y2,offset)
    % prepare inputs
    x1=x1(:);
    y1=y1(:);
    x2=x2(:);
    y2=y2(:)+offset; % shift right chunk vertically
    % evaluate quality of parabolic fit with given offset
    x=[x1;x2];
    y=[y1;y2];
    p=polyfit(x,y,2);
    yf=polyval(p,x);
    res=sum((y-yf).^2);
end