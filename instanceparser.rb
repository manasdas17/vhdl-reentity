
class InstanceParser
	
	def initialize entity
		@entity = entity
	end

	def find_instances 
		#a unix grep does this with `grep -Rn " #{@entity} " *`
		puts "ATTENTION: You must update the following instances of #{@entity.upcase}"
		Dir['*.vhd'].each do |file|
			i = 1
			open(file).each_line do |line|
				if line =~ /\s*\S+:\s+#{@entity}\s+/i
					puts "in " + file + " line "+ i.to_s + ":  " + line
				end
				i += 1
			end
		end
	end
	
end

e = InstanceParser.new ARGV[0]
e.find_instances

