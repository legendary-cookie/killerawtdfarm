repeat wait() until game:IsLoaded()

--auto tp, replay and play
getgenv().AutoPlaceUnit = true
getgenv().AutoFirstSkip = true
getgenv().Auto3xSpeed = true
getgenv().AutoUpgrade2x = true
getgenv().AutoUpgrade = false
getgenv().AutoReplay = true
getgenv().AutoJoinGame = true
getgenv().AutoBuyFood = true
getgenv().AutoFeed = true
getgenv().AutoBuffPicker = true

--get currunt cords to place unit on urself
local x = game.Players.LocalPlayer.Character.Torso.Position.x
local y = game.Players.LocalPlayer.Character.Torso.Position.y
local z = game.Players.LocalPlayer.Character.Torso.Position.z

--auto join in lobby
if game.PlaceId == 6558526079 then

    spawn(function()
        if getgenv().AutoJoinGame == true then 
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
            
            function clickUI(gui)
                local GuiService = game:GetService("GuiService")
                local VirtualInputManager = game:GetService("VirtualInputManager")
            
                GuiService.SelectedObject = (gui)
            
                VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
                task.wait(0.1)
                VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
            end
            
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

    --auto first skip/start game
    spawn(function()
        if getgenv().AutoFirstSkip == true then
            game:GetService("ReplicatedStorage").Remote.SkipEvent:FireServer()
        end
    end)

    --auto Buy Food
    spawn(function()
        while getgenv().AutoBuyFood == true do
            wait(20)
            function clickUI(gui)
                local GuiService = game:GetService("GuiService")
                local VirtualInputManager = game:GetService("VirtualInputManager")
            
                GuiService.SelectedObject = (gui)
            
                VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
                task.wait(0.1)
                VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
            end
            
            clickUI(game:GetService("Players").LocalPlayer.PlayerGui.InterFace.BuyMeatMenu.Menu.Buy10)
        end
    end)

    --auto Feed
    spawn(function()
        while getgenv().AutoFeed == true do
            wait(3)
            function clickUI(gui)
                local GuiService = game:GetService("GuiService")
                local VirtualInputManager = game:GetService("VirtualInputManager")
                
                GuiService.SelectedObject = (gui)
                
                VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
                task.wait(0.1)
                VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
            end
                
            clickUI(game:GetService("Players").LocalPlayer.PlayerGui.InterFace.Selection.FeedAll)
        end
    end)

    --auto bUff picker
    spawn(function()
        while getgenv().BuffPicker == true do
            function clickUI(gui)
                local GuiService = game:GetService("GuiService")
                local VirtualInputManager = game:GetService("VirtualInputManager")
                    
                GuiService.SelectedObject = (gui)
                    
                VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
                task.wait(0.1)
                VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
            end
                    
            clickUI(game:GetService("Players").LocalPlayer.PlayerGui.BuffInterFace.BuffSelection.List.ATK.Pick) --ATK can change to RNG, ElemntPower or Tamer
            wait(1)
        end
    end)

    --auto replay
    spawn(function()
        while getgenv().AutoReplay == true do
            function clickUI(gui)
                local GuiService = game:GetService("GuiService")
                local VirtualInputManager = game:GetService("VirtualInputManager")
            
                GuiService.SelectedObject = (gui)
            
                VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
                task.wait(0.1)
                VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
            end
            
            clickUI(game:GetService("Players").LocalPlayer.PlayerGui.EndUI.UI.ReplayS)
            wait(5)
        end
    end)

    --auto place unit of choice on your cords(can be changed if you know the x, y and z)
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

    --upgrade unit for each local args set
    spawn(function()
        if getgenv().AutoUpgrade2x == true then
            wait(15)
            local args = {
                [1] = workspace.Units.Killer
            }
            game:GetService("ReplicatedStorage").Remote.UpgradeUnit:InvokeServer(unpack(args))

            wait(10)

            local args = {
                [1] = workspace.Units.Killer
            }
            game:GetService("ReplicatedStorage").Remote.UpgradeUnit:InvokeServer(unpack(args))
        end
    end)

    --spam upgrade of selected unit
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
