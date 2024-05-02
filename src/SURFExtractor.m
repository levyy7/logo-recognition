%% Función para extraer las caracteristicas SURF de una imagen
function [features, featureMetrics, location] = SURFExtractor(img)
    gray = rgb2gray(img);

    kp_img = detectSURFFeatures(gray, "NumScaleLevels", 5);
    location = kp_img.Location;
    featureMetrics = kp_img.Metric;
    
    features = extractFeatures(gray, kp_img, "Method", "SURF");
end