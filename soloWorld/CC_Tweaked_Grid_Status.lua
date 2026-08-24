center = 6
middle = 14
monitor = peripheral.wrap("monitor_3")
w, h = monitor.getSize()
redstoneIntegrator = peripheral.wrap("redstoneIntegrator_1")
redstoneIntegrator_alarm = peripheral.wrap("redstoneIntegrator_2")
main_buffer = peripheral.wrap("gtceu:mv_battery_buffer_16x_0")
monitor.setTextColor(colors.black)
status_good = colors.green
status_moderate = colors.orange
status_ok = colors.yellow
status_bad = colors.red
status_neutral = colors.white

low_power = redstoneIntegrator.getInput("north")
no_power = redstoneIntegrator.getInput("west")
fuse_off = redstoneIntegrator.getInput("south")
grid_reset = redstoneIntegrator.getInput("east")
low_power_alarm = redstoneIntegrator_alarm.getInput("north")
no_power_alarm = redstoneIntegrator_alarm.getInput("east")
low_main_power = redstoneIntegrator.getInput("down")
net_power = main_buffer.getInputPerSec() - main_buffer.getOutputPerSec()
main_buffer_charge = main_buffer.getEnergyStored() / main_buffer.getEnergyCapacity() * 100

function outline()
    -- Top
    monitor.setCursorPos(1, 1)
    monitor.write(" " .. string.rep("_", w - 2))

    monitor.setCursorPos(1, 2)
    monitor.write("/" .. string.rep(" ", w - 2) .. "\\")

    -- Sides
    for y = 3, h - 1 do
        monitor.setCursorPos(1, y)
        monitor.write("|")

        monitor.setCursorPos(w, y)
        monitor.write("|")
    end

    -- Bottom
    monitor.setCursorPos(1, h)
    monitor.write("\\" .. string.rep("_", w - 2) .. "/")
end

function centerText(text, y)
    local w, h = monitor.getSize()
    local x = math.floor((w - #text) / 2) + 1

    monitor.setCursorPos(x, y)
    monitor.write(text)
end

parallel.waitForAny(
    function()
        while true do
            low_power = redstoneIntegrator.getInput("north")
            no_power = redstoneIntegrator.getInput("west")
            fuse_off = redstoneIntegrator.getInput("south")
            grid_reset = redstoneIntegrator.getInput("east")
            low_power_alarm = redstoneIntegrator_alarm.getInput("north")
            no_power_alarm = redstoneIntegrator_alarm.getInput("east")
            low_main_power = redstoneIntegrator.getInput("down")
            net_power = main_buffer.getInputPerSec() - main_buffer.getOutputPerSec()
            main_buffer_charge = main_buffer.getEnergyStored() / main_buffer.getEnergyCapacity() * 100
            sleep(0.1)
        end
    end,
    function()
        while true do
            if no_power_alarm == true then
                parallel.waitForAny(
                    function()
                        while redstoneIntegrator_alarm.getInput("east") do
                            monitor.setBackgroundColor(status_bad)
                            monitor.clear()
                            outline()
                            centerText("NO POWER", 2)
                            centerText("CLICK TO CLEAR ALARM", 6)
                            sleep(1)
                            monitor.setBackgroundColor(status_neutral)
                            monitor.clear()
                            outline()
                            centerText("NO POWER", 2)
                            centerText("CLICK TO CLEAR ALARM", 6)
                            print("no power alarm activated")
                            sleep(1)
                        end
                    end,
                    function()
                        os.pullEvent("monitor_touch")
                        redstoneIntegrator_alarm.setOutput("west", true)
                        print("no power alarm cleared")
                        sleep(1)
                        redstoneIntegrator_alarm.setOutput("west", false)
                    end
                )
            elseif low_power_alarm == true then
                parallel.waitForAny(
                    function()
                        while redstoneIntegrator_alarm.getInput("north") do
                            monitor.setBackgroundColor(status_moderate)
                            monitor.clear()
                            outline()
                            centerText("LOW POWER", 2)
                            centerText("CLICK TO CLEAR ALARM", 6)
                            sleep(1)
                            monitor.setBackgroundColor(status_neutral)
                            monitor.clear()
                            outline()
                            centerText("LOW POWER", 2)
                            centerText("CLICK TO CLEAR ALARM", 6)
                            print("low power alarm activated")
                            sleep(1)
                        end
                    end,
                    function()
                        os.pullEvent("monitor_touch")
                        redstoneIntegrator_alarm.setOutput("west", true)
                        print("low power alarm cleared")
                        sleep(1)
                        redstoneIntegrator_alarm.setOutput("west", false)
                    end
                )
            elseif grid_reset == true then
                monitor.setBackgroundColor(status_neutral)
                monitor.clear()
                outline()
                centerText("GRID RESETING", 2)
                if main_buffer_charge < 75 then
                    centerText("RESTART MAY FAIL", 4)
                    centerText("DUE TO LOW POWER", 5)
                    centerText("PLEASE WAIT FOR GRID TO", 7)
                    centerText("FINISH RESTART", 8)
                else
                    centerText("RESTART FAILURE UNLIKELY", 4)
                    centerText("PLEASE WAIT FOR GRID TO", 6)
                    centerText("FINISH RESTART", 7)
                end
            elseif fuse_off == true then
                monitor.setBackgroundColor(status_ok)
                monitor.clear()
                outline()
                centerText("FUSE OFF", 2)
                centerText("GRID SHUTDOWN IN EFFECT", 4)
                centerText("RENABLE POWER GRID WHENEVER", 6)
                centerText("POSSIBLE", 7)
            elseif no_power == true then
                parallel.waitForAny(
                    function()
                        while redstoneIntegrator.getInput("west") == true do
                            monitor.setBackgroundColor(status_bad)
                            monitor.clear()
                            outline()
                            centerText("NO POWER", 2)
                            centerText("GRID SHUTDOWN IN EFFECT", 4)
                            if main_buffer_charge < 75 then
                                centerText("RESTART MAY FAIL", 6)
                                centerText("DUE TO LOW POWER", 7)
                                centerText("PLEASE WAIT FOR GRID TO", 9)
                                centerText("CARGE TO AT LEAST 75%", 10)
                            else
                                centerText("RESTART FAILURE UNLIKELY", 6)
                                centerText("CLICK TO RESET GRID", 8)
                            end
                            sleep(1)
                        end
                    end,
                    function()
                        os.pullEvent("monitor_touch")
                        redstoneIntegrator_alarm.setOutput("down", true)
                        sleep(1)
                        redstoneIntegrator_alarm.setOutput("down", false)
                    end
                )
            elseif low_power == true then
                monitor.setBackgroundColor(status_moderate)
                monitor.clear()
                outline()
                centerText("LOW POWER", 2)
                centerText("BE PREPARED FOR POWER GRID", 4)
                centerText("SHUTDOWN AT ANY MOMENT", 5)
                centerText("BE AWARE OF REMAINING", 7)
                centerText("BATTERY AMOUNT IN BUFFERS", 8)
            else
                monitor.setBackgroundColor(status_good)
                monitor.clear()
                outline()
                centerText("SYSTEMS NORMAL", 2)
                centerText("POWER GRID ONLINE", 4)
                if net_power < 0 then
                    centerText("POWER GRID IN NET LOSS", 6)
                elseif net_power == 0 then
                    centerText("POWER GRID UNUSED", 6)
                else
                    centerText("NO WARNINGS AT THIS TIME", 6)
                end
            end

            redstoneIntegrator_alarm.setOutput("west", false)
            redstoneIntegrator_alarm.setOutput("down", false)
            sleep(1)
        end
    end
)
