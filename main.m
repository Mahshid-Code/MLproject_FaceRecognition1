% Mahshid 
% Machine Learning Project 1
% Main Function
%%
clc
clear all 
close all
format long

%% Choose the type of effect/data to be studied and startup parameters
run_task=1;
while run_task==1
    choice_data=menu('Please choose what you want to study','Facial Expressions Effect','Pose Effect','Illumination Variation Effect');   
    if choice_data<3
        condition_amount=1;
    else
        condition_amount=menu('Please choose amount of effect on Test data','Too Little','Little','Average','A lot');
    end
    
    [Control_data,Effect_data,frontier_image]=Data_division(choice_data,condition_amount);
    choice_task=menu('Please choose the method','MLE + Bayesian','Nearest Neighbor','PCA + NN & Bayesian','LDA + NN & Bayesian');
    switch choice_task
        case 1
            Task1=MLE_BAYESIAN(Control_data,Effect_data);
        case 2
            Task2=NN_rule(Control_data,Effect_data,frontier_image);
        case 3
            Task3=PCA_BAYES_NN(Control_data,Effect_data);
        case 4
            if choice_data==1
                display('Issues with limited Trainging,Please try LDA on pose or Effect data')
            else
            Task4=LDA_BAYES_NN(Control_data,Effect_data);
            end
    end
    run_task=menu('Do you want to run another study?','Yes','No');
    
end

display('Have a good day!')
