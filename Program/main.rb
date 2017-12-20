require 'time'
STDOUT.sync = true
# 終了時の処理
at_exit {
	File.open("tcpdump-analysis.txt", "a") do |f|
		f.puts({"time"=>Time.now.to_i.to_s,"status"=>"exit"})
	end
	File.open("src_list.txt", "a") do |f|
		f.puts({"time"=>Time.now.to_i.to_s,"status"=>"exit"})
	end
	File.open("times_list_src.txt", "a") do |f|
		f.puts({"time"=>Time.now.to_i.to_s,"status"=>"exit"})
	end
	File.open("times_list_dst.txt", "a") do |f|
		f.puts({"time"=>Time.now.to_i.to_s,"status"=>"exit"})
	end
	p "EXIT"
}
# 開始時の処理
File.open("tcpdump-analysis.txt", "a") do |f|
	f.puts({"time"=>Time.now.to_i.to_s,"status"=>"start"})
	f.puts("\n")
end
File.open("src_list.txt", "a") do |f|
	f.puts({"time"=>Time.now.to_i.to_s,"status"=>"start"})
	f.puts("\n")
end
File.open("times_list_src.txt", "a") do |f|
	f.puts({"time"=>Time.now.to_i.to_s,"status"=>"start"})
	f.puts("\n")
end
File.open("times_list_dst.txt", "a") do |f|
	f.puts({"time"=>Time.now.to_i.to_s,"status"=>"start"})
end
p "START"


src = {"time"=>Time.now.to_i.to_s}
dst = {"time"=>Time.now.to_i.to_s}
while true do
	line = STDIN.gets
	p line
	data = {}
	# 処理できるかどうかを判定。これ以外は、まだできない。
		if line =~ /([0-9]+\.[0-9]+\s[A-Za-z0-9]+\s[\w\.-]+\.[\w\.-]+\s>\s[\w\.-]+\.[\w\.-]+)/
		# 処理
		line = $1.split(" ")
		data["time"] = line[0].to_i.to_s
		data["status"] = "OK"
		data["type"] = line[1]
		ip = line[2].split(".")
		data["src_port"] = ip[ip.size-1]
		ip.delete_at(ip.size-1)
		data["src_ip"] = ip.join(".")
		ip = line[4].split(".")
		data["dst_port"] = ip[ip.size-1]
		ip.delete_at(ip.size-1)
		data["dst_ip"] = ip.join(".")
		# 書き込み
		File.open("tcpdump-analysis.txt", "a") do |f|
			f.puts("#{data}\n")
		end
		File.open("data_list_var.txt","w") do |f|
			f.puts(data)
		end
		src[data["src_ip"]] = src[data["src_ip"]].to_i + 1
		dst[data["dst_ip"]] = dst[data["dst_ip"]].to_i + 1
		File.open("times_list_src.txt","a") do |f|
			f.puts(src)
			f.puts("\n")
		end
		File.open("times_list_dst.txt","a") do |f|
			f.puts(dst)
			f.puts("\n")
		end
		p data
	else
	# 処理できなかった。
		File.open("tcpdump-analysis.txt", "a") do |f|
			f.puts({"time"=>Time.now.to_i.to_s,"status"=>"excp"})
			f.puts("\n")
		end
		p "EXEP"
	end

end

