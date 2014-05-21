require_relative 'sambot'

sambot {
	mod :withings, {
		api_key: '640582be9d2b5d86021cdb13051ce7b94371893c8f1f611827172895', 
		api_secret: '94d24839629f373be02c7e34502091c83b6c1395c5eb621d3e1b7c1f2f61'
	}
	mod :twitter, {
		api_key: 'tE1khNl0pNUylrjKNCu8wAr2Q', 
		api_secret: '3syAm0IuMxI1wJrH3D26fQDldZY0lZaB4Fj0pwE6KcVuLskBok'
	}
	mod :weight2twitter
}
