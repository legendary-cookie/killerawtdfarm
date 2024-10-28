repeat wait() until game:IsLoaded()
wait(5)
getgenv().AutoPlaceUnit = true
getgenv().AutoSkip = false
getgenv().AutoFirstSkip = true
getgenv().Auto3xSpeed = true
getgenv().AutoUpgrade2x = true

local x = game.Players.LocalPlayer.Character.Torso.Position.x
local y = game.Players.LocalPlayer.Character.Torso.Position.y
local z = game.Players.LocalPlayer.Character.Torso.Position.z


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
        if getgenv().AutoUpgrade2x == true then
            wait(12)
            local args = {
                [1] = workspace.Units.Killer
            }
            game:GetService("ReplicatedStorage").Remote.UpgradeUnit:InvokeServer(unpack(args))

            wait(7)

            local args = {
                [1] = workspace.Units.Killer
            }
            game:GetService("ReplicatedStorage").Remote.UpgradeUnit:InvokeServer(unpack(args))
        end
    end)

end
