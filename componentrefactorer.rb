require 'test/unit'
require 'entityparser'

class ComponentRefactorer

	def initialize entityparser=nil
		@eparser = entityparser
		@entity = @eparser.entity unless @eparser.nil?
	end

	def get_files_with_components
		@files = []
		Dir['*vhd'].each do |vhd_file|
			open(vhd_file) do |content|
				if not content.grep(/component\s+#{@entity}/).empty?
					files.push vhd_file
				end
			end
		end
		return @files.sort
	end

end


class TestComponentRefactorer < Test::Unit::TestCase

	def test_ComponentRefactorer_init
		crefactorer = ComponentRefactorer.new
		assert_not_nil crefactorer
	end

	def test_ComponentRefactorer_init_with_entityparser
		eparser = EntityParser.new 'test1'
		crefactorer = ComponentRefactorer.new eparser
		assert_not_nil crefactorer
	end

	def test_ComponentRefactorer_files_with_components
		eparser = EntityParser.new 'test1'
		crefactorer = ComponentRefactorer.new eparser
		assert_equal crefactorer.get_files_with_components,['pack1.vhd','test3.vhd'].sort
	end

#	def test_ComponentRefactorer_refactor_components
#	end

end


