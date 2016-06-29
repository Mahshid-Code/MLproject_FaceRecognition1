function classification = bayesian(X, mu, sigma)
% %  N=size(X,1);
% % classification=[];
% % for i = 1:N
% %     classification(1,i) =(-1/2)*((X(i,:) - mu)*inv(sigma)*(X(i,:)-mu)')-(1/2)*log(det(sigma));
% % end



nROW = size(X,1);
X = bsxfun(@minus,X,mu);

[U S V]=svd(sigma);
diag_S=diag(S);
Ind=diag_S<=0;
diag_S(Ind)=[];

Inverse_Est_Covariance=U*diag([diag_S.^(-1);zeros(nROW-length(diag_S),1)])*U';
new_cov = diag(X'*Inverse_Est_Covariance*X);  
Constants_bayes_formula = nROW*log(2*pi)+2*sum(diag_S);   
classification = -(Constants_bayes_formula+new_cov)/2;
