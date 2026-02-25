-- [[ mt's hub v1.7.2 | FIXED TAB ERROR ]] --

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local HttpService = game:GetService("HttpService")

local Discord_Webhook = "https://discord.com/api/webhooks/1475231703873093836/lwObHISJaDHcFVwXzFee8qkYYtWhDCyg_OpwR29_Ne2MgpTpbZK220srtbDMgxtuI5JE"

-- Sistema de Keys (Aceita com ou sem o "I")
local KeysAtivas = { 
    ["MATHEUS-ADMIN-2026"] = {expira = {dia=30, mes=12, year=2026}, dono = "Matheus"},
    ["MATHEUS-ADIMIN-2026"] = {expira = {dia=30, mes=12, year=2026}, dono = "Matheus"}
}

-- Janela de Login
local Window = Fluent:CreateWindow({
    Title = "mt's hub v1.7.2",
    SubTitle = "by Matheus078881",
    TabWidth = 160, Size = UDim2.fromOffset(450, 300), Acrylic = true, Theme = "Dark"
})

local LoginTab = Window:AddTab({ Title = "Login", Icon = "lock" })
local KeyInput = LoginTab:AddInput("KeyInput", {Title = "Insira sua Key", Default = ""})

LoginTab:AddButton({
    Title = "Entrar no Hub",
    Callback = function()
        local input = KeyInput.Value
        if KeysAtivas[input] then
            -- 1. Notifica o sucesso
            Fluent:Notify({ Title = "Login", Content = "Bem-vindo, " .. KeysAtivas[input].dono .. "!", Duration = 3 })
            
            -- 2. Fecha a janela atual com segurança
            Window:Destroy()
            task.wait(0.8) -- Espera quase 1 segundo para o celular processar a limpeza

            -- 3. CRIA A NOVA JANELA (Definindo como variável local de segurança)
            local MainHub = Fluent:CreateWindow({
                Title = "mt's hub v1.7.2",
                SubTitle = "Premium Edition",
                TabWidth = 160, Size = UDim2.fromOffset(580, 460), 
                Acrylic = true, Theme = "Dark"
            })
            
            -- 4. CHECAGEM DE SEGURANÇA: Só cria as abas se o MainHub existir
            if MainHub then
                local TabGlob = MainHub:AddTab({ Title = "Global Tracker", Icon = "bell" })
                local TabMov = MainHub:AddTab({ Title = "Movimentação", Icon = "run" })
                local TabMisc = MainHub:AddTab({ Title = "Misc", Icon = "coffee" })

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
                                content = "🚨 **MT'S HUB: ALVO DETECTADO!**\n👤 Jogador: "..game.Players.LocalPlayer.Name.."\n🎮 Link: https://www.roblox.com/games/"..game.PlaceId
                            })
                            local req = syn and syn.request or http_request or request
                            if req then req({Url = Discord_Webhook, Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = payload}) end
                            task.wait(60)
                        end
                        task.wait(5)
                    end
                end)

                -- ANTI-AFK
                TabMisc:AddToggle("AntiAFK", {Title = "Ativar Anti-AFK", Default = false, Callback = function(V)
                    local VirtualUser = game:GetService("VirtualUser")
                    game.Players.LocalPlayer.Idled:Connect(function()
                        if V then
                            VirtualUser:CaptureController()
                            VirtualUser:ClickButton2(Vector2.new())
                        end
                    end)
                end})
            end

        else
            Fluent:Notify({ Title = "Erro", Content = "Key incorreta!", Duration = 5 })
        end
    end
})
