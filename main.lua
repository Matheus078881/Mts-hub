-- [[ mt's hub v2.0 | ORION EDITION - ESTABILIDADE TOTAL ]] --

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

-- Notificação Inicial (Pra você saber que carregou)
OrionLib:MakeNotification({
    Name = "mt's hub v2.0",
    Content = "Carregando sistema de segurança...",
    Image = "rbxassetid://4483345998",
    Time = 5
})

local Window = OrionLib:MakeWindow({Name = "mt's hub v2.0 | Matheus078881", HidePremium = false, SaveConfig = true, ConfigFolder = "MTHub"})

-- ABA DE LOGIN
local TabLogin = Window:MakeTab({ Name = "Chave", Icon = "rbxassetid://4483345998", PremiumOnly = false })

TabLogin:AddTextbox({
    Name = "Insira sua Key",
    Default = "",
    TextDisappear = true,
    Callback = function(Value)
        if Value == "MATHEUS-ADMIN-2026" or Value == "MATHEUS-ADIMIN-2026" then
            OrionLib:MakeNotification({
                Name = "Acesso Liberado!",
                Content = "Bem-vindo de volta, Matheus!",
                Image = "rbxassetid://4483345998",
                Time = 5
            })
        end
    end	  
})

-- ABA DE MOVIMENTAÇÃO
local TabMov = Window:MakeTab({ Name = "Movimentação", Icon = "rbxassetid://4483345998", PremiumOnly = false })

TabMov:AddSlider({
    Name = "Velocidade",
    Min = 16,
    Max = 500,
    Default = 16,
    Color = Color3.fromRGB(255,255,255),
    Increment = 1,
    ValueName = "Speed",
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end    
})

TabMov:AddSlider({
    Name = "Pulo",
    Min = 50,
    Max = 500,
    Default = 50,
    Color = Color3.fromRGB(255,255,255),
    Increment = 1,
    ValueName = "Jump",
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
    end    
})

-- ABA MISC
local TabMisc = Window:MakeTab({ Name = "Misc", Icon = "rbxassetid://4483345998", PremiumOnly = false })

TabMisc:AddToggle({
    Name = "Anti-AFK",
    Default = false,
    Callback = function(Value)
        local vu = game:GetService("VirtualUser")
        game:GetService("Players").LocalPlayer.Idled:connect(function()
            if Value then
                vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
                wait(1)
                vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
            end
        end)
    end    
})

OrionLib:Init() -- Finaliza a criação do Hub
