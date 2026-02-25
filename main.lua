-- 古いgh hubを消して新しく起動
if _G.ghHubLoaded then
    pcall(function() _G.ghHubLoaded() end)
end
_G.ghHubLoaded = function()
    for _, v in ipairs(game.Players.LocalPlayer.PlayerGui:GetChildren()) do
        if v.Name == "OrionV2" or v.Name == "Orion" or v.Name == "OrionLib" then
            pcall(function() v:Destroy() end)
        end
    end
end

local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Siro-script/FtaP.90hub/refs/heads/main/Orion"))()

local KEY = "gh hub beta v0.5"
local keyCorrect = false

local KeyWindow = OrionLib:MakeWindow({
    Name = "gh hub - キー認証",
    IntroText = "gh hub",
    HidePremium = false,
    SaveConfig = false,
    ConfigFolder = "gh hub"
})

local KeyTab = KeyWindow:MakeTab({
    Name = "🔑 認証",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

KeyTab:AddSection({ Name = "🔑 キーを入力してください" })
KeyTab:AddTextbox({
    Name = "キー入力",
    Default = "",
    TextDisappear = false,
    Callback = function(Value)
        keyCorrect = (Value == KEY)
    end
})

KeyTab:AddButton({
    Name = "✅ 認証する",
    Callback = function()
        if not keyCorrect then
            local p = game.Players.LocalPlayer
            local sg = Instance.new("ScreenGui")
            sg.ResetOnSpawn = false
            sg.Parent = p.PlayerGui
            local lb = Instance.new("TextLabel")
            lb.Size = UDim2.new(1,0,0,60)
            lb.Position = UDim2.new(0,0,0.4,0)
            lb.BackgroundTransparency = 0.3
            lb.BackgroundColor3 = Color3.fromRGB(0,0,0)
            lb.TextColor3 = Color3.fromRGB(255,50,50)
            lb.TextScaled = true
            lb.Text = "❌ キーが違います！"
            lb.Parent = sg
            task.delay(2, function() sg:Destroy() end)
            return
        end

        for _, v in ipairs(game.Players.LocalPlayer.PlayerGui:GetChildren()) do
            if v.Name == "OrionV2" or v.Name == "Orion" or v.Name == "OrionLib" then
                pcall(function() v:Destroy() end)
            end
        end

        task.wait(0.5)

        local OrionLib2 = loadstring(game:HttpGet("https://raw.githubusercontent.com/Siro-script/FtaP.90hub/refs/heads/main/Orion"))()

        local Window = OrionLib2:MakeWindow({
            Name = "gh hub",
            IntroText = "gh hub Godscript",
            HidePremium = false,
            SaveConfig = false,
            ConfigFolder = "gh hub"
        })

        local MainTab = Window:MakeTab({ Name = "Main", Icon = "rbxassetid://4483345998", PremiumOnly = false })
        MainTab:AddSection({ Name = "UI Components" })
        MainTab:AddLabel("This is a label")
        MainTab:AddParagraph("Paragraph","This is a paragraph text.")
        MainTab:AddButton({ Name = "Button", Callback = function() end })
        MainTab:AddToggle({ Name = "Toggle", Default = false, Callback = function() end })
        MainTab:AddSlider({ Name = "Slider", Min = 0, Max = 100, Default = 50, Increment = 1, ValueName = "Value", Callback = function() end })
        MainTab:AddDropdown({ Name = "Dropdown", Default = "Option 1", Options = {"Option 1","Option 2","Option 3"}, Callback = function() end })
        MainTab:AddColorpicker({ Name = "Color Picker", Default = Color3.fromRGB(255,0,0), Callback = function() end })
        MainTab:AddTextbox({ Name = "Textbox", Default = "", TextDisappear = true, Callback = function() end })
        MainTab:AddBind({ Name = "Keybind", Default = Enum.KeyCode.RightShift, Hold = false, Callback = function() end })

        local HaneTab = Window:MakeTab({ Name = "羽😂", Icon = "rbxassetid://4483345998", PremiumOnly = false })
        HaneTab:AddSection({ Name = "🎆 FireworkSparkler 設定" })

        local HeartTab = Window:MakeTab({ Name = "💗 ハート", Icon = "rbxassetid://4483345998", PremiumOnly = false })
        HeartTab:AddSection({ Name = "💗 ハート専用設定" })

        local AimTab = Window:MakeTab({ Name = "🎯 サイレントエイム", Icon = "rbxassetid://4483345998", PremiumOnly = false })
        AimTab:AddSection({ Name = "🎯 サイレントエイム設定" })

        -- サイレントエイム変数
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local UserInputService = game:GetService("UserInputService")
        local LP = Players.LocalPlayer

        _G.SilentAimEnabled = false
        _G.SilentAimRange = 30
        _G.TriggerBotEnabled = false
        _G.TriggerDelay = 0.1

        local function GetHRP()
            return LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
        end

        local function GetDirection(Origin, Position)
            return (Position - Origin).Unit * (Origin - Position).Magnitude
        end

        local function GetClosestPlayerInWorld()
            local Closest, Distance = nil, _G.SilentAimRange
            local hrp = GetHRP()
            if not hrp then return nil end
            for _, Player in ipairs(Players:GetPlayers()) do
                if Player ~= LP then
                    local Character = Player.Character
                    local Head = Character and Character:FindFirstChild("Head")
                    local Humanoid = Character and Character:FindFirstChild("Humanoid")
                    if Head and Humanoid and Humanoid.Health > 0 then
                        local _Distance = (hrp.Position - Head.Position).Magnitude
                        if _Distance <= Distance then
                            Closest = Head
                            Distance = _Distance
                        end
                    end
                end
            end
            return Closest
        end

        -- トリガーボット
        local LastTriggerTime = 0
        local TriggerConnection = nil

        local function UpdateTriggerBot()
            if TriggerConnection then
                TriggerConnection:Disconnect()
                TriggerConnection = nil
            end
            if _G.TriggerBotEnabled then
                TriggerConnection = RunService.Heartbeat:Connect(function()
                    local CurrentTime = tick()
                    if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
                        if CurrentTime - LastTriggerTime >= _G.TriggerDelay then
                            local Target = GetClosestPlayerInWorld()
                            if Target then
                                pcall(function() mouse1click() end)
                                LastTriggerTime = CurrentTime
                            end
                        end
                    end
                end)
            end
        end

        -- サイレントエイム（Raycastハイジャック）
        local oldNamecall = nil
        local function HookSilentAim()
            if oldNamecall then return end
            oldNamecall = hookmetamethod(game, "__namecall", function(...)
                local Method = getnamecallmethod()
                local Arguments = {...}
                if _G.SilentAimEnabled and Arguments[1] == workspace and Method == "Raycast" then
                    if typeof(Arguments[#Arguments]) ~= "RaycastParams" then
                        return oldNamecall(...)
                    end
                    local HitPart = GetClosestPlayerInWorld()
                    if HitPart then
                        Arguments[3] = GetDirection(Arguments[2], HitPart.Position)
                        return oldNamecall(unpack(Arguments))
                    end
                end
                return oldNamecall(...)
            end)
        end
        pcall(HookSilentAim)

        -- エイムUIの構築
        AimTab:AddSlider({
            Name = "照準範囲（スタッド）",
            Min = 5, Max = 500, Default = 30, Increment = 0.5,
            ValueName = "studs",
            Callback = function(v) _G.SilentAimRange = v end
        })

        AimTab:AddToggle({
            Name = "🎯 サイレントエイム ON/OFF",
            Default = false,
            Callback = function(v)
                _G.SilentAimEnabled = v
            end
        })

        AimTab:AddSection({ Name = "🤖 トリガーボット設定" })

        AimTab:AddSlider({
            Name = "トリガー遅延（秒）",
            Min = 0.05, Max = 0.5, Default = 0.1, Increment = 0.01,
            ValueName = "秒",
            Callback = function(v) _G.TriggerDelay = v end
        })

        AimTab:AddToggle({
            Name = "🤖 トリガーボット ON/OFF",
            Default = false,
            Callback = function(v)
                _G.TriggerBotEnabled = v
                UpdateTriggerBot()
            end
        })

        -- 羽スクリプト
        local player2 = Players.LocalPlayer
        local sparklerLoop = nil
        local heartLoop = nil
        local myModels = {}
        local heartModels = {}
        local othersModels = {}
        local othersLoop = nil

        local spreadDist   = 1
        local bodyDist     = 1
        local heightOff    = 0
        local maxCount     = 2
        local othersCount  = 2
        local flapSpeed    = 2
        local flapAngle    = 30
        local jointCount   = 1
        local currentShape = "羽"

        local heartCount   = 10
        local heartScale   = 2
        local heartHeight  = 0
        local heartSpeed   = 0.5

        local function getAllSparklerModels()
            local list = {}
            for _, v in ipairs(workspace:GetDescendants()) do
                if v.Name == "FireworkSparkler" and v:IsA("Model") then
                    table.insert(list, v)
                end
            end
            return list
        end

        local function setupPhysics(model)
            for _, v in ipairs(model:GetDescendants()) do
                if v:IsA("BasePart") then
                    pcall(function()
                        v.CanCollide = false
                        v.CanTouch = false
                        v.Anchored = false
                        if not v:FindFirstChildOfClass("BodyPosition") then
                            local bp = Instance.new("BodyPosition")
                            bp.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                            bp.P = 500000
                            bp.D = 50
                            bp.Position = v.Position
                            bp.Parent = v
                        end
                        if not v:FindFirstChildOfClass("BodyGyro") then
                            local bg = Instance.new("BodyGyro")
                            bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
                            bg.P = 500000
                            bg.D = 50
                            bg.CFrame = v.CFrame
                            bg.Parent = v
                        end
                    end)
                end
            end
        end

        local function moveModel(model, targetCFrame)
            if not model or not model.Parent then return end
            local primary = model.PrimaryPart
            if not primary then return end
            for _, v in ipairs(model:GetDescendants()) do
                if v:IsA("BasePart") then
                    pcall(function()
                        local bp = v:FindFirstChildOfClass("BodyPosition")
                        local bg = v:FindFirstChildOfClass("BodyGyro")
                        local worldCF = targetCFrame * primary.CFrame:ToObjectSpace(v.CFrame)
                        if bp then bp.Position = worldCF.Position end
                        if bg then bg.CFrame = worldCF end
                    end)
                end
            end
        end

        local function calcWing(root, row, side, totalRows, jointIndex)
            local t = tick()
            local jointPhase = (jointIndex - 1) * 0.4
            local rowMult   = (row - 1) / math.max(totalRows - 1, 1)
            local jointMult = (jointIndex - 1) / math.max(jointCount - 1, 1)
            local flapMult  = rowMult * (0.3 + jointMult * 0.7)
            local flapY = math.sin(t * flapSpeed + row * 0.5 + jointPhase) * flapAngle * 0.1 * flapMult
            local jointOffset = (jointIndex - 1) * spreadDist * 0.5
            local x = side == "left"
                and -(bodyDist + (row - 1) * spreadDist + jointOffset)
                or   (bodyDist + (row - 1) * spreadDist + jointOffset)
            local targetCFrame = root.CFrame * CFrame.new(x, heightOff + flapY, 0)
            local rot = side == "left"
                and CFrame.Angles(0, math.rad(180), 0)
                or  CFrame.Angles(0, math.rad(0), 0)
            return targetCFrame * rot
        end

        local function calcCircle(root, index, total)
            local t = tick()
            local angle = (index - 1) / total * (math.pi * 2)
            local radius = bodyDist + spreadDist
            local x = math.cos(angle + t * flapSpeed * 0.3) * radius
            local z = math.sin(angle + t * flapSpeed * 0.3) * radius
            local flapY = math.sin(t * flapSpeed + index) * flapAngle * 0.05
            return (root.CFrame * CFrame.new(x, heightOff + flapY, z)) * CFrame.Angles(0, angle, 0)
        end

        local function calcSpiral(root, index, total)
            local t = tick()
            local angle = (index - 1) / total * (math.pi * 4) + t * flapSpeed * 0.5
            local radius = bodyDist + (index / total) * spreadDist * 3
            local x = math.cos(angle) * radius
            local z = math.sin(angle) * radius
            local y = heightOff + (index / total) * spreadDist * 2
            return (root.CFrame * CFrame.new(x, y, z)) * CFrame.Angles(0, angle, 0)
        end

        local function calcHeart(root, index, total)
            local t = tick()
            local angle = (index - 1) / total * (math.pi * 2)
            local scale = heartScale
            local hx = scale * (16 * math.sin(angle)^3) / 10
            local hy = scale * (13 * math.cos(angle) - 5 * math.cos(2*angle) - 2 * math.cos(3*angle) - math.cos(4*angle)) / 10
            local rotAngle = t * heartSpeed
            local rx = hx * math.cos(rotAngle)
            local rz = hx * math.sin(rotAngle)
            local worldPos = root.CFrame * CFrame.new(rx, heartHeight + hy, rz)
            local rot = CFrame.Angles(0, math.rad(180), 0) * CFrame.Angles(0, rotAngle, 0)
            return CFrame.new(worldPos.Position) * rot
        end

        local function runShape(root, models)
            local total = #models
            if currentShape == "羽" then
                local leftModels = {}
                local rightModels = {}
                for i, m in ipairs(models) do
                    if i % 2 == 1 then table.insert(leftModels, m)
                    else table.insert(rightModels, m) end
                end
                for row = 1, #leftModels do
                    for j = 1, jointCount do
                        local model = leftModels[row]
                        if model and model.Parent then
                            moveModel(model, calcWing(root, row, "left", #leftModels, j))
                        end
                    end
                end
                for row = 1, #rightModels do
                    for j = 1, jointCount do
                        local model = rightModels[row]
                        if model and model.Parent then
                            moveModel(model, calcWing(root, row, "right", #rightModels, j))
                        end
                    end
                end
            else
                for i, model in ipairs(models) do
                    if model and model.Parent then
                        local cf
                        if currentShape == "円形" then cf = calcCircle(root, i, total)
                        elseif currentShape == "渦巻き" then cf = calcSpiral(root, i, total) end
                        if cf then moveModel(model, cf) end
                    end
                end
            end
        end

        local function showError(msg)
            local sg2 = Instance.new("ScreenGui")
            sg2.ResetOnSpawn = false
            sg2.Parent = player2.PlayerGui
            local lbl2 = Instance.new("TextLabel")
            lbl2.Size = UDim2.new(1,0,0,60)
            lbl2.Position = UDim2.new(0,0,0.4,0)
            lbl2.BackgroundTransparency = 0.3
            lbl2.BackgroundColor3 = Color3.fromRGB(0,0,0)
            lbl2.TextColor3 = Color3.fromRGB(255,50,50)
            lbl2.TextScaled = true
            lbl2.Text = msg
            lbl2.Parent = sg2
            task.delay(3, function() sg2:Destroy() end)
        end

        local function startMyAttach()
            local all = getAllSparklerModels()
            myModels = {}
            local need = maxCount * jointCount
            for i = 1, math.min(need, #all) do
                table.insert(myModels, all[i])
                setupPhysics(all[i])
            end
            if #myModels == 0 then showError("FireworkSparklerが見つかりません！") return end
            sparklerLoop = RunService.Heartbeat:Connect(function()
                local char = player2.Character
                if not char then return end
                local root = char:FindFirstChild("HumanoidRootPart")
                if not root then return end
                runShape(root, myModels)
            end)
        end

        local function stopMyAttach()
            if sparklerLoop then sparklerLoop:Disconnect() sparklerLoop = nil end
            myModels = {}
        end

        local function startHeartAttach()
            local all = getAllSparklerModels()
            heartModels = {}
            for i = 1, math.min(heartCount, #all) do
                table.insert(heartModels, all[i])
                setupPhysics(all[i])
            end
            if #heartModels == 0 then showError("FireworkSparklerが見つかりません！") return end
            heartLoop = RunService.Heartbeat:Connect(function()
                local char = player2.Character
                if not char then return end
                local root = char:FindFirstChild("HumanoidRootPart")
                if not root then return end
                local total = #heartModels
                for i, model in ipairs(heartModels) do
                    if model and model.Parent then
                        moveModel(model, calcHeart(root, i, total))
                    end
                end
            end)
        end

        local function stopHeartAttach()
            if heartLoop then heartLoop:Disconnect() heartLoop = nil end
            heartModels = {}
        end

        local function startOthersAttach()
            local all = getAllSparklerModels()
            local used = {}
            for _, m in ipairs(myModels) do used[m] = true end
            for _, m in ipairs(heartModels) do used[m] = true end
            othersModels = {}
            local need = othersCount * jointCount
            for _, m in ipairs(all) do
                if not used[m] then
                    table.insert(othersModels, m)
                    setupPhysics(m)
                    if #othersModels >= need then break end
                end
            end
            othersLoop = RunService.Heartbeat:Connect(function()
                local char = player2.Character
                if not char then return end
                local root = char:FindFirstChild("HumanoidRootPart")
                if not root then return end
                runShape(root, othersModels)
            end)
        end

        local function stopOthersAttach()
            if othersLoop then othersLoop:Disconnect() othersLoop = nil end
            othersModels = {}
        end

        HaneTab:AddDropdown({ Name = "形の選択", Default = "羽", Options = {"羽","円形","渦巻き"}, Callback = function(v) currentShape = v end })
        HaneTab:AddSlider({ Name = "吸い付く個数（自分）", Min = 2, Max = 90, Default = 2, Increment = 2, ValueName = "個", Callback = function(v) maxCount = v end })
        HaneTab:AddSlider({ Name = "関節数", Min = 1, Max = 10, Default = 1, Increment = 1, ValueName = "個", Callback = function(v) jointCount = v end })
        HaneTab:AddSlider({ Name = "体からの距離", Min = 1, Max = 20, Default = 1, Increment = 1, ValueName = "スタッド", Callback = function(v) bodyDist = v end })
        HaneTab:AddSlider({ Name = "羽同士の間隔", Min = 1, Max = 10, Default = 1, Increment = 1, ValueName = "スタッド", Callback = function(v) spreadDist = v end })
        HaneTab:AddSlider({ Name = "高さ", Min = -5, Max = 10, Default = 0, Increment = 1, ValueName = "", Callback = function(v) heightOff = v end })
        HaneTab:AddSlider({ Name = "羽ばたき速度", Min = 1, Max = 100, Default = 2, Increment = 1, ValueName = "", Callback = function(v) flapSpeed = v end })
        HaneTab:AddSlider({ Name = "羽ばたき幅", Min = 5, Max = 1440, Default = 30, Increment = 5, ValueName = "度", Callback = function(v) flapAngle = v end })
        HaneTab:AddToggle({ Name = "🎆 自分のSparkler ON/OFF", Default = false, Callback = function(v)
            if v then startMyAttach() else stopMyAttach() end
        end })
        HaneTab:AddSection({ Name = "👥 他人のFireworkSparkler" })
        HaneTab:AddSlider({ Name = "吸い付く個数（他人）", Min = 2, Max = 90, Default = 2, Increment = 2, ValueName = "個", Callback = function(v) othersCount = v end })
        HaneTab:AddToggle({ Name = "👥 他人のSparkler ON/OFF", Default = false, Callback = function(v)
            if v then startOthersAttach() else stopOthersAttach() end
        end })

        HeartTab:AddSlider({ Name = "💗 個数", Min = 2, Max = 90, Default = 10, Increment = 2, ValueName = "個", Callback = function(v) heartCount = v end })
        HeartTab:AddSlider({ Name = "💗 大きさ", Min = 1, Max = 20, Default = 2, Increment = 1, ValueName = "", Callback = function(v) heartScale = v end })
        HeartTab:AddSlider({ Name = "💗 高さ", Min = -5, Max = 10, Default = 0, Increment = 1, ValueName = "", Callback = function(v) heartHeight = v end })
        HeartTab:AddSlider({ Name = "💗 回転速度", Min = 0, Max = 10, Default = 1, Increment = 1, ValueName = "", Callback = function(v) heartSpeed = v * 0.5 end })
        HeartTab:AddToggle({ Name = "💗 ハート ON/OFF", Default = false, Callback = function(v)
            if v then startHeartAttach() else stopHeartAttach() end
        end })

        OrionLib2:Init()
    end
})

OrionLib:Init()
