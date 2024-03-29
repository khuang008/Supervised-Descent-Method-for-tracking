% CV Fall 2014 - Provided Code
% DO NOT MODIFY THIS SCRIPT!!!! THIS SCRIPT WILL BE USED FOR GRADING.
% MAKE SURE YOUR SUBMISSION CAN RUN THIS SCRIPT

% Add paths to provided functions
addpaths;

% Load provided mean shape
% mean_shape format : [nose_x nose_y; left_eye_x left_eye_y; right_eye_x; right_eye_y; right_ear_x right_ear_y; left_ear_x left_ear_y]
mean_shape = importdata('data/pooh/mean_shape.mat');

% Load annotations
% Annotation format for each row: 
% [frame_num nose_x nose_y left_eye_x left_eye_y right_eye_x right_eye_y right_ear_x right_ear_y left_ear_x left_ear_y]
ann = load('data/pooh/ann');

% Train SDM model
model = SDMtrain(mean_shape, ann);

% Run tracking on provided test video and save tracking result to video
% 1st argument: model learned
% 2nd argument: mean shape
% 3rd argument's format is: [nose_x nose_y; left_eye_x left_eye_y; right_eye_x right_eye_y; right_ear_x right_ear_y; left_ear_x left_ear_y]
% 4th argument: start frame
% 5th argument: output_video_name
init_shape = [362 339; 433 261; 304 258; 322 82; 464 106];
frm_index  = 992;
SDMtrack(model, mean_shape, init_shape, frm_index, 'pooh_sdm.avi');
