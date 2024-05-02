%% Extrae los descriptores SIFT de "testDataset.mat" y "trainingDataset.mat"

clear all;

%% Carga de Imágenes

load("./data/trainingDataset.mat");
load("./data/testDataset.mat");
load("./data/testComplexDataset.mat");
load("./data/testUnknownDataset.mat");

%%

trainingSIFTDescriptors = cell(numel(trainingDataset), 1);
testSIFTDescriptors = cell(numel(testDataset), 1);
testComplexSIFTDescriptors = cell(numel(testComplexDataset), 1);
testUnknownSIFTDescriptors = extractSIFTSetImages(testUnknownDataset);

for i = 1:numel(testDataset)
    trainingSIFTDescriptors{i} = extractSIFTSetImages(trainingDataset{i});
    testSIFTDescriptors{i} = extractSIFTSetImages(testDataset{i});
    testComplexSIFTDescriptors{i} = extractSIFTSetImages(testComplexDataset{i});
end

%%

save(".\data\testSIFTDescriptors.mat", "testSIFTDescriptors");
save(".\data\trainingSIFTDescriptors.mat", "trainingSIFTDescriptors");
save(".\data\testComplexSIFTDescriptors.mat", "testComplexSIFTDescriptors");
save(".\data\testUnknownSIFTDescriptors.mat", "testUnknownSIFTDescriptors");
