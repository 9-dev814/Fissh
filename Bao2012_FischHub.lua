--[[
    BẢO 2012 - Fisch Auto Farm VIP (Auto Cast, Auto Shake, Auto Reel & Anti-Ban)
]]

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local ProtectedGui = gethui and gethui() or CoreGui
if ProtectedGui:FindFirstChild("Bao2012_FischHub") then ProtectedGui.Bao2012_FischHub:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Bao2012_FischHub"
ScreenGui.ResetOnSpawn = false
if syn and syn.protect_gui then
    syn.protect_gui(ScreenGui)
    ScreenGui.Parent = ProtectedGui
else
    pcall(function() ScreenGui.Parent = ProtectedGui end)
    if not ScreenGui.Parent then ScreenGui.Parent = PlayerGui end
end

-- Toggle Button (Nút mở menu di chuyển được)
local ToggleButton = Instance.new("TextButton", ScreenGui)
ToggleButton.Size = UDim2.new(0, 130, 0, 40)
ToggleButton.Position = UDim2.new(0, 20, 0.3, 0)
ToggleButton.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
ToggleButton.Text = "🎣 BẢO 2012 HUB"
ToggleButton.TextColor3 = Color3.fromRGB(0, 255, 200)
ToggleButton.TextSize = 12
ToggleButton.Font = Enum.Font.GothamBold
Instance.new("UICorner", ToggleButton).CornerRadius = UDim.new(0, 8)
local ToggleStroke = Instance.new("UIStroke", ToggleButton)
ToggleStroke.Thickness = 2.5

-- Main Frame (420x520)
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 420, 0, 520)
Main.Position = UDim2.new(0.5, -210, 0.4, -260)
Main.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
Main.BorderSizePixel = 0
Main.Visible = false
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)

local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Thickness = 3.5

-- TopBar
local TopBar = Instance.new("Frame", Main)
TopBar.Size = UDim2.new(1, 0, 0, 36)
TopBar.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel", TopBar)
Title.Size = UDim2.new(0.6, 0, 1, 0)
Title.Position = UDim2.new(0.03, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "BẢO 2012 // FISCH AUTO FARM VIP"
Title.TextColor3 = Color3.fromRGB(0, 255, 200)
Title.TextSize = 11
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left

local Close = Instance.new("TextButton", TopBar)
Close.Size = UDim2.new(0, 26, 0, 26)
Close.Position = UDim2.new(1, -30, 0.5, -13)
Close.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
Close.Text = "X"
Close.TextColor3 = Color3.fromRGB(255, 255, 255)
Close.TextSize = 12
Close.Font = Enum.Font.GothamBold
Instance.new("UICorner", Close).CornerRadius = UDim.new(0, 5)
Close.MouseButton1Click:Connect(function() Main.Visible = false end)

local MinBtn = Instance.new("TextButton", TopBar)
MinBtn.Size = UDim2.new(0, 26, 0, 26)
MinBtn.Position = UDim2.new(1, -60, 0.5, -13)
MinBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
MinBtn.Text = "-"
MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinBtn.TextSize = 14
MinBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0, 5)

ToggleButton.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible end)

local minimized = false
MinBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    for _, child in ipairs(Main:GetChildren()) do
        if child ~= TopBar and child ~= MainStroke then
            child.Visible = not minimized
        end
    end
    MinBtn.Text = minimized and "+" or "-"
    Main.Size = minimized and UDim2.new(0, 420, 0, 36) or UDim2.new(0, 420, 0, 520)
end)

-- Neon Rainbow Animation
RunService.RenderStepped:Connect(function()
    local hue = (tick() * 0.3) % 1
    local rainbowColor = Color3.fromHSV(hue, 1, 1)
    MainStroke.Color = rainbowColor
    ToggleStroke.Color = rainbowColor
end)

