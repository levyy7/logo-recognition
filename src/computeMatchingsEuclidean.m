%% Calcula el numero de matchings de histogramas entre dos sets de imagenes
function numMatchings = computeMatchingsEuclidean(testImg, trainingImgs)
    numMatchings = 0;
    
    for i = 1:numel(trainingImgs)
        trainImg = trainingImgs{i};
        pairs = matchFeatures(testImg, trainImg, "Method","Exhaustive" ,"MatchThreshold", 2, "Unique",true);

        [nrows, ~] = size(pairs);
        numMatchings = numMatchings + nrows;
    end
end
