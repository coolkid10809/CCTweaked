local pasteID = "mSC1VBZE"

if fs.exists("startup") then
    fs.delete("startup")
end

if shell.run("pastebin", "get", pasteID, "startup") then
    print("Startup reinstalled!")
else
    print("Failed to download startup.")
end