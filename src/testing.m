%% Practica final VC: Detección de Logos
% Testing sobre el dataset "logos"

%%
addpath('./');
clear all;
%% Carga descriptores e imagen input

logo_types = ["Apple", "BLACKBERRY", "Cisco Systems", "Daewoo Electronics", "hp", "IBM", "Intel", "motorola"];
load("./data/testSIFTDescriptors.mat");
load("./data/trainingSIFTDescriptors.mat");
load("./data/testComplexSIFTDescriptors.mat");
load("./data/testUnknownSIFTDescriptors.mat");

load("./data/testSURFDescriptors.mat");
load("./data/trainingSURFDescriptors.mat");
load("./data/testComplexSURFDescriptors.mat");
load("./data/testUnknownSURFDescriptors.mat");


%% Test testSet

%[groupSIFT, matchingSIFT] = matchLogos(trainingSIFTDescriptors, testSIFTDescriptors);
%[groupSURF, matchingSURF] = matchLogos(trainingSURFDescriptors, testSURFDescriptors);

%% Test complexSet

%[groupSIFT, matchingSIFT] = matchLogos(trainingSIFTDescriptors, testComplexSIFTDescriptors);
%[groupSURF, matchingSURF] = matchLogos(trainingSURFDescriptors, testComplexSURFDescriptors);

%% Test testSet + Unknown

[groupSIFT, matchingSIFT] = matchLogos(trainingSIFTDescriptors, testSIFTDescriptors);
[groupSURF, matchingSURF] = matchLogos(trainingSURFDescriptors, testSURFDescriptors);

matchingSIFTUnknown = cell(numel(testUnknownSIFTDescriptors), 1);
matchingSURFUnknown = cell(numel(testUnknownSURFDescriptors), 1);
groupSIFTUnknown = zeros(numel(testUnknownSURFDescriptors), 1);
for j = 1:numel(testUnknownSURFDescriptors)
    inputFeaturesSIFT = testUnknownSIFTDescriptors{j};
    inputFeaturesSURF = testUnknownSURFDescriptors{j};
    numMatchingsLogoSIFT = zeros(numel(logo_types), 1);
    numMatchingsLogoSURF = zeros(numel(logo_types), 1);
    for i = 1:numel(logo_types)
        numMatchingsLogoSIFT(i) = computeMatchingsEuclidean(inputFeaturesSIFT, trainingSIFTDescriptors{i});
        numMatchingsLogoSIFT(i) = numMatchingsLogoSIFT(i) / computeNumHistograms(trainingSIFTDescriptors{i});

        numMatchingsLogoSURF(i) = computeMatchingsEuclidean(inputFeaturesSURF, trainingSURFDescriptors{i});
        numMatchingsLogoSURF(i) = numMatchingsLogoSURF(i) / computeNumHistograms(trainingSURFDescriptors{i});
    end
    matchingSIFTUnknown{j} = numMatchingsLogoSIFT;
    matchingSURFUnknown{j} = numMatchingsLogoSURF;
end

groupSIFT = [groupSIFT; groupSIFTUnknown];
matchingSIFT = [matchingSIFT; matchingSIFTUnknown];
matchingSURF = [matchingSURF; matchingSURFUnknown];

%%

numTestImgs = numel(matchingSIFT);
grouphat = zeros(numTestImgs, 1);
for i = 1:numTestImgs
    testMatchSIFT = matchingSIFT{i};
    testMatchSURF = matchingSURF{i};

    matching = testMatchSIFT*0.7 + testMatchSURF*0.3;
    [m, index] = max(matching)

    if m < 0.08
        grouphat(i) = 0;
    else
        grouphat(i) = index;
    end
end

%% Extract descriptors from input image

C = confusionmat(groupSIFT,grouphat);
figure, confusionchart(C);

accuracy =  sum(diag(C)) / sum(C(:))