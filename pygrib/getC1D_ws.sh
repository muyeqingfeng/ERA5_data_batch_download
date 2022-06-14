#!/bin/csh -f

@ year = 2017
set jdays = (31 28 31 30 31 30 31 31 30 31 30 31)
set cpdir = /mnt/PRESKY/data/cmadata/NAFP/ECMF/C1D

foreach mon (1 2 3 4 5 6 7 8 9 10 11 12)

set day = 1
while ( $day <=  $jdays[$mon] )

	set day   = `echo $day   | awk '{printf "%2.2d", $1}'`
	set mon   = `echo $mon   | awk '{printf "%2.2d", $1}'`

set hrs = 0
while ( $hrs <=  168)

	set dt = 3
#	if ($hrs >= 144) set dt = 6
	if ($hrs >= 72 ) set dt = 6

#----------------------------------------------------------------------
# input files
#----------------------------------------------------------------------
	@ thrs  = $hrs - ($hrs / 24) * 24
	@ tday  = $day + $hrs / 24
	@ tmon  = $mon
	@ tyear = $year
	if ($tday > $jdays[$mon]) then
	@ tday  = $tday - $jdays[$mon]
	@ tmon  = $tmon + 1
		if ($tmon > 12) then
		@ tyear  = $year + 1
		set tmon = 1
		endif
	endif
	set tday  = `echo $tday   | awk '{printf "%2.2d", $1}'`
	set tmon  = `echo $tmon   | awk '{printf "%2.2d", $1}'`
	set thrs  = `echo $thrs   | awk '{printf "%2.2d", $1}'`
	set fpath = $cpdir/${year}/${year}${mon}/${year}${mon}${day}
        set fileX = C1D${mon}${day}0000${tmon}${tday}${thrs}001
	set fileZ = $fpath/$fileX".bz2"

	cp $fileZ .
	bunzip2 $fileX".bz2"

