-- [[ mt's hub v2.2 | TESTE DIRETO NO EXECUTOR ]] --

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Button = Instance.new("TextButton")

ScreenGui.Parent = game.CoreGui
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Frame.Size = UDim2.new(0, 200, 0, 100)
Frame.Position = UDim2.new(0.5, -100, 0.5, -50)

Button.Parent = Frame
Button.Size = UDim2.new(1, 0, 1, 0)
Button.Text = "CLIQUE AQUI (TESTE)"
Button.BackgroundColor3 = Color3.fromRGB(0, 255, 0)

Button.MouseButton1Click:Connect(function()
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 150
    Button.Text = "VELOCIDADE ATIVADA!"
end)
