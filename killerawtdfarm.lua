repeat wait() until game:IsLoaded()
wait(1)

--settings
getgenv().AutoPlaceUnit = true
getgenv().AutoFirstSkip = true
getgenv().AutoReplay = true
getgenv().AutoJoinGame = true
getgenv().AutoBuyFood = true
getgenv().AutoFeed = true
getgenv().AutoBuffPicker = true
getgenv().AutoUpgrade2x = true

--get currunt cords to place unit on urself
local x = game.Players.LocalPlayer.Character.Torso.Position.x
local y = game.Players.LocalPlayer.Character.Torso.Position.y
local z = game.Players.LocalPlayer.Character.Torso.Position.z

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
            local args = {
                [1] = {
                    ["StageSelect"] = "Fairy Camelot",
                    ["Image"] = "rbxassetid://124277693193734",
                    ["FriendOnly"] = true,
                    ["Difficult"] = "Master"
                }
            }

            game:GetService("ReplicatedStorage").Remote.CreateRoom:FireServer(unpack(args))
            
            wait(0.5)
            
            clickUI(game:GetService("Players").LocalPlayer.PlayerGui.InRoomUi.RoomUI.QuickStart.TextButton)
        end
    end)

end

--auto place, upgrade, replay, speedup, start
if game.PlaceId == 6593190090 then

    local guiElement = game.Players.LocalPlayer.PlayerGui.EndUI.UI
    local yGui = guiElement.Position.Y

    --auto place unit of choice on your cords(can be changed if you know the x, y and z)
    spawn(function()
        while getgenv().AutoPlaceUnit == true do
            local args = {
                [1] = "Legendary Kroly",
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
            wait(1)
        end
    end)

    --upgrade unit for each local args set
    spawn(function()
        while getgenv().AutoUpgrade2x == true do
            local args = {
                [1] = workspace.Units:FindFirstChild("Legendary Kroly")
            }
            
            game:GetService("ReplicatedStorage").Remote.UpgradeUnit:InvokeServer(unpack(args))
            wait(1)
        end
    end)

    --auto first & open buy menu
    spawn(function()
        while getgenv().AutoFirstSkip == true do
            game:GetService("ReplicatedStorage").Remote.SkipEvent:FireServer()
        end
    end)

    --auto Buy Food
    spawn(function()
        while getgenv().AutoBuyFood == true do
            wait(10)
            local args = {
                [1] = 10
            }
            
            game:GetService("ReplicatedStorage").Remote.BuyMeat:InvokeServer(unpack(args))            
        end
    end)

    --auto Feed
    spawn(function()
        while getgenv().AutoFeed == true do
            wait(6)
            game:GetService("ReplicatedStorage").Remote.FeedAll:InvokeServer()
        end
    end)

    --auto buff picker doesnt work
    spawn(function()
        while getgenv().AutoBuffPicker == true do
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
end
