%MSE computing for different autoencoders
clc;
clear all;
close all;
%% load Dataset
% loadDataset;
loadKAZEDataset;

%% MSE computing
% models = ["autoencoder_32.mat","autoencoder_16.mat","autoencoder_8.mat","autoencoder_4.mat","autoencoder_2.mat","autoencoder_1.mat"];

models = ["KAZEautoencoder_32.mat","KAZEautoencoder_16.mat","KAZEautoencoder_8.mat","KAZEautoencoder_4.mat","KAZEautoencoder_2.mat","KAZEautoencoder_1.mat"];

% file_Id = fopen('data/mse_single_layer.txt','w');     
file_Id = fopen('data/mse_single_layerKAZE.txt','w');     

tic
for i = 1:length(models)
    load(models(i));
    [~,mse_train] = testAutoencoder(train_set,autoencoder);
    [~,mse_train_castle] = testAutoencoder(subtrain_set_castle,autoencoder);
    [~,mse_train_portello] = testAutoencoder(subtrain_set_portello,autoencoder);
    [~,mse_test_fountain] = testAutoencoder(test_set_fountain,autoencoder);
    [~,mse_test_tiso] = testAutoencoder(test_set_tiso,autoencoder);
    
    fprintf(file_Id,'Autoencoder type: %s\n',models(i));
    fprintf(file_Id,'MSE on training: %f\n',mse_train);
    fprintf(file_Id,'MSE on dataset castle: %f\n',mse_train_castle);
    fprintf(file_Id,'MSE on dataset portello: %f\n',mse_train_portello);
    fprintf(file_Id,'MSE on dataset fountain: %f\n',mse_test_fountain);
    fprintf(file_Id,'MSE on dataset tiso: %f\n',mse_test_tiso);
    fprintf(file_Id,'--------------------------------\n\n');    
end
fclose(file_Id);
toc