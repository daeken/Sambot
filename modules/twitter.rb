require_relative '../sambot'

channels.register(:twitter) { |channel|
	on :post, spec: [:message] { |event|
		puts event.message
	}
}