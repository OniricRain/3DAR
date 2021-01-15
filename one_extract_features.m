%% features for all datasets
dataset_name = ["portello","tiso","castle","fountain"];
for i = 1:length(dataset_name)
    message = ['processing ',string(dataset_name(i))];
    disp(message);
    tic
    createFeatures(dataset_name(i),"KAZE");
    time = toc;
    message = [string(dataset_name(i)),' has been processed, elapsed time: ', string(time)];
    disp(message);
end