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
		@files.each { |f| puts "-- "+f }
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

