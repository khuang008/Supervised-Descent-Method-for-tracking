close all;
clear;
addpaths;
poohpath = 'data/pooh';
ms = importdata(fullfile(poohpath, 'mean_shape.mat'));
ann = load(fullfile(poohpath,'ann'));
models=SDMtrain(ms, ann);
save('models.mat','models');