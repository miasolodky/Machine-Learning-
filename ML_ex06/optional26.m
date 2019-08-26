clear ; close all; clc
path='/MATLAB Drive/machine-learning-ex/ex6/emails/*';
spam_files = dir(path);
spam_files=spam_files(3:end); %the first two elements are '.' and '..'

%initializing parameters
features=[];
y=zeros(length(spam_files),1);

% i=1;
% for file = spam_files'
%     email_contents = readFile(fullfile('/MATLAB Drive/machine-learning-ex/ex6/emails/',file.name));
% %   process email:
%     word_indices = processEmail(email_contents);
%     features =[features emailFeatures(word_indices)];
%     y(i)=startsWith(file.name,'s');
%     i=i+1;
% end
load('optional_data.mat');
X=features';

%seperate to training set, cross validation and test
% randomize

m = size(X, 1);
sel=randperm(m);
X = X(sel,:);
y=y(sel);
% Number of elements for training, validation, and test sets
pctTrain = 0.6;
pctVal = 0.2;
mTrain = ceil(m*pctTrain);



% Define sets
X_train = X(1:mTrain,:);
y_train = y(1:mTrain); 

X_test = X(mTrain + 1:end,:);
y_test = y(mTrain + 1:end);

%training the model
fprintf('\nTraining Linear SVM (Spam Classification)\n')
fprintf('(this may take 1 to 2 minutes) ...\n')

C = 0.1;
model = svmTrain(X_train, y_train, C, @linearKernel);

p = svmPredict(model, X_train);

fprintf('Training Accuracy: %f\n', mean(double(p == y_train)) * 100);

%Evaluating the model on test set
fprintf('\nEvaluating the trained Linear SVM on a test set ...\n')

p = svmPredict(model, X_test);

fprintf('Test Accuracy: %f\n', mean(double(p == y_test)) * 100);

% ================= Part 5: Top Predictors of Spam ====================


% Sort the weights and obtin the vocabulary list
[weight, idx] = sort(model.w, 'descend');
vocabList = getVocabList();

fprintf('\nTop predictors of spam: \n');
for i = 1:15
    fprintf(' %-15s (%f) \n', vocabList{idx(i)}, weight(i));
end

fprintf('\n\n');
