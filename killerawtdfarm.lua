repeat wait() until game:IsLoaded()

-- Auto settings
local settings = {
    AutoPlaceUnit = true,
    AutoFirstSkip = true,
    Auto3xSpeed = true,
    AutoUpgrade2x = true,
    AutoUpgrade = false,
    AutoReplay = true,
    AutoJoinGame = true,
    AutoBuyFood = true,
    AutoFeed = true,
    AutoBuffPicker = true
}

-- Get current coordinates for unit placement
local player = game.Players.LocalPlayer
local x, y, z = player.Character.Torso.Position.x, player.Character.Torso.Position.y, player.Character.Torso.Position.z

-- Function to handle UI clicks
local function clickUI(guiPath)
    local GuiService = game:GetService("GuiService")
    local VirtualInputManager = game:GetService("VirtualInputManager")
    GuiService.SelectedObject = guiPath
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
    task.wait(0.1)
    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
end

-- Auto join lobby
if game.PlaceId == 6558526079 then
    spawn(function()
        if settings.AutoJoinGame then
            local args = {
                [1] = {
                    StageSelect = "Evil Pink Dungeon",
                    Image = "rbxassetid://15289588795",
                    FriendOnly = true,
                    Difficult = "Nightmare"
                }
            }
            game:GetService("ReplicatedStorage").Remote.CreateRoom:FireServer(unpack(args))
            wait(1)
            clickUI(player.PlayerGui.InRoomUi.RoomUI.QuickStart.TextButton)
        end
    end)
end

-- In-game auto actions
if game.PlaceId == 6593190090 then
    -- Auto speed
    spawn(function()
        if settings.Auto3xSpeed then
            local args = { "x2 Speed" }
            game:GetService("ReplicatedStorage").Remote.x2Event:FireServer(unpack(args))
        end
    end)

    -- Auto first skip
    spawn(function()
        if settings.AutoFirstSkip then
            game:GetService("ReplicatedStorage").Remote.SkipEvent:FireServer()
        end
    end)

    -- Auto Buy Food
    spawn(function()
        while settings.AutoBuyFood do
            wait(20)
            clickUI(player.PlayerGui.InterFace.BuyMeatMenu.Menu.Buy10)
        end
    end)

    -- Auto Feed
    spawn(function()
        while settings.AutoFeed do
            wait(3)
            clickUI(player.PlayerGui.InterFace.Selection.FeedAll)
        end
    end)

    -- Auto Buff Picker
    spawn(function()
        while settings.AutoBuffPicker do
            clickUI(player.PlayerGui.BuffInterFace.BuffSelection.List.ATK.Pick) -- Adjust for different buffs as needed
            wait(1)
        end
    end)

    -- Auto Replay
    spawn(function()
        while settings.AutoReplay do
            clickUI(player.PlayerGui.EndUI.UI.Replay)
            wait(5)
        end
    end)

    -- Auto place unit at saved coordinates
    spawn(function()
        if settings.AutoPlaceUnit then
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

    -- Auto Upgrade (2x)
    spawn(function()
        if settings.AutoUpgrade2x then
            wait(15)
            local args = { workspace.Units.Killer }
            game:GetService("ReplicatedStorage").Remote.UpgradeUnit:InvokeServer(unpack(args))
            wait(10)
            game:GetService("ReplicatedStorage").Remote.UpgradeUnit:InvokeServer(unpack(args))
        end
    end)

    -- Spam upgrade unit
    spawn(function()
        while settings.AutoUpgrade do
            wait(1)
            local args = { workspace.Units.Killer }
            game:GetService("ReplicatedStorage").Remote.UpgradeUnit:InvokeServer(unpack(args))
        end
    end)
end
