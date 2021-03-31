clear all

data_fitur = csvread('finger_extract.csv',1);
fitur = data_fitur(:,2:end);
label = data_fitur(:,1);


c = fitcknn(fitur,label,'NumNeighbors',1,...
    'NSMethod','exhaustive','Distance','euclidean',...
    'Standardize',1); 

save model_finger c

% img = imread('face/1 (1).jpg');
% img = rgb2gray(img);
% glcm = graycomatrix(img,'Offset',[2 0]);
% stats = graycoprops(glcm)
% contrast = stats.Contrast;
% homogeneity = stats.Homogeneity;
% correlation = stats.Correlation;
% energy = stats.Energy;
% 
% fitur=[contrast homogeneity correlation energy];
% [class,~]=predict(c,fitur);

