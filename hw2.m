%�v��Ū��
img = imread('test.jpg')
ff = padarray(double(img),[1 1], 'replicate');
%�]�w�֭�
FB = (1/9)*[1 1 1;1 1 1;1 1 1]; %�ҽk��
FL = [1 1 1;1 -8 1;1 1 1]*0.5; %2���L��(laplace)
[frameHeight, frameWidth, D] = size(img); %�O�v�����e
sobel_img = zeros(frameHeight, frameWidth, 'double'); %�Ͻg�﫬�A��double(��K�B��) 
%sobel�B�z
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
img1 = imfilter(sobel_img,FB,'replicate'); %sobel��v���ҽk�ƳB�z
img2 = imfilter(img,FL,'replicate'); %��ϰ�2���L���B�z
%�v����0~1(���H255)��P2���L���ᤧ�Ϭۭ�
for m = 1:frameWidth
    for l = 1:frameHeight
        img3(l,m,:)=((img1(l,m,:))/255).*(img2(l,m,:));
    end
end
%�N���G�[�^��Ϩ��o�U�Q�ƫᤧ�ĪG
for m = 1:frameWidth
    for l = 1:frameHeight
        img4(l,m,:)=img3(l,m,:)+img(l,m,:);
    end
end
%��ܹϤ�
figure(1);imshow(img);
figure(2);imshow(img2);
figure(3);imshow(uint8(sobel_img));
figure(4);imshow(uint8(img1));
figure(5);imshow(img3);
figure(6);imshow(img4);