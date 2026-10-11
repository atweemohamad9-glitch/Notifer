-- WNotifier Advanced Engine (Brainrot + User + Value + Auto Join)
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
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
    ["Garama and Madundung"] = true
}

local AutoJoinEnabled = true
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
Title.Text = "🟢 WNotifier (Private Engine)"
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 13
Title.TextColor3 = Color3.fromRGB(220, 220, 220)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.Size = UDim2.new(0, 220, 1, 0)
Title.BackgroundTransparency = 1
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopWindow

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Text = "Reading Server (10s)..."
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

local LogsScroll = Instance.new("ScrollingFrame")
LogsScroll.Size = UDim2.new(1, -5, 1, -10)
LogsScroll.Position = UDim2.new(0, 0, 0, 5)
LogsScroll.BackgroundColor3 = Color3.fromRGB(18, 20, 25)
LogsScroll.BorderSizePixel = 0
LogsScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
LogsScroll.ScrollBarThickness = 3
LogsScroll.Parent = LogsContainer

local ListLayoutLogs = Instance.new("UIListLayout")
ListLayoutLogs.SortOrder = Enum.SortOrder.LayoutOrder
ListLayoutLogs.Padding = UDim.new(0, 4)
ListLayoutLogs.Parent = LogsScroll

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
end

local function teleportToPlayer(targetPlayer)
    if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local myChar = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        if myChar and myChar:FindFirstChild("HumanoidRootPart") then
            myChar.HumanoidRootPart.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
        end
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

-- دالة طباعة المعلومات التفصيلية (Brainrot + Value + User + Joining status)
local function addLogEntry(brainrotName, valStr, playerName, targetPlayer)
    local key = playerName .. "_" .. brainrotName
    if loggedEntries[key] then return end
    loggedEntries[key] = true

    local Row = Instance.new("Frame")
    Row.Size = UDim2.new(1, -5, 0, 28)
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
    -- إظهار الاسم + القيمة/السعر + اليوزر
    InfoLbl.Text = "🔥 " .. brainrotName .. " (" .. valStr .. ") | @" .. playerName
    InfoLbl.Parent = Row

    local JoinBtn = Instance.new("TextButton")
    JoinBtn.Size = UDim2.new(0, 60, 0, 20)
    JoinBtn.Position = UDim2.new(1, -65, 0, 4)
    JoinBtn.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
    JoinBtn.Font = Enum.Font.SourceSansBold
    JoinBtn.TextSize = 10
    JoinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    JoinBtn.Text = "JOINING..."
    JoinBtn.Parent = Row

    JoinBtn.MouseButton1Click:Connect(function()
        teleportToPlayer(targetPlayer)
    end)

    LogsScroll.CanvasSize = UDim2.new(0, 0, 0, ListLayoutLogs.AbsoluteContentSize.Y + 10)
end

-- فحص السيرفر والـ Base والأغراض
task.spawn(function()
    for i = 10, 1, -1 do
        StatusLabel.Text = "Reading Server (" .. i .. "s)..."
        
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer then
                if p.Character then
                    for _, obj in ipairs(p.Character:GetDescendants()) do
                        -- إذا وجد Brainrot بالـ Whitelist أو بالـ Base
                        if WhitelistData[obj.Name] == true or obj:FindFirstChild("Money") or obj:FindFirstChild("Value") then
                            local rareName = WhitelistData[obj.Name] and obj.Name or obj.Name
                            local moneyValue = obj:FindFirstChild("Value") and tostring(obj.Value.Value) or (obj:FindFirstChild("Money") and tostring(obj.Money.Value) or "Secret")
                            
                            FoundRareInServer = true
                            addLogEntry(rareName, moneyValue, p.Name, p)
                            
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
