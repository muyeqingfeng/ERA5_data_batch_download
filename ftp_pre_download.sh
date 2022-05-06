#! /bin/csh -f
set homedir = /mnt/PRESKY/user/weishuo/pre_noaa/data/

set year = 1998
while ( $year <=  2021 )

 set wkdir = $homedir/$year
 mkdir -p $wkdir
 cd $wkdir

foreach mth (01 02 03 04 05 06 07 08 09 10 11 12)

set day = "01"
while ( $day <=  31 )

set hrs = "00"
while ( $hrs <=  24 )

  set days = `echo $day | awk '{printf "%2.2d", $1}' `
  set hour = `echo $hrs | awk '{printf "%2.2d", $1}' `
  set fname = www.ncei.noaa.gov/data/cmorph-high-resolution-global-precipitation-estimates/access/hourly/0.25deg/$year/$mth/$days/
  set fname = $fname'CMORPH_V1.0_ADJ_0.25deg-HLY_'$year$mth$days$hour'.nc'

  echo $fname
#  wget -nd $fname

@ hrs ++
end

@ day ++
end

end

@ year ++
end
