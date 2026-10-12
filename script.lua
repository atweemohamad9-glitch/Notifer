-- WNotifier Ultimate Alert Engine (Optimized Whitelist for Rare Fuse Brainrots)
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local StarterGui = game:GetService("StarterGui")
local SoundService = game:GetService("SoundService")
local LocalPlayer = Players.LocalPlayer

if CoreGui:FindFirstChild("WNotifierPrivateEngine") then
    CoreGui.WNotifierPrivateEngine:Destroy()
end

local WhitelistData = {
    -- Best Fuse Brainrots & High Rarity Secrets
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

    -- Classic OGs & Secrets
    ["Headless Horseman"] = true,
    ["John Pork"] = true,
    ["Meowl"] = true,
    ["Skibidi Toilet"] = true,
    ["Strawberry Elephant"] = true,
    ["Spyder Elephant"] = true,
    ["Brainrot"] = true,
    ["Secret"] = true,
    ["OG"] = true
}

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "WNotifierPrivateEngine"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = (gethui and gethui()) or CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 500, 0, 260)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -130)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 20, 26)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 8)
MainCorner.Parent = MainFrame

local TopWindow = Instance.new("Frame")
TopWindow.Size = UDim2.new(1, 0, 0, 30)
TopWindow.BackgroundColor3 = Color3.fromRGB(12, 14, 18)
TopWindow.BorderSizePixel = 0
TopWindow.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Text = "🔔 WNotifier REALTIME NOTIFIER (Fuse Ready)"
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 13
Title.TextColor3 = Color3.fromRGB(46, 204, 113)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.Size = UDim2.new(0, 310, 1, 0)
Title.BackgroundTransparency = 1
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopWindow

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Text = "Listening for Fuse Secrets/OG..."
StatusLabel.Font = Enum.Font.SourceSans
StatusLabel.TextSize = 11
StatusLabel.TextColor3 = Color3.fromRGB(241, 196, 15)
StatusLabel.Position = UDim2.new(1, -210, 0, 0)
StatusLabel.Size = UDim2.new(0, 200, 1, 0)
StatusLabel.BackgroundTransparency = 1
StatusLabel.TextXAlignment = Enum.TextXAlignment.Right
StatusLabel.Parent = TopWindow

local LogsScroll = Instance.new("ScrollingFrame")
LogsScroll.Size = UDim2.new(1, -10, 1, -40)
LogsScroll.Position = UDim2.new(0, 5, 0, 35)
LogsScroll.BackgroundColor3 = Color3.fromRGB(14, 16, 22)
LogsScroll.BorderSizePixel = 0
LogsScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
LogsScroll.ScrollBarThickness = 3
LogsScroll.Parent = MainFrame

local ListLayoutLogs = Instance.new("UIListLayout")
ListLayoutLogs.SortOrder = Enum.SortOrder.LayoutOrder
ListLayoutLogs.Padding = UDim.new(0, 3)
ListLayoutLogs.Parent = LogsScroll

local function playAlertSound()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://4590662766"
    sound.Volume = 2
    sound.Parent = SoundService
    sound:Play()
    sound.Ended:Connect(function() sound:Destroy() end)
end

local function teleportToPosition(cframe)
    local myChar = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    if myChar and myChar:FindFirstChild("HumanoidRootPart") then
        myChar.HumanoidRootPart.Velocity = Vector3.zero
        myChar.HumanoidRootPart.CFrame = cframe * CFrame.new(0, 3, 0)
    end
end

local loggedEntries = {}

local function notifyUser(brainrotName, valStr, playerName, targetCFrame)
    local key = playerName .. "_" .. brainrotName
    if loggedEntries[key] then return end
    loggedEntries[key] = true

    playAlertSound()
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = "🚨 HIGH VALUE BRAINROT FOUND!",
            Text = brainrotName .. " (" .. valStr .. ") | Owner: " .. playerName,
            Duration = 6
        })
    end)

    StatusLabel.Text = "FOUND: " .. brainrotName
    StatusLabel.TextColor3 = Color3.fromRGB(46, 204, 113)

    local Row = Instance.new("Frame")
    Row.Size = UDim2.new(1, 0, 0, 30)
    Row.BackgroundColor3 = Color3.fromRGB(24, 28, 38)
    Row.BorderSizePixel = 0
    Row.Parent = LogsScroll

    local InfoLbl = Instance.new("TextLabel")
    InfoLbl.Size = UDim2.new(1, -75, 1, 0)
    InfoLbl.Position = UDim2.new(0, 8, 0, 0)
    InfoLbl.BackgroundTransparency = 1
    InfoLbl.Font = Enum.Font.SourceSansBold
    InfoLbl.TextSize = 11
    InfoLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    InfoLbl.TextXAlignment = Enum.TextXAlignment.Left
    InfoLbl.Text = "🔥 " .. brainrotName .. " (" .. valStr .. ") | @" .. playerName
    InfoLbl.Parent = Row

    local JoinBtn = Instance.new("TextButton")
    JoinBtn.Size = UDim2.new(0, 65, 0, 22)
    JoinBtn.Position = UDim2.new(1, -70, 0, 4)
    JoinBtn.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
    JoinBtn.Font = Enum.Font.SourceSansBold
    JoinBtn.TextSize = 10
    JoinBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
    JoinBtn.Text = "TELEPORT"
    JoinBtn.Parent = Row

    JoinBtn.MouseButton1Click:Connect(function()
        if targetCFrame then teleportToPosition(targetCFrame) end
    end)

    LogsScroll.CanvasSize = UDim2.new(0, 0, 0, ListLayoutLogs.AbsoluteContentSize.Y + 10)
end

local function checkObject(v)
    local vNameLower = string.lower(v.Name)
    for name, isWhitelisted in pairs(WhitelistData) do
        if isWhitelisted then
            local nameLower = string.lower(name)
            if string.find(vNameLower, nameLower) or v.Name == name then
                local moneyVal = "Secret/Fuse"
                local ownerName = "Server"
                local targetCFrame = nil

                if v:IsA("BasePart") then
                    targetCFrame = v.CFrame
                elseif v:IsA("Model") then
                    if v.PrimaryPart then
                        targetCFrame = v.PrimaryPart.CFrame
                    else
                        local p = v:FindFirstChildWhichIsA("BasePart")
                        if p then targetCFrame = p.CFrame end
                    end
                end

                local valObj = v:FindFirstChild("Value") or v:FindFirstChild("Money") or v:FindFirstChild("Price")
                if valObj then moneyVal = tostring(valObj.Value) end

                local ownerObj = v:FindFirstChild("Owner") or (v.Parent and v.Parent:FindFirstChild("Owner"))
                if ownerObj then ownerName = tostring(ownerObj.Value) end

                if targetCFrame then
                    notifyUser(v.Name, moneyVal, ownerName, targetCFrame)
                end
            end
        end
    end
end

task.spawn(function()
    for _, v in ipairs(Workspace:GetDescendants()) do
        checkObject(v)
    end
end)

Workspace.DescendantAdded:Connect(function(v)
    task.spawn(checkObject, v)
end)
