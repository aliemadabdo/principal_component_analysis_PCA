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

%%note: save only the variables (m,M,n,N,Ppca,T) in the workspace at the same
%%file with PCAtrain.m as pcadb to run the test part correctly