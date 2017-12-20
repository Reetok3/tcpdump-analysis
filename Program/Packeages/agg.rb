STDOUT.sync = true
at_exit {
	File.open("tcpdump-analysis.txt", "a") do |f|
		f.puts({"time"=>Time.now.to_i.to_s,"status"=>"exit"})
	end
	File.open("src_list.txt", "a") do |f|
		f.puts({"time"=>Time.now.to_i.to_s,"status"=>"exit"})
	end
	File.open("times_list.txt", "a") do |f|
		f.puts({"time"=>Time.now.to_i.to_s,"status"=>"exit"})
	end
	"EXIT"
}
File.open("tcpdump-analysis.txt", "a") do |f|
	f.puts({"time"=>Time.now.to_i.to_s,"status"=>"start"})
	f.puts("\n")
end
File.open("src_list.txt", "a") do |f|
	f.puts({"time"=>Time.now.to_i.to_s,"status"=>"start"})
	f.puts("\n")
end
File.open("times_list.txt", "a") do |f|
	f.puts({"time"=>Time.now.to_i.to_s,"status"=>"start"})
	f.puts("\n")
end
class Agg
	def initalize()
		@src_ip_street, @src_port_street, @dst_ip_street, @dst_port_street = [],[],[],[]
		@src_ip_hash, @src_port_hash, @dst_ip_hash, @dst_port_hash = {}, {}, {}. {}
		@data = []
	end
	def run
		line = STDIN.gets
		data = {}
		if /([0-9]+\.[0-9]+\s[A-Za-z0-9]+\s[\w\.-]+\.[\w\.-]+\s>\s[\w\.-]+\.[\w\.-]+)/
			line = $1.split(" ")
			data["status"] = "OK"
			data["time"] = line[0].to_i.to_s
			data["type"] = line[1]
			ip = line[2].split(".")
			data["src_port"] = ip[ip.size-1]
			ip.delete_at(ip.size-1)
			data["src_ip"] = ip.join(".")
			ip = line[4].split(".")
			data["dst_port"] = ip[ip.size-1]
			ip.delete_at(ip.size-1)
			data["dst_ip"] = ip.join(".")
			@data.push(data)
			if src[data["src_ip"]] == nil
				src[data["src_ip"]] = 1
			else
				src[data["src_ip"]] = src[data["src_ip"]] + 1
			end
			File.open("times_list.txt","a") do |f|
				f.puts(src)
				f.puts("\n")
			end
			File.open("src_list.txt","a") do |f|
				f.puts({"time"=>Time.now.to_i.to_s,"src_ip"=>data["src_ip"]})
				f.puts("\n")
			end
			p src

		end
	end
end
