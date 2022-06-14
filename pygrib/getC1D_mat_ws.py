#!/bin/python
import pygrib as pg
import numpy as np
import scipy.io as sio
import os
from os.path import join
import bz2
from bz2 import decompress
import shutil

year = 2018
jdays = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
# mon   = [1,2,3,4,5,6,7,8,9,10,11,12]
mon = [1]
bz_path = '/mnt/PRESKY/data/cmadata/NAFP/ECMF/C1D/'


def savemat(data, save_path: str, file_name: str, var_name: str, level: int, 
            typeOfLevel: str, lat_era: list,lon_era: list, mat_var: str):
    """
    :data     : 打开的pygrib数据
    :save_path: 文件保存路径
    :file_name: 保存的文件名称
    :var_name : 提取的变量名称
    :level    : 提取的变量高度
    :lat      ：关注区域的 纬度
    :lon      : 关注区域的 经度
    :mat_var  ：保存至mat中的变量名称
    """
    file = join(save_path, file_name)
    var = data.select(name=var_name, typeOfLevel=typeOfLevel, level=level)[0]
    var, lat, lon = var.data(lat1=min(lat_era), lat2=max(lat_era), lon1=min(lon_era), lon2=max(lon_era))
    sio.savemat(file, {mat_var: np.array(np.flip(var, axis=0).transpose(), dtype='float32')})  # 单精度
    # example:
    # savemat(data=data,save_path=path,file_name=file_name,var_name='Geopotential Height',level=100,
    #         typeOfLevel=typeOfLevel,lat_era=lat_era,lon_era=lon_era,mat_var='z')


