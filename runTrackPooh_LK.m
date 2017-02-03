% I generate path for each frame, and in each frame, use the LK to calculate 
% the motion of each component. If a new location get too close to
% boundary, I just fix it in this frame to avoid out-of-bounds problem.
% I also write a drawFrmPooh fucnction to 
% display the result for each frame.
close all;
clear;
addpaths; 
imdir='data/pooh/testing/';
load('data/pooh/rects_frm992.mat');
vidout = VideoWriter('pooh_lk.avi');
vidout.FrameRate = 20;
open(vidout);
start_frame=0992;
end_frame=3000;
frame=start_frame:end_frame;
% get the path of each frames
imPath=cell(length(frame),1);
for i = 1:length(frame)
    imPath{i} = fullfile(imdir,strcat('image-',num2str(frame(i),'%04d'),'.jpg'));
end
nFrm = length(frame);     % number of frames for tracking
% the rect is organized in following way
rect=[rect_lear;
      rect_leye;
      rect_nose;
      rect_rear;
      rect_reye;];
  
% limit I set to avoid the rectangle get too close to bound
boundary_limit=5; 
drawFrmPooh(imPath, rect,1);
I= imread(imPath{1});
h=size(I,1);
w=size(I,2);
for iFrm = 2:nFrm
	It    = imread(imPath{iFrm-1});   % get previous frame
	It1   = imread(imPath{iFrm});% get current frame   
    for i = 1:size(rect,1);  
        % compute the displacement using LK
        [u,v] = LucasKanade(It,It1,rect(i,:)); 
        temp_motion = rect(i,:) + [u,v,u,v]; 
        % if new rectangle is too close to bound, fix it
        if(temp_motion(1)<boundary_limit||...
           temp_motion(2)<boundary_limit||...
           temp_motion(3)>w-boundary_limit||...
           temp_motion(4)>h-boundary_limit)
            rect(i,:)=rect(i,:);
        else
            rect(i,:)=temp_motion;
        end
        
    end
    hf    = drawFrmPooh(imPath, rect, iFrm); % draw frame
    frm = getframe;
	writeVideo(vidout, imresize(frm.cdata, 0.5));   
end
close(vidout);
