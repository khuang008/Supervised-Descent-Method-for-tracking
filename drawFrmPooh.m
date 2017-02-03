function hf = drawFrmPooh(imPath, rect, iFrm)
% display the frames and rectangle of component in
% each frame.
%
%
% imPath : the cell contains path to all frames' image
% rect: each row contains the position information of
%       different component
% iFrm: the number of the frame

hf = figure(1); clf; hold on;
I=imread(imPath{iFrm});
imshow(I);

% draw rectangle for each component
for i =1 : size(rect,1)
drawRect([rect(i,1:2),rect(i,3:4)-rect(i,1:2)],'r',3);
end
text(80,50,['frame ',num2str(iFrm+991)],'color','y','fontsize',30);
hold off;
title('Winnie tracker with Lucas-Kanade Tracker');
drawnow;