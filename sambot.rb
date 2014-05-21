class Object
	def metaclass
		class << self; self; end
	end
end

class ::Hash
	def method_missing(name)
		return self[name] if key? name
		self.each { |k,v| return v if k.to_s.to_sym == name }
		super.method_missing name
	end
end

class Channels
	def register(name, &block)
		channel = Channel.new name
		channel.instance_eval(&block) if block != nil

		self.metaclass.send(:define_method, name) { channel }

		channel
	end
end
class Channel
	def initialize(name)
		@subscribers = {}
		@name = name
	end
	def on(name, options={}, &block)
		if options.has_key? :spec
			specify name, options[:spec]
		end

		@subscribers[name] = [] if !@subscribers.has_key? name
		@subscribers[name].push block
	end
	def specify(name, spec)
		self.metaclass.send(:define_method, name) { |*args|
			event = {}
			spec.each_index {|i|
				event[spec[i]] = args[i]
			}
			self.message name, event
		}
	end
	def message(name, event)
		return if !@subscribers.has_key? name

		@subscribers[name].each {|block|
			block.call event
		}
	end
end
$channels = Channels.new
def channels() $channels end

class Sambot
	def initialize
		@timers = []
	end

	def mod(mod, options={})
		require_relative "modules/#{ mod }.rb"
	end

	def run
		loop {
			now = Time.now
			@timers.each_index { |i|
				period, block, last = @timers[i]
				if last == nil or now - last >= period
					@timers[i][2] = now
					block.call now
				end
			}
		}
	end

	def add_timer(period, &block)
		@timers.push [period, block, nil]
	end
end

def sambot(&block)
	$instance = Sambot.new
	$instance.instance_eval &block
	$instance.run
end

def update_every(days:0, hours:0, minutes:0, seconds:0, &block)
	period = days * 24 * 60 * 60 + hours * 60 * 60 + minutes * 60 + seconds

	$instance.add_timer period, &block
end
