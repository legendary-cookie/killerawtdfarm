repeat wait() until game:IsLoaded()

-- Auto options
getgenv().Settings = {
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

-- Get current coordinates to place unit
local player = game.Players.LocalPlayer
local position = player.Character.Torso.Position

-- Helper function to click a UI element
local function clickUI(gui)
    local GuiService = game:GetService("GuiService")
    local VirtualInputManager = game:GetService("VirtualInputManager")

    GuiService.SelectedObject = gui
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
    task.wait(0.1)
    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
end

-- Auto-join in lobby
if game.PlaceId == 6558526079 then
    spawn(function()
        if getgenv().Settings.AutoJoinGame then
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
            clickUI(player.PlayerGui.InRoomUi.RoomUI.QuickStart.TextButton)
        end
    end)
end

-- Game-specific automation
if game.PlaceId == 6593190090 then
    -- Auto 3x speed
    spawn(function()
        if getgenv().Settings.Auto3xSpeed then
            game:GetService("ReplicatedStorage").Remote.x2Event:FireServer("x2 Speed")
        end
    end)

    -- Auto first skip/start
    spawn(function()
        if getgenv().Settings.AutoFirstSkip then
            game:GetService("ReplicatedStorage").Remote.SkipEvent:FireServer()
        end
    end)

    -- Auto Buy Food
    spawn(function()
        while getgenv().Settings.AutoBuyFood do
            wait(20)
            clickUI(player.PlayerGui.InterFace.BuyMeatMenu.Menu.Buy10)
        end
    end)

    -- Auto Feed
    spawn(function()
        while getgenv().Settings.AutoFeed do
            wait(3)
            clickUI(player.PlayerGui.InterFace.Selection.FeedAll)
        end
    end)

    -- Auto Buff Picker
    spawn(function()
        while getgenv().Settings.AutoBuffPicker do
            clickUI(player.PlayerGui.BuffInterFace.BuffSelection.List.ATK.Pick) -- ATK can change to RNG, ElementPower, or Tamer
            wait(1)
        end
    end)

    -- Auto Replay
    spawn(function()
        while getgenv().Settings.AutoReplay do
            clickUI(player.PlayerGui.EndUI.UI.Replay)
            wait(5)
        end
    end)

    -- Auto Place Unit
    spawn(function()
        if getgenv().Settings.AutoPlaceUnit then
            local args = {
                [1] = "Killer",
                [2] = CFrame.new(position.x, position.y, position.z),
                [3] = 1,
                [4] = {"1", "1", "1", "1"}
            }
            game:GetService("ReplicatedStorage").Remote.SpawnUnit:InvokeServer(unpack(args))
        end
    end)

    -- Auto Upgrade Units
    local function upgradeUnit()
        local args = {[1] = workspace.Units.Killer}
        game:GetService("ReplicatedStorage").Remote.UpgradeUnit:InvokeServer(unpack(args))
    end

    spawn(function()
        if getgenv().Settings.AutoUpgrade2x then
            wait(15)
            upgradeUnit()
            wait(10)
            upgradeUnit()
        end
    end)

    spawn(function()
        while getgenv().Settings.AutoUpgrade do
            upgradeUnit()
            wait(1)
        end
    end)
end
