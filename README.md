# Alert

## Table of Contents

- [About](#about)
- [Installation](#installation)
- [Usage](#usage)
- [Commands](#commands)

## About

AlertBox is an out-of-the-box utility that allows you to create & customise alert messages with the ability to handle the player's response.  
Great for confirming sensitive transactions, sending important announcements to players and is easy to use.  

## Installation

Clone with Git or [download manually](https://github.com/MrGriefs/alertbox/archive/refs/heads/main.zip)

```bash
$ git clone https://github.com/MrGriefs/alertbox.git
```

(Optional) Edit the resource `config.lua` to enable commands

```lua
-- Adds the /announce and /alert commands
AddCommands = true
```

Start the resource in your `server.cfg` and allow the commands for admins

```cfg
start alertbox
add_ace group.admin command.announce allow # (optional)
add_ace group.admin command.alert allow # (optional)
```

## Usage

In a server-side lua script:  

```lua
TriggerClientEvent('alertbox:message', -1, 'Announcement', 'The server will be shutting down in 5 minutes!')
```

This will trigger the alertbox for all connected players, with the title being 'Announcement' and the message underneath.  
In a client-side lua script:  

```lua
-- will only trigger for the client
TriggerEvent('alertbox:message', 'Announcement', 'The server will be shutting down in 5 minutes!')
```

You can also send a specific client a message with multiple options and a callback function:

```lua
-- this can also be called in a client-side script!
TriggerClientEvent(
    'alertbox:message', -- event name
    playerId, -- client id to work on or -1 for all
    'bank', -- the title of alert - https://i.imgur.com/cBJl2Ay.png
    'Transfer $1,000 to another player?', -- the description of the alert
    {"CONFIRM", "CANCEL_TRANSFER"}, -- buttons that are enabled in this alert - util.lua Buttons for full list
    nil, -- also buttons that are enabled in this alert, but only uses util.lua AltButtons
    nil, -- another description below the first description - https://i.imgur.com/idG7BNe.png
    true, -- whether the background should be opaque. default is true - https://i.imgur.com/h3tcHwU.png
    nil, -- if a number, will show a "Error Code: " message at the bottom left https://i.imgur.com/dg0HQrt.png
    'bank:TransferCallback' -- a callback event - must be server-side. a function can be used if you're triggering 'alertbox:message' on a client
    )
-- in your bank resource:
RegisterNetEvent('bank:TransferCallback')
AddEventHandler('bank:TransferCallback', function(
    keymap, -- array<number|number[]>: all front-end controls that are used - https://docs.fivem.net/docs/game-references/controls/#controls
    button, -- string: button that was pressed, i.e. 'CANCEl', 'CONFIRM', 'CANCEL_TRANFER', etc, check util.lua
    key, -- number: the key that was pressed
    controlmap, -- the array of buttons, controlkey pairs
    usesAlt -- whether an alt key was used. if an alt key is used, keymap, button, key and controlmap will all be relative to the AltButtonControlMap table
)
    if button == 'CONFIRM' then -- if the CONFIRM (type 20) button was activated
        Bank:ConfirmTransaction(source) -- send the request to the server to confirm transfer
    else -- the 'CANCEL_TRANFER' button was activated
        Bank:CancelTransaction(source)
    end -- do nothing more, the UI closes automatically
end)
```

## Commands

Admin commands this resource **optionally** adds:  

* `/announce <message>` Sends a message globaly in chat, like this: ![img](https://i.imgur.com/eUBM56P.png)
* `/alert <message>` Sends a warning message/alert box to all players with the title 'announcement': ![img](https://i.imgur.com/jsejsTZ.png)
