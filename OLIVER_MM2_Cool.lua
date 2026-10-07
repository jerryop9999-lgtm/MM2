--========================================================
-- OLIVER - MM2 | COOL UI
-- Delta / LocalScript
--========================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")

local LP = Players.LocalPlayer
local PlayerGui = LP:WaitForChild("PlayerGui")

--========================================================
-- CONFIG
--========================================================

local LOGO_ID = "rbxassetid://132347212228560"
local BACKGROUND_ID = "rbxassetid://131522091567355"

local ESP_ENABLED = false
local NOCLIP_ENABLED = false

--========================================================
-- REMOVE OLD
--========================================================

local old = PlayerGui:FindFirstChild("OLIVER_MM2")
if old then old:Destroy() end

--========================================================
-- SCREEN GUI
--========================================================

local Gui = Instance.new("ScreenGui")
Gui.Name = "OLIVER_MM2"
Gui.ResetOnSpawn = false
Gui.IgnoreGuiInset = true
Gui.DisplayOrder = 999999
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Global
Gui.Parent = PlayerGui

--========================================================
-- DRAG
--========================================================

local function Drag(obj)
    local dragging = false
    local startInput
    local startPos

    obj.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

            dragging = true
            startInput = input.Position
            startPos = obj.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if not dragging then return end

        if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then

            local delta = input.Position - startInput

            obj.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
end

--========================================================
-- FLOATING LOGO BUTTON
--========================================================

local Float = Instance.new("ImageButton")
Float.Name = "FloatingButton"
Float.Parent = Gui
Float.Size = UDim2.fromOffset(52,52)
Float.Position = UDim2.new(0,18,0.5,-26)
Float.BackgroundColor3 = Color3.fromRGB(20,20,24)
Float.BorderSizePixel = 0
Float.Image = LOGO_ID
Float.ScaleType = Enum.ScaleType.Crop
Float.AutoButtonColor = false
Float.ZIndex = 999999

local fc = Instance.new("UICorner")
fc.CornerRadius = UDim.new(1,0)
fc.Parent = Float

local fs = Instance.new("UIStroke")
fs.Thickness = 2
fs.Transparency = 0.1
fs.Color = Color3.fromRGB(255,255,255)
fs.Parent = Float

Drag(Float)

--========================================================
-- MAIN FRAME
--========================================================

local Main = Instance.new("Frame")
Main.Name = "MainFrame"
Main.Parent = Gui
Main.Size = UDim2.fromOffset(300,245)
Main.Position = UDim2.new(0.5,-150,0.5,-122)
Main.BackgroundColor3 = Color3.fromRGB(15,15,19)
Main.BorderSizePixel = 0
Main.ZIndex = 100
Main.ClipsDescendants = true

local mc = Instance.new("UICorner")
mc.CornerRadius = UDim.new(0,18)
mc.Parent = Main

local ms = Instance.new("UIStroke")
ms.Thickness = 1.5
ms.Transparency = 0.15
ms.Color = Color3.fromRGB(255,255,255)
ms.Parent = Main

--========================================================
-- BACKGROUND
--========================================================

local BG = Instance.new("ImageLabel")
BG.Parent = Main
BG.Size = UDim2.fromScale(1,1)
BG.BackgroundTransparency = 1
BG.Image = BACKGROUND_ID
BG.ScaleType = Enum.ScaleType.Crop
BG.ImageTransparency = 0.55
BG.ZIndex = 101

local bgc = Instance.new("UICorner")
bgc.CornerRadius = UDim.new(0,18)
bgc.Parent = BG

local Dark = Instance.new("Frame")
Dark.Parent = Main
Dark.Size = UDim2.fromScale(1,1)
Dark.BackgroundColor3 = Color3.fromRGB(0,0,0)
Dark.BackgroundTransparency = 0.35
Dark.BorderSizePixel = 0
Dark.ZIndex = 102

local dc = Instance.new("UICorner")
dc.CornerRadius = UDim.new(0,18)
dc.Parent = Dark

--========================================================
-- TOP BAR / DRAG AREA
--========================================================

local Top = Instance.new("Frame")
Top.Parent = Main
Top.Size = UDim2.new(1,0,0,58)
Top.BackgroundTransparency = 1
Top.ZIndex = 110
Top.Active = true

-- Drag the MAIN FRAME, not the OLIVER title object itself.
-- The title stays attached to Main and cannot move separately.
do
    local dragging = false
    local dragStart
    local startPos

    Top.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = Main.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if not dragging then return end

        if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then
            local delta = input.Position - dragStart

            Main.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
end

local Title = Instance.new("TextLabel")
Title.Parent = Top
Title.Size = UDim2.new(1,-30,1,0)
Title.Position = UDim2.fromOffset(15,0)
Title.BackgroundTransparency = 1
Title.Text = "OLIVER"
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.TextSize = 23
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.ZIndex = 111
Title.Active = false
Title.Selectable = false

