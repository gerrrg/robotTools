import sys
import time
data = sys.stdin.readlines()

# max number of processes out
num_top_processes_log = 10;

# first line of real data (not headers)
line_start_idx = 7;

# locations of data in each line
idx_cpu = 8;
idx_mem = 9;
idx_name = 11;

# count processes
num_processes = len(data) - line_start_idx;

# get current time
epoch_time = float(time.time())

# check that we have process data from top
if num_processes > 0:
	
	# don't log more processes than you have
	num_processes_to_print = min(num_top_processes_log, num_processes);

	top_proc_list_out = [];
	cpu_total = 0.0;
	mem_total = 0.0;
	for i in range(line_start_idx, len(data)):
		
		line = data[i].strip();
		elements = line.split();

		cpu = elements[idx_cpu];
		mem = elements[idx_mem];

		if i < line_start_idx + num_processes_to_print:
			name = elements[idx_name];
			top_proc_list_out.append(':'.join([name, cpu, mem]))
		
		# add up all cpu and mem usage
		cpu_total += float(cpu)
		mem_total += float(mem)

	top_proc_string_out = '; '.join(top_proc_list_out);
	line_list_out = [str(epoch_time), str(cpu_total), str(mem_total), top_proc_string_out];
	line_out = ', '.join(line_list_out);

	print(line_out)