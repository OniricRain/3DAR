clear all
close all
clc


% load feature descriptors



% 

for n = 1:length(images)
    for m = setdiff(1:length(images),n) % = for every image different from n
        
        % match features
        index_pairs = matchFeatures(features{1,n}, features{1,m}, 'MaxRatio', .7, 'Unique',  true);
        
        % allocate number of coupling features
        C(n,m) = size(index_pairs,1);
        
        % allocate the indices of the coupling points in matching cell
        matchings{n,m} = index_pairs;
    end
end
