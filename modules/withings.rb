require_relative '../sambot'

channels.register(:withings) {
	specify :weigh_in, [:weight_lbs]

	update_every(seconds: 5) {
		weigh_in(123)
	}
}