local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local Window = WindUI:CreateWindow({
    Title = "NEXSRC",
    Icon = "target",
    Author = "by @vladkdm and @FuckYki",
    Folder = "NEXSRC",
    Size = UDim2.fromOffset(600, 500),
    Theme = "Dark",
    
    KeySystem = { 
        Key = { "@nexsrcscript" },
        Note = "Наш телеграм канал: @nexsrcscript",
        SaveKey = true
    },
})

Window:Tag({
    Title = "@nexsrcscript",
    Color = Color3.fromHex("#00BFFF")
})

-- ESP Tab
local ESPTab = Window:Tab({
    Title = "ESP",
    Icon = "eye",
    Locked = false,
})

-- Box ESP
local BoxDropdown = ESPTab:Dropdown({
    Title = "Box ESP Type",
    Values = { "None", "Corner", "Full", "3D" },
    Value = "None",
    Callback = function(option) 
        print("Box ESP Type selected: " .. option) 
    end
})

-- Skeleton ESP
local SkeletonToggle = ESPTab:Toggle({
    Title = "Skeleton ESP",
    Desc = "Показывать скелет игроков",
    Icon = "bone",
    Type = "Checkbox",
    Default = false,
    Callback = function(state) 
        print("Skeleton ESP: " .. tostring(state))
    end
})

-- Chams ESP
local ChamsToggle = ESPTab:Toggle({
    Title = "Chams ESP",
    Desc = "Подсвечивать игроков через стены",
    Icon = "box",
    Type = "Checkbox",
    Default = false,
    Callback = function(state) 
        print("Chams ESP: " .. tostring(state))
    end
})

-- Chams Teams
local ChamsDropdown = ESPTab:Dropdown({
    Title = "Chams ESP Teams",
    Values = { "Murderer", "Sheriff", "Innocents" },
    Value = { "Murderer" },
    Multi = true,
    AllowNone = true,
    Callback = function(option) 
        print("Chams teams selected: " .. game:GetService("HttpService"):JSONEncode(option)) 
    end
})

-- Team Colors
local MurdererColor = ESPTab:Colorpicker({
    Title = "Цвет маньяка",
    Desc = "Цвет для маньяка",
    Default = Color3.fromRGB(255, 0, 0),
    Transparency = 0,
    Locked = false,
    Callback = function(color) 
        print("Цвет маньяка: " .. tostring(color))
    end
})

local SheriffColor = ESPTab:Colorpicker({
    Title = "Цвет шерифа",
    Desc = "Цвет для шерифа",
    Default = Color3.fromRGB(0, 0, 255),
    Transparency = 0,
    Locked = false,
    Callback = function(color) 
        print("Цвет шерифа: " .. tostring(color))
    end
})

local InnocentsColor = ESPTab:Colorpicker({
    Title = "Цвет невинных",
    Desc = "Цвет для невинных игроков",
    Default = Color3.fromRGB(0, 255, 0),
    Transparency = 0,
    Locked = false,
    Callback = function(color) 
        print("Цвет невинных: " .. tostring(color))
    end
})

-- Additional ESP Settings
local NamesToggle = ESPTab:Toggle({
    Title = "Показывать имена",
    Desc = "Отображать имена игроков",
    Icon = "tag",
    Type = "Checkbox",
    Default = true,
    Callback = function(state) 
        print("Показывать имена: " .. tostring(state))
    end
})

local DistanceToggle = ESPTab:Toggle({
    Title = "Показывать дистанцию",
    Desc = "Отображать расстояние до игроков",
    Icon = "ruler",
    Type = "Checkbox",
    Default = true,
    Callback = function(state) 
        print("Показывать дистанцию: " .. tostring(state))
    end
})

local DrawDistanceSlider = ESPTab:Slider({
    Title = "Дальность отрисовки",
    Default = 1000,
    Min = 0,
    Max = 5000,
    Callback = function(Value)
        print("Дальность отрисовки:", Value)
    end
})

-- Aimbot Tab
local AimbotTab = Window:Tab({
    Title = "Aimbot",
    Icon = "crosshair",
    Locked = false,
})

-- Silent Aim
local SilentAimToggle = AimbotTab:Toggle({
    Title = "Silent Aim",
    Desc = "Автоматическое прицеливание",
    Icon = "target",
    Type = "Checkbox",
    Default = false,
    Callback = function(state) 
        print("Silent Aim: " .. tostring(state))
    end
})

-- Prediction
local PredictionSlider = AimbotTab:Slider({
    Title = "Prediction",
    Default = 100,
    Min = 0,
    Max = 200,
    Callback = function(Value)
        print("Prediction:", Value)
    end
})

-- Target Selection
local TargetDropdown = AimbotTab:Dropdown({
    Title = "Target Priority",
    Values = { "Murderer", "Sheriff", "Closest" },
    Value = "Murderer",
    Callback = function(option) 
        print("Target Priority: " .. option) 
    end
})

-- FOV Settings
local FOVSection = AimbotTab:Section({ 
    Title = "FOV Settings",
    TextXAlignment = "Left",
    TextSize = 17,
})

local FOVToggle = AimbotTab:Toggle({
    Title = "Show FOV",
    Desc = "Показывать поле зрения",
    Icon = "circle",
    Type = "Checkbox",
    Default = true,
    Callback = function(state) 
        print("Show FOV: " .. tostring(state))
    end
})

