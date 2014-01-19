function calldwt1(strtxt)
global a;
[a,map]=imread(strtxt);
[r,c,d]=size(a);
x=ceil(r/100);
y=ceil(c/100);
g3=a(1:x:end,1:y:end,:);
g3(g3==255)=5.5*255;
subplot(2,4,5); %for jignesh
imagesc(a);
xlabel('original image');
[r,c,d]=size(g3);
a=g3;
%c=rgb2gray(a);
%b=imresize(a, [512 512]); 
b=a;
n=r; % image is square image
k=1; % start the calculation of averages and differences of all rows first
for i=1:1:n
for j=1:2:n
if (j<=n-1)
s(i,k)=(b(i,j)+b(i,j+1))/2;
d(i,k)=b(i,j)-b(i,j+1);
end

k=k+1;
end
k=1;
end
for i=1:1:n % place the averages and differences in the original matrix
for j=1:1:n/2
b(i,j)=s(i,j);
b(i,ceil(j+n/2))=d(i,j);
end
end
for j=1:1:n/2 % calculate the averages and differences for the first half of the matrix
for i=1:2:n
if i<=n-1
s(k,j)=(b(i,j)+b(i+1,j))/2;
d(k,j)=b(i,j)-b(i+1,j);
end
k=k+1;
end
k=1;
end

for i=1:1:n/2 % place the results in the original matrix
for j=1:1:n/2
b(i,j)=s(i,j);
b(ceil(i+n/2),j)=d(i,j);
end
end
subplot(2,4,6);
imagesc(b); % image after doing one levelfor j
title('image after one level of compression')
end
% for i=1:1:n/2 % do the same on the image obtained after one level compression
% for j=1:2:n/2
% if (j<=n/2-1)
% s(i,k)=(b(i,j)+b(i,j+1))/2;
% d(i,k)=b(i,j)-b(i,j+1);
% end
% k=k+1;
% end
% k=1;
% end
% for i=1:1:n/2
% 
% for j=1:1:n/4
% b(i,j)=s(i,j);
% b(i,ceil(j+n/4))=d(i,j);
% end
% end
% for j=1:1:n/4
% for i=1:2:n/2
% if i<=n/2-1
% s(k,j)=(b(i,j)+b(i+1,j))/2;
% d(k,j)=b(i,j)-b(i+1,j);
% end
% k=k+1;
% end
% k=1;
% end
% for i=1:1:n/4
% for j=1:1:n/4
% b(i,j)=s(i,j);
% b(ceil(i+n/4),j)=d(i,j);
% end
% end
% 
% subplot(1,4,4)
% imagesc(b);
% title('image after two level of compression')
% for i=1:1:n/4 % perform the same on image obtained after second level of compression
% for j=1:2:n/4
% if (j<=n/4-1)
% s(i,k)=(b(i,j)+b(i,j+1))/2;
% d(i,k)=b(i,j)-b(i,j+1);
% end
% k=k+1;
% end
% k=1;
% end
% for i=1:1:n/4
% for j=1:1:n/8
% b(i,j)=s(i,j);
% b(i,j+n/8)=d(i,j);
% end
% end
% 
% for j=1:1:n/8
% for i=1:2:n/4
% if i<=n/4-1
% s(k,j)=(b(i,j)+b(i+1,j)/2);
% d(k,j)=b(i,j)-b(i+1,j);
% end
% k=k+1;
% end
% k=1;
% end
% for i=1:1:n/8
% for j=1:1:n/8
% b (i, j)=s(i,j);
% b (i+n/8, j)=d(i,j);
% end
% end
% figure (5);
% imshow (uint8(b));
% title ('image after third level of compression')