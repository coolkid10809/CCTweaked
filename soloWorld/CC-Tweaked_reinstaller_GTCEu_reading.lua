--[[GTCEu reading reinstaller
Reinstalls GTCEu reading
Do not use without permission from the creator
Created by: Coolkid10809
Pastebin "https://pastebin.com/qStMamQn"
github Repo: "https://github.com/coolkid10809/CCTweaked/blob/main/soloWorld/CC-Tweaked_reinstaller_GTCEu_reading.lua"]]
local pasteID = "mSC1VBZE"

if fs.exists("startup") then
    fs.delete("startup")
end

if shell.run("pastebin", "get", pasteID, "startup") then
    print("Startup reinstalled!")
else
    print("Failed to download startup.")
end