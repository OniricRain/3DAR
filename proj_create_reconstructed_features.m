clear all
close all
clc


% choose dataset
% dataset_name = 'portello'
% dataset_name = 'tiso'
% dataset_name = 'castle'
dataset_name = 'fountain'

% Load all the images to be used in the dataset
dir_files = strcat('data\', dataset_name,'\dataset');
imds = imageDatastore(dir_files);

%%
% load autoencoder model
load 'autoencoder_32.mat'
% load features
load(strcat('data/', dataset_name,'/', dataset_name, '_features.mat'))


n_images = length(features)
%%
features_rec = cell(1,n_images)
for i = 1:n_images
    [features_rec{1,i},~] = testAutoencoder(features{1,i}',autoencoder);
    % transpose 
    features_rec{1,i} = features_rec{1,i}';
end

%%
% C contains the number of matching points between every image
C = zeros(n_images,n_images);
% this cell contains the matching points indexes between every image
matchings = cell(n_images,n_images);

for n = 1:n_images
    for m = setdiff(1:n_images,n) % = for every image different from n
        
        % match features
        index_pairs = matchFeatures(features_rec{1,n}, features_rec{1,m}, 'MaxRatio', .7, 'Unique',  true);
        
        % allocate number of coupling features
        C(n,m) = size(index_pairs,1);
        
        % allocate the indices of the coupling points in matching cell
        matchings{n,m} = index_pairs;
    end
end


%%
% To fill the .txt file 
for n = 1:n_images-1
    for m = n+1:n_images
        image_path1 = imds.Files{n};
        image_path2 = imds.Files{m};
        
        A = matchings{n,m};
        B = matchings{m,n}; % I want to put the new couples of indexes of B in A
        
        B(:,[1 2]) = B(:,[2 1]); % swap the two columns
        % save indices of couples in B that are not found in A
        idx_new_couples = find(~ismember(B,A,'rows')); 
        % get the new couples by knoing their indices
        new_couples = B(idx_new_couples,:);
        
        % concatenate the two matrices of couples
        matching_couples = cat(1, A, new_couples);
        % sort indexes
        matching_couples = sortrows(matching_couples,1);
        matching_couples = matching_couples - 1; %subtract one for starting indexes from zero
        
        % save in the .txt file
        file_name = 'matches_file_rec32.txt';
        writeMatchingIndexes(image_path1, image_path2, matching_couples, dataset_name, file_name)   
    end
end

%% Save the features in the current directory
save(strcat('data/', dataset_name,'/', dataset_name, '_features_rec.mat'), 'features_rec');

