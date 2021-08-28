RegisterNetEvent('alertbox:message')
--- @param title? string The title of the alert message, appears in large, yellow bold text. Default: `"alert"`
--- @param message string The message to add below the title
--- @param p2? number[]|string[]|number|string Usable buttons to add to this alertbox. Accepts an array of button names or button types (see ButtonControlMap). Default: `"CONTINUE"`.
--- Example:
--- ```
--- {"NO", "YES", "CANCEL"}
--- ```
--- (Case-Sensitive, must be caps)
--- @param p3? number[]|string[]|number|string Same as `p2`, except only accepts button names or button types from `Constants.AltButtons`. Default: `nil`
--- @param message2? string An additional message to display below `message`. Default: no additional message
--- @param background? boolean Whether the background should be opaque. Default: `true`
--- @param errorCode? number An error code to show at the bottom left. Can be any number. Default: `nil`
--- @param handler? string The name of an event handler for keypresses within the alertbox, to allow custom script calling. Example:
--- ```lua
--- -- this can also be called in a client-side script!
--- TriggerClientEvent('alertbox:message', playerId, 'bank', 'Transfer $1,000 to another player?', {"CONFIRM", "CANCEL_TRANSFER"}, nil, nil, true, nil, 'bank:TransferCallback')
--- -- in your bank resource:
--- RegisterNetEvent('bank:TransferCallback')
--- AddEventHandler('bank:TransferCallback', function(
---     keymap, -- all front-end controls that are used
---     button, -- the button that was pressed, i.e. 5 for 'CANCEl', 2 for 'OK', etc, check client.lua
---     key, -- the key that was pressed
---     controlmap, -- the array of buttons, controlkey pairs
---     usesAlt -- whether an alt key was used. if an alt key is used, keymap, button, key and controlmap will all be relative to the AltButtonControlMap table
--- )
---     if button == 20 then -- if the 'CONFIRM' button was activated
---         Bank:ConfirmTransaction(source) -- send the request to the server to confirm transfer
---     else -- the 'CANCEL_TRANFER' button was activated
---         Bank:CancelTransaction(source)
---     end -- do nothing more, the UI closes automatically
--- end)
--- ```
--- @param p5? boolean Unknown parameter. Can be optionally set, not recommended
--- @param p6? number Unknown parameter. Can be optionally set, not recommended
--- @param p7? number Unknown parameter. Can be optionally set, not recommended
--- @param p8? string Unknown parameter. Can be optionally set, not recommended
--- @param p9? string Unknown parameter. Can be optionally set, not recommended
--- @see - https://docs.fivem.net/natives/?_0x15803FEC3B9A872B
AddEventHandler('alertbox:message', function(title, message, p2, p3, message2, background, errorCode, handler, p5, p6, p7, p8, p9)
    local message2Label
    -- set defaults
    if type(background) == "nil" then background = 1 end
    if type(p2) == "string" or type(p2) == "number" then
        p2 = {p2}
    end
    if type(p3) == "string" or type(p3) == "number" then
        p3 = {p3}
    end
    if type(p5) == "nil" then p5 = 0 end
    if type(p6) == "nil" then p6 = -1 end
    if type(p7) == "nil" then p7 = 1 end
    if type(p8) == "nil" then p8 = 0 end
    if type(p9) == "nil" then p9 = 0 end

    -- infer p2 and p3 as an array of buttom indexes (not binary indexes)
    if type(p2) == "table" then
        local tb = p2
        -- calculate into binary
        p2 = 0
        for _, v in ipairs(tb) do
            if type(v) == "string" then
                v = Constants.Buttons[v]
            end
            p2 = p2 + (2 ^ (v - 1))
        end
    end
    if type(p3) == "table" then
        local tb = p3
        -- calculate into binary
        p3 = 0
        for _, v in ipairs(tb) do
            if type(v) == "string" then
                v = Constants.AltButtons[v]
            end
            p3 = p3 + (2 ^ (v - 1))
        end
    end

    -- remove any floating point & set default
    p2 = math.modf(p2 or 16384)
    p3 = math.modf(p3 or 0)

    AddTextEntry('ALERTBOX_TITLE', title or 'alert')
    AddTextEntry('ALERTBOX_MESSAGE', message)
    if message2 then
        AddTextEntry('ALERTBOX_MESSAGE2', message2)
        message2Label = 'ALERTBOX_MESSAGE2'
    end

    -- filter the key mappings for the active buttons
    local p2Keymap = GetControlMap(p2, Constants.ButtonsMap, Constants.Buttons)
    local p3Keymap = GetControlMap(p3, Constants.AltButtonsMap, Constants.AltButtons)
    CreateThread(function()
	    while true do
	    	Citizen.Wait(0)
            SetWarningMessageWithAlert("ALERTBOX_TITLE", "ALERTBOX_MESSAGE", p2, p3, message2Label, p5, p6, p7, p8, p9, background, errorCode)
            if HandleKeymap(p2Keymap, Constants.ButtonsMap, handler, false) then
                break
            elseif HandleKeymap(p3Keymap, Constants.AltButtonsMap, handler, true) then
                break
            end
	    end
    end)
end)

function GetControlMap(Control, ControlMap, ButtonNames)
    local UsedButtons = {}
    local Cost = Control
    if Cost <= 0 then return {} end
    -- iterate over the control map in reverse, because binary is right-to-left. yeah that makes sense
    for i = 1, #ControlMap do
        local ButtonIndex = (#ControlMap - i + 1)
        local ButtonBinary = math.modf(2 ^ (ButtonIndex - 1))
        if ButtonBinary <= Cost then
            Cost = Cost - ButtonBinary
            table.insert(UsedButtons, {GetButtonNameFromIndex(ButtonIndex, ButtonNames), ButtonIndex})
            if Cost == 0 then
                break
            end
        end
    end
    return UsedButtons
end

function HandleKeymap(keymap, controlmap, handler, usesAlt)
    for _, val in ipairs(keymap) do
        local name = val[1]
        local indx = val[2]
        local keys = controlmap[indx]
        if type(keys) == "table" then
            for _, key in ipairs(keys) do
                if HandleKey(keymap, controlmap, name, key, handler, usesAlt) then
                    return true
                end
            end
        else
            if HandleKey(keymap, controlmap, name, keys, handler, usesAlt) then
                return true
            end
        end
    end
end

function HandleKey(keymap, controlmap, name, key, handler, usesAlt)
    if (IsControlJustReleased(2, key)) then
        if handler then
            if type(handler) == "table" then
                local payload = msgpack.pack({keymap, name, key, controlmap, usesAlt})
                InvokeFunctionReference(handler.__cfx_functionReference, payload, payload:len(), 0)
            elseif type(handler) == 'string' then
                TriggerServerEvent(handler, keymap, name, key, controlmap, usesAlt)
            else
                -- will probably throw an error as it's incredibly unlikely a function has been passed
                handler(keymap, name, key, controlmap, usesAlt)
            end
        end
        return true
    end
end

function GetButtonNameFromIndex(indx, names)
    for name, i in pairs(names) do
        if i == indx then return name end
    end
end