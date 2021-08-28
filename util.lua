--[[
    WARNING
    USING MULTIPLE BUTTONS OF THE SAME CONTROL KEY WILL LEAD TO DETECTION PROBLEMS
    -- If you want to use the same locale, simply use a duplicate key such as OK_ESC, CANCEL_ESC, etc
]]

Constants = {
    ['ButtonsMap'] = { -- Describes what input each button uses
        --          indx hexadecimal  decimal    binary 30-bits
        201         --  1 0x00000001          1 0b000000000000000000000000000001 - SELECT
      , 201         --  2 0x00000002          2 0b000000000000000000000000000010 - OK
      , 201         --  3 0x00000004          4 0b000000000000000000000000000100 - YES
      , 202         --  4 0x00000008          8 0b000000000000000000000000001000 - BACK
      , 202         --  5 0x00000010         16 0b000000000000000000000000010000 - CANCEL
      , 202         --  6 0x00000020         32 0b000000000000000000000000100000 - NO
      , 203         --  7 0x00000040         64 0b000000000000000000000001000000 - RETRY
      , 203         --  8 0x00000080        128 0b000000000000000000000010000000 - RESTART
      , 203         --  9 0x00000100        256 0b000000000000000000000100000000 - SKIP
      , 202         -- 10 0x00000200        512 0b000000000000000000001000000000 - QUIT
      , {189, 190}  -- 11 0x00000400       1024 0b000000000000000000010000000000 - ADJUST (ARROWS)
      , 203         -- 12 0x00000800       2048 0b000000000000000000100000000000 - SPACE_KEY
      , 203         -- 13 0x00001000       4096 0b000000000000000001000000000000 - SHARE
      , 203         -- 14 0x00002000       8192 0b000000000000000010000000000000 - SIGN_IN
      , 201         -- 15 0x00004000      16384 0b000000000000000100000000000000 - CONTINUE
      , {}          -- 16 0x00008000      32768 0b000000000000001000000000000000 - ADJUST_LEFT_RIGHT (SCROLL LEFT/RIGHT)
      , {241, 242}  -- 17 0x00010000      65536 0b000000000000010000000000000000 - ADJUST_UP_DOWN (SCROLL UP/DOWN)
      , 203         -- 18 0x00020000     131072 0b000000000000100000000000000000 - OVERWRITE
      , 201         -- 19 0x00040000     262144 0b000000000001000000000000000000 - SOCIAL_CLUB_SIGN_UP
      , 201         -- 20 0x00080000     524288 0b000000000010000000000000000000 - CONFIRM
      , 201         -- 21 0x00100000    1048576 0b000000000100000000000000000000 - QUEUE
      , 201         -- 22 0x00200000    2097152 0b000000001000000000000000000000 - RETRY_ENTER
      , 202         -- 23 0x00400000    4194304 0b000000010000000000000000000000 - BACK_ESC
      , 201         -- 24 0x00800000    8388608 0b000000100000000000000000000000 - SOCIAL_CLUB
      , 203         -- 25 0x01000000   16777216 0b000001000000000000000000000000 - SPECTATE
      , 202         -- 26 0x02000000   33554432 0b000010000000000000000000000000 - OK_ESC
      , 202         -- 27 0x04000000   67108864 0b000100000000000000000000000000 - CANCEL_TRANSFER
      , {}          -- 28 0x08000000  134217728 0b001000000000000000000000000000 - LOADING_SPINNER
      , 202         -- 29 0x10000000  268435456 0b010000000000000000000000000000 - NO_RETURN_TO_GTA
      , 202         -- 30 0x20000000  536870912 0b100000000000000000000000000000 - CANCEL_ESC
        -- All            0x3FFFFFFF 1073741823 0b111111111111111111111111111111
        -- Maximum   =  2 ^ 30 - 1 = 1073741823 (every single button, exc. alt buttons)
        -- https://docs.fivem.net/docs/game-references/controls/#controls
    },
    ['AltButtonsMap'] = { -- no one ever uses these, but they're here in case you do!
        203 -- 1 0x01  1 0b00001 - NO_SPACE
      , 202 -- 2 0x02  2 0b00010 - HOST
      , 201 -- 3 0x04  4 0b00100 - SEARCH_FOR_JOB
      , 201 -- 4 0x08  8 0b01000 - RETURN_KEY
      , 202 -- 5 0x10 16 0b10000 - FREEMODE
        -- All   0x1F 31 0b11111
        -- Maximum = 2 ^ 5 - 1 = 31 (every single alt button)
        -- https://docs.fivem.net/docs/game-references/controls/#controls
    },
    ['Buttons'] = { -- All available button types. You can either use the button name or its type
        ['SELECT']            = 1
      , ['OK']                = 2
      , ['YES']               = 3
      , ['BACK']              = 4
      , ['CANCEL']            = 5
      , ['NO']                = 6
      , ['RETRY']             = 7
      , ['RESTART']           = 8
      , ['SKIP']              = 9
      , ['QUIT']              = 10
      , ['ADJUST']            = 11
      , ['SPACE_KEY']         = 12
      , ['SHARE']             = 13
      , ['SIGN_IN']           = 14
      , ['CONTINUE']          = 15
      , ['ADJUST_LEFT_RIGHT'] = 16
      , ['ADJUST_UP_DOWN']    = 17
      , ['OVERWRITE']         = 18
      , ['CONFIRM']           = 20
      , ['QUEUE']             = 21
      , ['RETRY_ENTER']       = 22
      , ['BACK_ESC']          = 23
      , ['SOCIAL_CLUB']       = 24
      , ['SPECTATE']          = 25
      , ['OK_ESC']            = 26
      , ['CANCEL_TRANSFER']   = 27
      , ['LOADING_SPINNER']   = 28
      , ['NO_RETURN_TO_GTA']  = 29
      , ['CANCEL_ESC']        = 30
    },
    ['AltButtons'] = {
        ['NO_SPACE']          = 1
      , ['HOST']              = 2
      , ['SEARCH_FOR_JOB']    = 3
      , ['RETURN_KEY']        = 4
      , ['FREEMODE']          = 5
    }
}