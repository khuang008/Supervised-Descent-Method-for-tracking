function models = SDMtrain(mean_shape, annotations)
% CV Fall 2014 - Provided Code
% You need to implement the SDM training phase in this function, and
% produce tracking models for Winnie the Pooh
%
% Input:
%   mean_shape:    A provided 5x2 matrix indicating the x and y coordinates of 5 control points
%   annotations:   A ground truth annotation for training images. Each row has the format
%                  [frame_num nose_x nose_y left_eye_x left_eye_y right_eye_x right_eye_y right_ear_x right_ear_y left_ear_x left_ear_y]
% Output:
%   models:        The models that you will use in SDMtrack for tracking
%
poohpath = 'data/pooh';  
n=100;
m= size(annotations,1);
scalesToPerturb=[0.8 1.0 1.2];
perturbedConfigurations=[];
num_of_models=5;
models=cell(num_of_models,1);
% generate perturbed configurations
for i=1:m
      singleFrameAnnotation=reshape(annotations(i,2:end), 2, 5)';
      perturbedConfigurations =[perturbedConfigurations;
        genPerturbedConfigurations(singleFrameAnnotation,mean_shape,n,scalesToPerturb)];
end
% train the models
for i = 1:length(models)
    D = genDisplacementMatrix(perturbedConfigurations,annotations,n);
    F = genFeatureMatrix(perturbedConfigurations,annotations,n);
    [new_perturbedConfigurations W] = learnMappingAndUpdateConfigurations(perturbedConfigurations,F,D,m,n);
    models{i}=W;
    perturbedConfigurations=new_perturbedConfigurations;    
    loss=norm(D)  
end
   
	
end
