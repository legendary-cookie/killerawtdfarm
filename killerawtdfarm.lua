repeat wait() until game:IsLoaded()

-- Settings with ordered priority
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

-- Auto-join in lobby (highest priority)
if game.PlaceId == 6558526079 and getgenv().Settings.AutoJoinGame then
    spawn(function()
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
    end)
end

-- Game-specific automation in priority order
if game.PlaceId == 6593190090 then
    -- Flags to manage task completion order
    local tasks = {
        AutoJoinComplete = false,
        AutoPlaceComplete = false,
        Auto3xSpeedComplete = false,
        AutoFirstSkipComplete = false,
        AutoReplayComplete = false,
        AutoUpgrade2xComplete = false
    }

    -- Auto Place Unit
    spawn(function()
        if getgenv().Settings.AutoPlaceUnit then
            wait(2) -- Small delay to ensure game readiness
            local args = {
                [1] = "Killer",
                [2] = CFrame.new(position.x, position.y, position.z),
                [3] = 1,
                [4] = {"1", "1", "1", "1"}
            }
            game:GetService("ReplicatedStorage").Remote.SpawnUnit:InvokeServer(unpack(args))
            tasks.AutoPlaceComplete = true
        end
    end)

    -- Auto 3x Speed
    spawn(function()
        if getgenv().Settings.Auto3xSpeed then
            repeat wait() until tasks.AutoPlaceComplete
            game:GetService("ReplicatedStorage").Remote.x2Event:FireServer("x2 Speed")
            tasks.Auto3xSpeedComplete = true
        end
    end)

    -- Auto First Skip
    spawn(function()
        if getgenv().Settings.AutoFirstSkip then
            repeat wait() until tasks.Auto3xSpeedComplete
            game:GetService("ReplicatedStorage").Remote.SkipEvent:FireServer()
            tasks.AutoFirstSkipComplete = true
        end
    end)

    -- Auto Replay
    spawn(function()
        if getgenv().Settings.AutoReplay then
            repeat wait() until tasks.AutoFirstSkipComplete
            while getgenv().Settings.AutoReplay do
                clickUI(player.PlayerGui.EndUI.UI.Replay)
                wait(5)
            end
        end
    end)

    -- Auto Upgrade 2x
    local function upgradeUnit()
        local args = {[1] = workspace.Units.Killer}
        game:GetService("ReplicatedStorage").Remote.UpgradeUnit:InvokeServer(unpack(args))
    end

    spawn(function()
        if getgenv().Settings.AutoUpgrade2x then
            repeat wait() until tasks.AutoFirstSkipComplete
            wait(15)
            upgradeUnit()
            wait(10)
            upgradeUnit()
            tasks.AutoUpgrade2xComplete = true
        end
    end)

    -- Auto Upgrade
    spawn(function()
        if getgenv().Settings.AutoUpgrade then
            repeat wait() until tasks.AutoUpgrade2xComplete
            while getgenv().Settings.AutoUpgrade do
                upgradeUnit()
                wait(1)
            end
        end
    end)

    -- Auto Buff Picker
    spawn(function()
        if getgenv().Settings.AutoBuffPicker then
            repeat wait() until tasks.AutoUpgrade2xComplete
            while getgenv().Settings.AutoBuffPicker do
                clickUI(player.PlayerGui.BuffInterFace.BuffSelection.List.ATK.Pick) -- ATK can change to RNG, ElementPower, or Tamer
                wait(1)
            end
        end
    end)

    -- Auto Buy Food
    spawn(function()
        if getgenv().Settings.AutoBuyFood then
            repeat wait() until tasks.AutoBuffPickerComplete
            while getgenv().Settings.AutoBuyFood do
                wait(20)
                clickUI(player.PlayerGui.InterFace.BuyMeatMenu.Menu.Buy10)
            end
        end
    end)

    -- Auto Feed
    spawn(function()
        if getgenv().Settings.AutoFeed then
            repeat wait() until tasks.AutoBuyFoodComplete
            while getgenv().Settings.AutoFeed do
                wait(3)
                clickUI(player.PlayerGui.InterFace.Selection.FeedAll)
            end
        end
    end)
end
