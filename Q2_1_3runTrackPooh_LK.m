close all;
clear;
addpaths; 
imdir='data/pooh/testing/';
load('data/pooh/rects_frm992.mat');
vidout = VideoWriter('q_2_1_3pooh_lk.avi');
vidout.FrameRate = 20;
open(vidout);
start_frame=0992;
end_frame=3000;
boundary_limit=6;% to avoid out-of bounds
frame=start_frame:end_frame;
imPath=cell(length(frame),1);
for i = 1:length(frame)
    imPath{i} = fullfile(imdir,strcat('image-',num2str(frame(i),'%04d'),'.jpg'));
end
nFrm = length(frame);     % number of frames for tracking
rect=[rect_lear;
     rect_leye;
     rect_nose;
     rect_rear;
     rect_reye;];
 
 %record motion from frame t-2 to frame t-1
 prev_uv=zeros(5,2);

drawFrmPooh(imPath, rect,1);
%*********************************************************************
%get the [u,v] from first frame to second frame
It= imread(imPath{1});
It1  = imread(imPath{2});  
	
 for i = 1:size(rect,1);
    [u,v] = LucasKanade(It,It1,rect(i,:)); 
	prev_uv(i,:)=[u,v];     
	rect(i,:)  = rect(i,:) + [u,v,u,v]; % move the rectangle
 end
hf    = drawFrmPooh(imPath, rect, 2); % draw frame
frm = getframe;
writeVideo(vidout, imresize(frm.cdata, 0.5));

%*********************************************************************
%Compute the following frames

for iFrm = 3:nFrm
    It  = imread(imPath{iFrm-1});   % get previous frame
	It1 = imread(imPath{iFrm});% get current frame
    h=size(It1,1);
    w=size(It1,2);
    for i = 1:size(rect,1);
            [u,v] = LucasKanade(It,It1,rect(i,:)); % compute the displacement using LK
            % get the weighted motion
            temp_motion  = rect(i,:) + 0.7*[u,v,u,v]+0.3*[prev_uv(i,:),prev_uv(i,:)]; 
            prev_uv(i,:)=[u,v];
            % if new rectangle is too close to boundary, fix it
            if( temp_motion(1)<boundary_limit ||...
                temp_motion(2)<boundary_limit ||...
                temp_motion(3)>w-boundary_limit||....
                temp_motion(4)>h-boundary_limit)
                rect(i,:)= rect(i,:);
            else
                rect(i,:)=temp_motion;
            end
    end
	hf = drawFrmPooh(imPath, rect,iFrm); % draw frame
    frm = getframe;
	writeVideo(vidout, imresize(frm.cdata, 0.5));   
end
close(vidout);