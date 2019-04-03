
input_dir = fullfile('synthetic_dataset', 'ground_truth');
output_dir  = fullfile('output', 'nonuniform');
if( ~exist(output_dir, 'dir') )
    mkdir(output_dir);
end

gyro_dir = fullfile('synthetic_dataset', 'gyro');
noise = 0.01;

img_list = load_list('list/ground_truth.txt');
gyro_list = load_list('list/gyro.txt');

for i = 1:length(img_list)
    img_name = sprintf('%s.png', img_list{i});
    img_path = fullfile(input_dir, img_name);
    
    fprintf('Load %s\n', img_path);
    img = imread(img_path);

    for g = 1:length(gyro_list)

        gyro_filename = fullfile(gyro_dir, gyro_list{g}, 'gyro.txt');
        info_filename = fullfile(gyro_dir, gyro_list{g}, 'info.txt');

        % read trajectory and camera info
        fprintf('Load %s\n', gyro_filename);
        info_data = importdata(info_filename);

        fprintf('Load %s\n', info_filename);
        gyro_data = importdata(gyro_filename);

        % synthesize non-uniform blur from 6D camera trajectory
        blur_img = synthesize_nonuniform_blur(img, info_data, gyro_data);
        
        % add noise
        blur_img = blur_img + noise * rand(size(blur_img));

        output_name = sprintf('%s_%s.png', img_list{i}, gyro_list{g});
        output_path = fullfile(output_dir, output_name);
        fprintf('Save %s\n', output_path);
        imwrite(blur_img, output_path);
    end
end