-- Watermark
local Watermark = Instance.new("TextLabel", Main)
Watermark.Size = UDim2.new(1, 0, 0, 22)
Watermark.Position = UDim2.new(0, 0, 0, 38)
Watermark.BackgroundColor3 = Color3.fromRGB(15, 25, 25)
Watermark.Text = "✨ [ Bảo 2012 Hub ] - Auto Farm Fisch Siêu Cấp An Toàn ✨"
Watermark.TextColor3 = Color3.fromRGB(100, 255, 200)
Watermark.TextSize = 11
Watermark.Font = Enum.Font.GothamBold
Watermark.BorderSizePixel = 0

-- 5 Tabs System
local TabBar = Instance.new("ScrollingFrame", Main)
TabBar.Size = UDim2.new(1, -10, 0, 32)
TabBar.Position = UDim2.new(0, 5, 0, 63)
TabBar.BackgroundTransparency = 1
TabBar.CanvasSize = UDim2.new(0, 500, 0, 0)
TabBar.ScrollBarThickness = 0

local TabList = Instance.new("UIListLayout", TabBar)
TabList.FillDirection = Enum.FillDirection.Horizontal
TabList.Padding = UDim.new(0, 6)

local function createTabContent()
    local sf = Instance.new("ScrollingFrame", Main)
    sf.Size = UDim2.new(1, -10, 1, -102)
    sf.Position = UDim2.new(0, 5, 0, 98)
    sf.BackgroundTransparency = 1
    sf.CanvasSize = UDim2.new(0, 0, 0, 1200)
    sf.ScrollBarThickness = 3
    local l = Instance.new("UIListLayout", sf)
    l.Padding = UDim.new(0, 6)
    sf.Visible = false
    return sf
end

local tab1 = createTabContent() -- Auto Farm
local tab2 = createTabContent() -- Teleport / Đảo
local tab3 = createTabContent() -- Cửa Hàng / Bán Cá
local tab4 = createTabContent() -- Nhân vật & Chống Ban
local tab5 = createTabContent() -- Tiện ích & Fix Lag
tab1.Visible = true

local function createTabButton(name, targetTab)
    local btn = Instance.new("TextButton", TabBar)
    btn.Size = UDim2.new(0, 78, 1, 0)
    btn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 11
    btn.Font = Enum.Font.GothamBold
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    
    btn.MouseButton1Click:Connect(function()
        tab1.Visible = false
        tab2.Visible = false
        tab3.Visible = false
        tab4.Visible = false
        tab5.Visible = false
        targetTab.Visible = true
    end)
end

createTabButton("🎣 Auto Farm", tab1)
createTabButton("🏝️ Dịch Chuyển", tab2)
createTabButton("💰 Bán Cá", tab3)
createTabButton("🛡️ Chống Ban", tab4)
createTabButton("🚀 Tiện Ích", tab5)

local function makeBtn(parent, txt, color, cb)
    local b = Instance.new("TextButton", parent)
    b.Size = UDim2.new(1, 0, 0, 32)
    b.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    b.TextColor3 = color
    b.Text = txt
    b.TextSize = 11
    b.Font = Enum.Font.GothamBold
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    local s = Instance.new("UIStroke", b)
    s.Color = color
    s.Transparency = 0.3
    b.MouseButton1Click:Connect(cb)
    return b
end

-- TAB 1: AUTO FARM (Fisch Auto Cast, Shake, Reel)
_G.AutoCast = false
makeBtn(tab1, "🎣 Bật/Tắt Auto Quăng Cần (Auto Cast)", Color3.fromRGB(0, 255, 200), function()
    _G.AutoCast = not _G.AutoCast
    task.spawn(function()
        while _G.AutoCast do
            task.wait(1.5)
            pcall(function()
                local tool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
                if tool and tool:FindFirstChild("events") then
                    tool.events.cast:FireServer(100)
                end
            end)
        end
    end)
end)

