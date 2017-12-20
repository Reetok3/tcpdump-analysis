STDOUT.sync = true

# ["1503620584.632080", "IP", "172.16.52.154.137", ">", "172.16.255.255.137:", "NBT", "UDP", "PACKET(137):", "QUERY;", "REQUEST;", "BROADCAST"]
line = ""
data = []
while true do
	line = STDIN.gets
	info = line.split(" ")
	data=[]
	data.push(info[0]) # Time
	data.push(info[1]) # IP / IPv6
	# ip = info[2].delete(":").split(".")
	# p ip.size
	# if ip.size == 2 then
	# 	puts "2だ"
	# 	data.push(ip[0]) # src_ip
	# 	data.push(ip[1]) # src_port
	# else
	# 	puts "2ではない"
	# 	data.push(ip[0]+"."+ip[1]+"."+ip[2]+"."+ip[3])
	# 	data.push(ip[4])
	# end
	# ip = info[4].delete(":").split(".")
	# if ip.size == 2 then
	# 	data.push(ip[0]) # dst_ip
	# 	data.push(ip[1]) # dst_port
	# else
	# 	data.push(ip[0]+"."+ip[1]+"."+ip[2]+"."+ip[3]) # dst_ip
	# 	data.push(ip[4]) # dst_port
	# 	end
	# puts "\n\n\n\n\ninfo:"
	# p line
	# puts "\n\n\n\n\ndata:"
	# p data
end


