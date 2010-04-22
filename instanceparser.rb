require 'test/unit'

class InstanceParser
	
	def initialize entity
		@entity = entity
	end

	def find_instances
		@files = []
		Dir['*.vhd'].each do |file|
			open(file) do |content|
				if not content.grep(/\S+?:\s+#{@entity}/).empty?
					@files.push file
				end
			end
		end
		return @files
	end
	
end

class TestInstanceParser < Test::Unit::TestCase

	def test_InstanceParser_find_instances
		iparser = InstanceParser.new 'test1'
		assert_equal iparser.find_instances,['test3.vhd']
	end

end