_G.AutoShake = false
makeBtn(tab1, "⚡ Bật/Tắt Auto Lắc Cần (Auto Shake Mini-Game)", Color3.fromRGB(0, 200, 255), function()
    _G.AutoShake = not _G.AutoShake
    task.spawn(function()
        while _G.AutoShake do
            task.wait(0.1)
            pcall(function()
                local vu = game:GetService("VirtualUser")
                -- Tự động bấm nút UI lắc cần khi cá cắn
                for _, v in ipairs(PlayerGui:GetDescendants()) do
                    if v.Name == "shakeui" or v.Name == "button" then
                        if v:IsA("TextButton") or v:IsA("ImageButton") then
                            -- Gửi sự kiện click ảo an toàn
                            local pos = v.AbsolutePosition
                            vu:Button1Down(Vector2.new(pos.X + 10, pos.Y + 10))
                            task.wait(0.05)
                            vu:Button1Up(Vector2.new(pos.X + 10, pos.Y + 10))
                        end
                    end
                end
            end)
        end
    end)
end)

_G.AutoReel = false
makeBtn(tab1, "🐟 Bật/Tắt Auto Kéo Cá (Auto Reel)", Color3.fromRGB(255, 200, 0), function()
    _G.AutoReel = not _G.AutoReel
    task.spawn(function()
        while _G.AutoReel do
            task.wait(0.2)
            pcall(function()
                local tool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
                if tool and tool:FindFirstChild("events") then
                    tool.events.reeling:FireServer(100, true)
                end
            end)
        end
    end)
end)

-- TAB 2: TELEPORT (Dịch chuyển các đảo trong Fisch)
local tpBox = Instance.new("Frame", tab2)
tpBox.Size = UDim2.new(1, 0, 0, 230)
tpBox.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
Instance.new("UICorner", tpBox).CornerRadius = UDim.new(0, 6)
Instance.new("UIStroke", tpBox).Color = Color3.fromRGB(0, 180, 255)

local tpLbl = Instance.new("TextLabel", tpBox)
tpLbl.Size = UDim2.new(1, -8, 0, 25)
tpLbl.Position = UDim2.new(0, 8, 0, 5)
tpLbl.BackgroundTransparency = 1
tpLbl.Text = "🏝️ DỊCH CHUYỂN ĐẢO / KHU VỰC TRONG FISCH:"
tpLbl.TextColor3 = Color3.fromRGB(0, 180, 255)
tpLbl.TextSize = 11
tpLbl.Font = Enum.Font.GothamBold
tpLbl.TextXAlignment = Enum.TextXAlignment.Left

local fischIslands = {
    {"Spawn / Khởi Động", Vector3.new(471, 153, 229)},
    {"Moosewood (Làng Chính)", Vector3.new(382, 132, 191)},
    {"Roslit Bay (Đảo Roslit)", Vector3.new(1473, 132, 368)},
    {"Sunstone Island (Đảo Sunstone)", Vector3.new(909, 131, -1128)},
    {"Desolate Deep (Vực Sâu)", Vector3.new(3052, -260, 2962)},
    {"The Arch (Cổng Đá)", Vector3.new(1021, 131, -1297)}
}

local tpScroll = Instance.new("ScrollingFrame", tpBox)
tpScroll.Size = UDim2.new(1, -8, 0, 190)
tpScroll.Position = UDim2.new(0, 4, 0, 32)
tpScroll.BackgroundTransparency = 1
tpScroll.CanvasSize = UDim2.new(0, 0, 0, #fischIslands * 32)
tpScroll.ScrollBarThickness = 3
local tpLayout = Instance.new("UIListLayout", tpScroll)
tpLayout.Padding = UDim.new(0, 4)

for _, island in ipairs(fischIslands) do
    local b = Instance.new("TextButton", tpScroll)
    b.Size = UDim2.new(1, 0, 0, 28)
    b.BackgroundColor3 = Color3.fromRGB(20, 35, 55)
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Text = "🚀 Bay đến: " .. island[1]
    b.TextSize = 11
    b.Font = Enum.Font.GothamBold
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 4)
    b.MouseButton1Click:Connect(function()
        pcall(function()
            local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.CFrame = CFrame.new(island[2])
            end
        end)
    end)
