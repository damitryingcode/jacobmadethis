local url = "https://raw.githubusercontent.com/damitryingcode/jacobmadethis/refs/heads/main/main.lua"

local success, result = pcall(function()
    return game:HttpGet(url)
end)

if success and result then
    loadstring(result)()
else
    warn("Failed to load script.")
end
