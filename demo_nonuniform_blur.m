% -------------------------------------------------------------------------
%  Description:
%       Demo script to synthesize non-uniform blurred images from gyro data
%
%  Citation: 
%       A Comparative Study for Single Image Blind Deblurring
%       Wei-Sheng Lai, Jia-Bin Huang, Zhe Hu, Narendra Ahuja, and Ming-Hsuan Yang
%       IEEE Conference on Computer Vision and Pattern Recognition (CVPR), 2016
%
%  Contact:
%       Wei-Sheng Lai
%       wlai24@ucmerced.edu
%       University of California, Merced
% -------------------------------------------------------------------------

%% Load latent image
img_path = 'manmade_01.png';
fprintf('Load %s\n', img_path);
img = imread(img_path);


%% Load gyro data
gyro_dir = 'gyro/gyro_01';
gyro_path = fullfile(gyro_dir, 'gyro.txt');
info_path = fullfile(gyro_dir, 'info.txt');

fprintf('Load %s\n', gyro_path);
info_data = importdata(info_path);

fprintf('Load %s\n', info_path);
gyro_data = importdata(gyro_path);


%% synthesize non-uniform blur from 6D camera trajectory
blur_img = synthesize_nonuniform_blur(img, info_data, gyro_data);
        

%% add noise
noise = 0.01;
blur_img = blur_img + noise * rand(size(blur_img));


%% Save blurred image
output_path = 'manmade_01_gyro01.png';
fprintf('Save %s\n', output_path);
imwrite(blur_img, output_path);