local FOVSizeSlider = AimbotTab:Slider({
    Title = "FOV Size",
    Default = 80,
    Min = 10,
    Max = 300,
    Callback = function(Value)
        print("FOV Size:", Value)
    end
})

local FOVColor = AimbotTab:Colorpicker({
    Title = "FOV Color",
    Desc = "Цвет поля зрения",
    Default = Color3.fromRGB(255, 255, 255),
    Transparency = 0,
    Locked = false,
    Callback = function(color) 
        print("FOV Color: " .. tostring(color))
    end
})

-- Gun Highlight Features
local GunSection = AimbotTab:Section({ 
    Title = "Gun Features",
    TextXAlignment = "Left",
    TextSize = 17,
})

local GunHighlightToggle = AimbotTab:Toggle({
    Title = "Gun Highlight",
    Desc = "Подсветка оружия на карте",
    Icon = "gift",
    Type = "Checkbox",
    Default = true,
    Callback = function(state) 
        print("Gun Highlight: " .. tostring(state))
    end
})

local GunColor = AimbotTab:Colorpicker({
    Title = "Gun Color",
    Desc = "Цвет подсветки оружия",
    Default = Color3.fromRGB(255, 215, 0),
    Transparency = 0,
    Locked = false,
    Callback = function(color) 
        print("Gun Color: " .. tostring(color))
    end
})

-- Initialize role tracking
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local roles = {}
local murderer, sheriff, hero = nil, nil, nil

local function updateRole(player, role)
    roles[player] = role
    if role == "Murderer" then
        murderer = player
    elseif role == "Sheriff" then
        sheriff = player
    elseif role == "Hero" then
        hero = player
    end
    print(player.Name .. " role updated to: " .. role)
end

-- Role detection events
ReplicatedStorage.Fade.OnClientEvent:Connect(function(data)
    for i, v in ipairs(Players:GetPlayers()) do
        local info = data[v.Name]
        if info then
            local role = typeof(info) == "table" and info.Role or "Unknown"
            pcall(updateRole, v, role)
        end
    end
end)

ReplicatedStorage.UpdatePlayerData.OnClientEvent:Connect(function(data)
    for i, v in ipairs(Players:GetPlayers()) do
        local info = data[v.Name]
        if info then
            local role = typeof(info) == "table" and info.Role or "Unknown"
            pcall(updateRole, v, role)
        end
    end
end)

ReplicatedStorage.RoleSelect.OnClientEvent:Connect(function(role, ...)
    updateRole(LocalPlayer, role or "Unknown")
end)

ReplicatedStorage.Remotes.Gameplay.RoundEndFade.OnClientEvent:Connect(function()
    for i, v in pairs(roles) do
        updateRole(i, "Unknown")
    end
    murderer, sheriff, hero = nil, nil, nil
end)

-- Silent Aim functionality
local __namecall
__namecall = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    local args = { ... }
    if not checkcaller() then
        if typeof(self) == "Instance" then
            if self.Name == "ShootGun" and method == "InvokeServer" then
                if SilentAimToggle.Value then
                    local target = nil
                    if TargetDropdown.Value == "Murderer" and murderer then
                        target = murderer
                    elseif TargetDropdown.Value == "Sheriff" and sheriff then
                        target = sheriff
                    elseif TargetDropdown.Value == "Closest" then
                        -- Closest player logic would go here
                    end
                    
                    if target and target.Character and target.Character.PrimaryPart then
                        local root = target.Character.PrimaryPart
                        local velocity = root.AssemblyLinearVelocity
                        local aimPosition = root.Position + (velocity * Vector3.new(PredictionSlider.Value / 200, 0, PredictionSlider.Value / 200))
                        args[2] = aimPosition
                    end
                end
            end
        end
    end
    return __namecall(self, unpack(args))
end)

-- Gun highlight system
local GunHighlight = Instance.new("Highlight")
GunHighlight.FillColor = GunColor.Value
GunHighlight.OutlineTransparency = 1
GunHighlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
GunHighlight.RobloxLocked = true

local GunHandleAdornment = Instance.new("BoxHandleAdornment")
GunHandleAdornment.Color3 = GunColor.Value
GunHandleAdornment.Transparency = 0.2
GunHandleAdornment.AlwaysOnTop = true
GunHandleAdornment.AdornCullingMode = Enum.AdornCullingMode.Never
GunHandleAdornment.RobloxLocked = true

-- Update gun highlight when settings change
GunColor.Callback = function(color)
    GunHighlight.FillColor = color
    GunHandleAdornment.Color3 = color
end

GunHighlightToggle.Callback = function(state)
    if state then
        local gun = Workspace:FindFirstChild("GunDrop")
        if gun then
            GunHighlight.Adornee = gun
            GunHandleAdornment.Adornee = gun
            GunHighlight.Parent = game:GetService("CoreGui")
            GunHandleAdornment.Parent = game:GetService("CoreGui")
        end
    else
        GunHighlight.Adornee = nil
        GunHandleAdornment.Adornee = nil
    end
end

-- Initial gun check
spawn(function()
    while true do
        wait(1)
        if GunHighlightToggle.Value then
            local gun = Workspace:FindFirstChild("GunDrop")
            if gun then
                GunHighlight.Adornee = gun
                GunHandleAdornment.Adornee = gun
                GunHighlight.Parent = game:GetService("CoreGui")
                GunHandleAdornment.Parent = game:GetService("CoreGui")
            end
        end
    end
end)
