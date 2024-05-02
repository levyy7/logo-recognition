%% Función para cargar todas las imagenes con una extension determinada de una carpeta
function featuresCell = extractSIFTSetImages(imds)
    numImages = numel(imds.Files);
    featuresCell = cell(numImages, 1);

    for i = 1:numImages
        im = readimage(imds, i);
        featuresCell{i} = SIFTExtractor(im);
    end
end