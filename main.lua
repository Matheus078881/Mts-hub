-- [[ mt's hub v2.1 | VERSÃO ULTRA-COMPATÍVEL ]] --

-- Se já existir um hub, ele apaga o antigo para não bugar
if game.CoreGui:FindFirstChild("MT_Hub_Raiz") then
    game.CoreGui.MT_Hub_Raiz:Destroy()
end

-- CRIAÇÃO DA INTERFACE MANUAL
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local SpeedBtn = Instance.new("TextButton")
local JumpBtn = Instance.new("TextButton")
local CloseBtn = Instance.new("TextButton")

ScreenGui.Name = "MT_Hub_Raiz"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

-- Fundo do Menu
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 2
MainFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
MainFrame.Size = UDim2.new(0, 200, 0, 250)
MainFrame.Active = true
MainFrame.Draggable = true -- Você pode arrastar na tela!

-- Título
Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "mt's hub v2.1"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

-- Botão de Velocidade
SpeedBtn.Parent = MainFrame
SpeedBtn.Position = UDim2.new(0.1, 0, 0.2, 0)
SpeedBtn.Size = UDim2.new(0.8, 0, 0, 40)
SpeedBtn.Text = "Velocidade (100)"
SpeedBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
SpeedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

SpeedBtn.MouseButton1Click:Connect(function()
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 100
    print("Velocidade Ativada!")
end)

-- Botão de Pulo
JumpBtn.Parent = MainFrame
JumpBtn.Position = UDim2.new(0.1, 0, 0.45, 0)
JumpBtn.Size = UDim2.new(0.8, 0, 0, 40)
JumpBtn.Text = "Pulo (150)"
JumpBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
JumpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

JumpBtn.MouseButton1Click:Connect(function()
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = 150
end)

-- Botão de Fechar
CloseBtn.Parent = MainFrame
CloseBtn.Position = UDim2.new(0.1, 0, 0.75, 0)
CloseBtn.Size = UDim2.new(0.8, 0, 0, 40)
CloseBtn.Text = "Fechar Hub"
CloseBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)
