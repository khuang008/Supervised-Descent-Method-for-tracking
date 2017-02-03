function [updated_perturbedConfigurations W] = learnMappingAndUpdateConfigurations(perturbedConfigurations,F,D,m,n)

%perturbedConfigurations: (4Xm)X(5Xn)
% F : mnx640 Feature matrix
% D : mn x 10 Displacement matrix
% W : 640 x 10 learned linear mapping
    W = learnLS(F,D);
  updated_perturbedConfigurations=perturbedConfigurations;
    
    for i = 1 :m
        for j = 1:n
            f = F((i-1)*n+j,:);% f 
            predict_d= f*W;%1X10
            predict_d=reshape(predict_d',2,5);
            updated_perturbedConfigurations(i*4-3:i*4-2,j*5-4:j*5)=perturbedConfigurations(i*4-3:i*4-2,j*5-4:j*5)+predict_d;            
        end         
    end
end