local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Chloe X Clone - Hijau Kuning",
   LoadingTitle = "Loading Chloe Features...",
   LoadingSubtitle = "Fish It! by Grok",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "FishItHub",
      FileName = "Config"
   },
   KeySystem = false,
   Theme = "Emerald" -- HIJAU THEME! Kuning accent auto
})

local Tab1 = Window:CreateTab("Fishing", 4483362458)
local Section1 = Tab1:CreateSection("Fishing")

local FishingMode = Tab1:CreateDropdown({
   Name = "Mode (Legit/Rage/Blatant/Instant)",
   Options = {"Legit", "Rage", "Blatant", "Instant"},
   CurrentOption = {"Legit"},
   Flag = "FMode",
   Callback = function(Option)
      getgenv().FMode = Option[1]
   end,
})

local AutoFish = Tab1:CreateToggle({
   Name = "Instant Catch / Auto Fish",
   CurrentValue = false,
   Flag = "AFish",
   Callback = function(Value)
      getgenv().AFish = Value
   end,
})

local AutoSell = Tab1:CreateToggle({
   Name = "Auto Sell",
   CurrentValue = false,
   Flag = "ASell",
   Callback = function(Value)
      getgenv().ASell = Value
   end,
})

local AutoFav = Tab1:CreateToggle({
   Name = "Auto Favorite (Rebuy Best Rod)",
   CurrentValue = false,
   Flag = "AFav",
   Callback = function(Value)
      getgenv().AFav = Value
   end,
})

local Tab2 = Window:CreateTab("Auto", nil)
local Section2 = Tab2:CreateSection("Auto Features")

Tab2:CreateButton({
   Name = "Save Position",
   Callback = function()
      local char = game.Players.LocalPlayer.Character
      if char and char:FindFirstChild("HumanoidRootPart") then
         getgenv().SavedPos = char.HumanoidRootPart.CFrame
         Rayfield:Notify({Title = "Saved!", Content = "Position saved!", Duration = 3})
      end
   end,
})

Tab2:CreateButton({
   Name = "TP to Saved Pos",
   Callback = function()
      local char = game.Players.LocalPlayer.Character
      if char and char:FindFirstChild("HumanoidRootPart") and getgenv().SavedPos then
         char.HumanoidRootPart.CFrame = getgenv().SavedPos
      end
   end,
})

local AutoQuest = Tab2:CreateToggle({
   Name = "Auto Quest",
   CurrentValue = false,
   Callback = function(Value)
      getgenv().AQuest = Value
   end,
})

local AutoLevers = Tab2:CreateToggle({
   Name = "Auto Levers",
   CurrentValue = false,
   Callback = function(Value)
      getgenv().ALevers = Value
   end,
})

local CoinTradeT = Tab2:CreateToggle({
   Name = "Coin Trading",
   CurrentValue = false,
   Callback = function(Value)
      getgenv().ACoinTrade = Value
   end,
})

local Tab3 = Window:CreateTab("Player", 4483362458)
local Section3 = Tab3:CreateSection("Player Mods")

local FreezeP = Tab3:CreateToggle({
   Name = "Freeze Player",
   CurrentValue = false,
   Callback = function(Value)
      getgenv().FreezeP = Value
   end,
})

local InfJ = Tab3:CreateToggle({
   Name = "Inf Jump",
   CurrentValue = false,
   Callback = function(Value)
      getgenv().InfJ = Value
   end,
})

local WS = Tab3:CreateSlider({
   Name = "WalkSpeed",
   Range = {16, 500},
   Increment = 10,
   CurrentValue = 16,
   Flag = "WS",
   Callback = function(Value)
      local char = game.Players.LocalPlayer.Character
      if char and char:FindFirstChild("Humanoid") then
         char.Humanoid.WalkSpeed = Value
      end
   end,
})

local Nclip = Tab3:CreateToggle({
   Name = "Noclip",
   CurrentValue = false,
   Callback = function(Value)
      getgenv().Nclip = Value
   end,
})

local FB = Tab3:CreateToggle({
   Name = "Fullbright",
   CurrentValue = false,
   Callback = function(Value)
      getgenv().FB = Value
   end,
})

local Tab4 = Window:CreateTab("Teleports", nil)
local Section4 = Tab4:CreateSection("TP Locations") -- Edit pos sesuai map

Tab4:CreateButton({
   Name = "TP Spawn",
   Callback = function()
      game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 10, 0) -- Adjust
   end,
})

Tab4:CreateButton({
   Name = "TP Sell Area",
   Callback = function()
      game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-100, 5, 0) -- Adjust
   end,
})

Tab4:CreateButton({
   Name = "TP Jungle Event",
   Callback = function()
      game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(200, 10, 100) -- Adjust
   end,
})

local Tab5 = Window:CreateTab("Misc", 4483362458)
local Section5 = Tab5:CreateSection("Misc")

