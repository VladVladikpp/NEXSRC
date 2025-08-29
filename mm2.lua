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

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")

-- Variables
local LocalPlayer = Players.LocalPlayer
local murderer, sheriff, hero
local roles = {}
local visuals = {}
local BoundKeys = LocalPlayer.PlayerScripts.PlayerModule.CameraModule.MouseLockController.BoundKeys

-- Options storage
local Options = {
    Murderer_Color = { Value = Color3.fromRGB(255, 0, 0) },
    Sheriff_Color = { Value = Color3.fromRGB(0, 0, 255) },
    Hero_Color = { Value = Color3.fromRGB(255, 255, 0) },
    Innocent_Color = { Value = Color3.fromRGB(0, 255, 0) },
    Unknown_Color = { Value = Color3.fromRGB(128, 128, 128) }
}

-- Functions
local function findAngleDelta(a, b)
    return math.deg(math.acos(a:Dot(b)))
end

local function isCharacterValid(character)
    if character and character:IsA("Model") then
        local humanoid = character:FindFirstChildWhichIsA("Humanoid")
        if humanoid and humanoid.Health > 0 then
            local root = character.PrimaryPart or character:FindFirstChild("HumanoidRootPart")
            if root then
                return true
            end
        end
    end
    return false
end

local function updateRole(player, role)
    if role ~= roles[player] then
        print(player.Name .. " is now " .. role)
    end
    roles[player] = role
    
    if role == "Murderer" then
        murderer = player
    elseif role == "Sheriff" then
        sheriff = player
    elseif role == "Hero" then
        hero = player
    end
    
    if player ~= LocalPlayer then
        local highlight = visuals[player]
        if highlight then
            highlight.FillColor = role == "Murderer" and Options.Murderer_Color.Value or
                                role == "Sheriff" and Options.Sheriff_Color.Value or
                                role == "Hero" and Options.Hero_Color.Value or
                                role == "Innocent" and Options.Innocent_Color.Value or
                                Options.Unknown_Color.Value
        end
    end
end

local function onPlayerAdded(player)
    local highlight = Instance.new("Highlight")
    highlight.FillColor = Options.Unknown_Color.Value
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.RobloxLocked = true
    visuals[player] = highlight
    highlight.Parent = CoreGui

    player.CharacterAdded:Connect(function(character)
        highlight.Adornee = character
    end)
    
    if player.Character then
        highlight.Adornee = player.Character
    end
end

local function onPlayerRemoving(player)
    local highlight = visuals[player]
    if highlight then
        highlight:Destroy()
    end
    visuals[player] = nil
    roles[player] = nil
end

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

-- Team Colors
local MurdererColor = ESPTab:Colorpicker({
    Title = "Цвет маньяка",
    Desc = "Цвет для маньяка",
    Default = Color3.fromRGB(255, 0, 0),
    Transparency = 0,
    Locked = false,
    Callback = function(color) 
        Options.Murderer_Color.Value = color
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
        Options.Sheriff_Color.Value = color
        print("Цвет шерифа: " .. tostring(color))
    end
})

local HeroColor = ESPTab:Colorpicker({
    Title = "Цвет героя",
    Desc = "Цвет для героя",
    Default = Color3.fromRGB(255, 255, 0),
    Transparency = 0,
    Locked = false,
    Callback = function(color) 
        Options.Hero_Color.Value = color
        print("Цвет героя: " .. tostring(color))
    end
})

local InnocentColor = ESPTab:Colorpicker({
    Title = "Цвет невинных",
    Desc = "Цвет для невинных игроков",
    Default = Color3.fromRGB(0, 255, 0),
    Transparency = 0,
    Locked = false,
    Callback = function(color) 
        Options.Innocent_Color.Value = color
        print("Цвет невинных: " .. tostring(color))
    end
})

