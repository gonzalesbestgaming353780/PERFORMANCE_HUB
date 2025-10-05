-- Universal Anti-Lag, Anti-Overheat, Boost FPS Script for Roblox
-- Place this LocalScript inside a ScreenGui with three buttons named:
-- 'AntiLagButton', 'AntiOverheatButton', 'BoostFpsButton'

-- === Configuration ===
local REQUIRED_KEY = 555 -- Set your required key here

-- === Button Setup ===
local screenGui = script.Parent
local buttons = {
    AntiLagButton = screenGui:WaitForChild("AntiLagButton"),
    AntiOverheatButton = screenGui:WaitForChild("AntiOverheatButton"),
    BoostFpsButton = screenGui:WaitForChild("BoostFpsButton"),
}

-- === Unified Button Styling ===
local buttonStyle = {
    Size = UDim2.new(0, 200, 0, 50),
    BackgroundColor3 = Color3.fromRGB(40, 120, 255),
    TextColor3 = Color3.fromRGB(255, 255, 255),
    Font = Enum.Font.GothamBold,
    TextSize = 22,
    CornerRadius = UDim.new(0, 12),
    StrokeColor = Color3.fromRGB(30, 90, 190),
    StrokeThickness = 2
}

for name, btn in pairs(buttons) do
    btn.Size = buttonStyle.Size
    btn.BackgroundColor3 = buttonStyle.BackgroundColor3
    btn.TextColor3 = buttonStyle.TextColor3
    btn.Font = buttonStyle.Font
    btn.TextSize = buttonStyle.TextSize
    -- Add rounded corners
    if not btn:FindFirstChildOfClass("UICorner") then
        local corner = Instance.new("UICorner")
        corner.CornerRadius = buttonStyle.CornerRadius
        corner.Parent = btn
    end
    -- Add border shadow
    if not btn:FindFirstChildOfClass("UIStroke") then
        local stroke = Instance.new("UIStroke")
        stroke.Color = buttonStyle.StrokeColor
        stroke.Thickness = buttonStyle.StrokeThickness
        stroke.Parent = btn
    end
end

-- === Key Check ===
-- (Replace this with your own input method if needed)
local userKey = REQUIRED_KEY  -- Directly set for demo; replace with input code for user entry!

local function hasCorrectKey()
    return userKey == REQUIRED_KEY
end

-- === Universal Optimization Functions ===
local function reduceEffects()
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("ParticleEmitter") or obj:IsA("Smoke") or obj:IsA("Fire") then
            obj.Enabled = false
        elseif obj:IsA("Trail") then
            obj.Lifetime = NumberRange.new(0)
        elseif obj:IsA("Explosion") then
            obj.Visible = false
        end
    end
end

local function lowerGraphics()
    if workspace:FindFirstChildOfClass("Terrain") then
        workspace.Terrain.Decoration = false
        workspace.Terrain.WaterTransparency = 1
    end
    if game:GetService("Lighting") then
        local lighting = game:GetService("Lighting")
        lighting.GlobalShadows = false
        lighting.FogEnd = 100000
        lighting.Brightness = 2
    end
end

local function removeTextures()
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Texture") or obj:IsA("Decal") then
            obj.Transparency = 1
        end
    end
end

local function clearDebris()
    for _, obj in ipairs(workspace:GetChildren()) do
        if obj:IsA("Tool") or obj:IsA("Accessory") then
            obj:Destroy()
        end
    end
end

-- === Button Actions ===
buttons.AntiLagButton.MouseButton1Click:Connect(function()
    if hasCorrectKey() then
        reduceEffects()
        lowerGraphics()
        clearDebris()
        print("Anti-lag applied!")
    else
        warn("Incorrect key! Cannot apply Anti-lag.")
    end
end)

buttons.AntiOverheatButton.MouseButton1Click:Connect(function()
    if hasCorrectKey() then
        lowerGraphics()
        removeTextures()
        print("Anti-Overheat applied!")
    else
        warn("Incorrect key! Cannot apply Anti-Overheat.")
    end
end)

buttons.BoostFpsButton.MouseButton1Click:Connect(function()
    if hasCorrectKey() then
        reduceEffects()
        lowerGraphics()
        removeTextures()
        clearDebris()
        print("Boost FPS applied! (Recommended for low device)")
    else
        warn("Incorrect key! Cannot apply Boost FPS.")
    end
end)
