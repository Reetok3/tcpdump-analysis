STDOUT.sync = true

line = ""
count_ipsrc = {}
while true do
	line = STDIN.gets
	data = line.split(" ")
	p data

	date = data[0]
	ipsrc = data[2]
	ipdst = data[4]

	if (count_ipsrc[ipsrc] == nil) then
		count_ipsrc[ipsrc] = 0
	end
	count_ipsrc[ipsrc]+=1
	p count_ipsrc
end


