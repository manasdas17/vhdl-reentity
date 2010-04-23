
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

