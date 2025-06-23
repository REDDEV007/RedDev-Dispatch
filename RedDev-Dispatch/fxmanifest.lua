fx_version 'cerulean'
game 'gta5'

author 'RedDev'
description 'RedDev Dispatch Ambulance Notifications'
version '1.1.0'

shared_script 'config.lua'

client_scripts {
    'client.lua'
}

server_scripts {
    '@qb-core/shared/locale.lua',
    'server.lua'
}
