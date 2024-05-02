function [ pred, scores ] = predictHOG(im)
    hog = extractHOGFeatures(im, 'CellSize', [64 64]);
    titulos = strings(width(hog), 1);
    for i = 1:width(hog)
        titulos(i) = "Atr hog " + int2str(i);
    end
    
    titulos = transpose(titulos);
    
    T = array2table(hog, 'VariableNames', titulos);
    load('modelHOG.mat');
    [pred, scores] = trainedModelHOG.predictFcn(T);
end

function [ img ] = process(im)
    img = rgb2gray(im);
    img = imresize(img, [256 256]);
end