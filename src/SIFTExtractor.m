%% Función para cargar todas las imagenes con una extension determinada de una carpeta
function [features, featureMetrics, location] = SIFTExtractor(img)
    gray = rgb2gray(img);

    kp_img = detectSIFTFeatures(gray, "EdgeThreshold", 15, "ContrastThreshold", 0.01);
    location = kp_img.Location;
    featureMetrics = kp_img.Metric;
    
    features = extractFeatures(gray, kp_img, "Method", "SIFT");
end