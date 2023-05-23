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








%Program to implement face recognition using PCA

n=input ('Enter No. of Images for training: ');
L=input ('Enter No. of Dominant Eigen Values to keep: ') ;

M=100; N=90; %Required Image Dimensions
X=zeros(n, (M*N)); %Initialie Data set matrix [X]
T=zeros (n,L); %Initialize Transformed data set [T] in PCA space

for count=1:n
    I=imread (sprintf ('%d.jpg' , count)); %Reading images
    I=rgb2gray(I);
    I=imresize(I,[M,N]);
    X (count, : ) =reshape (I, [1,M*N]) ; %Reshaping images as 1D vector
end
Xb=X; %Copy database for further use

m=mean (X) ; %Mean of all Images
for i=1:n
    X(i, :)=X(i, :)-m; %Subtracting Mean from each 1D image
end

Q= (X'*X) / (n-1); %Finding Covariance Matrix
[Evecm,Evalm]=eig(Q); %Getting Eigen values and Eigen vectors of COV matrix [Q]
Eval=diag(Evalm); %Extracting all eigen values
[Evalsorted, Index]=sort (Eval, 'descend'); %Sorting Eigen Values
Evecsorted=Evecm(:,Index);
Ppca=Evecsorted(:,1:L); %Reduced Transformation matrix [Ppca]

%projecting each image to PCA space
for i=1:n
    T(i,:)=(Xb(i, :)-m)*Ppca; %Projecting each image to PCA space
end