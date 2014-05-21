require_relative '../sambot'

channels.withings.on(:weigh_in) { |event|
	channels.twitter.post("Just weighed myself at #{ event.weight_lbs } lbs on my @Withings scale!")
}
