function Task3=PCA_BAYES_NN(Control_data,Effect_data)

% PCA followed by Bayes Rule and NN rule

%%
format long
nSubj=size(Control_data,2);
nPixel=size(Control_data,1);
IperSubj=size(Control_data,3);
if nPixel==1920
    nROW=48;
else
    nROW=23;
end
TrainingLabels=[1:nSubj];
nTest=size(Effect_data,3);
nTraining=length(TrainingLabels);
Training_data=[];
for i=1:IperSubj
    Training_data=cat(2,Training_data,squeeze(Control_data(:,:,i)));
end


% Plot samples of average face and eigen faces
figure,
Avg_face=mean(Training_data,2);
colormap('Gray')
imagesc(reshape(Avg_face,nROW,[]));
title('Average Face')
axis off;

%%
A=Training_data-repmat(Avg_face,1,size(Training_data,2));
L = A'*A;
prompt={'Enter the Number of Components to be considered:'};
name='Number of Components';
numlines=1;
defaultanswer={'70'};
nPCA=str2num(cell2mat(inputdlg(prompt,name,numlines,defaultanswer)));
Training_PCA_matrix=pca(Training_data*Training_data','NumComponents' ,nPCA)';

figure,
colormap('Gray')
for i=1:9
    subplot(3,3,i)
    imagesc(reshape(Training_PCA_matrix(i+1,:),nROW,[]));
    if i==2
        title('Samples of Eigen Faces');
    end
    axis off;
end



%%
Training_PCA=Training_PCA_matrix*A;
Training_PCA_mu=[];
Training_PCA_cov=zeros(nPCA,nPCA,nSubj);
for i=1:nSubj
    Training_PCA_cov(:,:,i) = 1/(IperSubj-1).*squeeze(Training_PCA(:,(i-1)*IperSubj+1:i*IperSubj))*squeeze(Training_PCA(:,(i-1)*IperSubj+1:i*IperSubj))';
    Training_PCA_mu= [Training_PCA_mu squeeze(mean(squeeze(Training_PCA(:,(i-1)*IperSubj+1:i*IperSubj)),2))];
end


classification_results_NN=zeros(nTest,nSubj);
classification_results_Bayes=zeros(nTest,nSubj);

for iTest=1:nSubj
    for iEffect=1:size(Effect_data,3)
        Test_data=squeeze(Effect_data(:,iTest,iEffect))-Avg_face;
        Test_PCA=Training_PCA_matrix*Test_data;
        
        classification_results_NN(iEffect,iTest) = NN_classifier(Test_PCA, Training_PCA);
        
    end
end
for i=1:1:size(Effect_data,3)
    hit_rate_percent=find_accuracy(mod(classification_results_NN(i,:),nSubj),TrainingLabels);
    display('Method: PCA')
    display('Classification method: NN rule')
    display('Results:')
    display(['Hit Rate is ' num2str(hit_rate_percent) '%'])
end

