-- The entity/item names intentionally stay compatible with upstream blueprints.
-- The new mod identity has separate storage, so adopt surviving physical entities
-- without destroying loaders, held items, transport lines, or circuit connections.
local const = require('lib.constants')
local util = require('util')

local function adopt_existing()
    local adopted = 0
    for _, surface in pairs(game.surfaces) do
        for _, main in pairs(surface.find_entities_filtered {name = const.supported_type_names}) do
            if not This.MiniLoader:getEntity(main.unit_number) then
                local loaders = surface.find_entities_filtered {
                    position = main.position,
                    name = {const.loader_name(main.name), const.loader_name(main.name, true), const.loader_name(main.name, true, true)},
                    force = main.force,
                }
                local loader = loaders[1]
                local internal = surface.find_entities_filtered {
                    position = main.position, name = const.inserter_name(main.name), force = main.force,
                }
                table.sort(internal, function(a, b) return a.unit_number < b.unit_number end)
                if loader then
                    local data = prototypes.mod_data[const.name].data[main.name]
                    local config = This.Config:createConfiguration(main, nil, nil, data.nerf_mode)
                    config.direction = main.direction
                    config.loader_type = loader.loader_type
                    config.turbo_mode = loader.name ~= const.loader_name(main.name)
                    config.lane_filter = loader.name == const.loader_name(main.name, true, true)
                    if config.turbo_mode then
                        This.Config:updateConfigFromLoader(config, loader)
                    else
                        This.Config:updateConfigFromInserter(config, main)
                    end
                    -- Input inserters are deliberately forced to their maximum
                    -- stack size. The hidden loader retains the user's setting.
                    if loader.prototype.loader_adjustable_belt_stack_size then
                        config.stack_size = math.max(1, loader.loader_belt_stack_size_override)
                    end
                    local inserters = {main}
                    for _, entity in ipairs(internal) do inserters[#inserters + 1] = entity end
                    local state = This.Config:createState()
                    state.turbo_mode = config.turbo_mode
                    state.lane_filter = config.lane_filter
                    state.filter_mode = config.filter_mode
                    state.filters = util.copy(config.filters)
                    local entity = {main = main, loader = loader, inserters = inserters, config = config, state = state}
                    This.MiniLoader:setEntity(main.unit_number, entity)
                    This.MiniLoader:reconfigure(entity)
                    adopted = adopted + 1
                elseif #internal == 0 then
                    -- A placed main entity with no old internals can be initialized.
                    This.MiniLoader:create(main, nil, true)
                    adopted = adopted + 1
                else
                    error('Miniloader Fork: surviving inserters have no loader at ' .. serpent.line(main.position))
                end
            end
        end
    end
    if adopted > 0 then log('MINILOADER_FORK_ADOPTED ' .. adopted) end
end

return adopt_existing