--========================================================
-- WHITE EMOJI ICON
--========================================================

local SubTitle = Instance.new("TextLabel")
SubTitle.Parent = Top
SubTitle.Size = UDim2.new(1,-30,0,22)
SubTitle.Position = UDim2.fromOffset(15,35)
SubTitle.BackgroundTransparency = 1
SubTitle.Text = "⚔️  MM2"
SubTitle.TextColor3 = Color3.fromRGB(255,255,255)
SubTitle.TextTransparency = 0.15
SubTitle.TextSize = 12
SubTitle.Font = Enum.Font.GothamMedium
SubTitle.TextXAlignment = Enum.TextXAlignment.Left
SubTitle.ZIndex = 111

--========================================================
-- TOGGLE CREATOR
--========================================================
local UpdateESP
local RemoveESP
local SetNoclip
local ESP = {}


local function MakeToggle(y, label, emoji, callback)
    local Holder = Instance.new("Frame")
    Holder.Parent = Main
    Holder.Size = UDim2.new(1,-24,0,58)
    Holder.Position = UDim2.fromOffset(12,y)
    Holder.BackgroundColor3 = Color3.fromRGB(24,24,29)
    Holder.BorderSizePixel = 0
    Holder.ZIndex = 120

    local hc = Instance.new("UICorner")
    hc.CornerRadius = UDim.new(0,14)
    hc.Parent = Holder

    local hs = Instance.new("UIStroke")
    hs.Thickness = 1
    hs.Transparency = 0.45
    hs.Color = Color3.fromRGB(255,255,255)
    hs.Parent = Holder

    local Icon = Instance.new("TextLabel")
    Icon.Parent = Holder
    Icon.Size = UDim2.fromOffset(34,58)
    Icon.Position = UDim2.fromOffset(10,0)
    Icon.BackgroundTransparency = 1
    Icon.Text = emoji
    Icon.TextColor3 = Color3.fromRGB(255,255,255)
    Icon.TextSize = 21
    Icon.Font = Enum.Font.Gotham
    Icon.ZIndex = 121

    local Text = Instance.new("TextLabel")
    Text.Parent = Holder
    Text.Size = UDim2.new(1,-120,1,0)
    Text.Position = UDim2.fromOffset(48,0)
    Text.BackgroundTransparency = 1
    Text.Text = label
    Text.TextColor3 = Color3.fromRGB(255,255,255)
    Text.TextSize = 14
    Text.Font = Enum.Font.GothamSemibold
    Text.TextXAlignment = Enum.TextXAlignment.Left
    Text.ZIndex = 121

    -- Toggle shaped like the reference image
    local Toggle = Instance.new("TextButton")
    Toggle.Parent = Holder
    Toggle.Size = UDim2.fromOffset(78,36)
    Toggle.Position = UDim2.new(1,-88,0.5,-18)
    Toggle.BackgroundColor3 = Color3.fromRGB(105,105,110)
    Toggle.BorderSizePixel = 0
    Toggle.Text = ""
    Toggle.AutoButtonColor = false
    Toggle.ZIndex = 122

    local tc = Instance.new("UICorner")
    tc.CornerRadius = UDim.new(1,0)
    tc.Parent = Toggle

    local Knob = Instance.new("Frame")
    Knob.Parent = Toggle
    Knob.Size = UDim2.fromOffset(30,30)
    Knob.Position = UDim2.fromOffset(3,3)
    Knob.BackgroundColor3 = Color3.fromRGB(255,255,255)
    Knob.BorderSizePixel = 0
    Knob.ZIndex = 123

    local kc = Instance.new("UICorner")
    kc.CornerRadius = UDim.new(1,0)
    kc.Parent = Knob

    local State = Instance.new("TextLabel")
    State.Parent = Toggle
    State.Size = UDim2.fromScale(1,1)
    State.BackgroundTransparency = 1
    State.Text = "OFF"
    State.TextColor3 = Color3.fromRGB(255,255,255)
    State.TextSize = 10
    State.Font = Enum.Font.GothamBold
    State.ZIndex = 124

    local on = false

    local function SetState(value)
        on = value

        if on then
            Toggle.BackgroundColor3 = Color3.fromRGB(65,205,95)
            Knob.Position = UDim2.new(1,-33,0,3)
            State.Text = "ON"
        else
            Toggle.BackgroundColor3 = Color3.fromRGB(105,105,110)
            Knob.Position = UDim2.fromOffset(3,3)
            State.Text = "OFF"
        end
    end

    -- Use Activated so it works reliably with both mouse and mobile touch.
    Toggle.Activated:Connect(function()
        local newState = not on
        SetState(newState)
        if callback then
            task.spawn(callback, newState)
        end
    end)

    return Toggle, SetState
end

--========================================================
-- ESP
--========================================================

