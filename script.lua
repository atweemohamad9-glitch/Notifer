-- Ches get sniped - 100% Buffed Steal Engine (Pure English)
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local StarterGui = game:GetService("StarterGui")
local SoundService = game:GetService("SoundService")
local LocalPlayer = Players.LocalPlayer

if CoreGui:FindFirstChild("ChesGetSnipedEngine") then
    CoreGui.ChesGetSnipedEngine:Destroy()
end

local AutoTPEnabled = true

local WhitelistData = {
    -- Rare Secrets & Fuse Targets
    ["Garama and Madundung"] = true,
    ["Garama"] = true,
    ["Madundung"] = true,
    ["Celestial Pegasus"] = true,
    ["Capitano Moby"] = true,
    ["La Secret Combinasion"] = true,
    ["Dragon Skeletonini"] = true,
    ["Arcadragon"] = true,
    ["Griffin"] = true,

    -- DLC & Code Exclusives
    ["Pineaplino"] = true,
    ["Lazy Ducky"] = true,
    ["Tenini Ballini"] = true,
    ["Globa Steppa"] = true,
    ["Rico Dinero"] = true,
    ["Polaroidini"] = true,
    ["Grabatron"] = true,
    ["Pancake and Syrup"] = true,
    ["Boppin Bunny"] = true,
    ["Festive 67"] = true,
    ["Chicleteira Surfeiteira"] = true,
    ["Dragon Cannelloni"] = true,
    ["Kraken"] = true,
    ["Rocketini Frostini"] = true,
    ["Frullato Framingo"] = true,
    ["Waverider"] = true,
    ["Pizza And Ranch"] = true,

    -- OG Classics
    ["Meowl"] = true,
    ["Headless Horseman"] = true,
    ["John Pork"] = true,
    ["Skibidi Toilet"] = true,
    ["Strawberry Elephant"] = true,
    ["Spyder Elephant"] = true
}

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ChesGetSnipedEngine"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = (gethui and gethui()) or CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 520, 0, 280)
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -140)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 20, 26)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 8)
MainCorner.Parent = MainFrame

local TopWindow = Instance.new("Frame")
TopWindow.Size = UDim2.new(1, 0, 0, 35)
TopWindow.BackgroundColor3 = Color3.fromRGB(12, 14, 18)
TopWindow.BorderSizePixel = 0
TopWindow.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Text = "⚡ CHES GET SNIPED [100% BUFF]"
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 13
Title.TextColor3 = Color3.fromRGB(46, 204, 113)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.Size = UDim2.new(0, 260, 1, 0)
Title.BackgroundTransparency = 1
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopWindow

-- Toggle Button (AUTO TP: ON / OFF)
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 95, 0, 24)
ToggleBtn.Position = UDim2.new(1, -105, 0, 5)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.TextSize = 11
ToggleBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
ToggleBtn.Text = "AUTO TP: ON"
ToggleBtn.Parent = TopWindow

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 4)
ToggleCorner.Parent = ToggleBtn

ToggleBtn.MouseButton1Click:Connect(function()
    AutoTPEnabled = not AutoTPEnabled
    if AutoTPEnabled then
        ToggleBtn.Text = "AUTO TP: ON"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
    else
        ToggleBtn.Text = "AUTO TP: OFF"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(231, 76, 60)
    end
end)

local LogsScroll = Instance.new("ScrollingFrame")
LogsScroll.Size = UDim2.new(1, -10, 1, -45)
LogsScroll.Position = UDim2.new(0, 5, 0, 40)
LogsScroll.BackgroundColor3 = Color3.fromRGB(14, 16, 22)
LogsScroll.BorderSizePixel = 0
LogsScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
LogsScroll.ScrollBarThickness = 3
LogsScroll.Parent = MainFrame

local ListLayoutLogs = Instance.new("UIListLayout")
ListLayoutLogs.SortOrder = Enum.SortOrder.LayoutOrder
ListLayoutLogs.Padding = UDim.new(0, 4)
ListLayoutLogs.Parent = LogsScroll

local function playAlertSound()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://4590662766"
    sound.Volume = 25
    sound.Parent = SoundService
    sound:Play()
    sound.Ended:Connect(function() sound:Destroy() end)
end

