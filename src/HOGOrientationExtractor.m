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
    T = array2table(dataset);

    [f,c] = size(dataset);
    titulos = strings(c, 1);
    for i = 1:c
        if i <= 256
            titulos(i) = "Atr hist " + int2str(i);
        else
            titulos(i) = "Atr hog " + int2str(i-256);
        end
    end

    titulos = transpose(titulos);
    allVars = 1:width(T);
    names = append("dataset",string(allVars));
    T = addvars(T,class);
end

function [ features ] = getFeatures(im)
    cell = [64 64];
    treshold = 60;
    hog = extractHOGFeatures(im, 'CellSize', cell);
    hist = HistOrientations(im, treshold);
    features = cat(2, hist, hog);
end

function [ train_data, clase ] = getTrainData(images)
    numImages = numel(images.Files);
    train_data = [];
    clase = strings(numImages, 1);
    names = split(images.Folders,"/");
    name = names(length(names));
    for i=1:numImages
        im = readimage(images, i);
        im = processImage(im);
        features = getFeatures(im);
        train_data = [train_data; features];
        clase(i) = name;
    end
end

function [ h ] = HistOrientations(im, treshold)
    im = double(im);
    sob = fspecial('sobel')/4;
    gx = imfilter(im, sob); % Gradient horitzontal
    gy = imfilter(im, sob'); % Gradient vertical
    alfa = atan2(gy,gx);
    dir = uint8(254*(alfa+pi)/2/pi);
    mod = sqrt(gx.^2+gy.^2);
    mask = (mod < treshold);
    dir(mask) = 255;
    h = imhist(dir);
    h = h';
end

function [ img ] = processImage(im)
    img = rgb2gray(im);
    img = imresize(img, [256 256]);
end