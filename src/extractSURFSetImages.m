% Función para extraer las caracteristicas de una 
% estructura imageDatastore
function featuresCell = extractSURFSetImages(imds)
    numImages = numel(imds.Files);
    featuresCell = cell(numImages, 1);

    for i = 1:numImages
        im = readimage(imds, i);
        featuresCell{i} = SURFExtractor(im);
    end
end