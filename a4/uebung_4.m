%% 1)
% a)
% graythresh bekommt als Input ein Grauwertbild und berechnet mit diesem
% (Otsu-Methode) den Schwellenwert. Dieser kann für die methode imbinarize 
% verwendet werden. Diese Methode bekommt ein Grauwertbild und einen
% Schwellen wert und wandelt dieses in ein Binärbild um.
% otsuthresh erechnet ebenfalls einen Schwellenwert der mit imbinarize
% verwendet werden kann. Zusätzlich kann otsuthresh die 'effektvität' des
% threshholds zurückgeben.
% adaptthresh berechnet einen Schwellenwert für jede Region des
% Inputbildes. 
% b)
% Das Segmentieren ist schwierig da es in dem Bild zu viel Rauschen gibt
% und das die berechnung eines Schwellenwerts auf basis eines Histograms
% schwierig macht.
image = imread("BIVr.png");
threshhold = graythresh(image);
binary = imbinarize(image, threshhold);
imshow(binary);
% c)
glatt = imgaussfilt(image, 5);
threshglatt = graythresh(glatt);
glattbin = imbinarize(glatt, threshglatt);
figure;
imshow(glattbin);
figure;
histogram(glatt);
% Der mittelwert liegt etwas links der Mitte auf dem weg vom ersten großen
% peak nach unten in ein tal.

% d)
label_img = bwlabel(glattbin);
rgb = label2rgb(label_img);
figure;
imshow(rgb);

% e)
label_stats = regionprops(label_img, 'Area');
areas = [label_stats.Area];
areas = sort(areas);
% Die Anzahl der Pixel auf dem I-Punkt beträgt 1595
% Das areas array is aufsteigend sortiert und der I-Punkt ist die 4-Größte
% region im Bild.
areas(length(areas) - 3)

% f)
length(areas)

%% 2)
% a)
img = imread("shading.jpg");
shading = im2gray(im2double(img));
figure;
imshow(shading);
figure;
imhist(shading);
threshhold = graythresh(shading);
threshhold
[levels, metric] = multithresh(shading, 2);
levels
shading_quant = imquantize(shading, levels);
figure;
hist(shading_quant);
% Das ergebnis enthält 3 verschiedene grauwerte.
length(unique(shading_quant))
% b) 
% Der kleinste balken im histogram müssten die dunklen kugeln sein der
% mittlere die hellen kugeln und der hintergrund der größte Balken.

% c)
glatt_sh = imgaussfilt(shading, 100);
% d)
korektur = shading ./ glatt_sh;
korektur = korektur ./ max(korektur(:));
korektur = imadjust(korektur, stretchlim(korektur, [0.01, 0.99]), [0 1]);
figure;
imshow(korektur);

% e)
% Es sind bei mir nur zwei peaks zu erkennen die zum background un zu den
% hellen punkten gehören. Ich habe bei der Korrektur wohl einen fehler
% gemacht.
figure;
hist(korektur);

% f)
thresh = graythresh(shading);
thresh
threshs = multithresh(shading, 3);
threshs 
seg_otsu = imbinarize(shading, thresh);
seg_otsu_rgb = label2rgb(seg_otsu);
imshow(seg_otsu_rgb);
seg_multi = imquantize(shading, threshs);
seg_multi_rgb = label2rgb(seg_multi);
figure;
imshow(seg_multi_rgb);
% g)
% Ich versuche wie in aufgabe 1 die durch regionprops die einzelnen objekte
% des bildes zu erhalten und diese dann zu zählen allerdings bekomme ich
% im Area feld nur eine Zahl als gäbe es nur eine große region.
% Die Idee wäre, wenn es funktionieren würde, wenn zu viele Objekte gezählt
% werden z.b. bei rändern von Objekten alle besonders kleinen objekte
% herauszufiltern und nicht zu zählen.
[labels , num_l]= bwlabel(seg_otsu);
label_stats_a = regionprops(labels, 'Area');
label_stats_a.Area;

