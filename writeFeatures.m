% writeFeatures function
% input: - image_path: path of the image
%        - keypoints: keypoints calculated by the local feature detector 
%                     and descriptor SURF
%        - dataset_name: name of the dataset (portello, castle...). The 
%                        path where the .txt file is stored depends on which 
%                        dataset is used
% output: - []: no ouput. The info of the keypoints (location, scale and
%               orientation) and put them into a .txt file.
function [] = writeFeatures(image_path, keypoints, dataset_name)
    
    [~,name,ext] = fileparts(image_path); %~: filepath is not used
    
    file_path = strcat('data\', dataset_name,'\features');
    file_name = strcat(name,ext,'.txt');
    filespec = fullfile(file_path, file_name);
    % create a file for writing
    file_Id = fopen(filespec, 'w'); %permission 'w': for writing, discard existing contents, if any
    n_features = keypoints.Count;
    l_descriptors = 128;
    
    fprintf(file_Id, string(n_features) + ' ' + string(l_descriptors) + '\n');
    for n = 1:n_features
        fprintf(file_Id,'%.6f %.6f %.6f %.6f ', keypoints.Location(n,1), ...
                         keypoints.Location(n,2), keypoints.Scale(n), ...
                         keypoints.Orientation(n));
        fprintf(file_Id,'%d ', zeros(1,127));
        fprintf(file_Id,'%d\n', 0);           
    end
    
    fclose(file_Id);

end