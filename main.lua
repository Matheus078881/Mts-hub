-- [[ mt's hub v1.7.3 | TOTAL FIX - NO RELOAD ]] --

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local HttpService = game:GetService("HttpService")

local Discord_Webhook = "https://discord.com/api/webhooks/1475231703873093836/lwObHISJaDHcFVwXzFee8qkYYtWhDCyg_OpwR29_Ne2MgpTpbZK220srtbDMgxtuI5JE"

local KeysAtivas = { 
    ["MATHEUS-ADMIN-2026"] = {expira = {dia=30, mes=12, year=2026}, dono = "Matheus"},
    ["MATHEUS-ADIMIN-2026"] = {expira = {dia=30, mes=12, year=2026}, dono = "Matheus"}
}

-- Criamos uma única janela para tudo
local Window = Fluent:CreateWindow({
    Title = "mt's hub v1.7.3",
    SubTitle = "by Matheus078881",
    TabWidth = 160, Size = UDim2.fromOffset(580, 460), Acrylic = true, Theme = "Dark"
})

-- ABA DE LOGIN (Sempre aparece primeiro)
local LoginTab = Window:AddTab({ Title = "🔑 Login", Icon = "lock" })
local KeyInput = LoginTab:AddInput("KeyInput", {Title = "Insira sua Key", Default = ""})

LoginTab:AddButton({
    Title = "Verificar Key",
    Callback = function()
        local input = KeyInput.Value
        if KeysAtivas[input] then
            Fluent:Notify({ Title = "Login", Content = "Acesso Liberado, Matheus!", Duration = 3 })
            
            -- AGORA CRIAMOS AS OUTRAS ABAS APENAS APÓS O LOGIN
            local TabGlob = Window:AddTab({ Title = "Global Tracker", Icon = "bell" })
            local TabMov = Window:AddTab({ Title = "Movimentação", Icon = "run" })
            local TabMisc = Window:AddTab({ Title = "Misc", Icon = "coffee" })

            -- FUNÇÕES DE MOVIMENTAÇÃO
            TabMov:AddSlider("Speed", { Title = "Velocidade", Default = 16, Min = 16, Max = 300, 
                Callback = function(V) 
                    if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
                        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = V 
                    end
                end 
            })

            -- GLOBAL TRACKER (WEBHOOK)
            local BrainrotAtivo = false
            TabGlob:AddToggle("Tracker", {Title = "Monitorar Alvos (10M/s+)", Default = false, 
                Callback = function(V) BrainrotAtivo = V end
            })

            task.spawn(function()
                while true do
                    if BrainrotAtivo then
                        local payload = HttpService:JSONEncode({
                            content = "🚨 **MT'S HUB: ALVO!**\n👤: "..game.Players.LocalPlayer.Name.."\n🎮: https://www.roblox.com/games/"..game.PlaceId
                        })
                        local req = syn and syn.request or http_request or request
                        if req then req({Url = Discord_Webhook, Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = payload}) end
                        task.wait(60)
                    end
                    task.wait(5)
                end
            end)

            -- ANTI-AFK
            TabMisc:AddToggle("AntiAFK", {Title = "Anti-AFK", Default = false, Callback = function(V)
                local VirtualUser = game:GetService("VirtualUser")
                game.Players.LocalPlayer.Idled:Connect(function()
                    if V then
                        VirtualUser:CaptureController()
                        VirtualUser:ClickButton2(Vector2.new())
                    end
                end)
            end})

            -- Abre a primeira aba nova automaticamente
            Window:SelectTab(2) 
            
            -- Avisa que deu certo
            Fluent:Notify({ Title = "Sucesso", Content = "Abas carregadas com segurança!", Duration = 3 })
        else
            Fluent:Notify({ Title = "Erro", Content = "Key incorreta!", Duration = 5 })
        end
    end
})
