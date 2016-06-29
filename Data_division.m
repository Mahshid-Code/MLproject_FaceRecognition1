function [Control_data,Effect_data,frontier_image]=Data_division(choice_data,condition_amount)


TrainingData=[];
TestData=[];
Lables=[];

%% Load the data according to your choice
switch choice_data
    case 1
        display('You chose to study the facial expression effect!')
        load('data.mat'); % Size images 24x21 and 3 Images per subject
        nSubj=200;
        % for i=1:200;imagesc(face(:,:,i));pause(.1);end
        Neutral_faces=face(2:end,3:end,1:3:end); % 2:end and 3:end to delete the background
        Facial_faces=face(2:end,3:end,2:3:end);
        Illum_faces=face(2:end,3:end,3:3:end);
        I_perSub=3;
        Control_data=zeros(size(Neutral_faces,1),size(Neutral_faces,2),nSubj,I_perSub-1);
        Control_data=zeros(size(Neutral_faces,1)*size(Neutral_faces,2),nSubj,I_perSub-1);
        Control_data(:,:,1)=reshape(Neutral_faces,[],nSubj);
        Control_data(:,:,2)=reshape(Illum_faces,[],nSubj);
        Effect_data= reshape(Facial_faces,[],nSubj);
        frontier_image=1;
        %--------------------
    case 2
        display('You chose to study the pose effect!')
        load('pose.mat');% Size images 48x40 and 3 Images per subject
        nSubj=68;
        I_perSub=13;
        % for i=1:nSubj;for j=1:13,subplot(4,4,j);imshow(uint8(pose(:,:,j,i)));end;pause(1);end
        pose_reshaped=reshape(pose,48*40,I_perSub,nSubj);
        pose_1=zeros(48*40,nSubj,I_perSub);
        for i=1:68;
            for j=1:13
                pose_1(:,i,j)=squeeze(pose_reshaped(:,j,i));
            end
        end
        if condition_amount==1
            test_indx=4;
        else if condition_amount==2
                test_indx=3;
            else if condition_amount==3
                    test_indx=1;
                else if condition_amount==4
                        test_indx=12;
                    end
                end
            end
        end
        Control_data=pose_1(:,:,[1:test_indx-1 test_indx+1:end]);
        Effect_data=pose_1(:,:,test_indx);
        frontier_image=4;
        %--------------------
    case 3
        display('You chose to study the illumination effect!')
            load('illumination.mat');
            nSubj=68;
            % for i=1:nSubj;for j=1:21,subplot(5,5,j);imshow(uint8(illumination(:,:,j,i)));end;pause(1);end
            
            I_perSub=21;
            illumination=zeros(48*40,nSubj,I_perSub);
            for i=1:68;
                for j=1:21
                    illumination(:,i,j)=reshape(reshape(illum(:,j,i), 48, 40),[],1);
                end
            end
            % choose the test image according to user's condition choice
            if condition_amount==1
                test_indx=10;
            else if condition_amount==2
                    test_indx=8;
                else if condition_amount==3
                        test_indx=11;
                    else if condition_amount==4
                            test_indx=21;
                        end
                    end
                end
            end
            
            Control_data=illumination(:,:,[1:test_indx-1 test_indx+1:end]);
            Effect_data=illumination(:,:,test_indx);
            frontier_image=18;
            
        
end
% Normalize the data
for i=1:size(Control_data,2)
    for j=1:size(Control_data,3)
        Control_data(:,i,j)=Control_data(:,i,j)/max(Control_data(:,i,j));
    end
end

for i=1:size(Effect_data,2)
    for j=1:size(Effect_data,3)
    Effect_data(:,i,j)=Effect_data(:,i,j)/max(Effect_data(:,i,j));
end

end



