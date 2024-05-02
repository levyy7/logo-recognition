%% Extrae los descriptores SURF de "testDataset.mat" y "trainingDataset.mat"

%% Carga de Imágenes

load("./data/trainingDataset.mat");
load("./data/testDataset.mat");
load("./data/testComplexDataset.mat");
load("./data/testUnknownDataset.mat");

%%

testSURFDescriptors = cell(numel(testDataset), 1);
trainingSURFDescriptors = cell(numel(trainingDataset), 1);
testComplexSURFDescriptors = cell(numel(testComplexDataset), 1);
testUnknownSURFDescriptors = extractSURFSetImages(testUnknownDataset);


for i = 1:numel(testDataset)
    testSURFDescriptors{i} = extractSURFSetImages(testDataset{i});
    trainingSURFDescriptors{i} = extractSURFSetImages(trainingDataset{i});
    testComplexSURFDescriptors{i} = extractSURFSetImages(testComplexDataset{i});
end

%%

save(".\data\testSURFDescriptors.mat", "testSURFDescriptors");
save(".\data\trainingSURFDescriptors.mat", "trainingSURFDescriptors");
save(".\data\testComplexSURFDescriptors.mat", "testComplexSURFDescriptors");
save(".\data\testUnknownSURFDescriptors.mat", "testUnknownSURFDescriptors");