repeat wait() until game:IsLoaded()
wait(5)

-- settings
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

-- get current coordinates for placing unit
local x = game.Players.LocalPlayer.Character.Torso.Position.x
local y = game.Players.LocalPlayer.Character.Torso.Position.y
local z = game.Players.LocalPlayer.Character.Torso.Position.z

function clickUI(gui)
    local GuiService = game:GetService("GuiService")
    local VirtualInputManager = game:GetService("VirtualInputManager")

    -- Check if the gui is valid
    if gui then
        GuiService.SelectedObject = gui
        print("Clicking UI element:", gui.Name)

        -- Simulate key press and release with a longer delay if needed
        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
        task.wait(0.2)
        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
    else
        warn("GUI element not found or invalid")
    end
end

-- Auto join in lobby
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

            -- Click QuickStart button
            local quickStartButton = game:GetService("Players").LocalPlayer.PlayerGui.InRoomUi.RoomUI.QuickStart.TextButton
            clickUI(quickStartButton)
        end
    end)
end

-- Auto place, upgrade, replay, speedup, start
if game.PlaceId == 6593190090 then

    -- Auto 3x speed
    spawn(function()
        if getgenv().Auto3xSpeed == true then
            local args = { [1] = "x2 Speed" }
            game:GetService("ReplicatedStorage").Remote.x2Event:FireServer(unpack(args))
        end
    end)

    -- Auto place unit at specified coordinates
    spawn(function()
        if getgenv().AutoPlaceUnit == true then
            local args = {
                [1] = "Killer",
                [2] = CFrame.new(x, y, z),
                [3] = 1,
                [4] = { "1", "1", "1", "1" }
            }
            game:GetService("ReplicatedStorage").Remote.SpawnUnit:InvokeServer(unpack(args))
        end
    end)

    -- Auto first skip/start game
    spawn(function()
        if getgenv().AutoFirstSkip == true then
            game:GetService("ReplicatedStorage").Remote.SkipEvent:FireServer()
        end
    end)

    -- Auto buy food every 20 seconds
    spawn(function()
        while getgenv().AutoBuyFood do
            wait(20)
            local buyFoodButton = game:GetService("Players").LocalPlayer.PlayerGui.InterFace.BuyMeatMenu.Menu.Buy10
            clickUI(buyFoodButton)
        end
    end)

    -- Auto feed every 5 seconds
    spawn(function()
        while getgenv().AutoFeed do
            wait(5)
            local feedButton = game:GetService("Players").LocalPlayer