day = 1
for ii, monn in enumerate(mon):
    while day <= jdays[monn - 1]:

        hrs = 0
        while hrs <= 168:
            dt = 3
            if hrs >= 72:
                dt = 6

            # ----------------------------------------------------------------------
            # input files
            # ----------------------------------------------------------------------
            thrs = int(hrs - (hrs / 24) * 24)
            tday = int(day + hrs / 24)
            tmon = monn
            tyear = year
            if tday > jdays[monn - 1]:
                tday = tday - jdays[monn - 1]
                tmon = tmon + 1
                if tmon > 12:
                    tyear = year + 1
                    tmon = 1

            bz2file_path = str(year) + '/' + str(year) + str(monn).rjust(2, '0') + '/' + \
                           str(year) + str(monn).rjust(2, '0') + str(day).rjust(2, '0')
            fileX = 'C1D' + str(monn).rjust(2, '0') + str(day).rjust(2, '0') + \
                    '0000' + str(monn).rjust(2, '0') + str(day).rjust(2, '0') + str(thrs).rjust(2, '0') + \
                    '001'
            fileZ = bz_path + bz2file_path + '/' + fileX + '.bz2'
            # 拷贝bz2文件到当前路径
            shutil.copy(fileZ, '.')
            # 解压缩bz2文件
            with open(fileX, 'wb') as new_file, bz2.BZ2File(fileZ, 'rb') as file:
                for data in iter(lambda: file.read(100 * 1024), b''):
                    new_file.write(data)
            # 删除原始bz2文件
            os.remove(fileX + '.bz2')

            # print(fileX) # for test
            data = pg.open(fileX)
            # 裁取的数据区域
            lat_era = np.arange(16, 48, 0.25)
            lon_era = np.arange(96, 128, 0.25)

            # 数据读取及保存
            path = '../../gp100/tmpp'
            file_name = 'gp-' + str(year) + str(monn).rjust(2, '0') + str(day).rjust(2, '0') + '00' + '-' + str(
                hrs).rjust(3, '0') + '.mat'
            # ../../ = /mnt/PRESKY/user/weishuo/dataPRE/EC/
            file1 = os.path.join('../../gp100/tmpp', file_name)
            file2 = os.path.join('../../gp200/tmpp', file_name)
            file3 = os.path.join('../../gp300/tmpp', file_name)
            file4 = os.path.join('../../gp400/tmpp', file_name)
            file5 = os.path.join('../../gp500/tmpp', file_name)
            file6 = os.path.join('../../gp600/tmpp', file_name)
            file7 = os.path.join('../../gp700/tmpp', file_name)
            file8 = os.path.join('../../gp800/tmpp', file_name)
            file9 = os.path.join('../../gp850/tmpp', file_name)
            file10 = os.path.join('../../gp900/tmpp', file_name)
            file11 = os.path.join('../../gp1000/tmpp', file_name)

            z1 = data.select(name='Geopotential Height', typeOfLevel='isobaricInhPa', level=100)[0]
            z2 = data.select(name='Geopotential Height', typeOfLevel='isobaricInhPa', level=200)[0]
            z3 = data.select(name='Geopotential Height', typeOfLevel='isobaricInhPa', level=300)[0]
            z4 = data.select(name='Geopotential Height', typeOfLevel='isobaricInhPa', level=400)[0]
            z5 = data.select(name='Geopotential Height', typeOfLevel='isobaricInhPa', level=500)[0]
            z6 = data.select(name='Geopotential Height', typeOfLevel='isobaricInhPa', level=600)[0]
            z7 = data.select(name='Geopotential Height', typeOfLevel='isobaricInhPa', level=700)[0]
            z8 = data.select(name='Geopotential Height', typeOfLevel='isobaricInhPa', level=800)[0]
            z9 = data.select(name='Geopotential Height', typeOfLevel='isobaricInhPa', level=850)[0]
            z10 = data.select(name='Geopotential Height', typeOfLevel='isobaricInhPa', level=900)[0]
            z11 = data.select(name='Geopotential Height', typeOfLevel='isobaricInhPa', level=1000)[0]

            z1, lat1, lon1 = z1.data(lat1=min(lat_era), lat2=max(lat_era), lon1=min(lon_era), lon2=max(lon_era))
            z2, lat2, lon2 = z2.data(lat1=min(lat_era), lat2=max(lat_era), lon1=min(lon_era), lon2=max(lon_era))
            z3, lat3, lon3 = z3.data(lat1=min(lat_era), lat2=max(lat_era), lon1=min(lon_era), lon2=max(lon_era))
            z4, lat4, lon4 = z4.data(lat1=min(lat_era), lat2=max(lat_era), lon1=min(lon_era), lon2=max(lon_era))
            z5, lat5, lon5 = z5.data(lat1=min(lat_era), lat2=max(lat_era), lon1=min(lon_era), lon2=max(lon_era))
            z6, lat6, lon6 = z6.data(lat1=min(lat_era), lat2=max(lat_era), lon1=min(lon_era), lon2=max(lon_era))
            z7, lat7, lon7 = z7.data(lat1=min(lat_era), lat2=max(lat_era), lon1=min(lon_era), lon2=max(lon_era))
            z8, lat8, lon8 = z8.data(lat1=min(lat_era), lat2=max(lat_era), lon1=min(lon_era), lon2=max(lon_era))
            z9, lat9, lon9 = z9.data(lat1=min(lat_era), lat2=max(lat_era), lon1=min(lon_era), lon2=max(lon_era))
            z10, lat10, lon10 = z10.data(lat1=min(lat_era), lat2=max(lat_era), lon1=min(lon_era), lon2=max(lon_era))
            z11, lat11, lon11 = z11.data(lat1=min(lat_era), lat2=max(lat_era), lon1=min(lon_era), lon2=max(lon_era))

            sio.savemat(file1, {'z': np.array(np.flip(z1, axis=0).transpose(), dtype='float32')})
            sio.savemat(file2, {'z': np.array(np.flip(z2, axis=0).transpose(), dtype='float32')})
            sio.savemat(file3, {'z': np.array(np.flip(z3, axis=0).transpose(), dtype='float32')})
            sio.savemat(file4, {'z': np.array(np.flip(z4, axis=0).transpose(), dtype='float32')})
            sio.savemat(file5, {'z': np.array(np.flip(z5, axis=0).transpose(), dtype='float32')})
            sio.savemat(file6, {'z': np.array(np.flip(z6, axis=0).transpose(), dtype='float32')})
            sio.savemat(file7, {'z': np.array(np.flip(z7, axis=0).transpose(), dtype='float32')})
            sio.savemat(file8, {'z': np.array(np.flip(z8, axis=0).transpose(), dtype='float32')})
            sio.savemat(file9, {'z': np.array(np.flip(z9, axis=0).transpose(), dtype='float32')})
            sio.savemat(file10, {'z': np.array(np.flip(z10, axis=0).transpose(), dtype='float32')})
            sio.savemat(file11, {'z': np.array(np.flip(z11, axis=0).transpose(), dtype='float32')})

            os.remove(fileX)
            hrs = hrs + dt
        day += 1