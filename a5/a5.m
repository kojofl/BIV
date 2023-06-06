%% 1.
% Es ist wichtig anzumerken das bei mehrfachem ausführen evtl. die
% Workspace variablen verwendet werden wodurch das ergebnis verzert wird.
% Fix: Workspace clearen.
clear
% a)
img = imread("grains.jpg");
g_img = rgb2gray(img);
background = imhmin(imcomplement(g_img), 30);
watershed = watershed(background);
% b)
segmented_image = imoverlay(img, watershed == 0, 'red');
figure;
imshow(segmented_image);
% c) 
% Watershed markiert die einzelnen Pixel inerhalb von den segmenten von
% 1..n wobei n die Anzahl der Segmente ist, dementsprechend müssen erhalten
% wir die anzahl indem wir den maximalwert von der watershed matrix
% auslesen.
segment_anzahl = max(watershed(:));
disp(['Anzahl der Segmente: ' num2str(segment_anzahl)]);
% d)
% Alle 0 werte in watershed
disp(['Anzahl der Pixel der Wasserscheiden: ' num2str(histcounts(watershed(:), [0, 0]))]);
% e)
segment_ids = unique(watershed);
segment_pixels = histcounts(watershed(:), max(segment_ids) + 1);
[val, idx] = max(segment_pixels(2:end));
disp(['Das größte Segment hat ', num2str(val), ' Pixel.']);
% f)
largest_segment = imoverlay(segmented_image, watershed == idx, 'green');
figure;
imshow(largest_segment);

%% 2.
% Bild laden
image = imread('ifm.jpg');
segmentation = imread('ifm_seg.png');
D = bwdist(~segmentation);
imshow(D,[])
title('Distance Transform of Binary Image')
%D = -D;
D = imhmin(imcomplement(D), 1);
figure;
imshow(D,[])
title('Complement of Distance Transform')
L = watershed(D);
L(~segmentation) = 0;
rgb = label2rgb(L,'jet',[.5 .5 .5]);
imshow(rgb)
title('Watershed Transform')