local json = require "json/json"

local function printf(...)
    print(string.format(...))
    rcon.print(string.format(...))
    game.print(string.format(...))
end

--local function add_commands(namespace, custom_commands)
--    script.on_load(function()
--        remote.add_interface(namespace, custom_commands)
--
--        for command_name, _ in pairs(custom_commands) do
--            commands.add_command(command_name, command_name, function (e)
--                local command_success, error = pcall(function()
--                    local options = json.decode(e.parameter)
--                    remote.call(namespace, command_name, options)
--                    printf('Completed command "%s.%s"', namespace, command_name)
--                end)
--                if not command_success then
--                    printf('Error executing command "%s.%s": %s', namespace, command_name, error)
--                end
--            end)
--        end
--    end)
--end

script.on_load(function ()
    commands.add_command('remote_api', 'Invoke a command remotely', function (e)
        local result
        local command_success, error = pcall(function()
            -- local options = json.decode(e.parameter)
            local command = e.parameter or ''
            result = remote.call('remote_api', 'raw_command', command)
        end)
        if not command_success then
            printf('error %s', error)
        end
--        if type(result) == 'userdata' then
--            printf([[error result is a Factorio class, and these cannot be JSON-encoded due to
--            technical limitations – please request specific properties]])
--            return
--        end
        printf('success %s', json.encode(result))
    end)
    remote.add_interface('remote_api', {
        raw_command = function (command)
            local result = assert(loadstring(command))()
--            if not success then
--                printf('Error executing command "remote_api.raw_command": %s', error)
--            end
            return result
        end
    })
end)

--return {
--    add_commands = add_commands,
--    printf = printf,
--}