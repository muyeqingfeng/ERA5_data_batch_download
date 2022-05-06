clear

itt=0; if(itt==1)

lat=16:22;
lon=102:113;

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
	%--- 1/4
	dem2=finterpHtoL(dem,2);

save tmp.mat dem dem2
return
end



clf
load tmp.mat
subplot(211)
[c,h]=contourf(dem'); hold on; colorbar; %set(h,'edgecolor','none');
subplot(212)
[c,h]=contourf(dem2'); hold on; colorbar



