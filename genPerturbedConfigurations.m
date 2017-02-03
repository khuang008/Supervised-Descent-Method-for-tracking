function perturbedConfigurations = genPerturbedConfigurations(singleFrameAnnotation,meanShape, n, scalesToPerturb)
%% Compute perturbedConfigurations for a single frame
% Input:
%   singleFrameAnnotation:a 5-by-2 matrix storing the ground truth (x; y) locations
%   meanShape: a 5-by-2 matrix storing the mean shape
%   n : a scalar which species how many perturbed congurations to be
%   scalesToPerturb : a vector which species how many different scales to scale the mean shape 
% Output:
%   perturbedConfigurations is a 4-by-(n*5) matrix

    num_of_component=size(singleFrameAnnotation,1);
    perturbedConfigurations= zeros(4,n*num_of_component);
    
    max_pertub=10;% the max pixels movement between frames;
    %Initialize the meanshape
    scale = findscale(singleFrameAnnotation,meanShape);
    meanShape =meanShape./scale;
    trans=mean(singleFrameAnnotation-meanShape);
    meanShape= meanShape+repmat(trans,num_of_component,1);
   
    % generate perturbedConfigurations
    for i = 1:n
        translation= floor([max_pertub*(rand-0.5),max_pertub*(rand-0.5)]);
        translation= repmat(translation,num_of_component,1);
        temp_mean_shape = meanShape+translation;
        randscale = scalesToPerturb(floor(rand*length(scalesToPerturb)+1));
        temp_mean_shape = temp_mean_shape*randscale;
        perturbedConfigurations(1:2,num_of_component*(i-1)+1:num_of_component*i)= temp_mean_shape';
        perturbedConfigurations(3,num_of_component*(i-1)+1:num_of_component*i) = [7 4 4 10 10]./randscale./scale;
    end
end