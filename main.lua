-- [[ mt's hub v2.3 | INTERFACE NATIVA - SEM LAG ]] --

local player = game.Players.LocalPlayer
local sg = Instance.new("ScreenGui", game.CoreGui)
sg.Name = "MTHub_Final"

local main = Instance.new("Frame", sg)
main.Size = UDim2.new(0, 220, 0, 280)
main.Position = UDim2.new(0.5, -110, 0.5, -140)
main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true -- Você pode arrastar ele!

-- Arredondar bordas
local corner = Instance.new("UICorner", main)
corner.CornerRadius = UDim.new(0, 10)

-- Título
local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "MT'S HUB V2.3"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
Instance.new("UICorner", title).CornerRadius = UDim.new(0, 10)

-- Função para criar botões rápido
local function createBtn(name, pos, color, func)
    local btn = Instance.new("TextButton", main)
    btn.Name = name
    btn.Text = name
    btn.Size = UDim2.new(0.8, 0, 0, 40)
    btn.Position = pos
    btn.BackgroundColor3 = color
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    btn.MouseButton1Click:Connect(func)
    return btn
end

-- BOTÃO VELOCIDADE
createBtn("Velocidade (150)", UDim2.new(0.1, 0, 0.2, 0), Color3.fromRGB(0, 120, 255), function()
    player.Character.Humanoid.WalkSpeed = 150
end)

-- BOTÃO PULO
createBtn("Super Pulo", UDim2.new(0.1, 0, 0.4, 0), Color3.fromRGB(120, 0, 255), function()
    player.Character.Humanoid.JumpPower = 150
end)

-- BOTÃO ANTI-AFK
createBtn("Ativar Anti-AFK", UDim2.new(0.1, 0, 0.6, 0), Color3.fromRGB(0, 180, 100), function()
    local vu = game:GetService("VirtualUser")
    player.Idled:Connect(function()
        vu:CaptureController()
        vu:ClickButton2(Vector2.new())
    end)
    game:GetService("StarterGui"):SetCore("SendNotification", {Title = "MT HUB", Text = "Anti-AFK Ativado!"})
end)

-- BOTÃO FECHAR
createBtn("Fechar Script", UDim2.new(0.1, 0, 0.8, 0), Color3.fromRGB(200, 0, 0), function()
    sg:Destroy()
end)
