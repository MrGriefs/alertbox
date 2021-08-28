fx_version 'cerulean'
game 'gta5'

version '0.1.0'
author 'Reece Stokes <hagen@hyena.gay>'
description 'FiveM utility resource for easier alertbox handling.'
repository 'https://github.com/MrGriefs/alertbox'

client_script {
    'util.lua',
    'client.lua',
}
server_script {
    'config.lua',
    'server.lua',
}