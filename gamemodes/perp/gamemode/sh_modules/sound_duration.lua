local soundDurations = {}
soundDurations["perp2.5/ambulance_siren.mp3"] 		= 6.791810
soundDurations["perp2.5/breathing.mp3"] 			= 15.568950
soundDurations["perp2.5/firetruck_siren.mp3"] 		= 8.829360
soundDurations["perp2.5/hose2.mp3"] 				= 0.512640
soundDurations["perp2.5/house_alarm_long.mp3"] 		= 32.208950
soundDurations["perp2.5/phone_ring.mp3"] 			= 2.690580
soundDurations["perp2.5/rain_heavy.wav"] 			= 3.892420
soundDurations["perp2.5/rain_heavy_fadein.wav"] 	= 3.970580
soundDurations["perp2.5/rain_heavy_fadeout.wav"] 	= 3.944330
soundDurations["perp2.5/rain_shower.wav"] 			= 3.892420
soundDurations["perp2.5/rain_shower_fadein.wav"] 	= 3.970580
soundDurations["perp2.5/rain_shower_fadeout.wav"] 	= 3.944330
soundDurations["perp2.5/siren_long.mp3"] 			= 4.628410
soundDurations["perp2.5/siren_wail.mp3"] 			= 2.949440
soundDurations["perp2.5/cradio_close.mp3"] 			= 0.522340
soundDurations["perp2.5/cradio_start.mp3"] 			= 0.156710
soundDurations["perp2.5/cradio_static.mp3"] 		= 3.970520
soundDurations["perp2.5/phone_dial.mp3"] 			= 1.541200
soundDurations["perp2.5/phone_error.mp3"] 			= 3.866090
soundDurations["perp2.5/firetruck_horn.mp3"] 		= 0.470180
soundDurations["perp2.5/firetruck_horn4.mp3"] 		= 1.200000
soundDurations["perp2.5/siren_short.mp3"] 			= 1.070990
soundDurations["perp2.5/car_horn.wav"] 				= 1.000040
soundDurations["perp2.5/car_horn_dixie.mp3"] 		= 3.030180
soundDurations["perp2.5/car_horn_long.wav"] 		= 0.706120
soundDurations["perp2.5/tsiren.mp3"] 				= 22.02120

soundDurations["perp2.5/ringtones/brit.mp3"] 		= 16.561600
soundDurations["perp2.5/ringtones/cencounters.mp3"] = 5.041600
soundDurations["perp2.5/ringtones/classic.mp3"] 	= 13.897090
soundDurations["perp2.5/ringtones/digital.mp3"] 	= 4.780380
soundDurations["perp2.5/ringtones/dnb.mp3"] 		= 27.898750
soundDurations["perp2.5/ringtones/doorbell.mp3"] 	= 5.982010
soundDurations["perp2.5/ringtones/dubstep.mp3"] 	= 23.156070
soundDurations["perp2.5/ringtones/garden_party.mp3"]= 56.293850
soundDurations["perp2.5/ringtones/gold.mp3"]		= 28.931430
soundDurations["perp2.5/ringtones/human.mp3"]		= 5.276710
soundDurations["perp2.5/ringtones/jam.mp3"]			= 4.153440
soundDurations["perp2.5/ringtones/mario.mp3"]		= 42.187730
soundDurations["perp2.5/ringtones/moskau.mp3"]		= 19.435070
soundDurations["perp2.5/ringtones/mysterious.mp3"]	= 4.597520
soundDurations["perp2.5/ringtones/raindrops.mp3"]	= 7.000790
soundDurations["perp2.5/ringtones/tetris.mp3"]		= 28.969770

soundDurations["perp2.5/ringtones/badtouch.mp3"]		= 11
soundDurations["perp2.5/ringtones/djmash2.mp3"]			= 38
soundDurations["perp2.5/ringtones/infinity.mp3"]		= 28
soundDurations["perp2.5/ringtones/letgo.mp3"]			= 29
soundDurations["perp2.5/ringtones/milkshake.mp3"]		= 21
soundDurations["perp2.5/ringtones/pendulum.mp3"]		= 21
soundDurations["perp2.5/ringtones/pjanno.mp3"]			= 29
soundDurations["perp2.5/ringtones/righthere.mp3"]		= 40
soundDurations["perp2.5/ringtones/shutyourmouth.mp3"]	= 17
soundDurations["perp2.5/ringtones/turnlightsoff.mp3"]	= 20
soundDurations["perp2.5/ringtones/djsmash.mp3"]			= 16
soundDurations["perp2.5/ringtones/santa.mp3"] 			= 20

soundDurations["vehicles/golf/v8_start_loop1.wav"] 				= 7.581650
soundDurations["vehicles/caterham/rev_short_loop.wav"] 			= 2.552240
soundDurations["vehicles/lambo/rev_short_loop.wav"] 			= 2.945370
soundDurations["vehicles/enzo/turbo.mp3"] 						= 2.638320
soundDurations["vehicles/shelby/shelby_rev_short_loop1.wav"] 	= 4.257930
soundDurations["vehicles/premier/rev_short_loop.wav"] 			= 1.067660
soundDurations["vehicles/landstalker/rev_short_loop.wav"] 		= 2.502430


function SoundDuration ( str )
	if (!soundDurations[string.lower(str)]) then
		Error("Unknown Sound Duration: " .. string.lower(str) .. "\n")
		return 1
	end
	
	return soundDurations[string.lower(str)]
end