local ESPToggle, SetESPVisual = MakeToggle(
    70,
    "ESP BOX Frame",
    "👁️",
    function(state)
        ESP_ENABLED = state
        if state then
            UpdateESP()
        else
            for player in pairs(ESP) do
                RemoveESP(player)
            end
        end
    end
)

--========================================================
-- NOCLIP
--========================================================

local NoclipToggle, SetNoclipVisual = MakeToggle(
    138,
    "NOCLIP",
    "🪽",
    function(state)
        NOCLIP_ENABLED = state
        SetNoclip(state)
    end
)

--========================================================
-- ROLE DETECTION
--========================================================

local function HasTool(player, name)
    local char = player.Character
    if char and char:FindFirstChild(name) then
        return true
    end

    local backpack = player:FindFirstChildOfClass("Backpack")
    if backpack and backpack:FindFirstChild(name) then
        return true
    end

    return false
end

local function GetRole(player)
    if HasTool(player,"Knife") then
        return "Murderer"
    end

    if HasTool(player,"Gun") or HasTool(player,"Revolver") then
        return "Sheriff"
    end

    return nil
end

--========================================================
-- ESP BOX
--========================================================

RemoveESP = function(player)
    local data = ESP[player]
    if not data then return end

    if data.Box then data.Box:Destroy() end
    if data.Label then data.Label:Destroy() end

    ESP[player] = nil
end

local function CreateESP(player, role)
    if player == LP then return end

    local char = player.Character
    if not char then return end

    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end

    local color

    if role == "Murderer" then
        color = Color3.fromRGB(255,55,55)
    elseif role == "Sheriff" then
        color = Color3.fromRGB(60,150,255)
    else
        return
    end

    RemoveESP(player)

    -- Real rectangular frame around the character
    local box = Instance.new("BoxHandleAdornment")
    box.Name = "OLIVER_ESP_BOX"
    box.Adornee = root
    box.AlwaysOnTop = true
    box.ZIndex = 10
    box.Size = Vector3.new(4.2,6.2,2.2)
    box.Color3 = color
    box.Transparency = 0.45
    box.Parent = root

    local label = Instance.new("BillboardGui")
    label.Name = "OLIVER_ROLE"
    label.Adornee = root
    label.Size = UDim2.fromOffset(170,34)
    label.StudsOffset = Vector3.new(0,4,0)
    label.AlwaysOnTop = true
    label.Parent = Gui

    local txt = Instance.new("TextLabel")
    txt.Parent = label
    txt.Size = UDim2.fromScale(1,1)
    txt.BackgroundTransparency = 1
    txt.Text = player.DisplayName .. "  [" .. role .. "]"
    txt.TextColor3 = color
    txt.TextStrokeTransparency = 0
    txt.TextStrokeColor3 = Color3.fromRGB(0,0,0)
    txt.TextSize = 13
    txt.Font = Enum.Font.GothamBold

    ESP[player] = {
        Box = box,
        Label = label,
        Role = role,
        Character = char
    }
end

UpdateESP = function()
    if not ESP_ENABLED then
        for player in pairs(ESP) do
            RemoveESP(player)
        end
        return
    end

    -- Rebuild the role ESP when needed.
    -- This makes OFF -> ON reliable and also updates
    -- the color/role when a player's role changes.
    for _,player in ipairs(Players:GetPlayers()) do
        if player ~= LP then
            local role = GetRole(player)

            if role == "Murderer" or role == "Sheriff" then
                local current = ESP[player]

                if current and current.Role == role
                    and current.Character == player.Character then
                    -- Current ESP is still valid.
                else
                    RemoveESP(player)
                    CreateESP(player, role)
                end
            else
                RemoveESP(player)
            end
        end
    end
end

--========================================================
-- NOCLIP
--========================================================

SetNoclip = function(state)
    local char = LP.Character
    if not char then return end

    for _,obj in ipairs(char:GetDescendants()) do
        if obj:IsA("BasePart") then
            obj.CanCollide = not state
        end
    end
end

RunService.Stepped:Connect(function()
    if NOCLIP_ENABLED then
        SetNoclip(true)
    end
end)

--========================================================
-- RESPAWN / PLAYER EVENTS
--========================================================

LP.CharacterAdded:Connect(function()
    task.wait(1)

    if NOCLIP_ENABLED then
        SetNoclip(true)
    end

    if ESP_ENABLED then
        UpdateESP()
    end
end)

Players.PlayerRemoving:Connect(function(player)
    RemoveESP(player)
end)

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        task.wait(0.5)
        if ESP_ENABLED then
            UpdateESP()
        end
    end)
end)

--========================================================
-- ESP LOOP
--========================================================

task.spawn(function()
    while task.wait(0.25) do
        if ESP_ENABLED then
            UpdateESP()
        end
    end
end)

--========================================================
-- FLOAT OPEN / CLOSE
--========================================================

Float.Activated:Connect(function()
    Main.Visible = not Main.Visible
end)

print("OLIVER - MM2 Cool UI loaded")
