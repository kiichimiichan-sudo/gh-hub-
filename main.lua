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

local KeyWindow = OrionLib:MakeWindow({Name = "gh hub - キー認証", IntroText = "gh hub", HidePremium = false, SaveConfig = false, ConfigFolder = "gh hub"})
local KeyTab = KeyWindow:MakeTab({Name = "🔑 認証", Icon = "rbxassetid://4483345998", PremiumOnly = false})
KeyTab:AddSection({Name = "🔑 キーを入力してください"})
KeyTab:AddTextbox({Name = "キー入力", Default = "", TextDisappear = false, Callback = function(Value) keyCorrect = (Value == KEY) end})
KeyTab:AddButton({Name = "✅ 認証する", Callback = function()
    if not keyCorrect then
        local sg = Instance.new("ScreenGui"); sg.ResetOnSpawn = false; sg.Parent = game.Players.LocalPlayer.PlayerGui
        local lb = Instance.new("TextLabel"); lb.Size = UDim2.new(1,0,0,60); lb.Position = UDim2.new(0,0,0.4,0)
        lb.BackgroundTransparency = 0.3; lb.BackgroundColor3 = Color3.fromRGB(0,0,0)
        lb.TextColor3 = Color3.fromRGB(255,50,50); lb.TextScaled = true; lb.Text = "❌ キーが違います！"; lb.Parent = sg
        task.delay(2, function() sg:Destroy() end); return
    end
    for _, v in ipairs(game.Players.LocalPlayer.PlayerGui:GetChildren()) do
        if v.Name == "OrionV2" or v.Name == "Orion" or v.Name == "OrionLib" then pcall(function() v:Destroy() end) end
    end
    task.wait(0.5)

    local OrionLib2 = loadstring(game:HttpGet("https://raw.githubusercontent.com/Siro-script/FtaP.90hub/refs/heads/main/Orion"))()
    local Window = OrionLib2:MakeWindow({Name = "gh hub", IntroText = "gh hub Godscript", HidePremium = false, SaveConfig = false, ConfigFolder = "gh hub"})

    local MainTab    = Window:MakeTab({Name = "Main",                Icon = "rbxassetid://4483345998", PremiumOnly = false})
    local HaneTab    = Window:MakeTab({Name = "羽😂",                Icon = "rbxassetid://4483345998", PremiumOnly = false})
    local HeartTab   = Window:MakeTab({Name = "💗 ハート",            Icon = "rbxassetid://4483345998", PremiumOnly = false})
    local AimTab     = Window:MakeTab({Name = "🎯 サイレントエイム",   Icon = "rbxassetid://4483345998", PremiumOnly = false})
    local AntiTab    = Window:MakeTab({Name = "🛡️ アンチグラブ",      Icon = "rbxassetid://4483345998", PremiumOnly = false})
    local LineTab    = Window:MakeTab({Name = "🌈 レインボーライン",   Icon = "rbxassetid://4483345998", PremiumOnly = false})
    local CombatTab  = Window:MakeTab({Name = "💪 コンバット",        Icon = "rbxassetid://4483345998", PremiumOnly = false})
    local PlayerTab2 = Window:MakeTab({Name = "🏃 ローカルプレイヤー", Icon = "rbxassetid://4483345998", PremiumOnly = false})
    local ObjTab     = Window:MakeTab({Name = "📦 オブジェクトグラブ", Icon = "rbxassetid://4483345998", PremiumOnly = false})
    local BlobTab    = Window:MakeTab({Name = "🐙 ブロブマン",         Icon = "rbxassetid://4483345998", PremiumOnly = false})
    local FunTab2    = Window:MakeTab({Name = "🎭 ファン/トロール",     Icon = "rbxassetid://4483345998", PremiumOnly = false})

    local Players           = game:GetService("Players")
    local RunService        = game:GetService("RunService")
    local UserInputService  = game:GetService("UserInputService")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Debris            = game:GetService("Debris")
    local LP                = Players.LocalPlayer
    local GetPlayers        = Players.GetPlayers

    local playerCharacter = LP.Character or LP.CharacterAdded:Wait()
    LP.CharacterAdded:Connect(function(c) playerCharacter = c end)

    local GrabEvents      = ReplicatedStorage:WaitForChild("GrabEvents")
    local CharacterEvents = ReplicatedStorage:WaitForChild("CharacterEvents")
    local MenuToys        = ReplicatedStorage:WaitForChild("MenuToys")
    local SetNetworkOwner = GrabEvents:WaitForChild("SetNetworkOwner")
    local Struggle        = CharacterEvents:WaitForChild("Struggle")
    local EndGrabEarly    = GrabEvents:WaitForChild("EndGrabEarly")
    local DestroyToy      = MenuToys:WaitForChild("DestroyToy")

    local toysFolder = workspace:FindFirstChild(LP.Name.."SpawnedInToys")

    local function isDescendantOf(target, other)
        local cur = target.Parent
        while cur do if cur == other then return true end cur = cur.Parent end
        return false
    end

    local function spawnItem(itemName, position)
        task.spawn(function()
            ReplicatedStorage.MenuToys.SpawnToyRemoteFunction:InvokeServer(itemName, CFrame.new(position), Vector3.new(0,90,0))
        end)
    end

    local function spawnItemCf(itemName, cf)
        task.spawn(function()
            ReplicatedStorage.MenuToys.SpawnToyRemoteFunction:InvokeServer(itemName, cf, Vector3.new(0,0,0))
        end)
    end

    local function DestroyT(toy)
        toy = toy or (toysFolder and toysFolder:FindFirstChildWhichIsA("Model"))
        if toy then DestroyToy:FireServer(toy) end
    end

    local function getNearestPlayer()
        local nearest, nearDist = nil, math.huge
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local d = (playerCharacter.HumanoidRootPart.Position - p.Character.HumanoidRootPart.Position).Magnitude
                if d < nearDist then nearDist = d; nearest = p end
            end
        end
        return nearest
    end

    local function getDescendantParts(name)
        local parts = {}
        pcall(function()
            for _, d in ipairs(workspace.Map:GetDescendants()) do
                if d:IsA("Part") and d.Name == name then table.insert(parts, d) end
            end
        end)
        return parts
    end

    local poisonHurtParts  = getDescendantParts("PoisonHurtPart")
    local paintPlayerParts = getDescendantParts("PaintPlayerPart")

    -- Main Tab
    MainTab:AddSection({Name = "UI Components"})
    MainTab:AddLabel("gh hub beta v0.5")
    MainTab:AddParagraph("クレジット","gh hub by kiichimiichan")

    -- =====================
    -- アンチグラブ
    -- =====================
    AntiTab:AddSection({Name = "🛡️ アンチグラブ設定"})
    local autoStruggleConn = nil
    local antiKickConn = nil
    local antiExplosionConn = nil
    local charAddedConn = nil

    local function setupAntiExplosion(character)
        local ragdolled = character:WaitForChild("Humanoid"):FindFirstChild("Ragdolled")
        if ragdolled then
            antiExplosionConn = ragdolled:GetPropertyChangedSignal("Value"):Connect(function()
                for _, part in ipairs(character:GetChildren()) do
                    if part:IsA("BasePart") then part.Anchored = ragdolled.Value end
                end
            end)
        end
    end

    AntiTab:AddToggle({Name = "🛡️ アンチグラブ ON/OFF", Default = false, Callback = function(v)
        if v then
            autoStruggleConn = RunService.Heartbeat:Connect(function()
                local char = LP.Character
                if char and char:FindFirstChild("Head") then
                    local partOwner = char.Head:FindFirstChild("PartOwner")
                    if partOwner then
                        pcall(function()
                            Struggle:FireServer()
                            ReplicatedStorage.GameCorrectionEvents.StopAllVelocity:FireServer()
                        end)
                        for _, part in pairs(char:GetChildren()) do
                            if part:IsA("BasePart") then part.Anchored = true end
                        end
                        while LP.IsHeld.Value do task.wait() end
                        for _, part in pairs(char:GetChildren()) do
                            if part:IsA("BasePart") then part.Anchored = false end
                        end
                    end
                end
            end)
        else
            if autoStruggleConn then autoStruggleConn:Disconnect(); autoStruggleConn = nil end
        end
    end})

    AntiTab:AddToggle({Name = "🛡️ アンチキックグラブ", Default = false, Callback = function(v)
        if v then
            antiKickConn = RunService.Heartbeat:Connect(function()
                local char = LP.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    local fpp = char.HumanoidRootPart:FindFirstChild("FirePlayerPart")
                    if fpp then
                        local po = fpp:FindFirstChild("PartOwner")
                        if po and po.Value ~= LP.Name then
                            pcall(function()
                                CharacterEvents.RagdollRemote:FireServer(char.HumanoidRootPart, 0)
                            end)
                            task.wait(0.1)
                            pcall(function() Struggle:FireServer() end)
                        end
                    end
                end
            end)
        else
            if antiKickConn then antiKickConn:Disconnect(); antiKickConn = nil end
        end
    end})

    AntiTab:AddToggle({Name = "💥 アンチエクスプロージョン", Default = false, Callback = function(v)
        if v then
            if LP.Character then setupAntiExplosion(LP.Character) end
            charAddedConn = LP.CharacterAdded:Connect(function(c)
                if antiExplosionConn then antiExplosionConn:Disconnect() end
                setupAntiExplosion(c)
            end)
        else
            if antiExplosionConn then antiExplosionConn:Disconnect(); antiExplosionConn = nil end
            if charAddedConn then charAddedConn:Disconnect(); charAddedConn = nil end
        end
    end})

    AntiTab:AddSection({Name = "⚔️ セルフディフェンス"})
    local autoDefendCoro = nil
    AntiTab:AddToggle({Name = "⚔️ セルフディフェンス / エアサスペンド", Default = false, Callback = function(v)
        if v then
            autoDefendCoro = coroutine.create(function()
                while task.wait(0.02) do
                    local char = LP.Character
                    if char and char:FindFirstChild("Head") then
                        local po = char.Head:FindFirstChild("PartOwner")
                        if po then
                            local attacker = Players:FindFirstChild(po.Value)
                            if attacker and attacker.Character then
                                pcall(function()
                                    Struggle:FireServer()
                                    SetNetworkOwner:FireServer(attacker.Character.Head or attacker.Character.Torso, attacker.Character.HumanoidRootPart.CFrame)
                                end)
                                task.wait(0.1)
                                local target = attacker.Character:FindFirstChild("Torso")
                                if target then
                                    local vel = target:FindFirstChild("l") or Instance.new("BodyVelocity")
                                    vel.Name = "l"; vel.Parent = target
                                    vel.Velocity = Vector3.new(0, 50, 0)
                                    vel.MaxForce = Vector3.new(0, math.huge, 0)
                                    Debris:AddItem(vel, 100)
                                end
                            end
                        end
                    end
                end
            end)
            coroutine.resume(autoDefendCoro)
        else
            if autoDefendCoro then coroutine.close(autoDefendCoro); autoDefendCoro = nil end
        end
    end})

    -- =====================
    -- コンバット
    -- =====================
    CombatTab:AddSection({Name = "💪 コンバット設定"})
    local strengthPower = 400
    local strengthConn = nil
    local poisonGrabCoro = nil
    local ufoGrabCoro = nil
    local fireGrabCoro = nil
    local noclipGrabCoro = nil
    local kickGrabConns = {}
    local fireAllCoro = nil
    local burnPart = nil

    local function arson(part)
        pcall(function()
            if not toysFolder:FindFirstChild("Campfire") then
                spawnItem("Campfire", Vector3.new(-72.9304581,-5.96906614,-265.543732))
            end
            local campfire = toysFolder:WaitForChild("Campfire")
            burnPart = campfire:FindFirstChild("FirePlayerPart")
            if burnPart then
                burnPart.Size = Vector3.new(7,7,7)
                burnPart.Position = part.Position
                task.wait(0.3)
                burnPart.Position = Vector3.new(0,-50,0)
            end
        end)
    end

    local function grabHandler(grabType)
        while true do
            pcall(function()
                local child = workspace:FindFirstChild("GrabParts")
                if child then
                    local grabPart = child:FindFirstChild("GrabPart")
                    if grabPart then
                        local weld = grabPart:FindFirstChild("WeldConstraint")
                        if weld and weld.Part1 then
                            local head = weld.Part1.Parent:FindFirstChild("Head")
                            if head then
                                while workspace:FindFirstChild("GrabParts") do
                                    local partsTable = grabType == "poison" and poisonHurtParts or paintPlayerParts
                                    for _, part in pairs(partsTable) do
                                        part.Size = Vector3.new(2,2,2)
                                        part.Transparency = 1
                                        part.Position = head.Position
                                    end
                                    task.wait()
                                    for _, part in pairs(partsTable) do
                                        part.Position = Vector3.new(0,-200,0)
                                    end
                                end
                            end
                        end
                    end
                end
            end)
            task.wait()
        end
    end

    local function fireGrabFunc()
        while true do
            pcall(function()
                local child = workspace:FindFirstChild("GrabParts")
                if child then
                    local grabPart = child:FindFirstChild("GrabPart")
                    if grabPart then
                        local weld = grabPart:FindFirstChild("WeldConstraint")
                        if weld and weld.Part1 then
                            local head = weld.Part1.Parent:FindFirstChild("Head")
                            if head then arson(head) end
                        end
                    end
                end
            end)
            task.wait()
        end
    end

    local function noclipGrabFunc()
        while true do
            pcall(function()
                local child = workspace:FindFirstChild("GrabParts")
                if child then
                    local grabPart = child:FindFirstChild("GrabPart")
                    if grabPart then
                        local weld = grabPart:FindFirstChild("WeldConstraint")
                        if weld and weld.Part1 then
                            local character = weld.Part1.Parent
                            if character.HumanoidRootPart then
                                while workspace:FindFirstChild("GrabParts") do
                                    for _, part in pairs(character:GetChildren()) do
                                        if part:IsA("BasePart") then part.CanCollide = false end
                                    end
                                    task.wait()
                                end
                                for _, part in pairs(character:GetChildren()) do
                                    if part:IsA("BasePart") then part.CanCollide = true end
                                end
                            end
                        end
                    end
                end
            end)
            task.wait()
        end
    end

    local function handleCharacterAdded(player)
        local conn = player.CharacterAdded:Connect(function(character)
            local hrp = character:WaitForChild("HumanoidRootPart")
            local fpp = hrp:WaitForChild("FirePlayerPart")
            fpp.Size = Vector3.new(4.5,5,4.5)
            fpp.CollisionGroup = "1"
            fpp.CanQuery = true
        end)
        table.insert(kickGrabConns, conn)
    end

    local function kickGrabFunc()
        for _, player in pairs(Players:GetPlayers()) do
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = player.Character.HumanoidRootPart
                if hrp:FindFirstChild("FirePlayerPart") then
                    local fpp = hrp.FirePlayerPart
                    fpp.Size = Vector3.new(4.5,5.5,4.5)
                    fpp.CollisionGroup = "1"
                    fpp.CanQuery = true
                end
            end
            handleCharacterAdded(player)
        end
        local conn = Players.PlayerAdded:Connect(handleCharacterAdded)
        table.insert(kickGrabConns, conn)
    end

    local function fireAllFunc()
        while true do
            pcall(function()
                if toysFolder:FindFirstChild("Campfire") then
                    DestroyT(toysFolder:FindFirstChild("Campfire"))
                    task.wait(0.5)
                end
                spawnItemCf("Campfire", playerCharacter.Head.CFrame)
                local campfire = toysFolder:WaitForChild("Campfire")
                local firePlayerPart
                for _, part in pairs(campfire:GetChildren()) do
                    if part.Name == "FirePlayerPart" then
                        part.Size = Vector3.new(10,10,10)
                        firePlayerPart = part
                        break
                    end
                end
                local originalPos = playerCharacter.Torso.Position
                SetNetworkOwner:FireServer(firePlayerPart, firePlayerPart.CFrame)
                playerCharacter:MoveTo(firePlayerPart.Position)
                task.wait(0.3)
                playerCharacter:MoveTo(originalPos)
                local bp = Instance.new("BodyPosition")
                bp.P = 20000
                bp.Position = playerCharacter.Head.Position + Vector3.new(0,600,0)
                bp.Parent = campfire.Main
                while true do
                    for _, player in pairs(Players:GetChildren()) do
                        pcall(function()
                            bp.Position = playerCharacter.Head.Position + Vector3.new(0,600,0)
                            if player.Character and player.Character.HumanoidRootPart and player.Character ~= playerCharacter then
                                firePlayerPart.Position = player.Character.HumanoidRootPart.Position
                                task.wait()
                            end
                        end)
                    end
                    task.wait()
                end
            end)
            task.wait()
        end
    end

    CombatTab:AddSlider({Name = "💥 スレングスパワー", Min = 300, Max = 10000, Default = 400, Increment = 1, ValueName = "", Callback = function(v) strengthPower = v end})
    CombatTab:AddToggle({Name = "💥 スレングス ON/OFF", Default = false, Callback = function(v)
        if v then
            strengthConn = workspace.ChildAdded:Connect(function(model)
                if model.Name == "GrabParts" then
                    local partToImpulse = model.GrabPart.WeldConstraint.Part1
                    if partToImpulse then
                        local vel = Instance.new("BodyVelocity", partToImpulse)
                        model:GetPropertyChangedSignal("Parent"):Connect(function()
                            if not model.Parent then
                                if UserInputService:GetLastInputType() == Enum.UserInputType.MouseButton2 then
                                    vel.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
                                    vel.Velocity = workspace.CurrentCamera.CFrame.LookVector * strengthPower
                                    Debris:AddItem(vel, 1)
                                else
                                    vel:Destroy()
                                end
                            end
                        end)
                    end
                end
            end)
        else
            if strengthConn then strengthConn:Disconnect(); strengthConn = nil end
        end
    end})

    CombatTab:AddSection({Name = "グラブエフェクト"})
    CombatTab:AddToggle({Name = "☠️ ポイズングラブ", Default = false, Callback = function(v)
        if v then
            poisonGrabCoro = coroutine.create(function() grabHandler("poison") end)
            coroutine.resume(poisonGrabCoro)
        else
            if poisonGrabCoro then coroutine.close(poisonGrabCoro); poisonGrabCoro = nil end
            for _, part in pairs(poisonHurtParts) do part.Position = Vector3.new(0,-200,0) end
        end
    end})
    CombatTab:AddToggle({Name = "☢️ ラジオアクティブグラブ", Default = false, Callback = function(v)
        if v then
            ufoGrabCoro = coroutine.create(function() grabHandler("radioactive") end)
            coroutine.resume(ufoGrabCoro)
        else
            if ufoGrabCoro then coroutine.close(ufoGrabCoro); ufoGrabCoro = nil end
            for _, part in pairs(paintPlayerParts) do part.Position = Vector3.new(0,-200,0) end
        end
    end})
    CombatTab:AddToggle({Name = "🔥 ファイアグラブ", Default = false, Callback = function(v)
        if v then
            fireGrabCoro = coroutine.create(fireGrabFunc)
            coroutine.resume(fireGrabCoro)
        else
            if fireGrabCoro then coroutine.close(fireGrabCoro); fireGrabCoro = nil end
        end
    end})
    CombatTab:AddToggle({Name = "👻 ノークリップグラブ", Default = false, Callback = function(v)
        if v then
            noclipGrabCoro = coroutine.create(noclipGrabFunc)
            coroutine.resume(noclipGrabCoro)
        else
            if noclipGrabCoro then coroutine.close(noclipGrabCoro); noclipGrabCoro = nil end
        end
    end})
    CombatTab:AddToggle({Name = "👟 キックグラブ", Default = false, Callback = function(v)
        if v then
            kickGrabFunc()
        else
            for _, conn in pairs(kickGrabConns) do conn:Disconnect() end
            for _, player in pairs(Players:GetPlayers()) do
                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    local fpp = player.Character.HumanoidRootPart:FindFirstChild("FirePlayerPart")
                    if fpp then fpp.Size = Vector3.new(2.5,5.5,2.5); fpp.CollisionGroup = "Default"; fpp.CanQuery = false end
                end
            end
            kickGrabConns = {}
        end
    end})
    CombatTab:AddSection({Name = "全体攻撃"})
    CombatTab:AddToggle({Name = "🔥 ファイアオール", Default = false, Callback = function(v)
        if v then
            fireAllCoro = coroutine.create(fireAllFunc)
            coroutine.resume(fireAllCoro)
        else
            if fireAllCoro then coroutine.close(fireAllCoro); fireAllCoro = nil end
        end
    end})

    -- =====================
    -- ローカルプレイヤー
    -- =====================
    PlayerTab2:AddSection({Name = "🏃 プレイヤー設定"})
    local crouchWalkSpeed = 50
    local crouchJumpPower = 50
    local crouchSpeedCoro = nil
    local crouchJumpCoro = nil

    PlayerTab2:AddSlider({Name = "クラウチスピード値", Min = 6, Max = 1000, Default = 50, Increment = 1, ValueName = "", Callback = function(v) crouchWalkSpeed = v end})
    PlayerTab2:AddToggle({Name = "🏃 クラウチスピード ON/OFF", Default = false, Callback = function(v)
        if v then
            crouchSpeedCoro = coroutine.create(function()
                while true do
                    pcall(function()
                        if playerCharacter.Humanoid and playerCharacter.Humanoid.WalkSpeed == 5 then
                            playerCharacter.Humanoid.WalkSpeed = crouchWalkSpeed
                        end
                    end)
                    task.wait()
                end
            end)
            coroutine.resume(crouchSpeedCoro)
        else
            if crouchSpeedCoro then coroutine.close(crouchSpeedCoro); crouchSpeedCoro = nil end
            pcall(function() playerCharacter.Humanoid.WalkSpeed = 16 end)
        end
    end})
    PlayerTab2:AddSlider({Name = "クラウチジャンプ値", Min = 6, Max = 1000, Default = 50, Increment = 1, ValueName = "", Callback = function(v) crouchJumpPower = v end})
    PlayerTab2:AddToggle({Name = "⬆️ クラウチジャンプ ON/OFF", Default = false, Callback = function(v)
        if v then
            crouchJumpCoro = coroutine.create(function()
                while true do
                    pcall(function()
                        if playerCharacter.Humanoid and playerCharacter.Humanoid.JumpPower == 12 then
                            playerCharacter.Humanoid.JumpPower = crouchJumpPower
                        end
                    end)
                    task.wait()
                end
            end)
            coroutine.resume(crouchJumpCoro)
        else
            if crouchJumpCoro then coroutine.close(crouchJumpCoro); crouchJumpCoro = nil end
            pcall(function() playerCharacter.Humanoid.JumpPower = 24 end)
        end
    end})

    -- =====================
    -- オブジェクトグラブ
    -- =====================
    ObjTab:AddSection({Name = "📦 オブジェクトグラブ設定"})
    local anchoredParts = {}
    local anchoredConns = {}
    local anchorGrabCoro = nil
    local autoRecoverCoro = nil

    local function createHighlight(parent)
        local h = Instance.new("Highlight")
        h.DepthMode = Enum.HighlightDepthMode.Occluded
        h.FillTransparency = 1
        h.OutlineColor = Color3.new(0,0,1)
        h.OutlineTransparency = 0.5
        h.Parent = parent
        return h
    end

    local function createBodyMovers(part, position, rotation)
        local bp = Instance.new("BodyPosition")
        bp.P = 15000; bp.D = 200
        bp.MaxForce = Vector3.new(5000000,5000000,5000000)
        bp.Position = position; bp.Parent = part
        local bg = Instance.new("BodyGyro")
        bg.P = 15000; bg.D = 200
        bg.MaxTorque = Vector3.new(5000000,5000000,5000000)
        bg.CFrame = rotation; bg.Parent = part
    end

    local function cleanupAnchored()
        for _, part in ipairs(anchoredParts) do
            if part then
                pcall(function()
                    if part:FindFirstChild("BodyPosition") then part.BodyPosition:Destroy() end
                    if part:FindFirstChild("BodyGyro") then part.BodyGyro:Destroy() end
                    local h = part:FindFirstChild("Highlight") or (part.Parent and part.Parent:FindFirstChild("Highlight"))
                    if h then h:Destroy() end
                end)
            end
        end
        for _, conn in ipairs(anchoredConns) do conn:Disconnect() end
        anchoredParts = {}; anchoredConns = {}
    end

    local function anchorGrabFunc()
        while true do
            pcall(function()
                local grabParts = workspace:FindFirstChild("GrabParts")
                if not grabParts then return end
                local grabPart = grabParts:FindFirstChild("GrabPart")
                if not grabPart then return end
                local weld = grabPart:FindFirstChild("WeldConstraint")
                if not weld or not weld.Part1 then return end
                local primaryPart = weld.Part1
                if isDescendantOf(primaryPart, workspace.Map) then return end
                for _, player in pairs(Players:GetChildren()) do
                    if player.Character and isDescendantOf(primaryPart, player.Character) then return end
                end
                if not table.find(anchoredParts, primaryPart) then
                    local target = primaryPart.Parent:IsA("Model") and primaryPart.Parent ~= workspace and primaryPart.Parent or primaryPart
                    createHighlight(target)
                    table.insert(anchoredParts, primaryPart)
                    local conn = target.DescendantAdded:Connect(function(d)
                        if d.Name == "PartOwner" and d.Value ~= LP.Name then
                            local h = primaryPart:FindFirstChild("Highlight") or (primaryPart.Parent and primaryPart.Parent:FindFirstChild("Highlight"))
                            if h then h.OutlineColor = Color3.new(1,0,0) end
                        end
                    end)
                    table.insert(anchoredConns, conn)
                end
                for _, child in ipairs(primaryPart:GetChildren()) do
                    if child:IsA("BodyPosition") or child:IsA("BodyGyro") then child:Destroy() end
                end
                while workspace:FindFirstChild("GrabParts") do task.wait() end
                createBodyMovers(primaryPart, primaryPart.Position, primaryPart.CFrame)
            end)
            task.wait()
        end
    end

    local function recoverPartsFunc()
        while true do
            pcall(function()
                local character = LP.Character
                if character and character:FindFirstChild("HumanoidRootPart") then
                    for _, part in pairs(anchoredParts) do
                        coroutine.wrap(function()
                            if part then
                                local d = (part.Position - character.HumanoidRootPart.Position).Magnitude
                                if d <= 30 then
                                    local h = part:FindFirstChild("Highlight") or (part.Parent and part.Parent:FindFirstChild("Highlight"))
                                    if h and h.OutlineColor == Color3.new(1,0,0) then
                                        SetNetworkOwner:FireServer(part, part.CFrame)
                                        local po = part:WaitForChild("PartOwner", 1)
                                        if po and po.Value == LP.Name then
                                            h.OutlineColor = Color3.new(0,0,1)
                                        end
                                    end
                                end
                            end
                        end)()
                    end
                end
            end)
            task.wait(0.02)
        end
    end

    ObjTab:AddToggle({Name = "📦 アンカーグラブ ON/OFF", Default = false, Callback = function(v)
        if v then
            if not anchorGrabCoro or coroutine.status(anchorGrabCoro) == "dead" then
                anchorGrabCoro = coroutine.create(anchorGrabFunc)
                coroutine.resume(anchorGrabCoro)
            end
        else
            if anchorGrabCoro and coroutine.status(anchorGrabCoro) ~= "dead" then
                coroutine.close(anchorGrabCoro); anchorGrabCoro = nil
            end
        end
    end})
    ObjTab:AddToggle({Name = "🔄 オートリカバー ON/OFF", Default = false, Callback = function(v)
        if v then
            if not autoRecoverCoro or coroutine.status(autoRecoverCoro) == "dead" then
                autoRecoverCoro = coroutine.create(recoverPartsFunc)
                coroutine.resume(autoRecoverCoro)
            end
        else
            if autoRecoverCoro and coroutine.status(autoRecoverCoro) ~= "dead" then
                coroutine.close(autoRecoverCoro); autoRecoverCoro = nil
            end
        end
    end})
    ObjTab:AddButton({Name = "🗑️ アンカー解除", Callback = cleanupAnchored})
    ObjTab:AddButton({Name = "💥 パーツ分解", Callback = function() cleanupAnchored() end})

    -- =====================
    -- ブロブマン
    -- =====================
    BlobTab:AddSection({Name = "🐙 ブロブマン設定"})
    local blobmanCoro = nil
    local blobTargetCoro = nil
    local blobman = nil
    local blobalter = 1
    _G.BlobmanDelay = 0.005
    _G.BlobTargetName = ""

    local function blobGrabPlayer(player, blob)
        if not blob or not blob.Parent then return end
        if blobalter == 1 then
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                pcall(function()
                    local args = {
                        blob:FindFirstChild("LeftDetector"),
                        player.Character.HumanoidRootPart,
                        blob:FindFirstChild("LeftDetector"):FindFirstChild("LeftWeld")
                    }
                    blob:WaitForChild("BlobmanSeatAndOwnerScript"):WaitForChild("CreatureGrab"):FireServer(unpack(args))
                end)
                blobalter = 2
            end
        else
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                pcall(function()
                    local args = {
                        blob:FindFirstChild("RightDetector"),
                        player.Character.HumanoidRootPart,
                        blob:FindFirstChild("RightDetector"):FindFirstChild("RightWeld")
                    }
                    blob:WaitForChild("BlobmanSeatAndOwnerScript"):WaitForChild("CreatureGrab"):FireServer(unpack(args))
                end)
                blobalter = 1
            end
        end
    end

    local function showNotif(msg)
        local sg = Instance.new("ScreenGui"); sg.ResetOnSpawn = false; sg.Parent = LP.PlayerGui
        local lb = Instance.new("TextLabel"); lb.Size = UDim2.new(1,0,0,60); lb.Position = UDim2.new(0,0,0.4,0)
        lb.BackgroundTransparency = 0.3; lb.BackgroundColor3 = Color3.fromRGB(0,0,0)
        lb.TextColor3 = Color3.fromRGB(255,100,0); lb.TextScaled = true; lb.Text = msg; lb.Parent = sg
        task.delay(3, function() sg:Destroy() end)
    end

    local function findBlobman()
        for _, desc in pairs(workspace:GetDescendants()) do
            if desc.Name == "CreatureBlobman" then
                if desc:FindFirstChild("VehicleSeat") and desc.VehicleSeat:FindFirstChild("SeatWeld") and isDescendantOf(desc.VehicleSeat.SeatWeld.Part1, LP.Character) then
                    return desc
                end
            end
        end
        return nil
    end

    local function getPlayerNames()
        local names = {}
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LP then table.insert(names, p.Name) end
        end
        return names
    end

    BlobTab:AddSlider({Name = "🐙 デストロイスピード", Min = 0.005, Max = 1, Default = 0.005, Increment = 0.005, ValueName = "秒", Callback = function(v) _G.BlobmanDelay = v end})

    -- デストロイサーバー（全員）
    BlobTab:AddToggle({Name = "🐙 デストロイサーバー（全員）ON/OFF", Default = false, Callback = function(v)
        if v then
            blobmanCoro = coroutine.create(function()
                blobman = findBlobman()
                if not blobman then
                    showNotif("❌ ブロブマンに乗ってください！")
                    return
                end
                while true do
                    pcall(function()
                        for _, player in pairs(Players:GetChildren()) do
                            if player ~= LP then
                                blobGrabPlayer(player, blobman)
                                task.wait(_G.BlobmanDelay)
                            end
                        end
                    end)
                    task.wait(0.02)
                end
            end)
            coroutine.resume(blobmanCoro)
        else
            if blobmanCoro then coroutine.close(blobmanCoro); blobmanCoro = nil end
            blobman = nil
        end
    end})

    -- ターゲット指定グラブ
    BlobTab:AddSection({Name = "🎯 ターゲット指定グラブ"})
    local targetPlayerName = ""
    local playerNames = getPlayerNames()

    BlobTab:AddButton({Name = "🔄 プレイヤーリスト更新", Callback = function()
        playerNames = getPlayerNames()
        local sg = Instance.new("ScreenGui"); sg.ResetOnSpawn = false; sg.Parent = LP.PlayerGui
        local lb = Instance.new("TextLabel"); lb.Size = UDim2.new(1,0,0,50); lb.Position = UDim2.new(0,0,0.35,0)
        lb.BackgroundTransparency = 0.3; lb.BackgroundColor3 = Color3.fromRGB(0,0,0)
        lb.TextColor3 = Color3.fromRGB(100,255,100); lb.TextScaled = true
        lb.Text = "✅ リスト更新完了！"; lb.Parent = sg
        task.delay(2, function() sg:Destroy() end)
    end})

    BlobTab:AddDropdown({
        Name = "🎯 ターゲット選択",
        Default = #playerNames > 0 and playerNames[1] or "プレイヤーなし",
        Options = #playerNames > 0 and playerNames or {"プレイヤーなし"},
        Callback = function(v)
            targetPlayerName = v
            _G.BlobTargetName = v
        end
    })

    BlobTab:AddToggle({Name = "🎯 ターゲット連打グラブ ON/OFF", Default = false, Callback = function(v)
        if v then
            blobTargetCoro = coroutine.create(function()
                blobman = findBlobman()
                if not blobman then
                    showNotif("❌ ブロブマンに乗ってください！")
                    return
                end
                if targetPlayerName == "" or targetPlayerName == "プレイヤーなし" then
                    showNotif("❌ ターゲットを選択してください！")
                    return
                end
                while true do
                    pcall(function()
                        local target = Players:FindFirstChild(_G.BlobTargetName)
                        if target then
                            -- 掴む
                            blobGrabPlayer(target, blobman)
                            task.wait(0.3)
                            -- 離す
                            EndGrabEarly:FireServer()
                            task.wait(0.3)
                        end
                    end)
                end
            end)
            coroutine.resume(blobTargetCoro)
        else
            if blobTargetCoro then coroutine.close(blobTargetCoro); blobTargetCoro = nil end
        end
    end})

    Players.PlayerAdded:Connect(function() playerNames = getPlayerNames() end)
    Players.PlayerRemoving:Connect(function() playerNames = getPlayerNames() end)

    -- =====================
    -- ファン/トロール
    -- =====================
    FunTab2:AddSection({Name = "🎭 ファン/トロール設定"})
    local coinAmount = ""
    local decoyOffset = 15
    local circleRadius = 10
    local stopDistance = 5
    local followMode = true
    local decoyConns = {}

    FunTab2:AddTextbox({Name = "コイン数", Default = "", TextDisappear = false, Callback = function(v) coinAmount = v end})
    FunTab2:AddButton({Name = "💰 コイン取得", Callback = function()
        pcall(function()
            LP.PlayerGui.MenuGui.TopRight.CoinsFrame.CoinsDisplay.Coins.Text = tostring(tonumber(coinAmount) or 0)
        end)
    end})
    FunTab2:AddSection({Name = "デコイ設定"})
    FunTab2:AddSlider({Name = "デコイオフセット", Min = 1, Max = 10, Default = 5, Increment = 1, ValueName = "", Callback = function(v) decoyOffset = v end})
    FunTab2:AddSlider({Name = "サークル半径", Min = 1, Max = 50, Default = 10, Increment = 1, ValueName = "", Callback = function(v) circleRadius = v end})
    FunTab2:AddButton({Name = "🤖 デコイフォロー", Callback = function()
        local decoys = {}
        for _, d in pairs(workspace:GetDescendants()) do
            if d:IsA("Model") and d.Name == "YouDecoy" then table.insert(decoys, d) end
        end
        local numDecoys = #decoys
        local midPoint = math.ceil(numDecoys / 2)

        local function updateDecoyPositions()
            for index, decoy in pairs(decoys) do
                local torso = decoy:FindFirstChild("Torso")
                if torso then
                    local bp = torso:FindFirstChild("BodyPosition")
                    local bg = torso:FindFirstChild("BodyGyro")
                    if bp and bg then
                        local targetPos
                        if followMode then
                            if playerCharacter and playerCharacter:FindFirstChild("HumanoidRootPart") then
                                targetPos = playerCharacter.HumanoidRootPart.Position
                                local offset = (index - midPoint) * decoyOffset
                                local forward = playerCharacter.HumanoidRootPart.CFrame.LookVector
                                local right = playerCharacter.HumanoidRootPart.CFrame.RightVector
                                targetPos = targetPos - forward * decoyOffset + right * offset
                            end
                        else
                            local nearest = getNearestPlayer()
                            if nearest and nearest.Character and nearest.Character:FindFirstChild("HumanoidRootPart") then
                                local angle = math.rad((index-1) * (360 / numDecoys))
                                targetPos = nearest.Character.HumanoidRootPart.Position + Vector3.new(math.cos(angle)*circleRadius, 0, math.sin(angle)*circleRadius)
                                bg.CFrame = CFrame.new(torso.Position, nearest.Character.HumanoidRootPart.Position)
                            end
                        end
                        if targetPos then
                            local dist = (targetPos - torso.Position).Magnitude
                            if dist > stopDistance then
                                bp.Position = targetPos
                                if followMode then bg.CFrame = CFrame.new(torso.Position, targetPos) end
                            else
                                bp.Position = torso.Position; bg.CFrame = torso.CFrame
                            end
                        end
                    end
                end
            end
        end

        for _, decoy in pairs(decoys) do
            local torso = decoy:FindFirstChild("Torso")
            if torso then
                local bp = Instance.new("BodyPosition"); bp.Parent = torso
                local bg = Instance.new("BodyGyro"); bg.Parent = torso
                bp.MaxForce = Vector3.new(40000,40000,40000); bp.D = 100; bp.P = 100
                bg.MaxTorque = Vector3.new(40000,40000,40000); bg.D = 100; bg.P = 20000
                local conn = RunService.Heartbeat:Connect(updateDecoyPositions)
                table.insert(decoyConns, conn)
                pcall(function() SetNetworkOwner:FireServer(torso, playerCharacter.Head.CFrame) end)
            end
        end
    end})
    FunTab2:AddButton({Name = "🔄 フォローモード切替", Callback = function() followMode = not followMode end})
    FunTab2:AddButton({Name = "❌ デコイ切断", Callback = function()
        for _, conn in ipairs(decoyConns) do conn:Disconnect() end
        decoyConns = {}
    end})

    -- =====================
    -- サイレントエイム
    -- =====================
    _G.SilentAimEnabled = false
    _G.SilentAimRange = 30
    _G.TriggerBotEnabled = false
    _G.TriggerDelay = 0.1

    local function GetHRP() return LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") end
    local function GetDirection(Origin, Position) return (Position - Origin).Unit * (Origin - Position).Magnitude end

    local function GetClosestPlayerInWorld()
        local Closest, Distance = nil, _G.SilentAimRange
        local hrp = GetHRP()
        if not hrp then return nil end
        for _, Player in next, GetPlayers(Players) do
            if Player ~= LP then
                local Character = Player.Character
                if not Character then continue end
                local Head = Character:FindFirstChild("Head")
                local Humanoid = Character:FindFirstChild("Humanoid")
                if Head and Head.Parent and Humanoid and Humanoid.Health > 0 then
                    local _Distance = (hrp.Position - Head.Position).Magnitude
                    if _Distance < Distance then Closest = Head; Distance = _Distance end
                end
            end
        end
        if Closest and Closest.Parent then return Closest end
        return nil
    end

    local LastTriggerTime = 0
    local TriggerConnection = nil

    local function UpdateTriggerBot()
        if TriggerConnection then TriggerConnection:Disconnect(); TriggerConnection = nil end
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

    local oldNamecall = nil
    local function HookSilentAim()
        if oldNamecall then return end
        oldNamecall = hookmetamethod(game, "__namecall", function(...)
            if checkcaller() then return oldNamecall(...) end
            local Method = getnamecallmethod()
            local Arguments = {...}
            if _G.SilentAimEnabled and Arguments[1] == workspace and Method == "Raycast" then
                if typeof(Arguments[#Arguments]) ~= "RaycastParams" then return oldNamecall(...) end
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

    AimTab:AddSection({Name = "🎯 サイレントエイム設定"})
    AimTab:AddSlider({Name = "照準範囲（スタッド）", Min = 5, Max = 500, Default = 30, Increment = 0.5, ValueName = "studs", Callback = function(v) _G.SilentAimRange = v end})
    AimTab:AddToggle({Name = "🎯 サイレントエイム ON/OFF", Default = false, Callback = function(v) _G.SilentAimEnabled = v end})
    AimTab:AddSection({Name = "🤖 トリガーボット設定"})
    AimTab:AddSlider({Name = "トリガー遅延（秒）", Min = 0.05, Max = 0.5, Default = 0.1, Increment = 0.01, ValueName = "秒", Callback = function(v) _G.TriggerDelay = v end})
    AimTab:AddToggle({Name = "🤖 トリガーボット ON/OFF", Default = false, Callback = function(v) _G.TriggerBotEnabled = v; UpdateTriggerBot() end})

    -- =====================
    -- レインボーライン
    -- =====================
    local rainbowEnabled = false
    local hueOffset = 0
    local originalColors = {}
    if ReplicatedStorage:FindFirstChild("DataEvents") and ReplicatedStorage.DataEvents:FindFirstChild("UpdateLineColorsEvent") then
        for i = 1, 10 do table.insert(originalColors, Color3.new(1,1,1)) end
    end

    local function FireRainbowColors()
        pcall(function()
            local cs = ColorSequence.new{
                ColorSequenceKeypoint.new(0,   Color3.fromHSV((0.0+hueOffset)%1,1,1)),
                ColorSequenceKeypoint.new(0.1, Color3.fromHSV((0.1+hueOffset)%1,1,1)),
                ColorSequenceKeypoint.new(0.2, Color3.fromHSV((0.2+hueOffset)%1,1,1)),
                ColorSequenceKeypoint.new(0.3, Color3.fromHSV((0.3+hueOffset)%1,1,1)),
                ColorSequenceKeypoint.new(0.4, Color3.fromHSV((0.4+hueOffset)%1,1,1)),
                ColorSequenceKeypoint.new(0.5, Color3.fromHSV((0.5+hueOffset)%1,1,1)),
                ColorSequenceKeypoint.new(0.6, Color3.fromHSV((0.6+hueOffset)%1,1,1)),
                ColorSequenceKeypoint.new(0.7, Color3.fromHSV((0.7+hueOffset)%1,1,1)),
                ColorSequenceKeypoint.new(0.8, Color3.fromHSV((0.8+hueOffset)%1,1,1)),
                ColorSequenceKeypoint.new(0.9, Color3.fromHSV((0.9+hueOffset)%1,1,1)),
                ColorSequenceKeypoint.new(1.0, Color3.fromHSV((1.0+hueOffset)%1,1,1)),
            }
            ReplicatedStorage.DataEvents.UpdateLineColorsEvent:FireServer(cs, cs.Keypoints[1].Value, cs.Keypoints[2].Value, cs.Keypoints[3].Value, cs.Keypoints[4].Value, cs.Keypoints[5].Value, cs.Keypoints[6].Value, cs.Keypoints[7].Value, cs.Keypoints[8].Value, cs.Keypoints[9].Value)
        end)
    end

    RunService.Heartbeat:Connect(function()
        if rainbowEnabled then hueOffset = (hueOffset + 0.005) % 1; FireRainbowColors() end
    end)

    LineTab:AddSection({Name = "🌈 レインボーライン設定"})
    LineTab:AddToggle({Name = "🌈 レインボーライン ON/OFF", Default = false, Callback = function(v)
        rainbowEnabled = v
        if not v and #originalColors > 0 then
            pcall(function()
                ReplicatedStorage.DataEvents.UpdateLineColorsEvent:FireServer(originalColors[1],originalColors[2],originalColors[3],originalColors[4],originalColors[5],originalColors[6],originalColors[7],originalColors[8],originalColors[9],originalColors[10])
            end)
        end
    end})
    LineTab:AddLabel("Credit: BGHACKERS / BGHackers(@Logfeetst)")

    -- =====================
    -- 羽スクリプト
    -- =====================
    local player2 = Players.LocalPlayer
    local sparklerLoop = nil
    local heartLoop = nil
    local myModels = {}
    local heartModels = {}
    local othersModels = {}
    local othersLoop = nil

    local spreadDist = 1; local bodyDist = 1; local heightOff = 0
    local maxCount = 2; local othersCount = 2; local flapSpeed = 2
    local flapAngle = 30; local jointCount = 1; local currentShape = "羽"
    local heartCount = 10; local heartScale = 2; local heartHeight = 0; local heartSpeed = 0.5

    local function getAllSparklerModels()
        local list = {}
        for _, v in ipairs(workspace:GetDescendants()) do
            if v.Name == "FireworkSparkler" and v:IsA("Model") then table.insert(list, v) end
        end
        return list
    end

    local function setupPhysics(model)
        for _, v in ipairs(model:GetDescendants()) do
            if v:IsA("BasePart") then
                pcall(function()
                    v.CanCollide = false; v.CanTouch = false; v.Anchored = false
                    if not v:FindFirstChildOfClass("BodyPosition") then
                        local bp = Instance.new("BodyPosition")
                        bp.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
                        bp.P = 500000; bp.D = 50; bp.Position = v.Position; bp.Parent = v
                    end
                    if not v:FindFirstChildOfClass("BodyGyro") then
                        local bg = Instance.new("BodyGyro")
                        bg.MaxTorque = Vector3.new(math.huge,math.huge,math.huge)
                        bg.P = 500000; bg.D = 50; bg.CFrame = v.CFrame; bg.Parent = v
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
        local jointPhase = (jointIndex-1)*0.4
        local rowMult = (row-1)/math.max(totalRows-1,1)
        local jointMult = (jointIndex-1)/math.max(jointCount-1,1)
        local flapMult = rowMult*(0.3+jointMult*0.7)
        local flapY = math.sin(t*flapSpeed+row*0.5+jointPhase)*flapAngle*0.1*flapMult
        local jointOffset = (jointIndex-1)*spreadDist*0.5
        local x = side == "left" and -(bodyDist+(row-1)*spreadDist+jointOffset) or (bodyDist+(row-1)*spreadDist+jointOffset)
        local targetCFrame = root.CFrame * CFrame.new(x, heightOff+flapY, 0)
        local rot = side == "left" and CFrame.Angles(0,math.rad(180),0) or CFrame.Angles(0,0,0)
        return targetCFrame * rot
    end

    local function calcCircle(root, index, total)
        local t = tick()
        local angle = (index-1)/total*(math.pi*2)
        local radius = bodyDist+spreadDist
        local x = math.cos(angle+t*flapSpeed*0.3)*radius
        local z = math.sin(angle+t*flapSpeed*0.3)*radius
        local flapY = math.sin(t*flapSpeed+index)*flapAngle*0.05
        return (root.CFrame*CFrame.new(x,heightOff+flapY,z))*CFrame.Angles(0,angle,0)
    end

    local function calcSpiral(root, index, total)
        local t = tick()
        local angle = (index-1)/total*(math.pi*4)+t*flapSpeed*0.5
        local radius = bodyDist+(index/total)*spreadDist*3
        local x = math.cos(angle)*radius; local z = math.sin(angle)*radius
        local y = heightOff+(index/total)*spreadDist*2
        return (root.CFrame*CFrame.new(x,y,z))*CFrame.Angles(0,angle,0)
    end

    local function calcHeart(root, index, total)
        local t = tick()
        local angle = (index-1)/total*(math.pi*2)
        local hx = heartScale*(16*math.sin(angle)^3)/10
        local hy = heartScale*(13*math.cos(angle)-5*math.cos(2*angle)-2*math.cos(3*angle)-math.cos(4*angle))/10
        local rotAngle = t*heartSpeed
        local rx = hx*math.cos(rotAngle); local rz = hx*math.sin(rotAngle)
        local worldPos = root.CFrame*CFrame.new(rx,heartHeight+hy,rz)
        return CFrame.new(worldPos.Position)*CFrame.Angles(0,math.rad(180),0)*CFrame.Angles(0,rotAngle,0)
    end

    local function runShape(root, models)
        local total = #models
        if currentShape == "羽" then
            local leftModels = {}; local rightModels = {}
            for i, m in ipairs(models) do
                if i%2==1 then table.insert(leftModels,m) else table.insert(rightModels,m) end
            end
            for row=1,#leftModels do for j=1,jointCount do
                local model = leftModels[row]
                if model and model.Parent then moveModel(model, calcWing(root,row,"left",#leftModels,j)) end
            end end
            for row=1,#rightModels do for j=1,jointCount do
                local model = rightModels[row]
                if model and model.Parent then moveModel(model, calcWing(root,row,"right",#rightModels,j)) end
            end end
        else
            for i, model in ipairs(models) do
                if model and model.Parent then
                    local cf
                    if currentShape == "円形" then cf = calcCircle(root,i,total)
                    elseif currentShape == "渦巻き" then cf = calcSpiral(root,i,total) end
                    if cf then moveModel(model, cf) end
                end
            end
        end
    end

    local function showError(msg)
        local sg2 = Instance.new("ScreenGui"); sg2.ResetOnSpawn = false; sg2.Parent = player2.PlayerGui
        local lbl2 = Instance.new("TextLabel"); lbl2.Size = UDim2.new(1,0,0,60); lbl2.Position = UDim2.new(0,0,0.4,0)
        lbl2.BackgroundTransparency = 0.3; lbl2.BackgroundColor3 = Color3.fromRGB(0,0,0)
        lbl2.TextColor3 = Color3.fromRGB(255,50,50); lbl2.TextScaled = true; lbl2.Text = msg; lbl2.Parent = sg2
        task.delay(3, function() sg2:Destroy() end)
    end

    local function startMyAttach()
        local all = getAllSparklerModels(); myModels = {}
        local need = maxCount*jointCount
        for i=1,math.min(need,#all) do table.insert(myModels,all[i]); setupPhysics(all[i]) end
        if #myModels==0 then showError("FireworkSparklerが見つかりません！") return end
        sparklerLoop = RunService.Heartbeat:Connect(function()
            local char = player2.Character; if not char then return end
            local root = char:FindFirstChild("HumanoidRootPart"); if not root then return end
            runShape(root, myModels)
        end)
    end

    local function stopMyAttach()
        if sparklerLoop then sparklerLoop:Disconnect(); sparklerLoop = nil end; myModels = {}
    end

    local function startHeartAttach()
        local all = getAllSparklerModels(); heartModels = {}
        for i=1,math.min(heartCount,#all) do table.insert(heartModels,all[i]); setupPhysics(all[i]) end
        if #heartModels==0 then showError("FireworkSparklerが見つかりません！") return end
        heartLoop = RunService.Heartbeat:Connect(function()
            local char = player2.Character; if not char then return end
            local root = char:FindFirstChild("HumanoidRootPart"); if not root then return end
            local total = #heartModels
            for i, model in ipairs(heartModels) do
                if model and model.Parent then moveModel(model, calcHeart(root,i,total)) end
            end
        end)
    end

    local function stopHeartAttach()
        if heartLoop then heartLoop:Disconnect(); heartLoop = nil end; heartModels = {}
    end

    local function startOthersAttach()
        local all = getAllSparklerModels(); local used = {}
        for _, m in ipairs(myModels) do used[m] = true end
        for _, m in ipairs(heartModels) do used[m] = true end
        othersModels = {}; local need = othersCount*jointCount
        for _, m in ipairs(all) do
            if not used[m] then table.insert(othersModels,m); setupPhysics(m) end
            if #othersModels >= need then break end
        end
        othersLoop = RunService.Heartbeat:Connect(function()
            local char = player2.Character; if not char then return end
            local root = char:FindFirstChild("HumanoidRootPart"); if not root then return end
            runShape(root, othersModels)
        end)
    end

    local function stopOthersAttach()
        if othersLoop then othersLoop:Disconnect(); othersLoop = nil end; othersModels = {}
    end

    HaneTab:AddSection({Name = "🎆 FireworkSparkler 設定"})
    HaneTab:AddDropdown({Name = "形の選択", Default = "羽", Options = {"羽","円形","渦巻き"}, Callback = function(v) currentShape = v end})
    HaneTab:AddSlider({Name = "吸い付く個数（自分）", Min = 2, Max = 90, Default = 2, Increment = 2, ValueName = "個", Callback = function(v) maxCount = v end})
    HaneTab:AddSlider({Name = "関節数", Min = 1, Max = 10, Default = 1, Increment = 1, ValueName = "個", Callback = function(v) jointCount = v end})
    HaneTab:AddSlider({Name = "体からの距離", Min = 1, Max = 20, Default = 1, Increment = 1, ValueName = "スタッド", Callback = function(v) bodyDist = v end})
    HaneTab:AddSlider({Name = "羽同士の間隔", Min = 1, Max = 10, Default = 1, Increment = 1, ValueName = "スタッド", Callback = function(v) spreadDist = v end})
    HaneTab:AddSlider({Name = "高さ", Min = -5, Max = 10, Default = 0, Increment = 1, ValueName = "", Callback = function(v) heightOff = v end})
    HaneTab:AddSlider({Name = "羽ばたき速度", Min = 1, Max = 100, Default = 2, Increment = 1, ValueName = "", Callback = function(v) flapSpeed = v end})
    HaneTab:AddSlider({Name = "羽ばたき幅", Min = 5, Max = 1440, Default = 30, Increment = 5, ValueName = "度", Callback = function(v) flapAngle = v end})
    HaneTab:AddToggle({Name = "🎆 自分のSparkler ON/OFF", Default = false, Callback = function(v)
        if v then startMyAttach() else stopMyAttach() end
    end})
    HaneTab:AddSection({Name = "👥 他人のFireworkSparkler"})
    HaneTab:AddSlider({Name = "吸い付く個数（他人）", Min = 2, Max = 90, Default = 2, Increment = 2, ValueName = "個", Callback = function(v) othersCount = v end})
    HaneTab:AddToggle({Name = "👥 他人のSparkler ON/OFF", Default = false, Callback = function(v)
        if v then startOthersAttach() else stopOthersAttach() end
    end})

    HeartTab:AddSection({Name = "💗 ハート専用設定"})
    HeartTab:AddSlider({Name = "💗 個数", Min = 2, Max = 90, Default = 10, Increment = 2, ValueName = "個", Callback = function(v) heartCount = v end})
    HeartTab:AddSlider({Name = "💗 大きさ", Min = 1, Max = 20, Default = 2, Increment = 1, ValueName = "", Callback = function(v) heartScale = v end})
    HeartTab:AddSlider({Name = "💗 高さ", Min = -5, Max = 10, Default = 0, Increment = 1, ValueName = "", Callback = function(v) heartHeight = v end})
    HeartTab:AddSlider({Name = "💗 回転速度", Min = 0, Max = 10, Default = 1, Increment = 1, ValueName = "", Callback = function(v) heartSpeed = v*0.5 end})
    HeartTab:AddToggle({Name = "💗 ハート ON/OFF", Default = false, Callback = function(v)
        if v then startHeartAttach() else stopHeartAttach() end
    end})

    OrionLib2:Init()
end})

OrionLib:Init()