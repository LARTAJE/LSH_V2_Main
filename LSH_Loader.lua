local PlayerService = game:GetService("Players")
local GameId = game.GameId
local Repository = "https://raw.githubusercontent.com/LARTAJE/LSH_V2_Main/refs/heads/main/".. GameId ..".lua"
loadstring(game:HttpGet(Repository))()
