import requests
from os.path import join
import os.path

day1 = [31,28,31,30,31,30,31,31,30,31,30,31]
day2 = [31,29,31,30,31,30,31,31,30,31,30,31]

""" 闰年判别 """
def check_year(year):
    if (year % 400 == 0) or (year % 4 == 0) and (year % 100 != 0):
        day = day2
    else:
        day = day1
    return day

""" 文件保存路径 """
def path_save(year, month, day):
    dirs1 = join(r"D:/My_Document/Code/pre/", str(year))
    if not os.path.exists(dirs1):
        os.makedirs(dirs1)
        path1 = dirs1
    else:
        path1 = dirs1

    dirs2 = join(path1, str(month).rjust(2,'0'))
    if not os.path.exists(dirs2):
        os.makedirs(dirs2)
        path2 = dirs2
    else:
        path2 = dirs2

    dirs3 = join(path2, str(day).rjust(2,'0'))
    if not os.path.exists(dirs3):
        os.makedirs(dirs3)
        path3 = dirs3
    else:
        path3 = dirs3
    return path3

""" 数据下载 """
for year in range(1998,1999):
    day_num = check_year(year)
    for month in range(1,13):
        for day in range(1,day_num[month-1]+1):
            path = path_save(year, month, day)
            for hour in range(24):
                filename = 'CMORPH_V1.0_ADJ_0.25deg-HLY_' + str(year)  +str(month).rjust(2,'0') + str(day).rjust(2,'0') + str(hour).rjust(2,'0') + '.nc'
                url=join("https://www.ncei.noaa.gov/data/cmorph-high-resolution-global-precipitation-estimates/access/hourly/0.25deg/",
                         str(year)+'/'+str(month).rjust(2,'0')+'/'+str(day).rjust(2,'0')+'/'+filename)

                # filename= url.split("1998/01/01/")[1]#取url最后一些关键字作为数据命名
                print ("正在下载：",filename)

                download = requests.get(url,stream=True )
                with open(path+'/'+filename, "wb") as code:#"wb" 以二进制写方式打开，只能写文件
                    code.write(download.content)

    print(str(year)+"结束,",download.status_code)