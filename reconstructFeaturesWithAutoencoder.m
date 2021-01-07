
function [] = reconstructFeaturesWithAutoencoder(dataset_name, imds, features, autoencoder)
    % nuber of neurons in the code layer
    hidden_size = autoencoder{1}.HiddenSize;
    
    n_images = numel(imds.Files);
    
    % contains all the rec. features for each image of the dataset
    features_rec = cell(1,n_images);
    for i = 1:n_images
        [features_rec{1,i},~] = testAutoencoder(features{1,i}',autoencoder);
        % transpose 
        features_rec{1,i} = features_rec{1,i}';
    end
    
    % C contains the number of matching points between every image
    C = zeros(n_images,n_images);
    % this cell contains the matching points indexes between every image
    matchings = cell(n_images,n_images);

    for n = 1:n_images
        for m = setdiff(1:n_images,n) % = for every image different from n

            % match features
            index_pairs = matchFeatures(features_rec{1,n}, features_rec{1,m}, ...
                                        'MaxRatio', .7, 'Unique',  true);

            % allocate number of coupling features
            C(n,m) = size(index_pairs,1);

            % allocate the indices of the coupling points in matching cell
            matchings{n,m} = index_pairs;
        end
    end
    
    % delete file with matching idexes, if exist
    file_name = strcat('matches_file_rec', string(hidden_size),'.txt');
    file_path = strcat('data\',dataset_name,'\',file_name);
    if exist(file_path, 'file') == 2
       delete(file_path)
    end

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
            writeMatchingIndexes(image_path1, image_path2, matching_couples, dataset_name, file_name)   
        end
    end

    %% Save the features in the current directory
    save(strcat('data/', dataset_name,'/', dataset_name, '_features_rec', string(hidden_size),'.mat'), 'features_rec');

end