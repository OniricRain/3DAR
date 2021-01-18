% Prova Upright
  I = imread('cameraman.tif');
  keypoints = detectSURFFeatures(I, 'NumOctaves', 8);
  features1 = extractFeatures(I, keypoints,'Method','KAZE');
  features2 = extractFeatures(I, keypoints,'Method','KAZE','Upright',true);
  isequal(features1,features2)