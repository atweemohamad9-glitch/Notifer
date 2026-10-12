-- WNotifier Ultra Engine (Workspace Finder + High Performance)
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
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
    ["Brainrot"] = true
}

local AutoJoinEnabled = true
local OGJoinEnabled = true
local FoundRareInServer = false

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "WNotifierPrivateEngine"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = (gethui and gethui()) or CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 560, 0, 320)
MainFrame.Position = UDim2.new(0.5, -280, 0.5, -160)
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
Title.Text = "🟢 WNotifier ULTRA Finder"
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 13
Title.TextColor3 = Color3.fromRGB(220, 220, 220)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.Size = UDim2.new(0, 220, 1, 0)
Title.BackgroundTransparency = 1
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopWindow

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Text = "Scanning Server..."
StatusLabel.Font = Enum.Font.SourceSans
StatusLabel.TextSize = 12
StatusLabel.TextColor3 = Color3.fromRGB(241, 196, 15)
StatusLabel.Position = UDim2.new(1, -150, 0, 0)
StatusLabel.Size = UDim2.new(0, 140, 1, 0)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Parent = TopWindow

local SideBar = Instance.new("Frame")
SideBar.Size = UDim2.new(0, 110, 1, -28)
SideBar.Position = UDim2.new(0, 0, 0, 28)
SideBar.BackgroundColor3 = Color3.fromRGB(16, 18, 23)
SideBar.BorderSizePixel = 0
SideBar.Parent = MainFrame

local LogsContainer = Instance.new("Frame")
LogsContainer.Size = UDim2.new(1, -115, 1, -33)
LogsContainer.Position = UDim2.new(0, 112, 0, 30)
LogsContainer.BackgroundTransparency = 1
LogsContainer.Parent = MainFrame

local WhitelistScroll = Instance.new("ScrollingFrame")
WhitelistScroll.Size = UDim2.new(1, -115, 1, -33)
WhitelistScroll.Position = UDim2.new(0, 112, 0, 30)
WhitelistScroll.BackgroundColor3 = Color3.fromRGB(20, 22, 28)
WhitelistScroll.BorderSizePixel = 0
WhitelistScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
WhitelistScroll.ScrollBarThickness = 4
WhitelistScroll.Visible = false
WhitelistScroll.Parent = MainFrame

local ListLayoutWL = Instance.new("UIListLayout")
ListLayoutWL.SortOrder = Enum.SortOrder.LayoutOrder
ListLayoutWL.Padding = UDim.new(0, 4)
ListLayoutWL.Parent = WhitelistScroll

local ActionBar = Instance.new("Frame")
ActionBar.Size = UDim2.new(1, 0, 0, 26)
ActionBar.BackgroundTransparency = 1
ActionBar.Parent = LogsContainer

local OgBtn = Instance.new("TextButton")
OgBtn.Size = UDim2.new(0, 95, 0, 22)
OgBtn.Position = UDim2.new(1, -200, 0, 2)
OgBtn.BackgroundColor3 = Color3.fromRGB(241, 196, 15)
OgBtn.Font = Enum.Font.SourceSansBold
OgBtn.TextSize = 11
OgBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
OgBtn.Text = "★ OG-join: ON"
OgBtn.Parent = ActionBar

local AutoBtn = Instance.new("TextButton")
AutoBtn.Size = UDim2.new(0, 95, 0, 22)
AutoBtn.Position = UDim2.new(1, -100, 0, 2)
AutoBtn.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
AutoBtn.Font = Enum.Font.SourceSansBold
AutoBtn.TextSize = 11
AutoBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
AutoBtn.Text = "● Auto-join: ON"
AutoBtn.Parent = ActionBar

AutoBtn.MouseButton1Click:Connect(function()
    AutoJoinEnabled = not AutoJoinEnabled
    AutoBtn.Text = AutoJoinEnabled and "● Auto-join: ON" or "● Auto-join: OFF"
    AutoBtn.BackgroundColor3 = AutoJoinEnabled and Color3.fromRGB(46, 204, 113) or Color3.fromRGB(231, 76, 60)
end)

OgBtn.MouseButton1Click:Connect(function()
    OGJoinEnabled = not OGJoinEnabled
    OgBtn.Text = OGJoinEnabled and "★ OG-join: ON" or "★ OG-join: OFF"
    OgBtn.BackgroundColor3 = OGJoinEnabled and Color3.fromRGB(241, 196, 15) or Color3.fromRGB(231, 76, 60)
end)

local LogsScroll = Instance.new("ScrollingFrame")
LogsScroll.Size = UDim2.new(1, -5, 1, -30)
LogsScroll.Position = UDim2.new(0, 0, 0, 30)
LogsScroll.BackgroundColor3 = Color3.fromRGB(18, 20, 25)
LogsScroll.BorderSizePixel = 0
LogsScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
LogsScroll.ScrollBarThickness = 3
LogsScroll.Parent = LogsContainer