local function performTeleport(cframe)
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if hrp and cframe then
        hrp.Velocity = Vector3.zero
        hrp.CFrame = cframe * CFrame.new(0, 3, 2)
    end
end

local loggedKeys = {}

local function addLogAndTeleport(brainrotName, ownerUser, priceVal, targetCFrame)
    local key = ownerUser .. "_" .. brainrotName
    if loggedKeys[key] then return end
    loggedKeys[key] = true

    playAlertSound()

    if AutoTPEnabled and targetCFrame then
        performTeleport(targetCFrame)
    end

    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = "🎯 CHES SNIPED TARGET!",
            Text = brainrotName .. " | Owner: " .. ownerUser .. " | " .. priceVal,
            Duration = 6
        })
    end)

    local Row = Instance.new("Frame")
    Row.Size = UDim2.new(1, 0, 0, 32)
    Row.BackgroundColor3 = Color3.fromRGB(24, 28, 38)
    Row.BorderSizePixel = 0
    Row.Parent = LogsScroll

    local InfoLbl = Instance.new("TextLabel")
    InfoLbl.Size = UDim2.new(1, -80, 1, 0)
    InfoLbl.Position = UDim2.new(0, 8, 0, 0)
    InfoLbl.BackgroundTransparency = 1
    InfoLbl.Font = Enum.Font.SourceSansBold
    InfoLbl.TextSize = 11
    InfoLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    InfoLbl.TextXAlignment = Enum.TextXAlignment.Left
    InfoLbl.Text = "🔥 " .. brainrotName .. " | @" .. ownerUser .. " | " .. priceVal
    InfoLbl.Parent = Row

    local TPBtn = Instance.new("TextButton")
    TPBtn.Size = UDim2.new(0, 68, 0, 24)
    TPBtn.Position = UDim2.new(1, -73, 0, 4)
    TPBtn.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
    TPBtn.Font = Enum.Font.SourceSansBold
    TPBtn.TextSize = 10
    TPBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
    TPBtn.Text = "RE-TP"
    TPBtn.Parent = Row

    TPBtn.MouseButton1Click:Connect(function()
        if targetCFrame then performTeleport(targetCFrame) end
    end)

    LogsScroll.CanvasSize = UDim2.new(0, 0, 0, ListLayoutLogs.AbsoluteContentSize.Y + 10)
end

local function scanObject(v)
    for name, isWhitelisted in pairs(WhitelistData) do
        if isWhitelisted and string.lower(v.Name) == string.lower(name) then
            local priceVal = "Value: Rare"
            local ownerUser = "Server"
            local targetCFrame = nil

            if v:IsA("BasePart") then
                targetCFrame = v.CFrame
            elseif v:IsA("Model") then
                targetCFrame = v.PrimaryPart and v.PrimaryPart.CFrame or (v:FindFirstChildWhichIsA("BasePart") and v:FindFirstChildWhichIsA("BasePart").CFrame)
            end

            local valObj = v:FindFirstChild("Value") or v:FindFirstChild("Money") or v:FindFirstChild("Price")
            if valObj then priceVal = "$" .. tostring(valObj.Value) end

            local ownerObj = v:FindFirstChild("Owner") or (v.Parent and v.Parent:FindFirstChild("Owner"))
            if ownerObj then ownerUser = tostring(ownerObj.Value) end

            if targetCFrame then
                addLogAndTeleport(v.Name, ownerUser, priceVal, targetCFrame)
            end
        end
    end
end

local function scanPlayers()
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            local function checkContainer(cont)
                if not cont then return end
                for _, item in ipairs(cont:GetDescendants()) do
                    for name, isWhitelisted in pairs(WhitelistData) do
                        if isWhitelisted and string.lower(item.Name) == string.lower(name) then
                            if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                                addLogAndTeleport(item.Name, plr.Name, "In Inventory", plr.Character.HumanoidRootPart.CFrame)
                            end
                        end
                    end
                end
            end
            if plr.Character then checkContainer(plr.Character) end
            if plr.Backpack then checkContainer(plr.Backpack) end
        end
    end
end

-- Buffed Fast Loop (0.1s)
task.spawn(function()
    while task.wait(0.1) do
        for _, v in ipairs(Workspace:GetDescendants()) do
            scanObject(v)
        end
        scanPlayers()
    end
end)