end

-- TAB 3: BÁN CÁ & SHOP
makeBtn(tab3, "💰 Dịch Chuyển Đến NPC Bán Cá Nhanh (Sell All)", Color3.fromRGB(255, 200, 0), function()
    pcall(function()
        local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            -- Tìm NPC Sell trong Workspace
            for _, v in ipairs(Workspace:GetDescendants()) do
                if v.Name:lower():find("sell") or v.Name:lower():find("merchant") then
                    if v:FindFirstChild("HumanoidRootPart") then
                        hrp.CFrame = v.HumanoidRootPart.CFrame + Vector3.new(0, 3, 3)
                        break
                    end
                end
            end
        end
    end)
end)

makeBtn(tab3, "🛒 Mở Cửa Hàng Cần Câu / Đồ (Teleport Shop)", Color3.fromRGB(255, 150, 50), function()
    pcall(function()
        local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            for _, v in ipairs(Workspace:GetDescendants()) do
                if v.Name:lower():find("rod") or v.Name:lower():find("shop") or v.Name:lower():find("equip") then
                    if v:FindFirstChild("HumanoidRootPart") then
                        hrp.CFrame = v.HumanoidRootPart.CFrame + Vector3.new(0, 3, 3)
                        break
                    end
                end
            end
        end
    end)
end)

-- TAB 4: CHỐNG BAN (Anti-Ban & Safe AFK)
_G.AntiAFK = false
makeBtn(tab4, "🛡️ Bật/Tắt Chống Kick AFK (Anti-AFK)", Color3.fromRGB(0, 255, 120), function()
    _G.AntiAFK = not _G.AntiAFK
    task.spawn(function()
        local vu = game:GetService("VirtualUser")
        LocalPlayer.Idled:Connect(function()
            if _G.AntiAFK then
                vu:Button2Down(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
                task.wait(1)
                vu:Button2Up(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
            end
        end)
    end)
end)

makeBtn(tab4, "👻 Bật/Tắt Tàng Hình Treo Máy (Client Invisible)", Color3.fromRGB(150, 150, 255), function()
    pcall(function()
        local char = LocalPlayer.Character
        if char then
            for _, p in ipairs(char:GetDescendants()) do
                if p:IsA("BasePart") or p:IsA("Decal") then
                    p.Transparency = 1
                end
            end
        end
    end)
end)

-- TAB 5: TIỆN ÍCH & FIX LAG
makeBtn(tab5, "🚀 Kích Hoạt Fix Lag Tối Đa (Treo Máy Mượt)", Color3.fromRGB(0, 255, 200), function()
    pcall(function()
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 9e9
        for _, v in ipairs(Workspace:GetDescendants()) do
            if v:IsA("Part") or v:IsA("MeshPart") then
                v.Material = Enum.Material.SmoothPlastic
                v.Reflectance = 0
            elseif v:IsA("ParticleEmitter") or v:IsA("Fire") or v:IsA("Smoke") then
                v.Enabled = false
            end
        end
    end)
end)

makeBtn(tab5, "🌙 Bật Fullbright (Xóa Tối Biển Đêm)", Color3.fromRGB(255, 255, 100), function()
    pcall(function()
        Lighting.Brightness = 2
        Lighting.ClockTime = 14
        Lighting.FogEnd = 100000
        Lighting.GlobalShadows = false
        Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
    end)
end)

-- Draggable handler
local function makeDraggable(obj, handle)
    local dragging, dragStart, startPos
    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = obj.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            obj.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end

makeDraggable(Main, TopBar)
makeDraggable(ToggleButton, ToggleButton)
