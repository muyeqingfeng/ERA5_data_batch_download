#!/usr/bin/python

import cdsapi
import urllib3
import os
import numpy as np
from subprocess import call

def idmDownloader(task_url, folder_path, file_name):
    """
    IDM下载器
    :param task_url: 下载任务地址
    :param folder_path: 存放文件夹
    :param file_name: 文件名
    :return:
    """
    # IDM安装目录
    idm_engine = "C:\\Program Files (x86)\\Internet Download Manager\\IDMan.exe"
    # 将任务添加至队列
    call([idm_engine, '/d', task_url, '/p', folder_path, '/f', file_name, '/a'])
    # 开始任务队列
    call([idm_engine, '/s'])
    
# download data from: https://cds.climate.copernicus.eu/cdsapp#!/dataset/reanalysis-era5-pressure-levels?tab=form
urllib3.disable_warnings()
c = cdsapi.Client()

# define the pressure levels you want download
pressure_level = ['800','850','900','1000']

# define the years you want to download
yearstart = 2000
yearend = 2021

# define spatial limits of download
north = 47.75
west = 96
south = 16
east = 127.75
# define the variables you want download
variable = ['geopotential','specific_humidity','u_component_of_wind','v_component_of_wind']
name_list=['GP','sh','u','v']
years = np.array(range(yearstart, yearend + 1), dtype="str")
area = [north, west, south, east]

# change the path to save the download file
def change_path(pl_para):
    file_path = "z" + pl
    dirs = os.path.join("D:/Jupyter notebook code/data/",file_path,"download_ws")
    if not os.path.exists(dirs):
        os.makedirs(dirs)
        os.chdir(dirs)
    else:
        os.chdir(dirs)
    

for year in years:
    for pl in pressure_level:
        change_path(pl)
        for name,var in zip(name_list,variable):
            r = c.retrieve(
                    'reanalysis-era5-pressure-levels',
                    {
                        'product_type': 'reanalysis',
                        'format': 'netcdf',
                        'pressure_level': pl,
                        'variable': var,
                        'year': year,
                        'month': [
                            '01', '02', '03',
                            '04', '05', '06',
                            '07','08','09',
                            '10','11','12',
                        ],
                        'day': [
                            '01', '02', '03',
                            '04', '05', '06',
                            '07', '08', '09',
                            '10', '11', '12',
                            '13', '14', '15',
                            '16', '17', '18',
                            '19', '20', '21',
                            '22', '23', '24',
                            '25', '26', '27',
                            '28', '29', '30',
                            '31',
                        ],
                        'time': [
                            '00:00', '01:00', '02:00',
                            '03:00', '04:00', '05:00',
                            '06:00', '07:00', '08:00',
                            '09:00', '10:00', '11:00',
                            '12:00', '13:00', '14:00',
                            '15:00', '16:00', '17:00',
                            '18:00', '19:00', '20:00',
                            '21:00', '22:00', '23:00'
                        ],
                        'area': area,
                    },
                    )
            url = r.location
            path = os.getcwd()#"D:\\Jupyter notebook code\\data\test\\"
            filename = name + pl + '_' + year + '.nc'
            idmDownloader(url, path, filename)  # 添加进IDM中下载
    print('data of {} is OK!'.format(year))
