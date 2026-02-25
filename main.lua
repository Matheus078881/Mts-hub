-- [[ mt's hub v1.8 | KAVO EDITION - ANTI-LAG ]] --

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("mt's hub v1.8", "DarkScene")

-- CONFIGURAÇÃO DO WEBHOOK
local Discord_Webhook = "https://discord.com/api/webhooks/1475231703873093836/lwObHISJaDHcFVwXzFee8qkYYtWhDCyg_OpwR29_Ne2MgpTpbZK220srtbDMgxtuI5JE"

-- ABA DE LOGIN
local TabLogin = Window:NewTab("Chave")
local SectionLogin = TabLogin:NewSection("Insira a Key abaixo:")

SectionLogin:NewTextBox("Key aqui", "Digite MATHEUS-ADMIN-2026", function(txt)
    if txt == "MATHEUS-ADMIN-2026" or txt == "MATHEUS-ADIMIN-2026" then
        print("Acesso Liberado!")
        -- Notificação simples para não bugar
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "mt's hub",
            Text = "Acesso Liberado! Use as abas ao lado.",
            Duration = 5
        })
    end
end)

-- ABA DE MOVIMENTAÇÃO
local TabMov = Window:NewTab("Movimentação")
local SectionMov = TabMov:NewSection("Controle de Velocidade")

SectionMov:NewSlider("Velocidade", "Corre igual ao Flash", 500, 16, function(s)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end)

SectionMov:NewSlider("Pulo", "Pula igual ao Hulk", 500, 50, function(p)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = p
end)

-- ABA GLOBAL (WEBHOOK)
local TabGlob = Window:NewTab("Global Tracker")
local SectionGlob = TabGlob:NewSection("Notificações Discord")

SectionGlob:NewToggle("Ativar Tracker", "Envia pro Webhook", function(state)
    _G.Tracker = state
    while _G.Tracker do
        local HttpService = game:GetService("HttpService")
        local data = {["content"] = "🚨 **ALVO:** " .. game.Players.LocalPlayer.Name}
        local request = syn and syn.request or http_request or request
        if request then
            request({Url = Discord_Webhook, Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = HttpService:JSONEncode(data)})
        end
        task.wait(60)
    end
end)

-- ABA MISC
local TabMisc = Window:NewTab("Misc")
local SectionMisc = TabMisc:NewSection("Outros")

SectionMisc:NewButton("Anti-AFK", "Não seja expulso", function()
    local vu = game:GetService("VirtualUser")
    game:GetService("Players").LocalPlayer.Idled:connect(function()
        vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        wait(1)
        vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    end)
end)
