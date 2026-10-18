-- CHES GET SNIPED - CRYSTAL & DISCORD WEBHOOK EDITION
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local StarterGui = game:GetService("StarterGui")
local SoundService = game:GetService("SoundService")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer

if CoreGui:FindFirstChild("ChesGetSnipedEngine") then
    CoreGui.ChesGetSnipedEngine:Destroy()
end

-- 🔗 Discord Webhook Active!
local DiscordWebhookURL = "https://discord.com/api/webhooks/1561375834366025750/VC95lyAKxrAM_CnlptKNqpvA-n9Wf8Ejy6w7gV3Nwhm7XZZxAIY0CozZkEwoCdLJzGlc" 

local AutoTPEnabled = true
local TargetsCount = 0

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

-- UI Setup (Crystal Theme)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ChesGetSnipedEngine"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = (gethui and gethui()) or CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 520, 0, 310)
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -155)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 15, 26)
MainFrame.BackgroundTransparency = 0.15
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Thickness = 2
MainStroke.Color = Color3.fromRGB(0, 242, 254)
MainStroke.Transparency = 0.2
MainStroke.Parent = MainFrame

local TopWindow = Instance.new("Frame")
TopWindow.Size = UDim2.new(1, 0, 0, 42)
TopWindow.BackgroundColor3 = Color3.fromRGB(5, 10, 20)
TopWindow.BackgroundTransparency = 0.3
TopWindow.BorderSizePixel = 0
TopWindow.Parent = MainFrame

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 12)
TopCorner.Parent = TopWindow

local Title = Instance.new("TextLabel")
Title.Text = "💎 CHES GET SNIPED"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.TextColor3 = Color3.fromRGB(0, 242, 254)
Title.Position = UDim2.new(0, 12, 0, 0)
Title.Size = UDim2.new(0, 180, 1, 0)
Title.BackgroundTransparency = 1
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopWindow

local CounterLabel = Instance.new("TextLabel")
CounterLabel.Text = "💎 TARGETS: 0"
CounterLabel.Font = Enum.Font.GothamMedium
CounterLabel.TextSize = 11
CounterLabel.TextColor3 = Color3.fromRGB(180, 235, 255)
CounterLabel.Position = UDim2.new(0, 195, 0, 0)
CounterLabel.Size = UDim2.new(0, 95, 1, 0)
CounterLabel.BackgroundTransparency = 1
CounterLabel.TextXAlignment = Enum.TextXAlignment.Left
CounterLabel.Parent = TopWindow

local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 100, 0, 28)
ToggleBtn.Position = UDim2.new(1, -215, 0, 7)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 242, 254)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 10
ToggleBtn.TextColor3 = Color3.fromRGB(5, 10, 20)
ToggleBtn.Text = "AUTO TP: ON"
ToggleBtn.Parent = TopWindow

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 6)
ToggleCorner.Parent = ToggleBtn

ToggleBtn.MouseButton1Click:Connect(function()
    AutoTPEnabled = not AutoTPEnabled
    if AutoTPEnabled then
        ToggleBtn.Text = "AUTO TP: ON"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 242, 254)
    else
        ToggleBtn.Text = "AUTO TP: OFF"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(235, 75, 75)
    end
end)

-- Server Hop Button
local HopBtn = Instance.new("TextButton")
HopBtn.Size = UDim2.new(0, 100, 0, 28)
HopBtn.Position = UDim2.new(1, -108, 0, 7)
HopBtn.BackgroundColor3 = Color3.fromRGB(155, 89, 182)
HopBtn.Font = Enum.Font.GothamBold
HopBtn.TextSize = 10
HopBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
HopBtn.Text = "SERVER HOP"
HopBtn.Parent = TopWindow

local HopCorner = Instance.new("UICorner")
HopCorner.CornerRadius = UDim.new(0, 6)
HopCorner.Parent = HopBtn

local function serverHop()
    local PlaceId = game.PlaceId
    local Servers = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"))
    for _, s in ipairs(Servers.data) do
        if s.playing < s.maxPlayers and s.id ~= game.JobId then
            TeleportService:TeleportToPlaceInstance(PlaceId, s.id, LocalPlayer)
            break
        end
    end
end

HopBtn.MouseButton1Click:Connect(serverHop)

