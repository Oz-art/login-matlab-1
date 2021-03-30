path_dataset = 'fingerprint/';
fitur=[];

for i=1:5
    img = imread(sprintf('%s1 (%d).bmp',path_dataset,i));
    img = rgb2gray(img);
    glcm = graycomatrix(img,'Offset',[2 0]);
    stats = graycoprops(glcm)
    contrast = stats.Contrast;
    homogeneity = stats.Homogeneity;
    correlation = stats.Correlation;
    energy = stats.Energy;
    if i==1
        class=1;
    elseif i==2
        class=2;
    elseif i==3
        class=3;
    elseif i==4
        class=4;
    elseif i==5
        class=5;
    end
    temp_fitur=[class contrast homogeneity correlation energy];
    fitur = [fitur; temp_fitur];
end
        
%  if i==1
%         class='Nickey';
%     elseif i==2
%         class='Jonson';
%     elseif i==3
%         class='Charly';
%     elseif i==4
%         class='Dalton';
%     elseif i==5
%         class='Edward';
%     end

a = array2table(fitur);
writetable(a,'finger_extract.csv');