require_relative '../sambot'

channels.withings.on(:weigh_in, changed: true) { |event|
	channels.twitter.post("Just weighed myself at #{ event.weight_lbs } on my @Withings scale!")
}
