function [ T ] = getDataSet()
    folder = 'logos2/Apple/';
    apple = imageDatastore(fullfile(folder, '*.jpg'), 'LabelSource','foldernames');
    folder = 'logos2/hp/';
    hp = imageDatastore(fullfile(folder, '*.jpg'), 'LabelSource','foldernames');
    folder = 'logos2/Intel/';
    intel = imageDatastore(fullfile(folder, '*.jpg'), 'LabelSource','foldernames');
    folder = 'logos2/BLACKBERRY/';
    blackberry = imageDatastore(fullfile(folder, '*.jpg'), 'LabelSource','foldernames');
    folder = 'logos2/Cisco Systems/';
    cisco = imageDatastore(fullfile(folder, '*.jpg'), 'LabelSource','foldernames');
    folder = 'logos2/IBM/';
    ibm = imageDatastore(fullfile(folder, '*.jpg'), 'LabelSource','foldernames');
    folder = 'logos2/Daewoo Electronics/';
    daewoo = imageDatastore(fullfile(folder, '*.jpg'), 'LabelSource','foldernames');
    folder = 'logos2/motorola/';
    motorola = imageDatastore(fullfile(folder, '*.jpg'), 'LabelSource','foldernames');
    folder = 'logos2/Unknown/';
    unknown = imageDatastore(fullfile(folder, '*.jpg'), 'LabelSource','foldernames');
    dataset = [];
    class = [];
    [train_data, clase] = getTrainData(apple);
    dataset = [dataset;train_data];
    class = [class; clase];
    [train_data, clase] = getTrainData(hp);
    dataset = [dataset;train_data];
    class = [class; clase];
    [train_data, clase] = getTrainData(intel);
    dataset = [dataset;train_data];
    class = [class; clase];
    [train_data, clase] = getTrainData(blackberry);
    dataset = [dataset;train_data];
    class = [class; clase];
    [train_data, clase] = getTrainData(cisco);
    dataset = [dataset;train_data];
    class = [class; clase];
    [train_data, clase] = getTrainData(ibm);
    dataset = [dataset;train_data];
    class = [class; clase];
    [train_data, clase] = getTrainData(daewoo);
    dataset = [dataset;train_data];
    class = [class; clase];
    [train_data, clase] = getTrainData(motorola);
    dataset = [dataset;train_data];
    class = [class; clase];
    [train_data, clase] = getTrainData(unknown);
    dataset = [dataset;train_data];
    class = [class; clase];
    T = array2table(dataset);

    [f,c] = size(dataset);
    titulos = strings(c, 1);
    for i = 1:c
        titulos(i) = "Atr hog " + int2str(i);
    end

    titulos = transpose(titulos);
    allVars = 1:width(T);
    names = append("dataset",string(allVars));
    T = renamevars(T,names, titulos);
    T = addvars(T,class);
end

function [ train_data, clase ] = getTrainData(images)
    cell = [64 64];
    numImages = numel(images.Files);
    train_data = [];
    clase = strings(numImages, 1);
    names = split(images.Folders,"/");
    name = names(length(names));
    for i=1:numImages
        im = readimage(images, i);
        im = processImage(im);
        hog = extractHOGFeatures(im, 'CellSize', cell);
        train_data = [train_data; hog];
        clase(i) = name;
    end
end

function [ img ] = processImage(im)
    img = rgb2gray(im);
    img = imresize(img, [256 256]);
end
