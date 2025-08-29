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
