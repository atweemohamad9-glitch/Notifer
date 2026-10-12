-- WNotifier Real-Time SNIPER Engine (Instant TP on Rare/OG Spawn)
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

if CoreGui:FindFirstChild("WNotifierPrivateEngine") then
    CoreGui.WNotifierPrivateEngine:Destroy()
end

local WhitelistData = {
    ["Headless Horseman"] = true,
    ["John Pork"] = true,
    ["Meowl"] = true,
    ["Skibidi Toilet"] = true,
    ["Strawberry Elephant"] = true,
    ["Spyder Elephant"] = true,
    ["Arcadragon"] = true,
    ["Griffin"] = true,
    ["Garama and Madundung"] = true,
    ["Dragon Skeletonini"] = true,
    ["Brainrot"] = true,
    ["Secret"] = true,
    ["OG"] = true
}

local AutoSnipeEnabled = true
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "WNotifierPrivateEngine"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = (gethui and gethui()) or CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 480, 0, 240)
MainFrame.Position = UDim2.new(0.5, -240, 0.5, -120)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 22, 28)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 8)
MainCorner.Parent = MainFrame

local TopWindow = Instance.new("Frame")
TopWindow.Size = UDim2.new(1, 0, 0, 28)
TopWindow.BackgroundColor3 = Color3.fromRGB(15, 17, 22)
TopWindow.BorderSizePixel = 0
TopWindow.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Text = "⚡ WNotifier SNIPER Active"
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 13
Title.TextColor3 = Color3.fromRGB(46, 204, 113)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.Size = UDim2.new(0, 250, 1, 0)
Title.BackgroundTransparency = 1
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopWindow

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Text = "Waiting for Secret/OG Spawn..."
StatusLabel.Font = Enum.Font.SourceSans
StatusLabel.TextSize = 12
StatusLabel.TextColor3 = Color3.fromRGB(241, 196, 15)
StatusLabel.Position = UDim2.new(1, -210, 0, 0)
StatusLabel.Size = UDim2.new(0, 200, 1, 0)
StatusLabel.BackgroundTransparency = 1
StatusLabel.TextXAlignment = Enum.TextXAlignment.Right
StatusLabel.Parent = TopWindow

local LogsScroll = Instance.new("ScrollingFrame")
LogsScroll.Size = UDim2.new(1, -10, 1, -38)
LogsScroll.Position = UDim2.new(0, 5, 0, 34)
LogsScroll.BackgroundColor3 = Color3.fromRGB(18, 20, 25)
LogsScroll.BorderSizePixel = 0
LogsScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
LogsScroll.ScrollBarThickness = 3
LogsScroll.Parent = MainFrame

local ListLayoutLogs = Instance.new("UIListLayout")
ListLayoutLogs.SortOrder = Enum.SortOrder.LayoutOrder
ListLayoutLogs.Padding = UDim.new(0, 2)
ListLayoutLogs.Parent = LogsScroll

local function teleportToPosition(cframe)
    local myChar = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    if myChar and myChar:FindFirstChild("HumanoidRootPart") then
        myChar.HumanoidRootPart.CFrame = cframe * CFrame.new(0, 0, 3)
    end
end

local loggedEntries = {}

local function addLogEntry(brainrotName, valStr, playerName, targetCFrame)
    local key = playerName .. "_" .. brainrotName
    if loggedEntries[key] then return end
    loggedEntries[key] = true

    local Row = Instance.new("Frame")
    Row.Size = UDim2.new(1, 0, 0, 28)
    Row.BackgroundColor3 = Color3.fromRGB(25, 28, 36)
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
    InfoLbl.Text = "🎯 SNIPED: " .. brainrotName .. " (" .. valStr .. ") | " .. playerName
    InfoLbl.Parent = Row

    local JoinBtn = Instance.new("TextButton")
    JoinBtn.Size = UDim2.new(0, 65, 0, 20)
    JoinBtn.Position = UDim2.new(1, -70, 0, 4)
    JoinBtn.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
    JoinBtn.Font = Enum.Font.SourceSansBold
    JoinBtn.TextSize = 10
    JoinBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
    JoinBtn.Text = "TP NOW"
    JoinBtn.Parent = Row

    JoinBtn.MouseButton1Click:Connect(function()
        if targetCFrame then
            teleportToPosition(targetCFrame)
        end
    end)

    LogsScroll.CanvasSize = UDim2.new(0, 0, 0, ListLayoutLogs.AbsoluteContentSize.Y + 10)
end

local function checkAndSnipe(v)
    for name, isWhitelisted in pairs(WhitelistData) do
        if isWhitelisted and (string.find(string.lower(v.Name), string.lower(name)) or v.Name == name) then
            local moneyVal = "Secret/OG"
            local ownerName = "Server"
            local targetCFrame = nil

            if v:IsA("BasePart") then
                targetCFrame = v.CFrame
            elseif v:IsA("Model") and v.PrimaryPart then
                targetCFrame = v.PrimaryPart.CFrame
            elseif v:IsA("Model") then
                local part = v:FindFirstChildWhichIsA("BasePart")
                if part then targetCFrame = part.CFrame end
            end

            local valObj = v:FindFirstChild("Value") or v:FindFirstChild("Money") or v:FindFirstChild("Price")
            if valObj then moneyVal = tostring(valObj.Value) end

            local ownerObj = v:FindFirstChild("Owner") or (v.Parent and v.Parent:FindFirstChild("Owner"))
            if ownerObj then ownerName = tostring(ownerObj.Value) end

            if targetCFrame then
                StatusLabel.Text = "SNIPED: " .. v.Name
                StatusLabel.TextColor3 = Color3.fromRGB(46, 204, 113)
                addLogEntry(v.Name, moneyVal, ownerName, targetCFrame)
                
                if AutoSnipeEnabled then
                    teleportToPosition(targetCFrame)
                end
            end
        end
    end
end

-- فحص أولي لكل الموجود حالياً
for _, v in ipairs(Workspace:GetDescendants()) do
    checkAndSnipe(v)
end

-- مراقبة فورية لأي شي جديد بينزل بالـ Workspace (حتى لو بعد ما فات شخص أو نزل العنصر)
Workspace.DescendantAdded:Connect(function(v)
    task.spawn(function()
        checkAndSnipe(v)
    end)
end)
