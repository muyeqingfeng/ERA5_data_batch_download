% ----------------------------------------------------------------------
% grib2格式数据信息读取及处理
% ----------------------------------------------------------------------
clear;clc
addpath('D:\My_Document\Code\Matlab_toolbox\nctoolbox-master')
setup_nctoolbox
lat_era  = 16:0.25:47.75;
lon_era = 96:0.25:127.75;

%file1 = 'Z_SURF_C_BABJ_20210701002613_P_CMPA_RT_CHN_0P01_HOR-PRE-2021070100.GRB2';
file2 = 'rmf.hgra.2017060100017.grb2';
%file3 = 'C1D09010000090100001';

grib_info1 = ncgeodataset(file2);
grib_info1.variables

lat    = grib_info1{'lat'}(:);
lon   = grib_info1{'lon'}(:);
pre   = grib_info1{'pressure'}(:);

lat_era  = lat(1:10:end);
lon_era = lon(1:10:end);
level = [10000:10000:80000,85000,90000,100000];

idx_lat  = [1:length(lat)];
idx_lon = [1:length(lon)];
idx_lev  = [1:length(pre)];
lat_index    = idx_lat(ismember(lat,lat_era));
lon_index   = idx_lon(ismember(lon,lon_era));
level_index = idx_lev (ismember(pre,level));

q    = squeeze(grib_info1{'Specific_humidity'}(:,:,:,:));
q    = q(level_index,lat_index,lon_index);
z    = grib_info1{'Pressure'}(:,:,:,:);
z    = z(level_index,lat_index,lon_index);
u    =  grib_info1{'U-component_of_wind'}(:,:,:,:);
u    = u(level_index,lat_index,lon_index);
v    =  grib_info1{'V-component_of_wind'}(:,:,:,:);
v    = v(level_index,lat_index,lon_index);



