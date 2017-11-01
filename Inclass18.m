% In class 18

% Problem 1. In this directory, you will find the same image of yeast cells as you used
% in homework 5. First preprocess the image any way you like - smoothing, edge detection, etc. 
% Then, try to find as many of the cells as you can using the
% imfindcircles routine with appropriate parameters. 
% Display the image with the circles drawn on it.  

I = imread('yeast.tif');
imshow(I);

M = I > 60;
imshow(M);


O = imopen(M, strel('disk',4));
imshow(O);

hx = fspecial('sobel');
hy = hx';
Iy = imfilter(double(O), hy, 'replicate');
Ix = imfilter(double(O), hx, 'replicate');
edge_img = sqrt(Ix.^2+Iy.^2);
imshow(edge_img, []);


[centers, radii] = imfindcircles(edge_img, [16 25], 'Sensitivity', 0.96);
imshow(edge_img, []);
hold on;
for ii = 1:length(centers)
    drawcircle(centers(ii,:), radii(ii), 'm');
end

% overlaying on the original image
[centers, radii] = imfindcircles(edge_img, [16 25], 'Sensitivity', 0.96);
imshow(I, []);
hold on;
for ii = 1:length(centers)
    drawcircle(centers(ii,:), radii(ii), 'm');
end


% Problem 2. (A) Draw two sets of 10 random numbers - one from the integers
% between 1 and 9 and the second from the integers between 1 and 10. Run a
% ttest to see if these are significantly different. (B) Repeat this a few
% times with different sets of random numbers to see if you get the same
% result. (C) Repeat (A) and (B) but this time use 100 numbers in each set
% and then 1000 numbers in each set. Comment on the results. 

% A
for ii = 1:1000
x = randi(9, [10,1]);
y = randi(10, [10,1]);

[is_sig(ii), pval(ii)] = ttest2(x, y);
end
resultA = sum(is_sig);
disp(resultA);

% B
% test 1
for ii = 1:1000
x = randi(90,[10,1]);
y = randi(100, [10,1]);

[is_sig(ii), pval(ii)] = ttest2(x, y);
end
resultB = sum(is_sig);
disp(resultB);

%test 2 
for ii = 1:1000
x = randi(9000,[10,1]);
y = randi(100, [10,1]);

[is_sig(ii), pval(ii)] = ttest2(x, y);
end
resultB = sum(is_sig);
disp(resultB);

% test 1 increases the number but keeps the ratio from A this does not
% result in an increase of the number of statistic significant comparison
% since it keeps the ratio of the mean from A.
% test 2 increases the possibilities of number that may be drawn for x,
% which results in a difference in the means corroborated by the amount of
% times ttest is significant


% C

% 100 numbers
% test 1
for zz = 1:100
for ii = 1:1000
x = randi(90,[100,1]);
y = randi(100, [100,1]);

[is_sig(ii), pval(ii)] = ttest2(x, y);
end
resultB_100(zz) = sum(is_sig);
end


%test 2 
for ii = 1:1000
x = randi(9000,[100,1]);
y = randi(100, [100,1]);

[is_sig(ii), pval(ii)] = ttest2(x, y);
end
resultB = sum(is_sig);
disp(resultB);

% 1000 numbers
% test 1
for zz = 1:100
for ii = 1:1000
x = randi(90,[1000,1]);
y = randi(100, [1000,1]);

[is_sig(ii), pval(ii)] = ttest2(x, y);
end
resultB_1000(zz) = sum(is_sig);
end


%test 2 
for ii = 1:1000
x = randi(9000,[1000,1]);
y = randi(100, [1000,1]);

[is_sig(ii), pval(ii)] = ttest2(x, y);
end
resultB = sum(is_sig);
disp(resultB);

% increasing the sample size greatly increase the power and confidence of
% the ttest to test the difference between the means. this becomes evident
% comparing the draw of 100 numbers on test1 to drawing 1000 numbers in
% test1 as it is evident in the histogram displayed below

hist(resultB_100);
h = findobj(gca,'Type','patch');
h.FaceColor = 'g';
hold on;
hist(resultB_1000);
legend('n = 100', 'n = 1000');
xlabel('Number of significant tests');
ylabel('Density');