# ERA5_data_batch_download
ERA5数据的批量下载 及 处理成.mat形式


# ERA5_data_download.py
ECMWF中ERA5再分析数据的批量下载。此代码在使用过程中，可能是由于数据量太大，网站是国外数据，网络不稳定等原因，频繁出现网站数据排队出错问题，导致代码频繁中断。
可以下载IDM下载器接管任务，效果好很多。

# data_process_uvGpSh_ws.py
这里是将数据处理成我想要的格式

# dem_data_process.m
将dem数据 (1/3600)° * (1/3600)° 平均值 0.25° * 0.25°
USGS地理信息中高程数据处理，官方提供了批量下载的工具bulk download，具体使用参考https://blog.csdn.net/qq_38734327/article/details/124347019
下载的高程数据数据精度达到 30m；我进行相关工作的模型网格点是0.25° * 0.25°，这个代码将相应区域的数据分辨率进行了由高到低的平均处理。

# pre_download.py ftp_pre_download.sh
noaa中降水hourly数据批量下载
数据地址：【https://www.ncei.noaa.gov/data/cmorph-high-resolution-global-precipitation-estimates/access/】