local UnknownColor = ESPTab:Colorpicker({
    Title = "Цвет неизвестных",
    Desc = "Цвет для неизвестных игроков",
    Default = Color3.fromRGB(128, 128, 128),
    Transparency = 0,
    Locked = false,
    Callback = function(color) 
        Options.Unknown_Color.Value = color
        print("Цвет неизвестных: " .. tostring(color))
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

-- Legit Tab
local LegitTab = Window:Tab({
    Title = "Legit",
    Icon = "shield",
    Locked = false,
})

-- Hitbox Extender
local ReachToggle = LegitTab:Toggle({
    Title = "Hitbox Extender",
    Desc = "Расширение хитбокса",
    Icon = "expand",
    Type = "Checkbox",
    Default = false,
    Callback = function(state) 
        print("Hitbox Extender: " .. tostring(state))
    end
})

local ReachSlider = LegitTab:Slider({
    Title = "Hitbox Radius",
    Default = 10,
    Min = 5,
    Max = 20,
    Callback = function(Value)
        print("Hitbox Radius:", Value)
    end
})

local ReachAngleSlider = LegitTab:Slider({
    Title = "Hitbox Angle",
    Default = 60,
    Min = 10,
    Max = 180,
    Callback = function(Value)
        print("Hitbox Angle:", Value)
    end
})

-- Kill All
local StabAllToggle = LegitTab:Toggle({
    Title = "Kill All",
    Desc = "Убивать всех вокруг",
    Icon = "skull",
    Type = "Checkbox",
    Default = false,
    Callback = function(state) 
        print("Kill All: " .. tostring(state))
    end
})

-- Auto Pickup Gun
local AutoGunToggle = LegitTab:Toggle({
    Title = "Auto-Pickup Gun",
    Desc = "Автоподбор оружия",
    Icon = "gift",
    Type = "Checkbox",
    Default = false,
    Callback = function(state) 
        print("Auto-Pickup Gun: " .. tostring(state))
    end
})

-- Speed Hack
local SpeedToggle = LegitTab:Toggle({
    Title = "Speed Hack",
    Desc = "Увеличение скорости",
    Icon = "zap",
    Type = "Checkbox",
    Default = false,
    Callback = function(state) 
        print("Speed Hack: " .. tostring(state))
    end
})

local SpeedSlider = LegitTab:Slider({
    Title = "Speed",
    Default = 2,
    Min = 1,
    Max = 10,
    Callback = function(Value)
        print("Speed:", Value)
    end
})

-- Initialize role tracking
for _, player in ipairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        onPlayerAdded(player)
    end
end

-- Role detection events
ReplicatedStorage.Fade.OnClientEvent:Connect(function(data)
    for _, player in ipairs(Players:GetPlayers()) do
        local info = data[player.Name]
        if info then
            local role = typeof(info) == "table" and info.Role or "Unknown"
            pcall(updateRole, player, role)
        end
    end
end)

ReplicatedStorage.UpdatePlayerData.OnClientEvent:Connect(function(data)
    for _, player in ipairs(Players:GetPlayers()) do
        local info = data[player.Name]
        if info then
            local role = typeof(info) == "table" and info.Role or "Unknown"
            pcall(updateRole, player, role)
        end
    end
end)

ReplicatedStorage.RoleSelect.OnClientEvent:Connect(function(role)
    updateRole(LocalPlayer, role or "Unknown")
end)

ReplicatedStorage.Remotes.Gameplay.RoundEndFade.OnClientEvent:Connect(function()
    for player in pairs(roles) do
        updateRole(player, "Unknown")
    end
    murderer, sheriff, hero = nil, nil, nil
end)

-- Main loop
RunService.RenderStepped:Connect(function()
    local character = LocalPlayer.Character
    if isCharacterValid(character) then
        -- Hitbox Extender
        if ReachToggle.Value then
            local Knife = character:FindFirstChild("Knife")
            if Knife and Knife:IsA("Tool") then
                local HumanoidRootPart = character.HumanoidRootPart
                for _, player in ipairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer and isCharacterValid(player.Character) then
                        local EnemyRoot = player.Character.HumanoidRootPart
                        local EnemyPosition = EnemyRoot.Position
                        local Distance = (EnemyPosition - HumanoidRootPart.Position).Magnitude
                        local Angle = findAngleDelta(
                            HumanoidRootPart.CFrame.LookVector.Unit,
                            (EnemyPosition - HumanoidRootPart.Position).Unit
                        )
                        if StabAllToggle.Value or (Distance <= ReachSlider.Value and Angle <= ReachAngleSlider.Value) then
                            firetouchinterest(EnemyRoot, Knife.Handle, 1)
                            firetouchinterest(EnemyRoot, Knife.Handle, 0)
                        end
                    end
                end
            end
        end

        -- Speed Hack
        if SpeedToggle.Value then
            character.Humanoid.WalkSpeed = 16 + SpeedSlider.Value
        else
            character.Humanoid.WalkSpeed = 16
        end

        -- Auto Pickup Gun
        if AutoGunToggle.Value and roles[LocalPlayer] == "Innocent" then
            local gundrop = Workspace:FindFirstChild("GunDrop")
            if gundrop then
                character.HumanoidRootPart.CFrame = gundrop.CFrame
            end
        end
    end
end)

-- Silent Aim hook
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
