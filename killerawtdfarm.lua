repeat wait() until game:IsLoaded()
wait(5)

--settings
getgenv().AutoPlaceUnit = true
getgenv().AutoFirstSkip = true
getgenv().Auto3xSpeed = true
getgenv().AutoUpgrade2x = true
getgenv().AutoReplay = true
getgenv().AutoJoinGame = true
getgenv().AutoBuyFood = true
getgenv().AutoFeed = true
getgenv().AutoBuffPicker = true

--get currunt cords to place unit on urself
local x = game.Players.LocalPlayer.Character.Torso.Position.x
local y = game.Players.LocalPlayer.Character.Torso.Position.y
local z = game.Players.LocalPlayer.Character.Torso.Position.z

local guiElement = game.Players.LocalPlayer.PlayerGui.EndUI.UI
local yGui = guiElement.Position.Y


function clickUI(gui)
    local GuiService = game:GetService("GuiService")
    local VirtualInputManager = game:GetService("VirtualInputManager")

    GuiService.SelectedObject = gui

    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
    task.wait(0.1)
    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
end

--auto join in lobby
if game.PlaceId == 6558526079 then

    spawn(function()
        if getgenv().AutoJoinGame == true then
            wait(1)
            local args = {
                [1] = {
                    ["StageSelect"] = "Evil Pink Dungeon",
                    ["Image"] = "rbxassetid://15289588795",
                    ["FriendOnly"] = true,
                    ["Difficult"] = "Nightmare"
                }
            }
            
            game:GetService("ReplicatedStorage").Remote.CreateRoom:FireServer(unpack(args))
            
            wait(1)
            
            clickUI(game:GetService("Players").LocalPlayer.PlayerGui.InRoomUi.RoomUI.QuickStart.TextButton)
        end
    end)

end

--auto place, upgrade, replay, speedup, start
if game.PlaceId == 6593190090 then

    --auto 3x(can be changed to 2x by changing x2 to x1 below)
    spawn(function()
        if getgenv().Auto3xSpeed == true then
            local args = {
                [1] = "x2 Speed"
            }
            game:GetService("ReplicatedStorage").Remote.x2Event:FireServer(unpack(args))
        end
    end)

    --auto place unit of choice on your cords(can be changed if you know the x, y and z)
    spawn(function()
        if getgenv().AutoPlaceUnit == true then
            local args = {
                [1] = "Denis",
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

    --auto first & open buy menu
    spawn(function()
        if getgenv().AutoFirstSkip == true then
            game:GetService("ReplicatedStorage").Remote.SkipEvent:FireServer()
            clickUI(game:GetService("Players").LocalPlayer.PlayerGui.InterFace.Equip.val.BuyMeat.Click)
        end
    end)

    --auto Buy Food
    spawn(function()
        while (getgenv().AutoBuyFood == true and game:GetService("Players").LocalPlayer.PlayerGui.InterFace.Equip.val.BuyMeat.Visible) do
            wait(20)
            clickUI(game:GetService("Players").LocalPlayer.PlayerGui.InterFace.BuyMeatMenu.Menu.Buy10)
        end
    end)

    --auto Feed
    spawn(function()
        while getgenv().AutoFeed == true do
            wait(6)
            game:GetService("ReplicatedStorage").Remote.FeedAll:InvokeServer()
        end
    end)

    --auto buff picker
    spawn(function()
        while getgenv().BuffPicker == true do
            if game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("BuffInterFace") then
                    clickUI(game:GetService("Players").LocalPlayer.PlayerGui.BuffInterFace.BuffSelection.List.ATK.Pick) --ATK can change to RNG, ElemntPower or Tamer
                    wait(1)
            end
        end
    end)

    --auto replay
    spawn(function()
        while getgenv().AutoReplay == true do
            guiElementN = game.Players.LocalPlayer.PlayerGui.EndUI.UI
            yGuiN = guiElement.Position.Y
            wait(1)
            if yGui ~= yGuiN then
                wait(2)
                clickUI(game:GetService("Players").LocalPlayer.PlayerGui.EndUI.UI.Replay)
            end
        end
    end)

    --upgrade unit for each local args set
    spawn(function()
        if getgenv().AutoUpgrade2x == true then
            wait(20)
            local args = {
                [1] = workspace.Units.Denis
            }
            game:GetService("ReplicatedStorage").Remote.UpgradeUnit:InvokeServer(unpack(args))

            wait(15)
            local args = {
                [1] = workspace.Units.Denis
            }
            game:GetService("ReplicatedStorage").Remote.UpgradeUnit:InvokeServer(unpack(args))
        end
    end)

end