local WebhookInput = Tab5:CreateInput({
   Name = "Discord Webhook URL",
   PlaceholderText = "https://discord.com/api/webhooks/...",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
      getgenv().WebhookUrl = Text
   end,
})

local NotifyW = Tab5:CreateToggle({
   Name = "Full Webhooks (Stats Notify)",
   CurrentValue = false,
   Callback = function(Value)
      getgenv().NotifyW = Value
   end,
})

local AShake = Tab5:CreateToggle({
   Name = "Auto Shake",
   CurrentValue = false,
   Callback = function(Value)
      getgenv().AShake = Value
   end,
})

local NoAnimF = Tab5:CreateToggle({
   Name = "No Fishing Animations",
   CurrentValue = false,
   Callback = function(Value)
      getgenv().NoAnimF = Value
   end,
})

-- SERVICES & REMOTES
local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local player = Players.LocalPlayer

local Remotes = RS:WaitForChild("Remotes")
local Comm = Remotes:WaitForChild("EventManager") -- or "Comm", adjust if needed

-- CONNECTIONS
local connections = {}

-- FULLBRIGHT
local oldLighting = {}
connections.Fullbright = FB.Changed:Connect(function()
   if getgenv().FB then
      oldLighting.Brightness = Lighting.Brightness
      oldLighting.ClockTime = Lighting.ClockTime
      oldLighting.FogEnd = Lighting.FogEnd
      oldLighting.GlobalShadows = Lighting.GlobalShadows
      oldLighting.Ambient = Lighting.Ambient
      Lighting.Brightness = 2
      Lighting.ClockTime = 0.3
      Lighting.FogEnd = math.huge
      Lighting.GlobalShadows = false
      Lighting.Ambient = Color3.fromRGB(255, 255, 255)
   else
      Lighting.Brightness = oldLighting.Brightness or 2
      Lighting.ClockTime = oldLighting.ClockTime or 14
      Lighting.FogEnd = oldLighting.FogEnd or 100000
      Lighting.GlobalShadows = oldLighting.GlobalShadows or true
      Lighting.Ambient = oldLighting.Ambient or Color3.fromRGB(117, 113, 106)
   end
end)

-- NOCLIP
connections.Noclip = RunService.Stepped:Connect(function()
   if getgenv().Nclip then
      local char = player.Character
      if char then
         for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
         end
      end
   end
end)

-- INF JUMP
connections.InfJump = UserInputService.JumpRequest:Connect(function()
   if getgenv().InfJ then
      local char = player.Character
      if char and char:FindFirstChild("Humanoid") then
         char.Humanoid:ChangeState("Jumping")
      end
   end
end)

-- FREEZE
spawn(function()
   while task.wait() do
      if getgenv().FreezeP then
         local char = player.Character
         if char and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
            char.HumanoidRootPart.RotVelocity = Vector3.new(0,0,0)
         end
      end
   end
end)

-- NO ANIM
spawn(function()
   while task.wait() do
      if getgenv().NoAnimF then
         local char = player.Character
         if char and char:FindFirstChild("Animator") then
            char.Animator.Disabled = true -- Disable all anims
         end
      end
   end
end)

-- MAIN LOOP (ALL FEATURES)
spawn(function()
   local fishCount = 0
   while task.wait(0.01) do
      local mode = getgenv().FMode or "Legit"
      local delay = (mode == "Instant" and 0.01) or (mode == "Blatant" and 0.05) or (mode == "Rage" and 0.2) or 1

      if getgenv().AFish then
         Comm:FireServer("CastLine")
         task.wait(delay)
         Comm:FireServer("ReelLine", 100) -- 100% perfect/instant catch
         fishCount = fishCount + 1
      end

      if getgenv().ASell then
         Comm:FireServer("SellAllFish") -- or "SellAll"
      end

      if getgenv().AFav then
         Comm:FireServer("BuyRod", "BestRodName") -- Diamond/Mythic etc, adjust
      end

      if getgenv().AQuest then
         Comm:FireServer("CompleteQuest") -- or loop quests
      end

      if getgenv().ALevers then
         -- TP levers & interact
         Comm:FireServer("PullLever")
      end

      if getgenv().ACoinTrade then
         Comm:FireServer("TradeCoins")
      end

      if getgenv().AShake then
         Comm:FireServer("Shake", true)
      end

      -- WEBHOOK NOTIFY
      if getgenv().NotifyW and getgenv().WebhookUrl and fishCount > 0 then
         local data = {
            content = "**Fish It Stats**\nCaught: " .. fishCount .. " fish\nMode: " .. mode,
            username = "Chloe X Clone"
         }
         pcall(function()
            HttpService:PostAsync(getgenv().WebhookUrl, HttpService:JSONEncode(data), Enum.HttpContentType.ApplicationJson)
         end)
         fishCount = 0
      end
   end
end)

Rayfield:LoadConfiguration()