#----------------------------------------------------------------------
# output files
# 没有750层
#----------------------------------------------------------------------
	set hrs   = `echo $hrs   | awk '{printf "%3.3d", $1}'`
	# ../../ == /mnt/PRESKY/user/weishuo/dataPRE/EC/
	set file1 =  ../../gp100/tmp/gp-${year}${mon}${day}00-${hrs}.nc
	set file2 =  ../../gp200/tmp/gp-${year}${mon}${day}00-${hrs}.nc
	set file3 =  ../../gp300/tmp/gp-${year}${mon}${day}00-${hrs}.nc
	set file4 =  ../../gp400/tmp/gp-${year}${mon}${day}00-${hrs}.nc
	#set file5 =  ../../gp500/tmp/gp-${year}${mon}${day}00-${hrs}.nc
	set file6 =  ../../gp600/tmp/gp-${year}${mon}${day}00-${hrs}.nc
	set file7 =  ../../gp700/tmp/gp-${year}${mon}${day}00-${hrs}.nc
	#set file8 =  ../../gp750/tmp/gp-${year}${mon}${day}00-${hrs}.nc
	set file9 =  ../../gp800/tmp/gp-${year}${mon}${day}00-${hrs}.nc
	set file10 =  ../../gp850/tmp/gp-${year}${mon}${day}00-${hrs}.nc
	set file11 =  ../../gp900/tmp/gp-${year}${mon}${day}00-${hrs}.nc
	#set file12 =  ../../gp1000/tmp/gp-${year}${mon}${day}00-${hrs}.nc
	cdo -f nc copy -sellonlatbox,96,127.75,16,47.75 -sellevel,10000  -selvar,gh $fileX $file1
	cdo -f nc copy -sellonlatbox,96,127.75,16,47.75 -sellevel,20000  -selvar,gh $fileX $file2
	cdo -f nc copy -sellonlatbox,96,127.75,16,47.75 -sellevel,30000  -selvar,gh $fileX $file3
	cdo -f nc copy -sellonlatbox,96,127.75,16,47.75 -sellevel,40000  -selvar,gh $fileX $file4
	#cdo -f nc copy -sellonlatbox,96,127.75,16,47.75 -sellevel,50000  -selvar,gh $fileX $file5
	cdo -f nc copy -sellonlatbox,96,127.75,16,47.75 -sellevel,60000	 -selvar,gh $fileX $file6
	cdo -f nc copy -sellonlatbox,96,127.75,16,47.75 -sellevel,70000  -selvar,gh $fileX $file7
	#cdo -f nc copy -sellonlatbox,96,127.75,16,47.75 -sellevel,75000  -selvar,gh $fileX $file8
	cdo -f nc copy -sellonlatbox,96,127.75,16,47.75 -sellevel,80000  -selvar,gh $fileX $file9
	cdo -f nc copy -sellonlatbox,96,127.75,16,47.75 -sellevel,85000	 -selvar,gh $fileX $file10
	cdo -f nc copy -sellonlatbox,96,127.75,16,47.75 -sellevel,90000  -selvar,gh $fileX $file11
	#cdo -f nc copy -sellonlatbox,96,127.75,16,47.75 -sellevel,100000 -selvar,gh $fileX $file12


	set file1 =  ../../sh100/tmp/sh-${year}${mon}${day}00-${hrs}.nc
	set file2 =  ../../sh200/tmp/sh-${year}${mon}${day}00-${hrs}.nc
	set file3 =  ../../sh300/tmp/sh-${year}${mon}${day}00-${hrs}.nc
	set file4 =  ../../sh400/tmp/sh-${year}${mon}${day}00-${hrs}.nc
	set file5 =  ../../sh500/tmp/sh-${year}${mon}${day}00-${hrs}.nc
	set file6 =  ../../sh600/tmp/sh-${year}${mon}${day}00-${hrs}.nc
	#set file7 =  ../../sh700/tmp/sh-${year}${mon}${day}00-${hrs}.nc
	#set file8 =  ../../sh750/tmp/sh-${year}${mon}${day}00-${hrs}.nc
	set file9 =  ../../sh800/tmp/sh-${year}${mon}${day}00-${hrs}.nc
	#set file10 =  ../../sh850/tmp/sh-${year}${mon}${day}00-${hrs}.nc
	set file11 =  ../../sh900/tmp/sh-${year}${mon}${day}00-${hrs}.nc
	set file12 =  ../../sh1000/tmp/sh-${year}${mon}${day}00-${hrs}.nc
	cdo -f nc copy -sellonlatbox,96,127.75,16,47.75 -sellevel,10000 -selvar,q $fileX $file1
	cdo -f nc copy -sellonlatbox,96,127.75,16,47.75 -sellevel,20000 -selvar,q $fileX $file2
	cdo -f nc copy -sellonlatbox,96,127.75,16,47.75 -sellevel,30000 -selvar,q $fileX $file3
	cdo -f nc copy -sellonlatbox,96,127.75,16,47.75 -sellevel,40000 -selvar,q $fileX $file4
	cdo -f nc copy -sellonlatbox,96,127.75,16,47.75 -sellevel,50000 -selvar,q $fileX $file5
	cdo -f nc copy -sellonlatbox,96,127.75,16,47.75 -sellevel,60000 -selvar,q $fileX $file6
	#cdo -f nc copy -sellonlatbox,96,127.75,16,47.75 -sellevel,70000 -selvar,q $fileX $file7
	#cdo -f nc copy -sellonlatbox,96,127.75,16,47.75 -sellevel,75000 -selvar,q $fileX $file8
	cdo -f nc copy -sellonlatbox,96,127.75,16,47.75 -sellevel,80000 -selvar,q $fileX $file9
	#cdo -f nc copy -sellonlatbox,96,127.75,16,47.75 -sellevel,85000 -selvar,q $fileX $file10
	cdo -f nc copy -sellonlatbox,96,127.75,16,47.75 -sellevel,90000 -selvar,q $fileX $file11
	cdo -f nc copy -sellonlatbox,96,127.75,16,47.75 -sellevel,100000 -selvar,q $fileX $file12


	set file1 =  ../../u100/tmp/u-${year}${mon}${day}00-${hrs}.nc
	set file2 =  ../../u200/tmp/u-${year}${mon}${day}00-${hrs}.nc
	set file3 =  ../../u300/tmp/u-${year}${mon}${day}00-${hrs}.nc
	set file4 =  ../../u400/tmp/u-${year}${mon}${day}00-${hrs}.nc
	set file5 =  ../../u500/tmp/u-${year}${mon}${day}00-${hrs}.nc
	set file6 =  ../../u600/tmp/u-${year}${mon}${day}00-${hrs}.nc
	#set file7 =  ../../u700/tmp/u-${year}${mon}${day}00-${hrs}.nc
	#set file8 =  ../../u750/tmp/u-${year}${mon}${day}00-${hrs}.nc
	set file9 =  ../../u800/tmp/u-${year}${mon}${day}00-${hrs}.nc
	#set file10 =  ../../u850/tmp/u-${year}${mon}${day}00-${hrs}.nc
	set file11 =  ../../u900/tmp/u-${year}${mon}${day}00-${hrs}.nc
	set file12 =  ../../u1000/tmp/u-${year}${mon}${day}00-${hrs}.nc
	cdo -f nc copy -sellonlatbox,96,127.75,16,47.75 -sellevel,10000 -selvar,u $fileX $file1
	cdo -f nc copy -sellonlatbox,96,127.75,16,47.75 -sellevel,20000 -selvar,u $fileX $file2
	cdo -f nc copy -sellonlatbox,96,127.75,16,47.75 -sellevel,30000 -selvar,u $fileX $file3
	cdo -f nc copy -sellonlatbox,96,127.75,16,47.75 -sellevel,40000 -selvar,u $fileX $file4
	cdo -f nc copy -sellonlatbox,96,127.75,16,47.75 -sellevel,50000 -selvar,u $fileX $file5
	cdo -f nc copy -sellonlatbox,96,127.75,16,47.75 -sellevel,60000 -selvar,u $fileX $file6
	#cdo -f nc copy -sellonlatbox,96,127.75,16,47.75 -sellevel,70000 -selvar,u $fileX $file7
	#cdo -f nc copy -sellonlatbox,96,127.75,16,47.75 -sellevel,75000 -selvar,u $fileX $file8
	cdo -f nc copy -sellonlatbox,96,127.75,16,47.75 -sellevel,80000 -selvar,u $fileX $file9
	#cdo -f nc copy -sellonlatbox,96,127.75,16,47.75 -sellevel,85000 -selvar,u $fileX $file10
	cdo -f nc copy -sellonlatbox,96,127.75,16,47.75 -sellevel,90000 -selvar,u $fileX $file11
	cdo -f nc copy -sellonlatbox,96,127.75,16,47.75 -sellevel,100000 -selvar,u $fileX $file12


	set file1 =  ../../v100/tmp/v-${year}${mon}${day}00-${hrs}.nc
	set file2 =  ../../v200/tmp/v-${year}${mon}${day}00-${hrs}.nc
	set file3 =  ../../v300/tmp/v-${year}${mon}${day}00-${hrs}.nc
	set file4 =  ../../v400/tmp/v-${year}${mon}${day}00-${hrs}.nc
	set file5 =  ../../v500/tmp/v-${year}${mon}${day}00-${hrs}.nc
	set file6 =  ../../v600/tmp/v-${year}${mon}${day}00-${hrs}.nc
	#set file7 =  ../../v700/tmp/v-${year}${mon}${day}00-${hrs}.nc
	#set file8 =  ../../v750/tmp/v-${year}${mon}${day}00-${hrs}.nc
	set file9 =  ../../v800/tmp/v-${year}${mon}${day}00-${hrs}.nc
	#set file10 =  ../../v850/tmp/v-${year}${mon}${day}00-${hrs}.nc
	set file11 =  ../../v900/tmp/v-${year}${mon}${day}00-${hrs}.nc
	set file12 =  ../../v1000/tmp/v-${year}${mon}${day}00-${hrs}.nc
	cdo -f nc copy -sellonlatbox,96,127.75,16,47.75 -sellevel,10000 -selvar,v $fileX $file1
	cdo -f nc copy -sellonlatbox,96,127.75,16,47.75 -sellevel,20000 -selvar,v $fileX $file2
	cdo -f nc copy -sellonlatbox,96,127.75,16,47.75 -sellevel,30000 -selvar,v $fileX $file3
	cdo -f nc copy -sellonlatbox,96,127.75,16,47.75 -sellevel,40000 -selvar,v $fileX $file4
	cdo -f nc copy -sellonlatbox,96,127.75,16,47.75 -sellevel,50000 -selvar,v $fileX $file5
	cdo -f nc copy -sellonlatbox,96,127.75,16,47.75 -sellevel,60000 -selvar,v $fileX $file6
	#cdo -f nc copy -sellonlatbox,96,127.75,16,47.75 -sellevel,70000 -selvar,v $fileX $file7
	#cdo -f nc copy -sellonlatbox,96,127.75,16,47.75 -sellevel,75000 -selvar,v $fileX $file8 
	cdo -f nc copy -sellonlatbox,96,127.75,16,47.75 -sellevel,80000 -selvar,v $fileX $file9
	#cdo -f nc copy -sellonlatbox,96,127.75,16,47.75 -sellevel,85000 -selvar,v $fileX $file10
	cdo -f nc copy -sellonlatbox,96,127.75,16,47.75 -sellevel,90000 -selvar,v $fileX $file11
	cdo -f nc copy -sellonlatbox,96,127.75,16,47.75 -sellevel,100000 -selvar,v $fileX $file12

	#-----------------------------------------------------------------
	# 降水
	#-----------------------------------------------------------------
        if ($hrs > 0) then
	set file1 =  ../../pre/tmp/pcp-${year}${mon}${day}00-${hrs}.nc
	cdo -f nc copy -sellonlatbox,96,127.75,16,47.75 -selvar,tp $fileX $file1
        endif

	rm $fileX

@ hrs = $hrs + $dt
end

@ day ++
end
end #mon
