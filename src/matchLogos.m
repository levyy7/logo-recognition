%% Funcion que devuelve el numero de matchings/numero de historgramas por cada imagen de test
function [group, matchings] = matchLogos(trainingDescriptors, testDescriptors)
    logo_types = ["Apple", "BLACKBERRY", "Cisco Systems", "Daewoo Electronics", "hp", "IBM", "Intel", "motorola"];
    numLogos = numel(logo_types);
    numImgsTest = sum(cellfun(@numel, testDescriptors));
    group = zeros(numImgsTest, 1);
    matchings = cell(numImgsTest, 1);
    
    counter = 1;
    for i = 1:numLogos
        c = testDescriptors{i};
        for j = 1:numel(c)
            histImg = c{j};
            group(counter) = i;
    
            numMatchingsLogo = zeros(numLogos, 1);
            for k = 1:numel(logo_types)
                numMatchingsLogo(k) = computeMatchingsEuclidean(histImg, trainingDescriptors{k});
                numMatchingsLogo(k) = numMatchingsLogo(k) / computeNumHistograms(trainingDescriptors{k});
            end
            
            matchings{counter} = numMatchingsLogo;
            %[m, index] = max(numMatchingsLogo);
            %grouphat((i - 1)*numImgsTest + j) = index;

            counter = counter + 1;
        end
    end
end