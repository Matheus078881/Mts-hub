-- [[ mt's hub v1.6 | DISCORD GLOBAL TRACKER ]] --

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local HttpService = game:GetService("HttpService")

-- ==========================================
-- CONFIGURAÇÕES (WEBHOOK E KEYS)
-- ==========================================
local Discord_Webhook = "https://discord.com/api/webhooks/1475231703873093836/lwObHISJaDHcFVwXzFee8qkYYtWhDCyg_OpwR29_Ne2MgpTpbZK220srtbDMgxtuI5JE" -- COLA O TEU LINK DO DISCORD AQUI!

local KeysAtivas = {
    ["MATHEUS-ADMIN-2026"] = {expira = {dia=30, mes=12, year=2026}, dono = "Matheus (Dono)"},
    ["KEY-CLIENTE-77"] = {expira = {dia=01, mes=04, year=2026}, dono = "Utilizador VIP"},
}
-- ==========================================

local function EnviarAoDiscord(mensagem)
    if Discord_Webhook == "https://discord.com/api/webhooks/1475231703873093836/lwObHISJaDHcFVwXzFee8qkYYtWhDCyg_OpwR29_Ne2MgpTpbZK220srtbDMgxtuI5JE" then return end
    local data = { ["content"] = mensagem }
    local payload = HttpService:JSONEncode(data)
    -- Nota: Alguns executores precisam de request ou http_request
    local request = syn and syn.request or http_request or request or (http and http.request)
    if request then
        request({ Url = Discord_Webhook, Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = payload })
    end
end

local function ChecarKey(input)
    if KeysAtivas[input] then
        local data = KeysAtivas[input].expira
        local expiraTime = os.time({day=data.dia, month=data.mes, year=data.year or 2026, hour=23})
        if os.time() <= expiraTime then return true, "Bem-vindo, " .. KeysAtivas[input].dono end
    end
    return false, "Key inválida ou expirada!"
end

-- [[ JANELA DE LOGIN ]] --
local Window = Fluent:CreateWindow({
    Title = "mt's hub v1.6 | GLOBAL TRACKER",
    SubTitle = "by Matheus078881",
    TabWidth = 160, Size = UDim2.fromOffset(450, 300), Acrylic = true, Theme = "Dark"
})

local LoginTab = Window:AddTab({ Title = "Login", Icon = "lock" })
local KeyInput = LoginTab:AddInput("KeyInput", {Title = "Chave de Acesso", Default = ""})

LoginTab:AddButton({
    Title = "Entrar",
    Callback = function()
        local sucesso, msg = ChecarKey(KeyInput.Value)
        if sucesso then
            Window:Destroy() 
            
            local MainHub = Fluent:CreateWindow({
                Title = "mt's hub v1.6", SubTitle = "Discord Integrated",
                TabWidth = 160, Size = UDim2.fromOffset(580, 460), Acrylic = true, Theme = "Dark"
            })
            
            local TabGlob = MainHub:AddTab({ Title = "Global Notifier", Icon = "bell" })
            local TabMov = MainHub:AddTab({ Title = "Movimentação", Icon = "run" })

            -- [[ LÓGICA DO BRAINROT NOTIFIER ]] --
            local BrainrotAtivo = false
            TabGlob:AddToggle("TrackerToggle", {Title = "Monitorar Brainrot (>10M/s)", Default = false, 
                Callback = function(V) BrainrotAtivo = V end
            })

            -- Loop que verifica o valor (Exemplo: monitorando uma Leaderstat ou Variável)
            task.spawn(function()
                while true do
                    if BrainrotAtivo then
                        -- Aqui simulamos a verificação. Na prática, podes ligar ao valor real do jogo:
                        local valorAtual = 11 -- Exemplo: game.Players.LocalPlayer.leaderstats.Brainrot.Value
                        
                        if valorAtual >= 10 then
                            local msgLink = "🚨 **ALVO DETECTADO!**\nJogador: " .. game.Players.LocalPlayer.Name .. "\nBrainrot: " .. valorAtual .. "M/s\nJobId: " .. game.JobId
                            EnviarAoDiscord(msgLink)
                            Fluent:Notify({ Title = "Notificação Enviada", Content = "Alvo enviado para o Discord!", Duration = 5 })
                            task.wait(60) -- Espera 1 minuto para não encher o Discord de spam
                        end
                    end
                    task.wait(5)
                end
            end)

            -- [[ FUNÇÕES DE MOVIMENTO ]] --
            TabMov:AddSlider("Speed", { Title = "Velocidade", Default = 16, Min = 16, Max = 300, Callback = function(V) game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = V end })

            Fluent:Notify({ Title = "mt's hub v1.6", Content = "Sistema de Rastreio Ativo!", Duration = 3 })
        else
            Fluent:Notify({ Title = "Erro", Content = msg, Duration = 5 })
        end
    end
})
