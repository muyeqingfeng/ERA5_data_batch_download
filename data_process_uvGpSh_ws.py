import numpy as np
import netCDF4 as nc
import os
import scipy.io as sio
import torch

# 处理数据的时间段
yearstart = 2000
yearend = 2021
years = np.array(range(yearstart, yearend + 1), dtype="str")

# 处理数据的层
pressure_level = ['100','200','300','400','500','600',
					'700','750','800','850','900','1000']
# 要处理的数据变量
variable_full_name = ['geopotential','specific_humidity','u_component_of_wind','v_component_of_wind']
variable_list=['GP','sh','u','v']
variable_nc = ['z','q','u','v']

# 改变工作路径到目标文件夹
def change_path(pl_para):
	file_path = "z" + pl
	dirs = os.path.join("./",file_path,"data_process_ws")
	if not os.path.exists(dirs):
		os.makedirs(dirs)
		os.chdir(dirs)
	else:
		os.chdir(dirs)

# 判断是否为闰年
for year in years:
	day = 365
	if ((int(year)%100)!=0 and (int(year)%4)==0) or (int(year)%400)==0:
		day = 366

	for pl in pressure_level:
		change_path(pl)
		for var,var_nc in zip(variable_list,variable_nc):
			file_name1 = os.path.join("./",'z'+pl,'download_ws',
									 '{}.nc'.format(var+pl+'_'+year))
			file_name2 = os.path.join("./", 'z' + pl, 'download_ws',
									 '{}.nc'.format(var + pl + '_' + str(int(year)+1)))
			# python读取的nc变量排列为 time*lat*log
			ncfile1 = nc.Dataset(file_name1)
			data1_fir = ncfile1[var_nc][:]
			data1_end = np.flip(data1_fir, axis=1)

			ncfile2 = nc.Dataset(file_name2)
			data2_fir = ncfile2[var_nc][:]
			data2_sec = np.flip(data2_fir, axis=1)
			data2_end = data2_sec[0:192, :, :]

			data_end = np.concatenate((data1_end, data2_end), axis=0)

			for i in range(day):
				f3 = []
				f6 = []
				file_w = data_end[i * 24:192 + (i * 24)]
				for k in range(0, 73, 3):
					file_h = file_w[k, :, :]
					f3.append(file_h)
				for m in range(78, 169, 6):
					file_m = file_w[m, :, :]
					f6.append(file_m)
				f3.extend(f6)
				f3 = np.array(f3)
				f3 = torch.tensor(f3)
				f3 = f3.permute(2, 1, 0)# 转化为log*lat*time 128*128*41
				f3 = np.array(f3, dtype=np.float32)
				j = i + 1

				output = "{}{}-{}_{}.mat".format(var, pl, year, str(j).rjust(3, '0'))
				sio.savemat(output, {var: f3})
	print('data process of {} is OK!'.format(year))

