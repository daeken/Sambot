require_relative '../sambot'

channels.register(:twitter) {
	on :post, spec: [:message] { |event|
		puts event.message
	}
}