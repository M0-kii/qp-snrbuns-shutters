local interiorID = nil

local shutters = {
    {name = 'shutter01', job = 'smoothie', coords = vector3(-507.01, -709.02, 33.67), size = vec3(1,1,2), rot = 0},
    {name = 'shutter02', job = 'burger', coords = vector3(-506.95, -714.94, 33.67), size = vec3(1,1,2), rot = 0},
    {name = 'shutter03', job = 'sandwich', coords = vector3(-507.05, -720.76, 33.67), size = vec3(1,1,2), rot = 0},
    {name = 'shutter04', job = 'tacos', coords = vector3(-515.17, -721.67, 33.67), size = vec3(1,1,2), rot = 0},
    {name = 'shutter05', job = 'pizza', coords = vector3(-518.51, -717.0, 33.67), size = vec3(1,1,2), rot = 0},
    {name = 'shutter06', job = 'sushisushi', coords = vector3(-521.17, -712.0, 33.67), size = vec3(1,1,2), rot = 0},
    {name = 'shutter07', job = 'coffee', coords = vector3(-523.37, -706.63, 33.67), size = vec3(1,1,2), rot = 0},
    {name = 'shutter08', job = 'noodle', coords = vector3(-526.58, -701.09, 33.67), size = vec3(1,1,2), rot = 0},
    {name = 'shutter09', job = 'donerkebab', coords = vector3(-526, -695.44, 33.67), size = vec3(1,1,2), rot = 0},
    {name = 'shutter10', job = 'hotdogs', coords = vector3(-526.56, -689.49, 33.67), size = vec3(1,1,2), rot = 0},
}

CreateThread(function()
    RequestIpl('3dp_snrbuns_milo')
    Wait(2000)
    interiorID = GetInteriorAtCoords(-515.792969, -706.0899, 38.7752)
    if IsValidInterior(interiorID) then RefreshInterior(interiorID) end
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
                    sh.state = not (sh.state or false)
                    if sh.state then
                        EnableInteriorProp(interiorID, sh.name)
                    else
                        DisableInteriorProp(interiorID, sh.name)
                    end
                    RefreshInterior(interiorID)
                end
            }
        }
    })
end