close all;
clear;
addpaths;
poohpath = 'data/pooh';
load('models.mat');
mean_shape = importdata('data/pooh/mean_shape.mat');
ann = load('data/pooh/ann');

init_shape = [362 339; 433 261; 304 258; 322 82; 464 106];
frm_index  = 992;
SDMtrack(models, mean_shape, init_shape, frm_index, 'pooh_sdm.avi');
