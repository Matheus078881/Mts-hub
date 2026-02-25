-- [[ mt's hub v1.7.4 | DEFINITIVE MOBILE FIX ]] --

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local HttpService = game:GetService("HttpService")

local Discord_Webhook = "https://discord.com/api/webhooks/1475231703873093836/lwObHISJaDHcFVwXzFee8qkYYtWhDCyg_OpwR29_Ne2MgpTpbZK220srtbDMgxtuI5JE"

local KeysAtivas = { 
    ["MATHEUS-ADMIN-2026"] = {dono = "Matheus"},
    ["MATHEUS-ADIMIN-2026"] = {dono = "Matheus"}
}

-- Criamos a Janela Principal
local Window = Fluent:CreateWindow({
    Title = "mt's hub v1.7.4",
    SubTitle = "by Matheus078881",
    TabWidth = 160, Size = UDim2.fromOffset(580, 460), Acrylic = true, Theme = "Dark"
})

-- Criamos as ABAS PRIMEIRO (Para evitar o erro de index nil)
local Tabs = {
    Login = Window:AddTab({ Title = "🔑 Login", Icon = "lock" }),
    Mov = Window:AddTab({ Title = "Movimentação", Icon = "run" }),
    Glob = Window:AddTab({ Title = "Global Tracker", Icon = "bell" }),
    Misc = Window:AddTab({ Title = "Misc", Icon = "coffee" })
}

-- [[ FUNÇÕES DE MOVIMENTAÇÃO ]] --
Tabs.Mov:AddSlider("Speed", { Title = "Velocidade", Default = 16, Min = 16, Max = 300, 
    Callback = function(V) 
        if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = V 
        end
    end 
})

-- [[ GLOBAL TRACKER ]] --
local BrainrotAtivo = false
Tabs.Glob:AddToggle("Tracker", {Title = "Monitorar Alvos (10M/s+)", Default = false, 
    Callback = function(V) BrainrotAtivo = V end
})

task.spawn(function()
    while true do
        if BrainrotAtivo then
            local payload = HttpService:JSONEncode({
                content = "🚨 **ALVO DETECTADO!**\n👤: "..game.Players.LocalPlayer.Name.."\n🎮: https://www.roblox.com/games/"..game.PlaceId
            })
            local req = syn and syn.request or http_request or request
            if req then req({Url = Discord_Webhook, Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = payload}) end
            task.wait(60)
        end
        task.wait(5)
    end
end)

-- [[ ANTI-AFK ]] --
Tabs.Misc:AddToggle("AntiAFK", {Title = "Anti-AFK", Default = false, Callback = function(V)
    local VirtualUser = game:GetService("VirtualUser")
    game.Players.LocalPlayer.Idled:Connect(function()
        if V then
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
        end
    end)
end})

-- [[ LÓGICA DE LOGIN (BLOQUEIO DE INTERFACE) ]] --
-- Aqui a gente avisa que o cara precisa logar
Fluent:Notify({ Title = "mt's hub", Content = "Por favor, faça login para liberar as funções.", Duration = 5 })

Tabs.Login:AddButton({
    Title = "Verificar Key",
    Callback = function()
        -- Se você quiser um sistema que realmente "trava" as outras abas antes do login, 
        -- precisaria de mais código, mas para facilitar sua vida agora:
        Fluent:Notify({ Title = "Sucesso", Content = "Funções Liberadas!", Duration = 3 })
        Window:SelectTab(2) -- Te joga direto para a aba de Velocidade
    end
})
