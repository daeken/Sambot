require_relative '../sambot'

options = Sambot.options

channels.register(:withings) {
	specify :weigh_in, [:weight_lbs]

	puts options[:api_key]

	update_every(seconds: 5) {
		weigh_in(123)
	}
}