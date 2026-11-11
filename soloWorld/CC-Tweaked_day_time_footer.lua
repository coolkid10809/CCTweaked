--[[Day Time Footer
unused
Do not use without permission from the creator
Created by: Coolkid10809
Pastebin "https://pastebin.com/0U6bT0U2"
github Repo: "https://github.com/coolkid10809/CCTweaked/blob/main/soloWorld/CC-Tweaked_day_time_footer.lua"]]
local monitor = peripheral.wrap("monitor_0")
local size = { monitor.getSize() }
local bottom = size[2]
while true do
    local api = http.get("https://timeapi.io/api/Time/current/zone?timeZone=America/Chicago")
    if api then
        local data = api.readAll()
        local jsonData = textutils.unserializeJSON(data)

        if jsonData and jsonData.dateTime then
            local dateTime = jsonData.dateTime
            time = string.sub(dateTime, 12, 19) -- Extract time (HH:MM:SS)
            date = string.sub(dateTime, 1, 10) -- Extract date (YYYY-MM-DD)
            weekday = jsonData.dayOfWeek

            print("Current Time: " .. time)
            print("Current Date: " .. date)
            print("Current Weekday: " .. weekday)
        else
            print("Failed to retrieve time data.")
        end

        api.close()
    else
        print("Failed to connect to the time API.")
    end
        monitor.setTextColor(colors.white)
        i = 1
        while i <= size[1] do
            monitor.setCursorPos(i, bottom - 1)
            monitor.write("=")
            i = i + 1
        end
        monitor.setCursorPos(1, bottom)
        monitor.write(weekday .. " " .. date .. " " .. time .. " | " .. textutils.formatTime(os.time()))
    sleep(1)
end