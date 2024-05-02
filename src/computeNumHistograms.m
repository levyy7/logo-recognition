%%
function numHistograms = computeNumHistograms(trainingImgs)
    numHistograms = 0;
    
    for i = 1:numel(trainingImgs)
        trainImg = trainingImgs{i};

        [nrows, ~] = size(trainImg);
        numHistograms = numHistograms + nrows;
    end
end