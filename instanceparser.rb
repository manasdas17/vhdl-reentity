
class InstanceParser
	
	def initialize entity
		@entity = entity
	end

	def find_instances 
		#a unix grep does this with 'grep -Rn entity *'
		puts "ATTENTION: You must update the following instances of #{@entity.upcase}"
		Dir['*.vhd'].each do |file|
			i = 1
			open(file).each_line do |line|
				if not line.grep(/\S+:\s+#{@entity}\s+/).empty?
					puts "in " + file + " line "+ i.to_s + ":  " + line
				end
				i += 1
			end
		end
	end
	
end

