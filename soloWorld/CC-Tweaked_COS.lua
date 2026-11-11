--[[COS (Cool's Operating System)
Runs on Advanced Ender Pocket Computer excluseively
Do not use without permission from the creator
Created by: Coolkid10809
Pastebin "https://pastebin.com/tV9YWrcg"
Github Repo: "https://github.com/coolkid10809/CCTweaked/blob/main/soloWorld/CC-Tweaked_COS"]]
function updatevar()
    local response = http.get("https://timeapi.io/api/Time/current/zone?timeZone=America/Chicago")
    if not response then
        return nil, nil
    end

    local ok, body = pcall(response.readAll)
    pcall(response.close)
    if not ok then
        return nil, nil
    end

    local time_data = textutils.unserializeJSON(body)
    if not time_data then
        return nil, nil
    end

    return time_data.time, time_data.date


end

function top_bar(current_time)
print("|"..(current_time or "--:--").."                   |")
end

function loadingbar()
    loadingItterations = 0
    if z == 0 then
        print("|                     |  |")
        print("|                     |  |")
        print("|                     |  |")
        z = 1
    elseif z == 1 then
        print("|                      / |")
        print("|                     /  |")
        print("|                    /   |")
        z = 2
    elseif z == 2 then
        print("|                        |")
        print("|                    --- |")
        print("|                        |")
        z = 3
    elseif z == 3 then
        print("|                    \\   |")
        print("|                     \\  |")
        print("|                      \\ |")
        z = 0
    else
        z = 0
    end
end

print("/------------------------\\")
print("|                        |")
print("|  CCCC   OOOO     SSSS  |")
print("| C      O    O   S      |")
print("| C      O    O   S      |")
print("| C      O    O    SSSS  |")
print("| C      O    O        S |")
print("| C      O    O        S |")
print("|  CCCC   OOOO     SSSS  |")
print("|                        |")
print("|------------------------|")
print("|                        |")
print("|    starting systems    |")
print("|                        |")
print("|      welcome back      |")
print("|                        |")
print("|                        |")
print("|                        |")
print("\\------------------------/")
sleep(3)
appToRun = "Menu"
while true do
    --Main Menu
    parallel.waitForAny(
        function()
            while true do
                local event, button, x, y = os.pullEvent("mouse_click")
                if x >= 13 and x <= 14 and y == 19 or exitToMenu == true then
                    appToRun = "Menu"
                    exitToMenu = false
                    return
                end
            end
        end,
        function()
            if appToRun == "Menu" then
                parallel.waitForAny(
                    function()
                        while true do
                            local current_time, current_date = updatevar()
                            print("/------------------------\\")
                            top_bar(current_time)
                            print("|------------------------|")
                            print("|Apps:                   |")
                            print("|Base Data               |")
                            print("|                        |")
                            print("|                        |")
                            print("|                        |")
                            print("|                        |")
                            print("|                        |")
                            print("|                        |")
                            print("|                        |")
                            print("|                        |")
                            print("|                        |")
                            print("|                        |")
                            print("|                        |")
                            print("|                        |")
                            print("|                        |")
                            print("\\------------------------/")
                            sleep(1)
                        end
                    end,
            
                    function()
                        while appToRun == "Menu" do
                            local event, button, x, y = os.pullEvent("mouse_click")
                            if x >= 2 and x <= 10 and y == 5 then
                                appToRun = "Base Data"
                            end
                        end
                    end
                )
            end
        
    
            if appToRun == "Base Data" then
                connected = false
                parallel.waitForAny(
                    function()
                        label = os.getComputerLabel()
                        if label == nil then
                            sleep(10)
                        else
                            local x = 0
                            while x < 20 or connected == false do
                                local current_time, current_date = updatevar()
                                print("/------------------------\\")
                                top_bar(current_time)
                                print("|------------------------|")
                                print("| LOADING BASE DATA      |")
                                print("|                        |")
                                print("|                        |")
                                print("|                        |")
                                print("|                        |")
                                print("|                        |")
                                print("|                        |")
                                print("|                        |")
                                print("|                        |")
                                print("|                        |")
                                print("|                        |")
                                print("|                        |")
                                loadingbar()
                                print("\\-----------[]-----------/")
                                sleep(.5)
                                x = x + 1
                            end
                        end
                    end,

                    function()
                        if label == nil then
                            print("/------------------------\\")
                            top_bar(current_time)
                            print("|------------------------|")
                            print("| Please set a label for |")
                            print("|      this device       |")
                            print("|                        |")
                            print("|  Label should be your  |")
                            print("|        username        |")
                            print("|                        |")
                            print("|  Exiting to main menu  |")
                            print("|                        |")
                            print("|                        |")
                            print("|                        |")
                            print("|                        |")
                            print("|                        |")
                            print("|                        |")
                            print("|                        |")
                            print("|                        |")
                            print("\\-----------[]-----------/")
                            sleep(5)
                            appToRun = "Menu"
                            exitToMenu = true
                        end
                        local selfChannel = os.computerID()
                        modem = peripheral.find("modem")
                        if not modem then
                            error("No modem found")
                        end
                        modem.open(0)
                        modem.open(selfChannel)
                        modem.transmit(0, selfChannel, "baseDataOpenRequest " .. label)
                        while true do
                            local event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")
                            if channel == selfChannel and message == "baseDataOpened " .. label then
                                baseChannel = replyChannel
                                connected = true
                                break
                            end
                        end
                        modem.close(0)
                        modem.open(baseChannel)
                    end
                )
                x = 0                     
                local current_time, current_date = updatevar()
                print("/------------------------\\")
                top_bar(current_time)
                print("|------------------------|")
                print("|                        |")
                print("|                        |")
                print("|                        |")
                print("|                        |")
                print("|                        |")
                print("|                        |")
                print("|                        |")
                print("|                        |")
                print("|                        |")
                print("|                        |")
                print("|                        |")
                print("|                        |")
                print("|                        |")
                print("|                        |")
                print("|                        |")
                print("\\-----------[]-----------/")
                local x = x + 1
                sleep(1)
                end
            end
    )
end