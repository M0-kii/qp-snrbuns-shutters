-- server.lua
local shutterStates = {}

RegisterServerEvent('shutters:toggle')
AddEventHandler('shutters:toggle', function(name)
    shutterStates[name] = not (shutterStates[name] or true)
    TriggerClientEvent('shutters:sync', -1, name, shutterStates[name])
end)

RegisterServerEvent('shutters:requestSync')
AddEventHandler('shutters:requestSync', function()
    local src = source
    for name, state in pairs(shutterStates) do
        TriggerClientEvent('shutters:sync', src, name, state)
    end
end)