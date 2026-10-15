-- CHES GET SNIPED - ULTIMATE BUG-FREE ENGINE
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
    -- Secrets & Rare Fuses
    ["Garama and Madundung"] = true,
    ["Garama"] = true,
    ["Madundung"] = true,
    ["Celestial Pegasus"] = true,
    ["Capitano Moby"] = true,
    ["La Secret Combinasion"] = true,
    ["Dragon Skeletonini"] = true,
    ["Arcadragon"] = true,
    ["Griffin"] = true,

    -- DLCs & Codes
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

-- UI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ChesGetSnipedEngine"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = (gethui and gethui()) or CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 520, 0, 290)
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -145)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 22, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Thickness = 2
MainStroke.Color = Color3.fromRGB(46, 204, 113)
MainStroke.Parent = MainFrame

local TopWindow = Instance.new("Frame")
TopWindow.Size = UDim2.new(1, 0, 0, 40)
TopWindow.BackgroundColor3 = Color3.fromRGB(12, 15, 22)
TopWindow.BorderSizePixel = 0
TopWindow.Parent = MainFrame

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 10)
TopCorner.Parent = TopWindow

local Title = Instance.new("TextLabel")
Title.Text = "🎯 CHES GET SNIPED [ULTRA PRO]"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 13
Title.TextColor3 = Color3.fromRGB(46, 204, 113)
Title.Position = UDim2.new(0, 12, 0, 0)
Title.Size = UDim2.new(0, 260, 1, 0)
Title.BackgroundTransparency = 1
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopWindow

local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 110, 0, 28)
ToggleBtn.Position = UDim2.new(1, -120, 0, 6)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 11
ToggleBtn.TextColor3 = Color3.fromRGB(12, 15, 22)
ToggleBtn.Text = "AUTO TP: ON"
ToggleBtn.Parent = TopWindow

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 6)
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
LogsScroll.Size = UDim2.new(1, -16, 1, -54)
LogsScroll.Position = UDim2.new(0, 8, 0, 46)
LogsScroll.BackgroundColor3 = Color3.fromRGB(10, 12, 18)
LogsScroll.BorderSizePixel = 0
LogsScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
LogsScroll.ScrollBarThickness = 4
LogsScroll.Parent = MainFrame

local LogsCorner = Instance.new("UICorner")
LogsCorner.CornerRadius = UDim.new(0, 6)
LogsCorner.Parent = LogsScroll

local ListLayout = Instance.new("UIListLayout")
ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
ListLayout.Padding = UDim.new(0, 5)
ListLayout.Parent = LogsScroll

local function playSound()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://4590662766"
    sound.Volume = 4
    sound.Parent = SoundService
    sound:Play()
    sound.Ended:Connect(function() sound:Destroy() end)
end

local function performTP(cframe)
    if not cframe then return end
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if hrp then
        hrp.Velocity = Vector3.zero
        hrp.AssemblyLinearVelocity = Vector3.zero
        hrp.CFrame = cframe * CFrame.new(0, 2, 2)
    end
end

local detectedTargets = {}

local function addTargetLog(brainrotName, ownerUser, priceVal, targetCFrame)
    local key = ownerUser .. "_" .. brainrotName
    if detectedTargets[key] then return end
    detectedTargets[key] = true

    playSound()

    if AutoTPEnabled and targetCFrame then
        performTP(targetCFrame)
    end

    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = "🎯 TARGET SNIPED!",
            Text = brainrotName .. " | @" .. ownerUser .. " | " .. priceVal,
            Duration = 5
        })
    end)

    local Row = Instance.new("Frame")
    Row.Size = UDim2.new(1, -6, 0, 36)
    Row.BackgroundColor3 = Color3.fromRGB(24, 29, 40)
    Row.BorderSizePixel = 0
    Row.Parent = LogsScroll

    local RowCorner = Instance.new("UICorner")
    RowCorner.CornerRadius = UDim.new(0, 6)
    RowCorner.Parent = Row

    local InfoLbl = Instance.new("TextLabel")
    InfoLbl.Size = UDim2.new(1, -85, 1, 0)
    InfoLbl.Position = UDim2.new(0, 10, 0, 0)
    InfoLbl.BackgroundTransparency = 1
    InfoLbl.Font = Enum.Font.GothamMedium
    InfoLbl.TextSize = 11
    InfoLbl.TextColor3 = Color3.fromRGB(240, 240, 240)
    InfoLbl.TextXAlignment = Enum.TextXAlignment.Left
    InfoLbl.Text = "🔥 " .. brainrotName .. "  |  User: @" .. ownerUser .. "  |  " .. priceVal
    InfoLbl.Parent = Row

    local TPBtn = Instance.new("TextButton")
    TPBtn.Size = UDim2.new(0, 70, 0, 26)
    TPBtn.Position = UDim2.new(1, -76, 0, 5)
    TPBtn.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
    TPBtn.Font = Enum.Font.GothamBold
    TPBtn.TextSize = 10
    TPBtn.TextColor3 = Color3.fromRGB(12, 15, 22)
    TPBtn.Text = "RE-TP"
    TPBtn.Parent = Row

    local TPBtnCorner = Instance.new("UICorner")
    TPBtnCorner.CornerRadius = UDim.new(0, 5)
    TPBtnCorner.Parent = TPBtn

    TPBtn.MouseButton1Click:Connect(function()
        if targetCFrame then performTP(targetCFrame) end
    end)

    LogsScroll.CanvasSize = UDim2.new(0, 0, 0, ListLayout.AbsoluteContentSize.Y + 10)
end

local function scanAll()
    for _, v in ipairs(Workspace:GetDescendants()) do
        for name, isWhitelisted in pairs(WhitelistData) do
            if isWhitelisted and string.lower(v.Name) == string.lower(name) then
                local targetCFrame = nil
                if v:IsA("BasePart") then
                    targetCFrame = v.CFrame
                elseif v:IsA("Model") then
                    targetCFrame = v.PrimaryPart and v.PrimaryPart.CFrame or (v:FindFirstChildWhichIsA("BasePart") and v:FindFirstChildWhichIsA("BasePart").CFrame)
                end

                local priceVal = "Rare Item"
                local valObj = v:FindFirstChild("Value") or v:FindFirstChild("Money") or v:FindFirstChild("Price")
                if valObj then priceVal = "$" .. tostring(valObj.Value) end

                local ownerUser = "Server Ground"
                local ownerObj = v:FindFirstChild("Owner") or (v.Parent and v.Parent:FindFirstChild("Owner"))
                if ownerObj then ownerUser = tostring(ownerObj.Value) end

                if targetCFrame then
                    addTargetLog(v.Name, ownerUser, priceVal, targetCFrame)
                end
            end
        end
    end

    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            local function checkContainer(cont)
                if not cont then return end
                for _, item in ipairs(cont:GetDescendants()) do
                    for name, isWhitelisted in pairs(WhitelistData) do
                        if isWhitelisted and string.lower(item.Name) == string.lower(name) then
                            if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                                addTargetLog(item.Name, plr.Name, "In Inventory", plr.Character.HumanoidRootPart.CFrame)
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

-- Fast Loop Execution
task.spawn(function()
    while task.wait(0.05) do
        scanAll()
    end
end)
