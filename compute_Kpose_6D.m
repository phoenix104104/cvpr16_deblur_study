function K_mat = compute_Kpose_6D(m,n,pose,s_temp)

dim_im = m*n;
focal_length = 36;
factor = 400/min(m,n);
% unit = [0.2,0.2,0.2,0.001*factor,0.001*factor,0.001*factor];

unit = [0.5,0.5,0.5,0,0,0];

%pixel loc
[p_col,p_row] = meshgrid(1:n,1:m);
loc = [p_row(:),p_col(:)];

%intrinsic K
fl = max(m,n)*focal_length/36;
x0 = m/2;
y0 = n/2;
K_intrin = [fl,0,x0;0,fl,y0;0,0,1];

%generate K_mat
% savepath = ['./K_mat/',num2str(m),'x',num2str(n),'/'];
% if(~exist(savepath))
%     mkdir(savepath);
% end
% depthpath = [savepath,'depth_',num2str(s_temp),'/'];
% if(~exist(depthpath))
%     mkdir(depthpath);  
% end

RX = pose(1)*unit(1);
RY = pose(2)*unit(2);
RZ = pose(3)*unit(3);
TX = pose(4)*unit(4);
TY = pose(5)*unit(5);
TZ = pose(6)*unit(6);

% file_name = [depthpath,'K_depth',num2str(s_temp),'_rx',num2str(pose(1)),'_ry'...
%     ,num2str(pose(2)),'_rz',num2str(pose(3)),'_tx',num2str(pose(4)),...
%     '_ty',num2str(pose(5)),'_tz',num2str(pose(6)),'.mat'];

% if(exist(file_name,'file'))
%     load(file_name);
% else

    R = sqrt(RX.*RX+RY.*RY+RZ.*RZ);
    RX = RX./R;
    RY = RY./R;
    RZ = RZ./R;
    R_sin = sin(R);
    R_cos = cos(R);
    R_cosc= 1-R_cos;

    if(R>0)
        P = zeros(3,3);
        P(1) = R_cos+RX.*RX.*R_cosc;
        P(2) = RZ.*R_sin+RY.*RX.*R_cosc;
        P(3) = -RY.*R_sin+RX.*RZ.*R_cosc;
        P(4) = -RZ.*R_sin+RY.*RX.*R_cosc;
        P(5) = R_cos+RY.*RY.*R_cosc;
        P(6) = RX.*R_sin+RY.*RZ.*R_cosc;
        P(7) = RY.*R_sin+RX.*RZ.*R_cosc;
        P(8) = -RX.*R_sin+RY.*RZ.*R_cosc;
        P(9) = R_cos+RZ.*RZ.*R_cosc;
        P = P + [0,0,(1/s_temp).*TX;0,0,(1/s_temp).*TY;0,0,0];
    else
        P = [1,0,(1/s_temp).*TX;0,1,(1/s_temp).*TY;0,0,1];
    end
    K_inv = eye(3)/K_intrin;
    H = K_intrin*P*K_inv;
    H_inv = inv(H);

    temp_loc = [loc';ones(1,dim_im)];
    proj_temp = (H_inv*temp_loc)';
    denom = proj_temp(:,3)+1e-10;

    location = proj_temp(:,1:2)./repmat(denom,[1,2]);
    location1 = location(:,1)';
    location1_floor = floor(location1);
    location2 = location(:,2)';
    location2_floor = floor(location2);    
    dif1 = location1 - location1_floor;
    dif2 = location2 - location2_floor;
    weight = [(1-dif1).*(1-dif2),dif1.*(1-dif2),dif2.*(1-dif1),dif1.*dif2];

    row_ind = [location1_floor,location1_floor+1,location1_floor,location1_floor+1];
    col_ind = [location2_floor,location2_floor,location2_floor+1,location2_floor+1];
    final_ind = find(row_ind>0 & row_ind<m+1 & col_ind>0 & col_ind<n+1);

    temp_loc = (location2_floor-1)*m+location1_floor;
    temp_col_ind = [temp_loc,temp_loc+1,temp_loc+m,temp_loc+m+1];
    temp_row_ind = [1:dim_im,1:dim_im,1:dim_im,1:dim_im];
    temp_value_ind = weight;

    K_mat = sparse(temp_row_ind(final_ind),temp_col_ind(final_ind),temp_value_ind(final_ind),dim_im,dim_im);
%     save(file_name,'K_mat');
% end
end