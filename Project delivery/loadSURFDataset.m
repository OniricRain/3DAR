%% Load the training set and the test set
% training set
dataset_name = 'portello'
load(strcat('data/', dataset_name,'/', dataset_name, '_SURFfeatures.mat'))
features1 = feat2set(features);
num_features_portello = length(features1);
dataset_name = 'castle'
load(strcat('data/', dataset_name,'/', dataset_name, '_SURFfeatures.mat'))
features2 = feat2set(features);

train_set = cat(2,features1,features2);


% test set
dataset_name = 'fountain'
load(strcat('data/', dataset_name,'/', dataset_name, '_SURFfeatures.mat'))
test_set_fountain = feat2set(features);

dataset_name = 'tiso'
load(strcat('data/', dataset_name,'/', dataset_name, '_SURFfeatures.mat'))
test_set_tiso = feat2set(features);


%normalization of the features
subtrain_set_portello = normalize(features1);
subtrain_set_castle = normalize(features2);
train_set = normalize(train_set);
test_set_fountain = normalize(test_set_fountain);
test_set_tiso = normalize(test_set_tiso);