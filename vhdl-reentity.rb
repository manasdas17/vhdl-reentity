require 'entityparser'
require 'componentrefactorer'
require 'instanceparser'

eparser = EntityParser.new ARGV[0]
crefactor = ComponentRefactorer.new eparser
crefactor.refactor_components
instance_parser = InstanceParser.new ARGV[0]
instance_parser.find_instances
