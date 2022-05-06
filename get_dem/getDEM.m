clear

itt=0; if(itt==1),
lat=15:48;
lon=95:128;
nx=length(lon); ny=length(lat); dem=NaN(8*nx,8*ny);
path='/mnt/PRESKY/user/weishuo/DEM_Download/data_raw/';
for iy=lat(1):lat(end)
for ix=lon(1):lon(end)
	cx=ix-lon(1)+1;
	cy=iy-lat(1)+1;
	yy=num2str(iy);
	xx=num2str(1000+ix);
	file=[path,'n',yy,'_e',xx(2:4),'_1arc_v3.tif']
if(exist(file))
	[A, R] = geotiffread(file);
	A=double(A);
	A=A';
	A(A<=0)=NaN;
	A=flipdim(A,2);
	A=A(1:3600,1:3600);
	%--- 1/8
	B=finterpHtoL(A,450);
	dem((cx-1)*8+1 : cx*8, (cy-1)*8+1 : cy*8) = B;
end
end
end
save getDEM.mat dem
return
end

load getDEM.mat

	dem8=dem;

lat=15+1/16:1/8:49;
lon=95+1/16:1/8:129;
index1 = find (lon>=(96-1/8) & lon<= (127.75+1/8));
index2 = find (lat>=(16-1/8) & lat<= ( 47.75+1/8));
dem=dem(index1,index2);

	dem4=finterpHtoL(dem,2);

	load /mnt/PRESKY/user/jinxiangze/dataPRE/DEM/elevation.mat elev
	w1=dem4(1:50,25:128);
	w2=elev(1:50,25:128);
	w1(isnan(w1))=w2(isnan(w1));
	dem4(1:50,25:128)=w1;

save getDEM.mat dem4 dem8
