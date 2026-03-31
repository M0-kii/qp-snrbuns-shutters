-- client.lua
local interiorID = nil
local shutters = {
    {name = 'shutter01', job = 'smoothie', coords = vector3(-506.50, -709.02, 33.67), size = vec3(1,1,2), rot = 0},
    {name = 'shutter02', job = 'burger', coords = vector3(-506.50, -714.84, 33.67), size = vec3(1,1,2), rot = 0},
    {name = 'shutter03', job = 'sandwich', coords = vector3(-506.55, -720.76, 33.67), size = vec3(1,1,2), rot = 0},
    {name = 'shutter04', job = 'tacos', coords = vector3(-515.87, -722.10, 33.67), size = vec3(1,1,2), rot = 0},
    {name = 'shutter05', job = 'pizza', coords = vector3(-518.90, -717.20, 33.67), size = vec3(1,1,2), rot = 0},
    {name = 'shutter06', job = 'sushisushi', coords = vector3(-521.87, -712.30, 33.67), size = vec3(1,1,2), rot = 0},
    {name = 'shutter07', job = 'coffee', coords = vector3(-524, -706.90, 33.67), size = vec3(1,1,2), rot = 0},
    {name = 'shutter08', job = 'noodle', coords = vector3(-525.30, -701.09, 33.67), size = vec3(1,1,2), rot = 0},
    {name = 'shutter09', job = 'donerkebab', coords = vector3(-526, -695.44, 33.67), size = vec3(1,1,2), rot = 0},
    {name = 'shutter10', job = 'hotdogs', coords = vector3(-526.56, -689.49, 33.67), size = vec3(1,1,2), rot = 0},
}

CreateThread(function()
    RequestIpl('3dp_snrbuns_milo')
    Wait(2000)
    interiorID = GetInteriorAtCoords(-515.792969, -706.0899, 38.7752)
    if IsValidInterior(interiorID) then
        for _, sh in ipairs(shutters) do
            sh.state = true
            EnableInteriorProp(interiorID, sh.name)
        end
        RefreshInterior(interiorID)
    end
    TriggerServerEvent('shutters:requestSync')
end)

for _, sh in ipairs(shutters) do
    exports.ox_target:addBoxZone({
        coords = sh.coords,
        size = sh.size,
        rotation = sh.rot,
        debug = false,
        options = {
            {
                icon = 'fas fa-shutters',
                label = 'Toggle Shutter',
                groups = sh.job,
                onSelect = function()
                    if not interiorID then return end
                    TriggerServerEvent('shutters:toggle', sh.name)
                end
            }
        }
    })
end

RegisterNetEvent('shutters:sync', function(name, state)
    if not interiorID then return end
    for _, sh in ipairs(shutters) do
        if sh.name == name then
            sh.state = state
            if state then
                EnableInteriorProp(interiorID, name)
            else
                DisableInteriorProp(interiorID, name)
            end
            RefreshInterior(interiorID)
            return
        end
    end
end)