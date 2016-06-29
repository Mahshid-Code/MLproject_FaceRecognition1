function Task2=NN_rule(Control_data,Effect_data,frontier_image)
% NN Rule
%%
format long
nSubj=size(Control_data,2);
TrainingLabels=[1:nSubj];
nTest=size(Effect_data,3);
if size(Control_data,3)==20 % In illumination, instead of mean consider the frontal image
    Training_data=squeeze(Control_data(:,:,frontier_image));
else
Training_data=mean(Control_data,3);
end
classification_results=zeros(nTest,nSubj);
for iTest=1:nSubj
    for iEffect=1:size(Effect_data,3)
        classification_results(iEffect,iTest) = NN_classifier(Effect_data(:,iTest,iEffect), Training_data);
    end
end

for i=1:1:size(Effect_data,3)
hit_rate_percent=find_accuracy(classification_results(i,:),TrainingLabels);
display(['Hit Rate in Test Set is ' num2str(hit_rate_percent) '%']) 
end
Task2=hit_rate_percent;