local LogsScroll = Instance.new("ScrollingFrame")
LogsScroll.Size = UDim2.new(1, -16, 1, -56)
LogsScroll.Position = UDim2.new(0, 8, 0, 48)
LogsScroll.BackgroundColor3 = Color3.fromRGB(4, 8, 15)
LogsScroll.BackgroundTransparency = 0.4
LogsScroll.BorderSizePixel = 0
LogsScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
LogsScroll.ScrollBarThickness = 3
LogsScroll.Parent = MainFrame

local LogsCorner = Instance.new("UICorner")
LogsCorner.CornerRadius = UDim.new(0, 8)
LogsCorner.Parent = LogsScroll

local ListLayout = Instance.new("UIListLayout")
ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
ListLayout.Padding = UDim.new(0, 6)
ListLayout.Parent = LogsScroll

local function playSound()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://4590662766"
    sound.Volume = 4
    sound.Parent = SoundService
    sound:Play()
    sound.Ended:Connect(function() sound:Destroy() end)
end

local function sendDiscordWebhook(brainrotName, ownerUser, priceVal)
    if DiscordWebhookURL == "" or not (http_request or request or HttpService.RequestAsync) then return end
    local reqFunc = http_request or request or HttpService.RequestAsync
    local payload = HttpService:JSONEncode({
        ["content"] = "🚨 **CHES GET SNIPED DETECTED TARGET!**",
        ["embeds"] = {{
            ["title"] = "🎯 New Rare Brainrot Target!",
            ["description"] = "**Item:** " .. brainrotName .. "\n**Owner:** @" .. ownerUser .. "\n**Price:** " .. priceVal,
            ["color"] = 62463,
            ["fields"] = {
                { ["name"] = "Server JobID", ["value"] = "```" .. game.JobId .. "```" }
            }
        }}
    })
    pcall(function()
        reqFunc({
            Url = DiscordWebhookURL,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = payload
        })
    end)
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

    TargetsCount = TargetsCount + 1
    CounterLabel.Text = "💎 TARGETS: " .. tostring(TargetsCount)

    playSound()
    sendDiscordWebhook(brainrotName, ownerUser, priceVal)

    if AutoTPEnabled and targetCFrame then
        performTP(targetCFrame)
    end

    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = "💎 CRYSTAL SNIPE DETECTED!",
            Text = brainrotName .. " | @" .. ownerUser .. " | " .. priceVal,
            Duration = 5
        })
    end)

    local Row = Instance.new("Frame")
    Row.Size = UDim2.new(1, -6, 0, 36)
    Row.BackgroundColor3 = Color3.fromRGB(15, 25, 40)
    Row.BackgroundTransparency = 0.3
    Row.BorderSizePixel = 0
    Row.Parent = LogsScroll

    local RowCorner = Instance.new("UICorner")
    RowCorner.CornerRadius = UDim.new(0, 6)
    RowCorner.Parent = Row

    local RowStroke = Instance.new("UIStroke")
    RowStroke.Thickness = 1
    RowStroke.Color = Color3.fromRGB(0, 242, 254)
    RowStroke.Transparency = 0.6
    RowStroke.Parent = Row

    local InfoLbl = Instance.new("TextLabel")
    InfoLbl.Size = UDim2.new(1, -85, 1, 0)
    InfoLbl.Position = UDim2.new(0, 10, 0, 0)
    InfoLbl.BackgroundTransparency = 1
    InfoLbl.Font = Enum.Font.GothamMedium
    InfoLbl.TextSize = 11
    InfoLbl.TextColor3 = Color3.fromRGB(230, 245, 255)
    InfoLbl.TextXAlignment = Enum.TextXAlignment.Left
    InfoLbl.Text = "✨ " .. brainrotName .. "  |  User: @" .. ownerUser .. "  |  " .. priceVal
    InfoLbl.Parent = Row

    local TPBtn = Instance.new("TextButton")
    TPBtn.Size = UDim2.new(0, 70, 0, 26)
    TPBtn.Position = UDim2.new(1, -76, 0, 5)
    TPBtn.BackgroundColor3 = Color3.fromRGB(0, 242, 254)
    TPBtn.Font = Enum.Font.GothamBold
    TPBtn.TextSize = 10
    TPBtn.TextColor3 = Color3.fromRGB(5, 10, 20)
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

-- Ultra Fast Loop (0.05s)
task.spawn(function()
    while task.wait(0.05) do
        scanAll()
    end
end)
