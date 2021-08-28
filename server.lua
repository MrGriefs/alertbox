if AddCommands then
    RegisterCommand('alert', function(source, args, rawCommand)
        TriggerClientEvent('alertbox:message', -1, 'Announcement', table.concat(args, ' '))
    end, true)

    RegisterCommand('announce', function(source, args, rawCommand)
        TriggerClientEvent('chatMessage', -1, '^3[Announcement]^0', {255, 255, 0}, '^3' .. table.concat(args, ' '))
    end, true)
end

-- Oh goodie, a free example! Looks like you've found me
-- Citizen.CreateThread(function()
--     TriggerClientEvent('alertbox:message', -1, 'bank', 'Transfer $1,000 to another player?', {"CONFIRM", "CANCEL_TRANSFER"}, nil, nil, true, nil, 'alertbox:Example')
--     RegisterNetEvent('alertbox:Example')
--     AddEventHandler('alertbox:Example', function(
--         keymap, -- all front-end controls that are used
--         button, -- the index of the button that was pressed, i.e. 5 for 'CANCEl', 2 for 'OK' etc
--         key, -- the key that was pressed
--         controlmap, -- the array of buttons, controlkey pairs
--         usesAlt -- whether an alt key was used. if an alt key is used, keymap, button, key and controlmap will all be relative to the AltButtonControlMap table
--     )
--         if button == 'CONFIRM' then -- if the 'CONFIRM' button was activated
--             print('confirm') -- send the request to the server to confirm transfer
--         else -- the 'CANCEL_TRANFER' button was activated
--             print('cancel')
--         end -- do nothing more, the UI closes automatically
--     end)
-- end)