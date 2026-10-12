-- WNotifier Cross-Server Auto-Joiner & Sniper (Pure English Code)
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
    ["Headless Horseman"] = true,
    ["John Pork"] = true,
    ["Meowl"] = true,
    ["Skibidi Toilet"] = true,
    ["Strawberry Elephant"] = true,
    ["Spyder Elephant"] = true
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
Title.Text = "⚡ WNotifier CROSS-SERVER SNIPER"
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 13
Title.TextColor3 = Color3.fromRGB(46, 204, 113)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.Size = UDim2.new(0, 310, 1, 0)
Title.BackgroundTransparency = 1
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopWindow

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Text = "Scanning Current Server..."
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

local function serverHop()
    StatusLabel.Text = "No Rares -> Server Hopping..."
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

local foundTargetInServer = false

local function checkCurrentServer()
    for _, v in ipairs(Workspace:GetDescendants()) do
        for name, isWhitelisted in pairs(WhitelistData) do
            if isWhitelisted and string.lower(v.Name) == string.lower(name) then
                local targetCFrame = nil
                if v:IsA("BasePart") then
                    targetCFrame = v.CFrame
                elseif v:IsA("Model") then
                    targetCFrame = v.PrimaryPart and v.PrimaryPart.CFrame or (v:FindFirstChildWhichIsA("BasePart") and v:FindFirstChildWhichIsA("BasePart").CFrame)
                end

                if targetCFrame then
                    foundTargetInServer = true
                    StatusLabel.Text = "TARGET FOUND: " .. v.Name
                    StatusLabel.TextColor3 = Color3.fromRGB(46, 204, 113)

                    -- Instant Teleport to the item in this server
                    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                    if char and char:FindFirstChild("HumanoidRootPart") then
                        char.HumanoidRootPart.Velocity = Vector3.zero
                        char.HumanoidRootPart.CFrame = targetCFrame * CFrame.new(0, 3, 0)
                    end
                    return
                end
            end
        end
    end
end

-- Scan immediately on load
checkCurrentServer()

-- If no rare item is in this server, hop to another public server after 3 seconds
if not foundTargetInServer then
    task.delay(3, function()
        serverHop()
    end)
end
