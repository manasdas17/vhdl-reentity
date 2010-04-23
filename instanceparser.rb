require 'test/unit'

class InstanceParser
	
	def initialize entity
		@entity = entity
	end

	def find_instances 
		#a unix grep does this with 'grep -Rn entity *'
		Dir['*.vhd'].each do |file|
			i = 1
			open(file).each_line do |line|
				if not line.grep(/\S+:\s+#{@entity}/).empty?
					puts "file: " + file + ": "+ i.to_s + ": " + line
				end
				i += 1
			end
		end
	end
	
end

class TestInstanceParser < Test::Unit::TestCase

	def test_InstanceParser_find_instances
		iparser = InstanceParser.new 'test1'
		iparser.find_instances
	end

end