local ListLayoutLogs = Instance.new("UIListLayout")
ListLayoutLogs.SortOrder = Enum.SortOrder.LayoutOrder
ListLayoutLogs.Padding = UDim.new(0, 2)
ListLayoutLogs.Parent = LogsScroll

local function switchTab(tabName)
    if tabName == "Logs" then
        LogsContainer.Visible = true
        WhitelistScroll.Visible = false
    elseif tabName == "Whitelist" then
        LogsContainer.Visible = false
        WhitelistScroll.Visible = true
    end
end

local categories = {"Logs", "Whitelist", "Owners", "Settings", "Users"}
for i, cat in ipairs(categories) do
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, 0, 0, 30)
    Btn.Position = UDim2.new(0, 0, 0, (i-1)*30)
    Btn.BackgroundColor3 = Color3.fromRGB(24, 27, 35)
    Btn.BackgroundTransparency = (cat == "Logs" and 0 or 1)
    Btn.Font = Enum.Font.SourceSans
    Btn.TextSize = 12
    Btn.TextColor3 = Color3.fromRGB(180, 180, 180)
    Btn.Text = cat
    Btn.Parent = SideBar
    Btn.MouseButton1Click:Connect(function() switchTab(cat) end)
end

for name, status in pairs(WhitelistData) do
    local Entry = Instance.new("Frame")
    Entry.Size = UDim2.new(1, -6, 0, 28)
    Entry.BackgroundColor3 = Color3.fromRGB(25, 28, 36)
    Entry.BorderSizePixel = 0
    Entry.Parent = WhitelistScroll

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -70, 1, 0)
    Label.Position = UDim2.new(0, 10, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Font = Enum.Font.SourceSans
    Label.TextSize = 12
    Label.TextColor3 = Color3.fromRGB(230, 230, 230)
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Text = name
    Label.Parent = Entry

    local Toggle = Instance.new("TextButton")
    Toggle.Size = UDim2.new(0, 50, 0, 20)
    Toggle.Position = UDim2.new(1, -55, 0, 4)
    Toggle.BackgroundColor3 = status and Color3.fromRGB(46, 204, 113) or Color3.fromRGB(231, 76, 60)
    Toggle.Font = Enum.Font.SourceSansBold
    Toggle.TextSize = 11
    Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    Toggle.Text = status and "ON" or "OFF"
    Toggle.Parent = Entry

    Toggle.MouseButton1Click:Connect(function()
        WhitelistData[name] = not WhitelistData[name]
        Toggle.Text = WhitelistData[name] and "ON" or "OFF"
        Toggle.BackgroundColor3 = WhitelistData[name] and Color3.fromRGB(46, 204, 113) or Color3.fromRGB(231, 76, 60)
    end)
end
WhitelistScroll.CanvasSize = UDim2.new(0, 0, 0, ListLayoutWL.AbsoluteContentSize.Y + 10)

local function teleportToPosition(cframe)
    local myChar = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    if myChar and myChar:FindFirstChild("HumanoidRootPart") then
        myChar.HumanoidRootPart.CFrame = cframe * CFrame.new(0, 0, 3)
    end
end

local function serverHop()
    StatusLabel.Text = "Server Hop..."
    StatusLabel.TextColor3 = Color3.fromRGB(231, 76, 60)
    local placeId = game.PlaceId
    local servers = {}
    local req = request or http_request or (syn and syn.request)
    if req then
        local res = req({Url = "https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?sortOrder=Asc&limit=100"})
        local body = HttpService:JSONDecode(res.Body)
        if body and body.data then
            for _, s in ipairs(body.data) do
                if s.id ~= game.JobId and s.playing < s.maxPlayers then
                    table.insert(servers, s.id)
                end
            end
        end
    end
    if #servers > 0 then
        TeleportService:TeleportToPlaceInstance(placeId, servers[math.random(1, #servers)], LocalPlayer)
    else
        TeleportService:Teleport(placeId, LocalPlayer)
    end
end

local loggedEntries = {}

local function addLogEntry(brainrotName, valStr, playerName, targetCFrame)
    local key = playerName .. "_" .. brainrotName
    if loggedEntries[key] then return end
    loggedEntries[key] = true

    local Row = Instance.new("Frame")
    Row.Size = UDim2.new(1, -5, 0, 26)
    Row.BackgroundColor3 = Color3.fromRGB(25, 28, 36)
    Row.BorderSizePixel = 0
    Row.Parent = LogsScroll

    local InfoLbl = Instance.new("TextLabel")
    InfoLbl.Size = UDim2.new(1, -75, 1, 0)
    InfoLbl.Position = UDim2.new(0, 8, 0, 0)
    InfoLbl.BackgroundTransparency = 1
    InfoLbl.Font = Enum.Font.SourceSansBold
    InfoLbl.TextSize = 11
    InfoLbl.TextColor3 = Color3.fromRGB(220, 220, 220)
    InfoLbl.TextXAlignment = Enum.TextXAlignment.Left
    InfoLbl.Text = "🔥 " .. brainrotName .. " (" .. valStr .. ") | @" .. playerName
    InfoLbl.Parent = Row

    local JoinBtn = Instance.new("TextButton")
    JoinBtn.Size = UDim2.new(0, 60, 0, 18)
    JoinBtn.Position = UDim2.new(1, -65, 0, 4)
    JoinBtn.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
    JoinBtn.Font = Enum.Font.SourceSansBold
    JoinBtn.TextSize = 10
    JoinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    JoinBtn.Text = "JOINING..."
    JoinBtn.Parent = Row

    JoinBtn.MouseButton1Click:Connect(function()
        if targetCFrame then
            teleportToPosition(targetCFrame)
        end
    end)

    LogsScroll.CanvasSize = UDim2.new(0, 0, 0, ListLayoutLogs.AbsoluteContentSize.Y + 10)
end

-- Full Workspace Scanning Engine (Dex-Finder Style)
task.spawn(function()
    for i = 7, 1, -1 do
        StatusLabel.Text = "Scanning Server (" .. i .. "s)..."
        
        -- Scan Workspace Objects / Plots / Models
        for _, v in ipairs(Workspace:GetDescendants()) do
            for name, isWhitelisted in pairs(WhitelistData) do
                if isWhitelisted and (string.find(string.lower(v.Name), string.lower(name)) or v.Name == name) then
                    local moneyVal = "Rare"
                    local ownerName = "Unknown"
                    local targetCFrame = nil

                    if v:IsA("BasePart") then
                        targetCFrame = v.CFrame
                    elseif v:IsA("Model") and v.PrimaryPart then
                        targetCFrame = v.PrimaryPart.CFrame
                    elseif v:IsA("Model") then
                        local part = v:FindFirstChildWhichIsA("BasePart")
                        if part then targetCFrame = part.CFrame end
                    end

                    -- Try finding money/value
                    local valObj = v:FindFirstChild("Value") or v:FindFirstChild("Money") or v:FindFirstChild("Price")
                    if valObj then
                        moneyVal = tostring(valObj.Value)
                    end

                    -- Try finding Owner
                    local ownerObj = v:FindFirstChild("Owner") or v.Parent:FindFirstChild("Owner")
                    if ownerObj then
                        ownerName = tostring(ownerObj.Value)
                    end

                    if targetCFrame then
                        FoundRareInServer = true
                        addLogEntry(v.Name, moneyVal, ownerName, targetCFrame)
                        if AutoJoinEnabled then
                            StatusLabel.Text = "Joining Target..."
                            StatusLabel.TextColor3 = Color3.fromRGB(46, 204, 113)
                            teleportToPosition(targetCFrame)
                        end
                    end
                end
            end
        end
        task.wait(1)
    end

    if not FoundRareInServer then
        StatusLabel.Text = "No Rares -> Hopping..."
        task.wait(0.5)
        serverHop()
    end
end)
= Enum.Font.SourceSansBold
    JoinBtn.TextSize = 10
    JoinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    JoinBtn.Text = "JOINING..."
    JoinBtn.Parent = Row

    JoinBtn.MouseButton1Click:Connect(function()
        teleportToPlayer(targetPlayer)
    end)

    LogsScroll.CanvasSize = UDim2.new(0, 0, 0, ListLayoutLogs.AbsoluteContentSize.Y + 10)
end

-- فحص دقيق وخاص بالوايت ليست فقط
task.spawn(function()
    for i = 10, 1, -1 do
        StatusLabel.Text = "Reading Server (" .. i .. "s)..."
        
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer then
                if p.Character then
                    for _, obj in ipairs(p.Character:GetDescendants()) do
                        -- التأكد حصرياً أن الغرض موجود بالوايت ليست ومفعل
                        if WhitelistData[obj.Name] == true then
                            local moneyVal = "Secret"
                            if obj:FindFirstChild("Value") then
                                moneyVal = tostring(obj.Value.Value)
                            elseif obj:FindFirstChild("Money") then
                                moneyVal = tostring(obj.Money.Value)
                            end
                            
                            FoundRareInServer = true
                            addLogEntry(obj.Name, moneyVal, p.Name, p)
                            
                            if AutoJoinEnabled then
                                StatusLabel.Text = "Joining Target..."
                                StatusLabel.TextColor3 = Color3.fromRGB(46, 204, 113)
                                teleportToPlayer(p)
                            end
                        end
                    end
                end
            end
        end
        
        task.wait(1)
    end

    if not FoundRareInServer then
        StatusLabel.Text = "No Rares -> Hopping..."
        task.wait(1)
        serverHop()
    end
end)
