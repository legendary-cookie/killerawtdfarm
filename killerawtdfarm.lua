repeat wait() until game:IsLoaded()

-- Global auto configuration
local autoConfig = {
    AutoPlaceUnit = true,
    AutoFirstSkip = true,
    Auto3xSpeed = true,
    AutoUpgrade2x = true,
    AutoUpgrade = false,
    AutoReplay = true,
    AutoJoinGame = true,
    AutoBuyFood = true,
    AutoFeed = true,
    AutoBuffPicker = true,
}

-- Helper function to simulate UI clicks
local function clickUI(guiPath)
    local GuiService = game:GetService("GuiService")
    local VirtualInputManager = game:GetService("VirtualInputManager")

    GuiService.SelectedObject = guiPath
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
    task.wait(0.1)
    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
end

-- Place unit at player position
local player = game.Players.LocalPlayer
local x, y, z = player.Character.Torso.Position:components()

-- Auto-join lobby
if game.PlaceId == 6558526079 and autoConfig.AutoJoinGame then
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

-- In-game auto functionalities
if game.PlaceId == 6593190090 then
    if autoConfig.Auto3xSpeed then
        spawn(function()
            game:GetService("ReplicatedStorage").Remote.x2Event:FireServer("x2 Speed")
        end)
    end

    if autoConfig.AutoFirstSkip then
        spawn(function()
            game:GetService("ReplicatedStorage").Remote.SkipEvent:FireServer()
        end)
    end

    if autoConfig.AutoBuyFood then
        spawn(function()
            while autoConfig.AutoBuyFood do
                wait(20)
                clickUI(player.PlayerGui.InterFace.BuyMeatMenu.Menu.Buy10)
            end
        end)
    end

    if autoConfig.AutoFeed then
        spawn(function()
            while autoConfig.AutoFeed do
                wait(3)
                clickUI(player.PlayerGui.InterFace.Selection.FeedAll)
            end
        end)
    end

    if autoConfig.AutoBuffPicker then
        spawn(function()
            while autoConfig.AutoBuffPicker do
                clickUI(player.PlayerGui.BuffInterFace.BuffSelection.List.ATK.Pick)
                wait(1)
            end
        end)
    end

    if autoConfig.AutoReplay then
        spawn(function()
            while autoConfig.AutoReplay do
                clickUI(player.PlayerGui.EndUI.UI.Replay)
                wait(5)
            end
        end)
    end

    if autoConfig.AutoPlaceUnit then
        spawn(function()
            local args = {
                [1] = "Killer",
                [2] = CFrame.new(x, y, z),
                [3] = 1,
                [4] = { "1", "1", "1", "1" }
            }
            game:GetService("ReplicatedStorage").Remote.SpawnUnit:InvokeServer(unpack(args))
        end)
    end

    if autoConfig.AutoUpgrade2x then
        spawn(function()
            local unit = workspace.Units.Killer
            wait(15)
            game:GetService("ReplicatedStorage").Remote.UpgradeUnit:InvokeServer(unit)
            wait(10)
            game:GetService("ReplicatedStorage").Remote.UpgradeUnit:InvokeServer(unit)
        end)
    end

    if autoConfig.AutoUpgrade then
        spawn(function()
            local unit = workspace.Units.Killer
            while autoConfig.AutoUpgrade do
                game:GetService("ReplicatedStorage").Remote.UpgradeUnit:InvokeServer(unit)
                wait(1)
            end
        end)
    end
end
