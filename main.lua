-- [[ SISTEMA DE KEYS PROFISSIONAL - mt's hub v1 ]] --

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

-- ==========================================
-- GESTÃO DE CLIENTES (O TEU PAINEL DE CONTROLO)
-- ==========================================
local KeysAtivas = {
    ["MATHEUS-ADMIN-2026"] = {expira = {dia=30, mes=12, ano=2026}, dono = "Matheus (Dono)"}
}
-- ==========================================

local function ChecarKey(input)
    if KeysAtivas[input] then
        local data = KeysAtivas[input].expira
        local expiraTime = os.time({day=data.dia, month=data.mes, year=data.ano, hour=23})
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
    Title = "mt's hub v1 | LOGIN SYSTEM",
    SubTitle = "by Matheus078881",
    TabWidth = 160, Size = UDim2.fromOffset(450, 300), Acrylic = true, Theme = "Dark"
})

local LoginTab = Window:AddTab({ Title = "Login", Icon = "lock" })

local KeyInput = LoginTab:AddInput("KeyInput", {
    Title = "Insere a tua Key",
    Default = "",
    Placeholder = "Cola a tua chave aqui...",
    Callback = function(Value) end
})

LoginTab:AddButton({
    Title = "Verificar e Entrar",
    Description = "Clica para validar o teu acesso",
    Callback = function()
        local input = KeyInput.Value
        local sucesso, msg = ChecarKey(input)
        
        if sucesso then
            Fluent:Notify({ Title = "Acesso Permitido", Content = msg, Duration = 5 })
            Window:Destroy() -- Fecha a janela de login
            
            -- [[ AQUI ABRE O TEU HUB PRINCIPAL APÓS O LOGIN ]] --
            local MainHub = Fluent:CreateWindow({
                Title = "mt's hub v1",
                SubTitle = "Acesso VIP",
                TabWidth = 160, Size = UDim2.fromOffset(580, 460), Acrylic = true, Theme = "Dark"
            })
            
            local Tab = MainHub:AddTab({ Title = "Principal", Icon = "home" })
            Tab:AddParagraph({ Title = "Bem-vindo!", Content = "O mt's hub está ativo e protegido." })
            
            -- Aqui podes continuar a adicionar as tuas funções (Speed, Jump, etc.)
            Tab:AddSlider("Slider", { Title = "Velocidade", Default = 16, Min = 16, Max = 500, Rounding = 1, 
                Callback = function(Value) game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value end 
            })
        else
            Fluent:Notify({ Title = "Erro de Acesso", Content = msg, Duration = 5 })
        end
    end
})
