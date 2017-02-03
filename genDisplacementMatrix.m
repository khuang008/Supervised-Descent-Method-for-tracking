function D = genDisplacementMatrix(perturbedConfigurations,ann,n)
%% prepare the displacement matrix D
% ann annotations
%
    m= size(ann,1);
    D=[];
    for i=1:m
      singleFrameAnnotation=reshape(ann(i,2:end), 2, 5)';
          for j = 1 : n
              displacement = singleFrameAnnotation'-perturbedConfigurations(4*i-3:4*i-2,5*j-4:5*j);
              d= reshape(displacement,1,[]);
              D=[D;d];  
          end
    end
end