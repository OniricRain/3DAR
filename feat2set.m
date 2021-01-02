function feat_set = feat2set(features)
% feat_set function, used for preprocess the data before the autoencoding
% input
% input: - features: cell array containing in each cell the features of an
% image
% output: - feat_set: matrix of doubles, contains all the feature
% descriptors of all the dataset image, each column is a descriptor
    
    feat_set = []; %initialize empty feature set
    for i =1:length(features)
        feat_transpose = features{1,i}';
        feat_set = [feat_set, feat_transpose];%each column is a sample
        feat_set = double(feat_set);%UseGPU requires this format
    end
end

