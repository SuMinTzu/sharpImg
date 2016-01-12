%影像讀取
img = imread('test.jpg')
ff = padarray(double(img),[1 1], 'replicate');
%設定閥值
FB = (1/9)*[1 1 1;1 1 1;1 1 1]; %模糊化
FL = [1 1 1;1 -8 1;1 1 1]*0.5; %2次微分(laplace)
[frameHeight, frameWidth, D] = size(img); %記影像長寬
sobel_img = zeros(frameHeight, frameWidth, 'double'); %圖篇改型態為double(方便運算) 
%sobel處理
for m = 2:frameWidth+1;
    for l = 2:frameHeight+1
        Gx = (ff(l-1, m+1) + 2*ff(l, m+1) + ff(l+1, m+1)) - ...
            (ff(l-1, m-1) + 2*ff(l, m-1) + ff(l+1, m-1));
        Gy = (ff(l+1, m-1) + 2*ff(l+1, m) + ff(l+1, m+1)) - ...
            (ff(l-1, m-1) + 2*ff(l-1, m) + ff(l-1, m+1));
        value = abs(Gx) + abs(Gy);
        sobel_img(l-1, m-1) = value;
    end
end 
img1 = imfilter(sobel_img,FB,'replicate'); %sobel後影像模糊化處理
img2 = imfilter(img,FL,'replicate'); %原圖做2次微分處理
%影像取0~1(除以255)後與2次微分後之圖相乘
for m = 1:frameWidth
    for l = 1:frameHeight
        img3(l,m,:)=((img1(l,m,:))/255).*(img2(l,m,:));
    end
end
%將結果加回原圖取得銳利化後之效果
for m = 1:frameWidth
    for l = 1:frameHeight
        img4(l,m,:)=img3(l,m,:)+img(l,m,:);
    end
end
%顯示圖片
figure(1);imshow(img);
figure(2);imshow(img2);
figure(3);imshow(uint8(sobel_img));
figure(4);imshow(uint8(img1));
figure(5);imshow(img3);
figure(6);imshow(img4);