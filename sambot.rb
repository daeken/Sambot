require 'pp'

class Object
	def metaclass
		class << self; self; end
	end
end

class Channels
	def register(name, &block)
		channel = Channel.new name

		self.metaclass.send(:define_method, name) { channel }

		channel.instance_eval(&block) if block != nil

		channel
	end
end
class Channel
	def initialize(name)
		@name = name
	end
	def on(name, options, &block)
		puts 'channel', name
		pp options
	end
end
$channels = Channels.new
def channels() $channels end

class Sambot
	def mod(mod, options={})
		puts 'loading module', mod
		require_relative "modules/#{ mod }.rb"
	end
end

def sambot(&block)
	instance = Sambot.new
	instance.instance_eval &block
end
