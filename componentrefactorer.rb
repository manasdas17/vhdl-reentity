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
					@files.push vhd_file
				end
			end
		end
		return @files.sort
	end

	def refactor_components
		if @files = [] then get_files_with_components end
		new_body = @eparser.get_entity_body
		puts "Updating the files:"
		puts @files
		for file in @files do 
			open(file) do |content|
				content_string = content.read
				aux = content_string.match(/(component\s+#{@entity}\s+is\s+)(.*?)(end\s+component)/m)[2]
				content_string[aux] = new_body
				f = File.open(file,'w')	
				f.puts content_string
				f.close
			end
		end
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

	def test_ComponentRefactorer_refactor_components
		eparser = EntityParser.new 'test1'
		crefactorer = ComponentRefactorer.new eparser
		crefactorer.refactor_components
	end

end

