middle = 25
center = 13
parallel.waitForAny(
    function()
        while true do
            buffer1 = peripheral.wrap("gtceu:mv_battery_buffer_16x_0")
            buffer2 = peripheral.wrap("gtceu:mv_battery_buffer_16x_1")
            dieselTank = peripheral.wrap("gtceu:steel_multiblock_tank_0")
            crudeOilTank = peripheral.wrap("gtceu:steel_multiblock_tank_1")
            monitor_1 = peripheral.wrap("monitor_1")
            reset_button = (peripheral.wrap("redstoneIntegrator_1"))
            reset_booleen = reset_button and reset_button.getInput("front") or false

            currentMvEnergy, maxMvEnergy, mvEnergyPercentage = 0, 1, 0
            currentLvEnergy, maxLvEnergy, lvEnergyPercentage = 0, 1, 0
            currentDieselAmount, maxDieselCapacity, dieselPercentage = 0, 1000, 0
            currentCrudeOilAmount, maxCrudeOilCapacity, crudeOilPercentage = 0, 1000, 0

            function conditionalFormatting(percentage)
                if percentage == 100 then
                    monitor_1.setTextColor(colors.lime)
                elseif percentage > 71 then
                    monitor_1.setTextColor(colors.green)
                elseif percentage > 41 then
                    monitor_1.setTextColor(colors.yellow)
                elseif percentage > 11 then
                    monitor_1.setTextColor(colors.orange)
                else
                    monitor_1.setTextColor(colors.red)
                end
            end

            if buffer1 then
                currentMvEnergy = buffer1.getEnergyStored()
                maxMvEnergy = buffer1.getEnergyCapacity()
                
                -- Calculate percentage
                mvEnergyPercentage = (currentMvEnergy / maxMvEnergy) * 100
            end

            if buffer2 then
                currentLvEnergy = buffer2.getEnergyStored()
                maxLvEnergy = buffer2.getEnergyCapacity()

                -- Calculate percentage
                lvEnergyPercentage = (currentLvEnergy / maxLvEnergy) * 100
            end

            if dieselTank then
                currentDieselAmountTable = dieselTank.tanks()
                local dieselEntry = currentDieselAmountTable and currentDieselAmountTable[1]

                if dieselEntry and dieselEntry.amount then
                    currentDieselAmount = math.floor(dieselEntry.amount / 1000 * 10 + 0.5) / 10
                    maxDieselCapacity = dieselEntry.capacity and (dieselEntry.capacity / 1000) or 1000
                    dieselPercentage = (currentDieselAmount / maxDieselCapacity) * 100
                end
            end

            if crudeOilTank then
                currentCrudeOilAmountTable = crudeOilTank.tanks()
                local crudeEntry = currentCrudeOilAmountTable and currentCrudeOilAmountTable[1]

                if crudeEntry and crudeEntry.amount then
                    currentCrudeOilAmount = math.floor(crudeEntry.amount / 1000 * 10 + 0.5) / 10
                    maxCrudeOilCapacity = crudeEntry.capacity and (crudeEntry.capacity / 1000) or 1000
                    crudeOilPercentage = (currentCrudeOilAmount / maxCrudeOilCapacity) * 100
                end
            end
            local monitor = peripheral.wrap("monitor_1")
            local size = { monitor.getSize() }
            local bottom = size[2]
            local time = "Unavailable"
            local date = "Unavailable"
            local weekday = "Unavailable"
            local api = http.get("https://timeapi.io/api/Time/current/zone?timeZone=America/Chicago")
                if api then
                    local data = api.readAll()
                    local jsonData = textutils.unserializeJSON(data)

                    if jsonData and jsonData.dateTime then
                        local dateTime = jsonData.dateTime
                        time = string.sub(dateTime, 12, 19) -- Extract time (HH:MM:SS)
                        date = string.sub(dateTime, 1, 10) -- Extract date (YYYY-MM-DD)
                        weekday = jsonData.dayOfWeek
                    end

                    api.close()
                end
            --write data to monitor
            monitor_1.clear()
            if reset_booleen == true then
                monitor_1.setTextColor(colors.red)
                monitor_1.setCursorPos(1, center - 3)
                monitor_1.write(" ________________________________________________ ")
                monitor_1.setCursorPos(1, center - 2)
                monitor_1.write("/                                                \\")
                monitor_1.setCursorPos(1, center - 1)
                monitor_1.write("|                     GRID                       |")
                monitor_1.setCursorPos(1, center)
                monitor_1.write("|                   RESET IN                     |")
                monitor_1.setCursorPos(1, center + 1)
                monitor_1.write("|                   PROGRESS                     |")
                monitor_1.setCursorPos(1, center + 2)
                monitor_1.write("\\________________________________________________/")
            else
                if true then
                    monitor_1.setTextColor(colors.blue)
                    monitor_1.setCursorPos(1, 1)
                    monitor_1.write("Battery Buffer 1 (MV)")
                    monitor_1.setTextColor(colors.white)
                    monitor_1.setCursorPos(1, 2)
                    monitor_1.write("==================================================")
                    monitor_1.setCursorPos(1, 3)
                    conditionalFormatting(mvEnergyPercentage)
                    monitor_1.write("Energy: " .. currentMvEnergy .. "FE")
                    monitor_1.setCursorPos(1, 4)
                    monitor_1.write("Capacity: " .. maxMvEnergy .. "FE")
                    monitor_1.setCursorPos(1, 5)
                    monitor_1.write("Percentage: " .. string.format("%.2f", mvEnergyPercentage) .. "%")
                    monitor_1.setTextColor(colors.yellow)
                    monitor_1.setCursorPos(middle, 3)
                    monitor_1.write("Input Ammount: " .. buffer1.getInputPerSec() .. "FE/s")
                    monitor_1.setCursorPos(middle, 4)
                    monitor_1.write("Output Ammount: " .. buffer1.getOutputPerSec() .. "FE/s")
                end
                if true then
                    monitor_1.setCursorPos(1, 7)
                    monitor_1.setTextColor(colors.blue)
                    monitor_1.write("Battery Buffer 2 (MV)")
                    monitor_1.setCursorPos(1, 8)
                    monitor_1.setTextColor(colors.white)
                    monitor_1.write("==================================================")
                    monitor_1.setCursorPos(1, 9)
                    conditionalFormatting(lvEnergyPercentage)
                    monitor_1.write("Energy: " .. currentLvEnergy .. "FE")
                    monitor_1.setCursorPos(1, 10)
                    monitor_1.write("Capacity: " .. maxLvEnergy .. "FE")
                    monitor_1.setCursorPos(1, 11)
                    monitor_1.write("Percentage: " .. string.format("%.2f", lvEnergyPercentage) .. "%")
                    monitor_1.setTextColor(colors.yellow)
                    monitor_1.setCursorPos(middle, 9)
                    monitor_1.write("Input Ammount: " .. buffer2.getInputPerSec() .. "FE/s")
                    monitor_1.setCursorPos(middle, 10)
                    monitor_1.write("Output Ammount: " .. buffer2.getOutputPerSec() .. "FE/s")
                end
                if true then
                    monitor_1.setCursorPos(1, 13)
                    monitor_1.setTextColor(colors.blue)
                    monitor_1.write("Diesel Tank")
                    monitor_1.setCursorPos(1, 14)
                    monitor_1.setTextColor(colors.white)
                    monitor_1.write("==================================================")
                    monitor_1.setCursorPos(1, 15)
                    conditionalFormatting(dieselPercentage)
                    monitor_1.write("Current Amount: " .. currentDieselAmount .. "B")
                    monitor_1.setCursorPos(1, 16)
                    monitor_1.write("Capacity: " .. maxDieselCapacity .. "B")
                    monitor_1.setCursorPos(1, 17)
                    monitor_1.write("Percentage: " .. string.format("%.2f", dieselPercentage) .. "%")
                end
                if true then
                    monitor_1.setCursorPos(1, 19)
                    monitor_1.setTextColor(colors.blue)
                    monitor_1.write("Crude Oil Tank")
                    monitor_1.setCursorPos(1, 20)
                    monitor_1.setTextColor(colors.white)
                    monitor_1.write("==================================================")
                    monitor_1.setCursorPos(1, 21)
                    conditionalFormatting(crudeOilPercentage)
                    monitor_1.write("Current Amount: " .. currentCrudeOilAmount .. "B")
                    monitor_1.setCursorPos(1, 22)
                    monitor_1.write("Capacity: " .. maxCrudeOilCapacity .. "B")
                    monitor_1.setCursorPos(1, 23)
                    monitor_1.write("Percentage: " .. string.format("%.2f", crudeOilPercentage) .. "%")
                end

                        monitor_1.setTextColor(colors.white)
                        i = 1
                        while i <= size[1] do
                            monitor_1.setCursorPos(i, bottom - 1)
                            monitor_1.write("=")
                            i = i + 1
                        end
                        monitor.setCursorPos(1, bottom)
                        monitor.write(weekday .. " " .. date .. " " .. time .. " | " .. textutils.formatTime(os.time()))
                sleep(.25)
            end
        end
    end,
    function()
        local modem = peripheral.find("modem")
        if not modem then
            error("No modem found")
        end

        local selfChannel = os.computerID()
        modem.open(selfChannel)
        modem.open(0)
        while true do
            local event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")
            if channel == 0 and message == "baseDataOpenRequest" then
                local pocketChannel = replyChannel
                print("Base Data Open Request Received")
                print("Opening Base Data...")
                modem.transmit(pocketChannel, selfChannel, "baseDataOpened")
                modem.close(0)
                break
            end
        end
    end
)