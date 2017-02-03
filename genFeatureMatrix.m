function F = genFeatureMatrix(perturbedConfigurations,ann,n)
%% prepare the feature matrix F
    poohpath = 'data/pooh';
    m= size(ann,1);
    F=[];
    for i=1:m
        I=imread(fullfile(poohpath,'training',sprintf('image-%04d.jpg', ann(i,1))));
        for j = 1: n
	    fc = perturbedConfigurations(i*4-3:i*4,5*j-4:5*j);
 		% Extract SIFT from I according to fc
		d = siftwrapper(I, fc);
        F=[F;reshape(d,1,[])];
        end
   end

end