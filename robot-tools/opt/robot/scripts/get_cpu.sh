#TODO add this to an environment variable/config file
cpu_filename=cpu_data.csv


curr_file=$( cat /tmp/robot-data-folder-path )/$cpu_filename
if [ ! -f  $curr_file ]
then
	echo "time, cpu, mem, procs, " > $curr_file
fi
top -b -n 1 -w85 | python3 parse_cpu.py >> $curr_file