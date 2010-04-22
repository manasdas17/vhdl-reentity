require 'test/unit'

class EntityParser

	attr_reader :entity

	def initialize entity=nil
		@entity = entity
		check_entity unless entity.nil?
	end

	def find_entity
		Dir['*.vhd'].each do |vhd_file|
			open(vhd_file) do |vhd_file_content|
				if not vhd_file_content.grep(/entity\s+#{@entity}\s+/).empty?
					@vhd_entity_file = vhd_file
					return true
				end
			end
		end
		return false
	end

	def check_entity
		if not find_entity then
			puts "ERROR 1: entity not found, exiting..."
			Process.exit 1
		end
	end
	
	def get_entity_body
		open(@vhd_entity_file) do |vhd|
			matchs = vhd.read.match(/(entity\s+#{@entity}\s+is\s+)(.*)(end\s+(entity|#{@entity}))/m)
			return matchs[2]
		end
	end

end

class EntityParserTester < Test::Unit::TestCase

	def test_EntityParser_init
		parser = EntityParser.new
		assert_not_nil parser
	end

	def test_EntityParser_find_entity
		parser = EntityParser.new "test1"
	end

	def test_EntityParser_get_entity_body
		parser = EntityParser.new "test1"
		assert_equal parser.get_entity_body, "port (\n\t\ta: in std_logic;\n\t\tb: out std_logic_vector(1 downto 0)\n\t);\n"
	end

end

