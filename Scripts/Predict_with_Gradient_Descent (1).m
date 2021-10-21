training_set = csvread('New_train.txt');    %Loading Dataset
real = csvread('New_real.txt');             %Loading Dataset

X = training_set(:, 2:80);                  %Assigning the features to value X
y = training_set(:, 81);                    %Assigning the prices to value y
m = length(y);                              %Assigning the length of y to value m 
m_vect = 1:m;                               %Turns m into a vector. Needed to perform addition appropriately later on.

% Feature Normalization on training set %

mu = zeros(1, size(X, 2));                  %Creates an empty array, intended to store the means of the features
sigma = zeros(1, size(X, 2));               %Creates an empty array, intended to store the standart deviations of the features

mu = mean(X);                               %Computing the means of the features of the training sets and storing them in an array mu
sigma = std(X);                             %Computing the standart deviations of the features of the training sets and storing them in an array sigma
X = X - mu;                                 %Subtracting the means of the features of the training sets from the dataset to normalize
X = X ./ sigma;                             %Dividing the data to normalize on the standart deviations of the features of the training sets

% Feature Normalization Complete %

X(:, 10) = 1                                %Change column 10 that contained only ones, with a new column of only ones, because during our feature normalization they evaluated to NaN's.
X = [ones(m, 1) X];                         %Adding an additional column of ones to the dataset. This is important for multiplying the parameters with the features.
alpha = 0.1;                                % Choosing the value for one step
num_iters = 200;                            % Number of steps
theta = zeros(80, 1);                       %Initializing theta values for step 1

% Running Gradient Descent %

for iter = 1:num_iters                      %Running the loop 200 times

    h = (theta' .* X);                                               % updating the cost error on every iteration                                          
    theta = theta - (alpha * (1/m) * sum((sum(h, 2) - y) .* X))';    % updating theta on every iteration                           
    e = (sum(h, 2) - y).^2;                                          % calculating the error and exponentiating every object to the power of 2, because that is the same as doing it one by one.
    J_history = (1/(2*m))*sum(e);                                    % dividing by 2m to avoid additional derivative calculations and summing to include all training examples in the cost calculation.                
      
end

% Running Gradient Descent complete %

% Plot the convergence graph (needed to make sure that we choose the right alpha and num_iters values) %

plot(1:num_iters, J_history, '-b', 'LineWidth', 2);
xlabel('Number of iterations');
ylabel('Cost J');

% Plotting the converge graph complete %

X_1 = real(:, 2:80);                            %Assigning the dataset we will predict price on to value X_1
tag = real(:, 1);                               %Assigning the tag number of each house to valuet tag

% Feature Normalization on dataset to predict %

X_1 = X_1 - mu;                                 %Subtracting the means of the features of the training sets from the dataset to normalize
X_1 = X_1 ./ sigma;                             %Dividing the data to normalize on the standart deviations of the features of the training sets

% Feature Normalization on dataset to predict complete %

price_1 = X_1 * theta;      %Predicting prices
result_1 = [tag, price_1]   %Concatenating them with the house's tag number


