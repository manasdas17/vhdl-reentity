require 'vhdlparser'

require 'test/unit'

$input = "memref"

class VhdlRefactoring
	attr_reader :entity_body
	def initialize _entity
		@entity = _entity
		@grep = VhdlParser.new _entity
		find_entity
	end

	def find_entity
		@entity_file = @grep.grep_entity
	end

	def get_entity_body
		file = File.open(@entity_file,'r').read
		@entity_body = file[/\(.*\);\s*end\s+(#{@entity}|entity)/m][/\(.*\)/m]
	end

	def find_component
		return @files_with_components = @grep.grep_component
	end

	def refactor_components
		for file in @files_with_components do
			file_content = File.open(file,'r').read
		#	file_content[/\(.*\);\s*end\s+component/m] = "#{@entity_body};end component\n"
			puts file_content[/component\s+#{@entity}\s+.*(component)*?/m]
		end
	end

end

class Testing < Test::Unit::TestCase
	def test_VhdlRefactoring_create
		ref = VhdlRefactoring.new $input
		assert_not_nil ref
	end

	def test_VhdlRefactoring_find_entity
		ref = VhdlRefactoring.new $input
		assert ref.find_entity == "memref.vhd"
	end

	def test_VhdlRefactoring_get_entity_body
		ref = VhdlRefactoring.new $input
		ref.find_entity
		ref.get_entity_body
#		puts ref.entity_body
	end

	def test_VhdlRefactoring_find_component
		ref = VhdlRefactoring.new $input
		assert ref.find_component == ["mypack.vhd"]
	end

	def test_refactor_components
		ref = VhdlRefactoring.new $input
		ref.get_entity_body
		ref.find_component
		ref.refactor_components
	end

end
