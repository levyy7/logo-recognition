% Carga los sets de imagenes en archivos de datos matlab

path = "./data/logos";
path_complex = "./data/logos/complex_background";
path_unknown = "./data/logos/Unknown";

logo_types = ["Apple", "BLACKBERRY", "Cisco Systems", "Daewoo Electronics", "hp", "IBM", "Intel", "motorola"];

%%

trainingDataset = cell(numel(logo_types), 1);
testDataset = cell(numel(logo_types), 1);

for i = 1:numel(logo_types)
    p = fullfile(path, logo_types(i));
    imds = imageDatastore(p, 'LabelSource', 'foldernames');

    [trainingDataset{i}, testDataset{i}] = splitEachLabel(imds, 0.85);
end

testComplexDataset = cell(numel(logo_types), 1);

for i = 1:numel(logo_types)
    p = fullfile(path_complex, logo_types(i));
    testComplexDataset{i} = imageDatastore(p, 'LabelSource', 'foldernames');
end

testUnknownDataset = imageDatastore(path_unknown, 'LabelSource', 'foldernames');


%%
save(".\data\trainingDataset", "trainingDataset");
save(".\data\testDataset", "testDataset");
save(".\data\testComplexDataset", "testComplexDataset");
save(".\data\testUnknownDataset", "testUnknownDataset")