repeat wait() until game:IsLoaded()
wait(5)
getgenv().AutoPlaceUnit = true
getgenv().AutoSellRedHair = true
getgenv().AutoSkip = true
getgenv().AutoFirstSkip = true
getgenv().Auto3xSpeed = true
getgenv().AutoUpgradeP1 = true
getgenv().AutoUpgradeP2 = true
getgenv().AutoUpgrade = false
getgenv().AutoReplay = true
getgenv().AutoJoinGame = true

local x = game.Players.LocalPlayer.Character.Torso.Position.x
local y = game.Players.LocalPlayer.Character.Torso.Position.y
local z = game.Players.LocalPlayer.Character.Torso.Position.z

local click = loadstring(game:HttpGet("https://raw.githubusercontent.com/buang5516/buanghub/main/realclick-obf.lua"))()

if game.PlaceId == 6558526079 then

    
    spawn(function()
        if getgenv().AutoJoinGame == true then 
            local args ={
                [1] = {
                    ["StageSelect"] = "Evil Pink Dungeon",
                    ["image"] = "rbxassetid://15289588795",
                    ["FriendOnly"] = true,
                    ["Difficult"] = "Nightmare"
                }
            }

            game:GetService("ReplicatedStorage").Remote.CreateRoom:FireServer(unpack(args))

            wait(1)
            click(game:GetService("StarterGui").EndUI.UI.Replay)
        end
    end)

end


if game.PlaceId == 6593190090 then

    spawn(function()
        if getgenv().AutoSkip == true then 
            local args = {
                [1] = "AutoSkip"
            }
            game:GetService("ReplicatedStorage").Remote.Setting:FireServer(unpack(args))
        end
    end)

    spawn(function()
        if getgenv().Auto3xSpeed == true then
            local args = {
                [1] = "x2 Speed"
            }
            game:GetService("ReplicatedStorage").Remote.x2Event:FireServer(unpack(args))
        end
    end)

    spawn(function()
        if getgenv().AutoFirstSkip == true then
            game:GetService("ReplicatedStorage").Remote.SkipEvent:FireServer()
        end
    end)

    spawn(function()
        while getgenv().AutoReplay == true do
            click(game:GetService("StarterGui").EndUI.UI.Replay)
            wait(1)
        end
    end)

    spawn(function()
        if getgenv().AutoPlaceUnit == true then
            local args = {
                [1] = "Killer",
                [2] = CFrame.new(x, y, z) * CFrame.Angles(-0, 0, -0),
                [3] = 1,
                [4] = {
                    [1] = "1",
                    [2] = "1",
                    [3] = "1",
                    [4] = "1"
                }
            }
            game:GetService("ReplicatedStorage").Remote.SpawnUnit:InvokeServer(unpack(args))
        end
    end)

    spawn(function()
        if getgenv().AutoUpgradeP1 == true then
            wait(5)
            local args = {
                [1] = workspace.Units.Killer
            }
            game:GetService("ReplicatedStorage").Remote.UpgradeUnit:InvokeServer(unpack(args))
        end
    end)

        spawn(function()
        if getgenv().AutoUpgradeP2 == true then
            wait(5)
            local args = {
                [1] = workspace.Units.Killer
            }
            game:GetService("ReplicatedStorage").Remote.UpgradeUnit:InvokeServer(unpack(args))
        end
    end)

    spawn(function()
        while getgenv().AutoUpgrade == true do
            wait(1)
            local args = {
                [1] = workspace.Units.Killer
            }
            game:GetService("ReplicatedStorage").Remote.UpgradeUnit:InvokeServer(unpack(args))
            wait(1)
        end
    end)
end
