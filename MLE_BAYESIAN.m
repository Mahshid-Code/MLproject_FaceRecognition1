function Task1=MLE_BAYESIAN(Control_data,Effect_data)
% ML estimation with Gaussian assumption followed by Bayes rule

%% Make ready the training and test set according to inputs
format long
nSubj=size(Control_data,2);
nPixel=size(Control_data,1);
if nPixel==1920
    nROW=48; 
else
    nROW=23;
end
TrainingLabels=[1:nSubj];
TestLabels=[1:nSubj];
nTest=size(Effect_data,3);
nTraining=length(TrainingLabels);
Training_data=[];
for i=1:size(Control_data,3)
Training_data=cat(2,Training_data,squeeze(Control_data(:,:,i)));
end
Lables=unique(TrainingLabels);
nCat=length(Lables);
%% MLE of each class distribution with Gaussian assumption
display('It takes a while...')
for i=1:nCat
    Ind=(TrainingLabels==Lables(i));
    subj_data=Training_data(:,Ind);
    mean_subj(:,i)=mean(subj_data,2);
    mean_subj_reordered=bsxfun(@minus,subj_data,mean_subj(:,i));
    Subject_covariance(:,:,i)=(mean_subj_reordered*mean_subj_reordered');
    Likelihood_val(i,:)=bayesian(Effect_data,mean_subj(:,i),Subject_covariance(:,:,i))';
end
%% Baysian Classifier

[junk,max_idx]=max(Likelihood_val);
classification_results=Lables(max_idx);

Hit_rate=sum(classification_results==TestLabels)/length(TestLabels);
display(['Hit rate for MLE on test set is' num2str(Hit_rate*100) '%'])
Task1=Hit_rate;
