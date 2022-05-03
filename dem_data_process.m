clear;clc;close all
for task = [1, 2]
    switch task
	case 1
	clear;clc;close all
        load('./DEM_Download/data/ERA5_latlon.mat')
	% read the list of file name
        file_dir = dir(['./DEM_Download/data_raw/*.tif']);
        file_dir = file_dir(1:1152);
		
	for ii = 1:length(file_dir)
		file_name = file_dir(ii).name;
		lat(ii) = str2num(file_name(2:3));
		lon(ii) = str2num(file_name(6:8));
	end
	lat = unique(lat);
	lon = unique(lon);

	% 将分辨率平均至0.125°
	fac = 0.125;
	% build the data grid/建立网格，内存预分配
	latg = lat(1)+fac/2:fac:lat(end)+1-fac/2;
	long = lon(1)+fac/2:fac:lon(end)+1-fac/2;


	for num = 1:length(file_dir)
		disp([ '[', num2str(num), ']' ,' / ', '[', num2str(length(file_dir)), ']'])
		file_name = file_dir(num).name;
		[A, R] = geotiffread(['/mnt/PRESKY/user/weishuo/DEM_Download/data_raw/', file_name]);
		A (A == -32767) = nan;
		d = A(1:3600, 1:3600);
		[nx,ny] = size(d);
		mx = floor(nx/(3600/(1/fac)));
		my = floor(ny/(3600/(1/fac)));

		nt = 3600/(1/fac);
		A1=reshape(d,nx,nt,my);
		A1=permute(A1,[2,1,3]);
		A1=reshape(A1,nt*nt,mx*my);
		A1=nanmean(A1);
		A2=reshape(A1,mx,my);

		latt = str2num(file_name(2:3));
		lont = str2num(file_name(6:8));

		n = latt - lat(1);
		m = lont - lon(1);
		% 平均至0.125°结果
		dem1((8*n)+1:(8*n)+8,(8*m)+1:(8*m)+8) = flipud(A2);
	end

	% 再次平均经纬度信息，将分辨率提高至0.25°
	data = dem1(2:end-1,2:end-1);
	latd = latg(2:end-1);
	lond = long(2:end-1);
	for n = 1:2:length(latd)
		lat_e((n+1)/2) = mean(latd(n:n+1));
		lon_e((n+1)/2) = mean(lond(n:n+1));
	end

	%再次平均，将分辨率提高至0.25°
	[nx,ny] = size(data);
	mx = nx/2;
	my = ny/2;
	nt = 2;
	A1=reshape(data,nx,nt,my);
	A1=permute(A1,[2,1,3]);
	A1=reshape(A1,nt*nt,mx*my);
	A1=nanmean(A1);
	dem2=reshape(A1,mx,my);

	lat_ERA5 = sort(lat_ERA5);
	lon_ERA5 = sort(lon_ERA5);
	xs = find(lat_e==lat_ERA5(1));
	xe = find(lat_e==lat_ERA5(end));
	ys = find(lon_e==lon_ERA5(1));
	ye = find(lon_e==lon_ERA5(end));

	dem = dem2(xs:xe,ys:ye);
	save(['./DEM_Download/data/dem_ERA5.mat'],'dem','lat_ERA5','lon_ERA5')
 
        case 2
        %% map-plot
        load('./DEM_Download/data/grids_xyz_original.mat')
        load('./DEM_Download/data/dem_ERA5.mat')
        dem_ERA5 = dem;
        elv_1 = elv; elv_1(elv_1 <= 0) = nan;
        dem_ERA5_1 = dem_ERA5;
        dem_ERA5_1(dem_ERA5_1 <= 0) = nan;

        contourf(elv');hcb = colorbar; caxis([0 5500])
        set(hcb, 'ytick', [0:500:5500], 'yticklabel', 0:500:5500)
        title('Model-elv', 'fontsize', 12)
        print(gcf, ['./DEM_Download/map/Model-elv.png'], '-r200', '-dpng')
        clf

        contourf(elv_1');hcb = colorbar; caxis([0 5500])
        set(hcb, 'ytick', [0:500:5500], 'yticklabel', 0:500:5500)
        title('Model-elv-mask', 'fontsize', 12)
        print(gcf, ['./DEM_Download/map/Model-elv-mask.png'], '-r200', '-dpng')
        clf

        contourf(dem_ERA5);hcb = colorbar; caxis([0 5500])
        set(hcb, 'ytick', [0:500:5500], 'yticklabel', 0:500:5500)
        title('DEM-elv', 'fontsize', 12)
        print(gcf, ['./DEM_Download/map/DEM-elv.png'], '-r200', '-dpng')
        clf

        contourf(dem_ERA5_1);hcb = colorbar; caxis([0 5500])
        set(hcb, 'ytick', [0:500:5500], 'yticklabel', 0:500:5500)
        title('DEM-elv-mask', 'fontsize', 12)
        print(gcf, ['./DEM_Download/map/DEM-elv-mask.png'], '-r200', '-dpng')
		
	contourf(elv'-dem_ERA5);hcb = colorbar;
	title('JIN-WEI difference', 'fontsize', 12)
	print(gcf, ['./DEM_Download/map/DEM-difference.png'], '-r200', '-dpng')
        close all
    end
end
