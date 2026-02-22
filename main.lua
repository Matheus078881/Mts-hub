-- [[ mt’s hub v1 - OFFICIAL RELEASE ]] --

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local lp = Players.LocalPlayer

-- 1. CONFIGURAÇÃO DE SOM
local SomClique = Instance.new("Sound", SoundService)
SomClique.SoundId = "rbxassetid://6895079853"
SomClique.Volume = 0.5
local function click() SomClique:Play() end

-- 2. CRIAÇÃO DA INTERFACE (GUI)
local ScreenGui = Instance.new("ScreenGui", lp:WaitForChild("PlayerGui"))
ScreenGui.Name = "MtsHubV1"
ScreenGui.ResetOnSpawn = false

-- 3. FRAME PRINCIPAL (A JANELA)
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 300, 0, 220)
Main.Position = UDim2.new(0.5, -150, 0.4, 0)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Main.Active = true
Main.Draggable = true -- Essencial para Mobile!
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)

-- 4. TÍTULO COM EFEITO RGB
local Titulo = Instance.new("TextLabel", Main)
Titulo.Size = UDim2.new(1, 0, 0, 35)
Titulo.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Titulo.Text = "mt’s hub v1"
Titulo.Font = Enum.Font.GothamBold
Titulo.TextSize = 18
Instance.new("UICorner", Titulo)

RunService.RenderStepped:Connect(function()
    Titulo.TextColor3 = Color3.fromHSV(tick() % 5 / 5, 1, 1)
end)

-- 5. BOTÕES DE ABAS
local BtnFarm = Instance.new("TextButton", Main)
BtnFarm.Size = UDim2.new(0.5, 0, 0.15, 0)
BtnFarm.Position = UDim2.new(0, 0, 0.16, 0)
BtnFarm.Text = "FARM"
BtnFarm.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
BtnFarm.TextColor3 = Color3.new(1,1,1)

local BtnMisc = Instance.new("TextButton", Main)
BtnMisc.Size = UDim2.new(0.5, 0, 0.15, 0)
BtnMisc.Position = UDim2.new(0.5, 0, 0.16, 0)
BtnMisc.Text = "MISC"
BtnMisc.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
BtnMisc.TextColor3 = Color3.new(1,1,1)

-- 6. CONTEÚDO DAS ABAS
local AbaFarm = Instance.new("Frame", Main)
AbaFarm.Size = UDim2.new(1, 0, 0.65, 0)
AbaFarm.Position = UDim2.new(0, 0, 0.35, 0)
AbaFarm.BackgroundTransparency = 1

local AbaMisc = Instance.new("Frame", Main)
AbaMisc.Size = UDim2.new(1, 0, 0.65, 0)
AbaMisc.Position = UDim2.new(0, 0, 0.35, 0)
AbaMisc.BackgroundTransparency = 1
AbaMisc.Visible = false

-- 7. BOTÕES DA ABA MISC (SPEED, JUMP, ESP)
local function createBtn(name, pos, color, parent)
    local b = Instance.new("TextButton", parent)
    b.Size = UDim2.new(0.9, 0, 0.25, 0)
    b.Position = pos
    b.BackgroundColor3 = color
    b.Text = name
    b.TextColor3 = Color3.new(1,1,1)
    b.Font = Enum.Font.GothamBold
    Instance.new("UICorner", b)
    return b
end

local sBtn = createBtn("SPEED (50)", UDim2.new(0.05, 0, 0.05, 0), Color3.fromRGB(0, 150, 0), AbaMisc)
local jBtn = createBtn("JUMP (100)", UDim2.new(0.05, 0, 0.35, 0), Color3.fromRGB(0, 100, 200), AbaMisc)
local eBtn = createBtn("ESP PLAYER (OFF)", UDim2.new(0.05, 0, 0.65, 0), Color3.fromRGB(100, 0, 0), AbaMisc)

-- 8. LÓGICA DO ESP
local espAtivado = false
local function doESP()
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= lp and v.Character then
            if espAtivado then
                if not v.Character:FindFirstChild("MtsESP") then
                    local h = Instance.new("Highlight", v.Character)
                    h.Name = "MtsESP"
                    h.FillColor = Color3.new(0, 1, 0)
                end
            else
                if v.Character:FindFirstChild("MtsESP") then v.Character.MtsESP:Destroy() end
            end
        end
    end
end

-- 9. EVENTOS DOS BOTÕES
BtnFarm.MouseButton1Click:Connect(function() click() AbaFarm.Visible = true AbaMisc.Visible = false end)
BtnMisc.MouseButton1Click:Connect(function() click() AbaFarm.Visible = false AbaMisc.Visible = true end)

sBtn.MouseButton1Click:Connect(function() click() if lp.Character then lp.Character.Humanoid.WalkSpeed = 50 end end)
jBtn.MouseButton1Click:Connect(function() click() if lp.Character then lp.Character.Humanoid.JumpPower = 100 end end)
eBtn.MouseButton1Click:Connect(function() 
    click() 
    espAtivado = not espAtivado
    eBtn.Text = espAtivado and "ESP PLAYER (ON)" or "ESP PLAYER (OFF)"
    eBtn.BackgroundColor3 = espAtivado and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(100, 0, 0)
    doESP()
end)

-- 10. BOTÃO MINIMIZAR (LOGO HACKER #3)
local MinBtn = Instance.new("ImageButton", ScreenGui)
MinBtn.Size = UDim2.new(0, 60, 0, 60)
MinBtn.Position = UDim2.new(0.02, 0, 0.1, 0)
MinBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
MinBtn.Image = "rbxassetid://10829822379" -- Ícone Hacker/Skull
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(1, 0)

MinBtn.MouseButton1Click:Connect(function()
    click()
    Main.Visible = not Main.Visible
end)

print("mt’s hub v1 carregado com sucesso! Criado por um futuro mestre.")
