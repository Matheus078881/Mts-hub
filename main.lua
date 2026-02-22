-- [[ mt's hub v1.2 | TUDO EM UM | LOGIN + FLY + INF JUMP + ESP ]] --

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

-- ==========================================
-- GESTÃO DE KEYS (O SEU PAINEL)
-- ==========================================
local KeysAtivas = {
    ["MATHEUS-ADMIN-2026"] = {expira = {dia=30, mes=12, year=2026}, dono = "Matheus (Dono)"},
    ["KEY-CLIENTE-77"] = {expira = {dia=01, mes=04, year=2026}, dono = "Utilizador VIP"},
}
-- ==========================================

local function ChecarKey(input)
    if KeysAtivas[input] then
        local data = KeysAtivas[input].expira
        local expiraTime = os.time({day=data.dia, month=data.mes, year=data.year or 2026, hour=23})
        if os.time() <= expiraTime then
            return true, "Bem-vindo, " .. KeysAtivas[input].dono
        else
            return false, "Esta Key expirou! Contacta o Matheus."
        end
    end
    return false, "Key inválida!"
end

-- [[ JANELA DE LOGIN ]] --
local Window = Fluent:CreateWindow({
    Title = "mt's hub v1.2 | LOGIN SYSTEM",
    SubTitle = "by Matheus078881",
    TabWidth = 160, Size = UDim2.fromOffset(450, 300), Acrylic = true, Theme = "Dark"
})

local LoginTab = Window:AddTab({ Title = "Login", Icon = "lock" })
local KeyInput = LoginTab:AddInput("KeyInput", {Title = "Insere a tua Key", Default = "", Placeholder = "Cola aqui..."})

LoginTab:AddButton({
    Title = "Verificar e Entrar",
    Callback = function()
        local sucesso, msg = ChecarKey(KeyInput.Value)
        
        if sucesso then
            Fluent:Notify({ Title = "Acesso Permitido", Content = msg, Duration = 5 })
            Window:Destroy() 
            
            -- [[ INTERFACE PRINCIPAL DO HUB ]] --
            local MainHub = Fluent:CreateWindow({
                Title = "mt's hub v1.2", SubTitle = "Premium Edition",
                TabWidth = 160, Size = UDim2.fromOffset(580, 460), Acrylic = true, Theme = "Dark"
            })
            
            local TabMov = MainHub:AddTab({ Title = "Movimentação", Icon = "run" })
            local TabVis = MainHub:AddTab({ Title = "Visual (ESP)", Icon = "eye" })

            -- [[ FUNÇÕES DE MOVIMENTAÇÃO ]] --
            TabMov:AddSlider("WalkSpeed", { Title = "Velocidade", Default = 16, Min = 16, Max = 300, Rounding = 1,
                Callback = function(V) game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = V end
            })

            local InfJump = false
            TabMov:AddToggle("InfJump", {Title = "Pulo Infinito", Default = false, Callback = function(V) InfJump = V end})
            game:GetService("UserInputService").JumpRequest:Connect(function()
                if InfJump then game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping") end
            end)

            local FlyEnabled = false
            TabMov:AddToggle("Fly", {Title = "Voar", Default = false, Callback = function(V)
                FlyEnabled = V
                local root = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
                if FlyEnabled then
                    local bv = Instance.new("BodyVelocity", root)
                    bv.Name = "FlyVel"
                    task.spawn(function()
                        while FlyEnabled do
                            bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
                            bv.Velocity = game.Players.LocalPlayer.Character.Humanoid.MoveDirection * 50
                            task.wait()
                        end
                        bv:Destroy()
                    end)
                end
            end})

            -- [[ FUNÇÃO VISUAL: ESP (BOX) ]] --
            TabVis:AddToggle("ESP", {Title = "Ver Jogadores (ESP)", Default = false, Callback = function(Value)
                _G.ESP = Value
                while _G.ESP do
                    for _, player in pairs(game.Players:GetPlayers()) do
                        if player ~= game.Players.LocalPlayer and player.Character and not player.Character:FindFirstChild("Highlight") then
                            local hl = Instance.new("Highlight", player.Character)
                            hl.FillColor = Color3.fromRGB(255, 0, 0)
                            hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                        end
                    end
                    task.wait(1)
                    if not _G.ESP then
                        for _, p in pairs(game.Players:GetPlayers()) do
                            if p.Character and p.Character:FindFirstChild("Highlight") then p.Character.Highlight:Destroy() end
                        end
                    end
                end
            end})

            Fluent:Notify({ Title = "Sucesso", Content = "Hub Carregado!", Duration = 3 })
        else
            Fluent:Notify({ Title = "Erro", Content = msg, Duration = 5 })
        end
    end
})
