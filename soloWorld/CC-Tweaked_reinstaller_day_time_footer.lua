--[[day time footer reinstaller
reinstalls day time footer
Do not use without permission from the creator
Created by: Coolkid10809
Pastebin "https://pastebin.com/QDJZhHGp"
github Repo: "https://github.com/coolkid10809/CCTweaked/blob/main/soloWorld/CC-Tweaked_reinstaller_day_time_footer.lua"]]
local pasteID = "0U6bT0U2"

if fs.exists("Day_Time_Footer") then
    fs.delete("Day_Time_Footer")
end

if shell.run("pastebin", "get", pasteID, "Day_Time_Footer") then
    print("Day Time Footer reinstalled!")
else
    print("Failed to download Day Time Footer.")
end