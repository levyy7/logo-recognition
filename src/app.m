%% Practica final VC: Detección de Logos

%%

addpath('./');

%% Carga descriptores e imagen input

logo_types = ["Apple", "BLACKBERRY", "Cisco Systems", "Daewoo Electronics", "hp", "IBM", "Intel", "motorola"];
load("./data/trainingSIFTDescriptors.mat");
load("./data/trainingSURFDescriptors.mat");

im = imread("data\logos\Intel\5.jpg");
figure, imshow(im);

%% Extract descriptors from input image

[inputFeaturesSIFT, ~, loc_kp_SIFT] = SIFTExtractor(im);
[inputFeaturesSURF, ~, loc_kp_SURF] = SURFExtractor(im);

%%
matchSIFT = zeros(8, 1);
matchSURF = zeros(8, 1);

for i = 1:numel(logo_types)
    matchSIFT(i) = computeMatchingsEuclidean(inputFeaturesSIFT, trainingSIFTDescriptors{i});
    matchSIFT(i) = matchSIFT(i) / computeNumHistograms(trainingSIFTDescriptors{i});

    matchSURF(i) = computeMatchingsEuclidean(inputFeaturesSURF, trainingSURFDescriptors{i});
    matchSURF(i) = matchSURF(i) / computeNumHistograms(trainingSURFDescriptors{i});
end

matchings = matchSIFT*0.7 + matchSURF*0.3;

[m, i] = max(matchings);

%if m < X 


disp(logo_types(i));