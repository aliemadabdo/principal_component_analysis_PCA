%Program for face recognation (testing)
clc;
load pcadb; %Loading pcadb.mat file

% pcadb loads followings in workspace
% Image size [M=100, N=90]
% Mean Image [m]
% Reduced Eigen vectors transformation matrix [Ppca]
% Transformed dataset matrix [T]

[filename,pathname]=uigetfile ('*.*','Select the Input Image') ;
filewithpath=strcat (pathname, filename) ;
img=imread(filewithpath) ;
imgo=img;

img=rgb2gray(img);
img=imresize (img, [M,N]) ;
img=double (reshape (img, [1,M*N]));

imgpca= (img-m)*Ppca; %Projecting query image to PCA space

distarray=zeros (n,1) ; %Initialize difference array

for i=1:n
    distarray(i) =sum (abs (T (i, :)-imgpca)); %Finding L1 distance
end

[result, indx]=min (distarray); %Getting best match
resultimg=imread (sprintf ('%d.jpg',indx)); %Getting best matched image

%Plotting Images
subplot(121)
imshow(imgo) ;
title('Query Face') ;
subplot(122)
imshow(resultimg);
title('Recognized Face');
