require "command" -- console command and corresponding remote interface
_ = require "api" -- convenience functions for developers

--namespace = 'remote_api'
--custom_commands = {
--    print = function(options)
--        remote_api.printf(options.message)
--    end,
--
--    create_entity = function (options)
--        local entity = game.surfaces[1].create_entity(options)
--        remote_api.printf('Created %s at %s, %s', entity.name, entity.position.x, entity.position.y)
--    end,
--
--    destroy_entity = function (options)
--        local entities = game.surfaces[1].find_entities_filtered(options)
--        for _, entity in ipairs(entities) do
--            remote_api.printf('Destroying %s at position %s, %s', entity.name, entity.position.x, entity.position.y)
--            entity.destroy()
--        end
--    end
--}

--remote_api.add_commands(namespace, custom_commands)