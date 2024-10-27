repeat wait() until game:IsLoaded()
wait(8)
getgenv().AutoPlaceUnit = true
getgenv().AutoSellRedHair = true
getgenv().AutoSkip = true
getgenv().AutoFirstSkip = true
getgenv().AutoTPToUnit = true
getgenv().Auto3xSpeed = true
getgenv().AutoUpgradex2 = true

if game.PlaceId == 6593190090 then

x = game.Players.LocalPlayer.Character.Torso.Position.x
y = game.Players.LocalPlayer.Character.Torso.Position.y
z = game.Players.LocalPlayer.Character.Torso.Position.z 

spawn(function()
    if getgenv().AutoTPToUnit == true
        then game.Players.LocalPlayer.Character:MoveTo(Vector3.new(x, y, z))
    end
end)

spawn(function()
    if getgenv().AutoSkip == true
        then 
    local args = {
        [1] = "AutoSkip"
    }

    game:GetService("ReplicatedStorage").Remote.Setting:FireServer(unpack(args))
    end
end)

spwan(function ()
    if getgenv().Auto3xSpeed == true
    then
    local args = {
        [1] = "x2 Speed"
    }

    game:GetService("ReplicatedStorage").Remote.x2Event:FireServer(unpack(args))
        end
end)

spawn(function()
    if getgenv().AutoFirstSkip == true
    then
game:GetService("ReplicatedStorage").Remote.SkipEvent:FireServer()
    end
end)

spawn(function()
    if getgenv().AutoPlaceUnit == true
    then
    local args = {
        [1] = "Killer [Sister]",
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
    if getgenv().AutoUpgradex2 == true
    then
    wait(5)
    local args = {
        [1] = workspace.Units.Killer[Sister]
    }

    game:GetService("ReplicatedStorage").Remote.UpgradeUnit:InvokeServer(unpack(args))

    wait(5)

    local args = {
        [1] = workspace.Units.Killer[Sister]
    }

    game:GetService("ReplicatedStorage").Remote.UpgradeUnit:InvokeServer(unpack(args))
    end
end)
end
