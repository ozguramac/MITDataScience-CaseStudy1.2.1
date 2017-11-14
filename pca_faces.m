% number of images on the training set.
M = 14;

%read and show images(jpg);

% S will store all the images
S=[];

figure(1);
for i=1:M
    str = strcat('instructors/', int2str(i));
    str = strcat(str, '.jpg');
    eval('img=imread(str);');
%    img = rgb2gray(img);
    img = imresize(img, [300,300]);

    subplot(ceil(sqrt(M)),ceil(sqrt(M)),i)
    imshow(img)
    if i==3
        title('Course Intructors','fontsize',14)
    end
    drawnow;
    
    % save the dimensions of the image (irow, icold)
    [irow, icol]=size(img);
    
    % creates a (N1*N2) x 1 matrix and add to S
    temp=reshape(img',irow*icol,1);
    
    %S will eventually be a (N1*N2) x M matrix.
    S=[S temp];
end

%Normalize.
ustd=80
um=100
for i=1:size(S,2)
    temp=double(S(:,i));
    m=mean(temp);
    st=std(temp);
    S(:,i)=(temp-m)*ustd/st+um;
end

%save and show normalized images
figure(2);
for i=1:M
    str=strcat(int2str(i),'.jpg');
    img=reshape(S(:,i),icol,irow);
    img=img';
    eval('imwrite(img,str)');
    subplot(ceil(sqrt(M)),ceil(sqrt(M)),i)
    imshow(img)
    drawnow;
    if i==3
        title('Normalized Images','fontsize',18)
    end
end

%mean face;

%obtains the mean of each row of each image
m=mean(S,2);

%convert to unsigned 8-bit integer. Values range from 0 to 255
tmimg=uint8(m);

%takes the vector and creates a matrix
img=reshape(tmimg,icol,irow);

%matrix transpose
img=img';
figure(3);
imshow(img);
title('Mean Image','fontsize',18)
meanImg = img

% show the difference from mean
figure(4);

for i=1:M
    str=strcat(int2str(i),'.jpg');
    img=reshape(S(:,i),icol,irow);
    img=img';
    img = img - meanImg;
    subplot(ceil(sqrt(M)),ceil(sqrt(M)),i)
    imshow(img)
    drawnow;
    if i==3
        title('Difference of Normalized Images from the Mean','fontsize',18)
    end
end
