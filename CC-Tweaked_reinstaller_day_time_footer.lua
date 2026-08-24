local pasteID = "0U6bT0U2"

if fs.exists("Day_Time_Footer") then
    fs.delete("Day_Time_Footer")
end

if shell.run("pastebin", "get", pasteID, "Day_Time_Footer") then
    print("Day Time Footer reinstalled!")
else
    print("Failed to download Day Time Footer.")
end