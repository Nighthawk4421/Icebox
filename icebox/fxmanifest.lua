fx_version 'cerulean'
game 'gta5'

description 'Icebox job by Nighthawk'
version '1.0'

shared_scripts {
	'config.lua'
}

client_script {
	'@PolyZone/client.lua',
	'@PolyZone/BoxZone.lua',
	'@PolyZone/EntityZone.lua',
	'@PolyZone/CircleZone.lua',
	'@PolyZone/ComboZone.lua',
	'client.lua'
}
server_script 'server.lua'

lua54 'yes'