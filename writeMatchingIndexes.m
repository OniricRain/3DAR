% writeMatchingIndexes function
% input: - image_path1: path of the first image
%        - image_path2: path of the second image
%        - index_pairs: indexes of the coupling keypoints of the two images
%        - dataset_name: name of the dataset (portello, castle...). The 
%                        path where the .txt file is stored depends on which 
%                        dataset is used
% output: - []: no ouput. The indexes of matching keypoints of every couple
%               of grayscale undistorted images are written in a .txt file
function [] = writeMatchingIndexes(image_path1, image_path2, index_pairs, dataset_name, file_name)

    [~,name1,ext1] = fileparts(image_path1); %~: filepath is not used
    [~,name2,ext2] = fileparts(image_path2);
    
    file_path = strcat('data\', dataset_name);
    filespec = fullfile(file_path, file_name);
    % create a file for writing
    file_Id = fopen(filespec, 'a'); % permission 'a': append data to the end of the file
    fprintf(file_Id, '%s %s\n', strcat(name1,ext1), strcat(name2,ext2));
    fprintf(file_Id, '%u %u\n', index_pairs');
    fprintf(file_Id, '\n');
    fclose(file_Id);
end