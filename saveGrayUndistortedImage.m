% saveGrayUndistortedImage function
% input: - image_path1: path of the image
%        - image: undistorted grayscale image to be saved
%        - dataset_name: name of the dataset (portello, castle...). The 
%                        path where the .txt file is stored depends on which 
%                        dataset is used
% output: - []: no ouput. The image is saved in a folder that depends on
%               which dataset is used
function [] = saveGrayUndistortedImage(image_path, image, dataset_name)
    [~,name,ext] = fileparts(image_path);
    
    file_path = strcat('data\', dataset_name,'\undistorted_grayscale_images');
    file_name = strcat(name,ext);
    filespec = fullfile(file_path, file_name);
    imwrite(image, filespec);
end