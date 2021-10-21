training_set = csvread('New_train.txt');  %Loading Dataset
real = csvread('New_real.txt');           %Loading Dataset 

size(training_set)                        %Making sure it has the right dimensions
size(real)                                %Making sure it has the right dimensions

X = training_set(:, 2:80);                %Assigning the features to value X
y = training_set(:, 81);                  %Assigning the prices to value y
m = length(y);                            %Assigning the length of y to value m 
X = [ones(m, 1) X];                       %Adding an additional column of ones to the dataset. This is important for multiplying the parameters with the features.

theta = zeros(size(X, 2), 1);             %Initializing theta values
theta = pinv(X' * X) * (X' * y);          %Using Normal Equation we don't need to scale features and it is all done in one single step, unlike gradient descent

X_1 = real(:, 2:80);                      %Assign the features of the dataset we will predict prices on to value X_1.    
n = length(real(:, 1));                   %Assign the length of the dataset to value n.
X_1 = [ones(n, 1) X_1];                   %Adding an additional column with ones.
tag = readl(:, 1);                        %Assigning the tag number of each house to valuet tag

price = X_1 * theta;                      %Predicting prices.
price = [tag, price]                      %Concatenating them with the house's tag number