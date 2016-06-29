function Task4=LDA_BAYES_NN(Control_data,Effect_data)
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

Avg_face=mean(Training_data,2);

%%
A=Training_data-repmat(Avg_face,1,size(Training_data,2));
L = A'*A;
prompt={'Enter the Number of Components to be considered:'};
name='Number of Components';
numlines=1;
defaultanswer={'70'};
nPCA=str2num(cell2mat(inputdlg(prompt,name,numlines,defaultanswer)));
Training_PCA_matrix=pca(Training_data*Training_data','NumComponents' ,nPCA)';




%%
Training_PCA_Labels=repmat([1:nSubj],1,size(Control_data,3));
LDA_input = Training_PCA_matrix*A;
LDA_Matrix=LDA_calc(LDA_input,Training_PCA_Labels);
Training_PCA_LDA=A'*Training_PCA_matrix'*LDA_Matrix;

classification_results_NN=zeros(nTest,nSubj);

for iTest=1:nSubj
    for iEffect=1:size(Effect_data,3)
        Test_data=squeeze(Effect_data(:,iTest,iEffect))-Avg_face;
        Test_LDA=Test_data'*Training_PCA_matrix'*LDA_Matrix;
        
        classification_results_NN(iEffect,iTest) = NN_classifier(Test_LDA', Training_PCA_LDA');
        
    end
end
for i=1:1:size(Effect_data,3)
    hit_rate_percent=find_accuracy(mod(classification_results_NN(i,:),nSubj),TrainingLabels);
    display('Method: PCA')
    display('Classification method: NN rule')
    display('Results:')
    display(['Hit Rate is ' num2str(hit_rate_percent) '%'])
end

Task4=hit_rate_percent;

