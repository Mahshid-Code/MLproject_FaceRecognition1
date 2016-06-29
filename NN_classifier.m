function NN_result = NN_classifier(sample, training)
%Author:Mahshid Najafi
test=repmat(sample,1,size(training,2));
distance=(test-training).^2;
distance_all=sum(distance);
[a,NN_result] =min(distance_all);
