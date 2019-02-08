%hybrid_image
clc;
clear all;
close all;

Image1='bicycle.bmp';
Image2='motorcycle.bmp';

%Image1='hung.jpg';
%Image2='tsai.png'

%Image1='obama.jpg';
%Image2='michelle_obama.jpg';

%Image1='marilyn.bmp';
%Image2='einstein.bmp';


I1=im2double( rgb2gray(  imread(Image1) ) );
I2=im2double( rgb2gray(  imread(Image2) ) );

sigma=5;
gaussiand=3*sigma*2+2;


I1Filter=highPassFilter(I1,gaussiand);


figure('Name','I1Filter'), imshow(I1Filter,[]);



sigma=1;
gaussiand=3*sigma*2+2;
I2Filter=lowPassFilter(I2,gaussiand);

figure('Name','I2Flter'), imshow(I2Filter,[]);



final_image=I1Filter+I2Filter;
figure('Name','hybrid'), imshow(final_image, []);




function imagefilter1=lowPassFilter(image,filter_size)

lowimage_fit = fft2(image);
imageshift=fftshift(lowimage_fit);

[M N]=size(lowimage_fit); 

X=0:N-1;
Y=0:M-1;
[X Y]=meshgrid(X,Y);
Center_of_x=0.5*N;
Center_of_y=0.5*M;
G=exp(-((X-Center_of_x).^2+(Y-Center_of_y).^2)./(2*filter_size).^2);

FilterImage=imageshift.*G;
FilterShiftImage=ifftshift(FilterImage);
imagefilter1=ifft2(FilterShiftImage);


end


function imagefilter2=highPassFilter(image,filter_size)

highimage_fit = fft2(image);
imageshift=fftshift(highimage_fit);

[M N]=size(highimage_fit); 

X=0:N-1;
Y=0:M-1;
[X Y]=meshgrid(X,Y);
Center_of_x=0.5*N;
Center_of_y=0.5*M;
G=1-exp(-((X-Center_of_x).^2+(Y-Center_of_y).^2)./(2*filter_size).^2);

FilterImage=imageshift.*G;
FilterShiftImage=ifftshift(FilterImage);
imagefilter2=ifft2(FilterShiftImage);


end