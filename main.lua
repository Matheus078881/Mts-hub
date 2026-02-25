-- [[ mt's hub v1.7.5 | THE FINAL FIX ]] --

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local HttpService = game:GetService("HttpService")

local Discord_Webhook = "https://discord.com/api/webhooks/1475231703873093836/lwObHISJaDHcFVwXzFee8qkYYtWhDCyg_OpwR29_Ne2MgpTpbZK220srtbDMgxtuI5JE"

-- Criamos a Janela de uma vez
local Window = Fluent:CreateWindow({
    Title = "mt's hub v1.7.5",
    SubTitle = "by Matheus078881",
    TabWidth = 160, Size = UDim2.fromOffset(580, 460), Acrylic = true, Theme = "Dark"
})

-- CRIAMOS AS ABAS LOGO NO INÍCIO (Isso evita o erro de AddTab)
local Tabs = {
    Login = Window:AddTab({ Title = "🔑 Login", Icon = "lock" }),
    Mov = Window:AddTab({ Title = "Movimentação", Icon = "run" }),
    Glob = Window:AddTab({ Title = "Global Tracker", Icon = "bell" }),
    Misc = Window:AddTab({ Title = "Misc", Icon = "coffee" })
}

-- [[ FUNÇÃO DE VELOCIDADE ]] --
Tabs.Mov:AddSlider("SpeedSlider", {
    Title = "Velocidade",
    Description = "Aumenta a velocidade do seu boneco",
    Default = 16, Min = 16, Max = 500, Rounded = 0,
    Callback = function(Value)
        if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
        end
    end
})

-- [[ GLOBAL TRACKER (WEBHOOK) ]] --
local TrackerAtivo = false
Tabs.Glob:AddToggle("TrackerToggle", {Title = "Ativar Monitoramento", Default = false, Callback = function(V) TrackerAtivo = V end})

task.spawn(function()
    while true do
        if TrackerAtivo then
            local p = HttpService:JSONEncode({content = "🚨 **ALVO DETECTADO!**\n👤: "..game.Players.LocalPlayer.Name})
            local req = syn and syn.request or http_request or request
            if req then req({Url = Discord_Webhook, Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = p}) end
            task.wait(60)
        end
        task.wait(5)
    end
end)

-- [[ ANTI-AFK ]] --
Tabs.Misc:AddToggle("AntiAFK", {Title = "Anti-AFK Ativo", Default = false, Callback = function(V)
    local VU = game:GetService("VirtualUser")
    game.Players.LocalPlayer.Idled:Connect(function()
        if V then VU:CaptureController() VU:ClickButton2(Vector2.new()) end
    end)
end})

-- [[ LOGICA DE LOGIN SIMPLIFICADA ]] --
Tabs.Login:AddInput("KeyInput", {
    Title = "Sua Chave",
    Default = "",
    Callback = function(Value)
        if Value == "MATHEUS-ADMIN-2026" or Value == "MATHEUS-ADIMIN-2026" then
            Fluent:Notify({ Title = "Sucesso!", Content = "Acesso liberado, Matheus!", Duration = 5 })
            Window:SelectTab(2) -- Pula para a aba de Movimentação
        end
    end
})

Tabs.Login:AddButton({
    Title = "Verificar Acesso",
    Callback = function()
        Fluent:Notify({ Title = "Dica", Content = "Digite a key no campo acima!", Duration = 5 })
    end
})

Window:SelectTab(1) -- Começa na aba de Login
