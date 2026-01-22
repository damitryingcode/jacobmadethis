-- Wait for game to fully load
print("Waiting for game to load...")
repeat wait(2) until game:IsLoaded()
print("Game loaded, initializing script...")
wait(3) -- Additional buffer time after game is loaded

-- Server hopping configuration
local IsServerHopping = false
local MaxHopAttempts = 10
local CurrentHopAttempts = 0
local LastHopTime = 0
local HOP_COOLDOWN = 15 -- seconds between hops
local SCAN_INTERVAL = 15 -- seconds between scans

-- Simple Whitelist Check
local Whitelist = {
    [9567930738] = true,  -- Your user ID
    [9269094601] = true,
    [9245522394] = true,
    [7181446] = true,
    -- Add more user IDs like this:
    -- [12345678] = true,
}

-- Server hop status tracking
local ServerHopStatus = {
    IsHopping = false,
    LastHopTime = 0,
    NextHopTime = 0,
    Attempts = 0,
    MaxAttempts = 1000,
    Cooldown = 15, -- seconds
    StatusMessage = "Ready"
}

-- Get the local player and services
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local TeleportService = game:GetService("TeleportService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

-- Check if player is whitelisted
if not Whitelist[player.UserId] then
    -- If not whitelisted, show message and stop the script
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Access Denied",
        Text = "You are not whitelisted to use this script.",
        Duration = 5
    })
    return
end

-- If we get here, the player is whitelisted
print("Access granted to user ID:", player.UserId)

-- Initialize services
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

print("Services initialized, starting scan process...")

local RejoinAfterFindingaValuablePlayer = true
local FoundaPlayer = nil
local MinValue = 15000
local MaxPlayersPlaying = 6

local YourWebHook = "https://discord.com/api/webhooks/1445563338686857387/Tf4WzOwUEYhQH4pxnEKrTXR6kvOgS-aO5NRxyG-Pw10_xW8cw_x91wBURpbYZ9UTEe7g"

local items = {
	BaubleChroma = 14000,
	Blossom_G = 900,
	Luger = 70,
	TreeGun2023Chroma = 57000,
	Frostbite = 7,
	SwirlyGun = 60,
	SeerChroma = 55,
	Raygun = 1500,
        RaygunChroma = 15000,
        SnowcannonChroma = 9700,
        SnowDagger = 300,
	XenoKnife = 325,
	XenoGun = 325,
	TidesChroma = 50,
	TravelerGunChroma = 170000,
	Prismatic = 7,
	Lugercane = 23,
	Iceflake = 28,
	ZombieBat = 290,
	Gun1 = 5,
	Pearl_K = 65,
	FangChroma = 55,
	EternalCane = 23,
	Deathshard = 20,
	Sorry = 825,
	Latte_G_2023 = 150,
	SwirlyAxe = 80,
	TreeGun2023 = 2550,
	LugerChroma = 85,
	Clockwork = 20,
	RedSeer = 3,
	Xmas = 12,
	Icebeam = 28,
	Gingermint_KChroma = 63,
	ConstellationChroma = 12500,
	Latte_K_2023 = 150,
	Hallowscythe = 48,
	Flora = 150,
	SunsetGunChroma = 5300,
	Eternal3 = 10,
	OrangeSeer = 2,
	Boneblade = 7,
	Saw = 7,
	Makeshift = 65,
	VampireGunChroma = 19000,
	Plasmabeam = 28,
	SunsetGun = 500,
	Eternal2 = 8,
	Waves_K = 155,
	Phaser = 6,
	Knife1 = 3,
	SunsetKnifeChroma = 2200,
	ElderwoodKnifeChroma = 65,
	GemstoneChroma = 50,
	Ocean_G = 160,
	FlowerwoodGun = 150,
	Harvester = 525,
	Bauble = 500,
	GreenLuger = 40,
	Cookieblade = 4,
	ChromaLightbringer = 90,
	Plasmablade = 28,
	HeatChroma = 60,
	TreeKnife2023Chroma = 27000,
	WatergunChroma = 2850,
	SlasherChroma = 60,
	Heartblade = 130,
	HallowsBlade = 10,
	WraithGun = 175,
	Blaster = 25,
	Rainbow_G = 265,
	Pixel = 23,
	Web = 1,
	Hallowgun = 27,
	AuroraKnife = 105,
	IceDragon = 10,
	Rainbow_K = 260,
	Watergun = 120,
	VampiresEdge = 15,
	Gingerblade = 20,
	RedLuger = 60,
	TheSeer = 3,
	VampireAxe = 625,
	BonebladeChroma = 40,
	Minty = 20,
	Nightblade = 25,
	Logchopper = 22,
	FlowerwoodKnife = 145,
	BloodKnife = 10,
	Sugar = 80,
	SunsetKnife = 325,
	TravelerGun = 3700,
	GhostKnife = 12,
	Celestial = 1150,
	Bioblade = 15,
	Fang = 15,
	Constellation = 1000,
	SwirlyGunChroma = 65,
	ElderwoodKnife = 65,
	AmericaSword = 25,
	Iceblaster = 65,
	Icepiercer = 400,
	ElderwoodScythe = 65,
	TimeKnife = 6,
	Peppermint = 5,
	PurpleSeer = 3,
	Witched = 6,
	Darkshot = 620,
	WintersEdge = 10,
	Phantom2022 = 60,
	Virtual = 20,
	ShadowKnife = 6,
	LaserChroma = 70,
	Skulls = 7,
	Ghostblade = 7,
	YellowSeer = 2,
	Darkbringer = 60,
	SharkChroma = 55,
	Flames = 10,
	Spectre2022 = 60,
	Jinglegun = 20,
	Gingermint_G = 23,
	Gingermint_K = 23,
	Bloom = 150,
	Slasher = 22,
	Darksword = 615,
	GoldenGun = 4,
	ChromaDarkbringer = 95,
	Handsaw = 10,
	Chill = 15,
	TreeKnife2023 = 1050,
	Shark = 27,
	SwirlyBlade = 40,
	Laser = 30,
	Heat = 18,
	BattleAxe2 = 18,
	Hallow = 12,
	AmericaGun = 8,
	Icewing = 5,
	TravelerAxe = 8750,
	Eternal = 8,
	VampireGun = 775,
	Pumpking = 12,
	Sakura_K = 890,
	Scythe = 60,
	Nebula = 22,
	Snowflake = 7,
	SawChroma = 45,
	Gingerscope = 18000,
	GingerbladeChroma = 45,
	Eternal4 = 10,
	Icebreaker = 125,
	Gemstone = 25,
	Eggblade = 7,
	BattleAxe = 12,
	Turkey2023 = 2075,
	CandleflameChroma = 68,
	Spider = 17,
	CottonCandy = 50,
	Candleflame = 65,
	Candy = 190,
	Lightbringer = 55,
	Pearl_G = 65,
	ElderwoodGun = 60,
	BlueSeer = 3,
	Amerilaser = 28,
	AuroraGun = 110,
	WraithKnife = 175,
	Tides = 15,
	Frostsaber = 13,
        AlienBeam = 500000000,
	DeathshardChroma = 60
}

for _,Player in pairs(Players:GetPlayers()) do
	local TotalValue = 0
	for Name, Amount in pairs(game:GetService("ReplicatedStorage").Remotes.Extras.GetFullInventory:InvokeServer(Player).Weapons.Owned) do
		if items[Name] then
			TotalValue += items[Name] * Amount
		end
	end
	local instanceId = HttpService:GenerateGUID()
	local timeNow = os.date("%d/%m/%Y %H:%M")


	--warn(Player.Name.." has "..TotalValue)

	if TotalValue>= MinValue then
		FoundaPlayer = Player

		if TotalValue>= MinValue then
			FoundaPlayer = Player

			function SendMessage(url, message)
				local http = game:GetService("HttpService")
				local headers = {
					["Content-Type"] = "application/json"
				}
				local data = {
					["content"] = message
				}
				local body = http:JSONEncode(data)
				local response = request({
					Url = url,
					Method = "POST",
					Headers = headers,
					Body = body
				})
				print("Sent")
			end

			SendMessage(YourWebHook, "everyone\nPlayer: "..Player.Name.."\nValue: "..TotalValue..'\nscript: ```lua\ngame:GetService("TeleportService"):TeleportToPlaceInstance('..game.GameId..','..instanceId..')```')

		end
	end
end

local function updateStatus(message)
    ServerHopStatus.StatusMessage = message
    -- Update status label if it exists
    if StatusLabel then
        StatusLabel.Text = "Status: " .. message
    end
end

local function serverHop()
    if ServerHopStatus.IsHopping then 
        warn("Already hopping servers")
        return 
    end
    
    ServerHopStatus.IsHopping = true
    ServerHopStatus.Attempts = ServerHopStatus.Attempts + 1
    
    -- Check cooldown
    local timeSinceLastHop = os.time() - ServerHopStatus.LastHopTime
    if timeSinceLastHop < ServerHopStatus.Cooldown then
        local waitTime = ServerHopStatus.Cooldown - timeSinceLastHop
        updateStatus(string.format("Waiting %ds cooldown...", waitTime))
        wait(waitTime)
    end
    
    updateStatus("Searching for servers...")
    
    local success, err = pcall(function()
        local placeId = game.PlaceId
        local servers = {}
        
        -- Get server list with error handling
        local fetchSuccess, result = pcall(function()
            return HttpService:JSONDecode(game:HttpGet(
                string.format("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Asc&limit=100", placeId),
                true
            ))
        end)
        
        if not fetchSuccess or not result or not result.data then
            error("Failed to fetch server list: " .. tostring(result))
        end
        
        servers = result.data
        
        if #servers == 0 then
            error("No servers found in the response")
        end
        
        -- Filter out the current server
        local currentJobId = game.JobId
        local availableServers = {}
        
        for _, server in ipairs(servers) do
            if server.id ~= currentJobId then
                table.insert(availableServers, server)
            end
        end
        
        if #availableServers == 0 then
            warn("No other servers available")
            return
        end
        
        -- Select a random server
        local server = availableServers[math.random(1, #availableServers)]
        
        if server and server.id then
            updateStatus(string.format("Joining server %d/%d...", 
                server.playing or 0, 
                server.maxPlayers or 50))
                
            -- Save hop time before teleporting
            ServerHopStatus.LastHopTime = os.time()
            
            -- Teleport to the selected server
            TeleportService:TeleportToPlaceInstance(placeId, server.id, player)
            
            -- If we're still here, the teleport failed
            error("Teleport failed")
        else
            error("Invalid server data")
        end
    end)
    
    if not success then
        ServerHopStatus.IsHopping = false
        updateStatus("Hop failed: " .. tostring(err))
        
        if ServerHopStatus.Attempts < ServerHopStatus.MaxAttempts then
            local retryDelay = math.min(5 * ServerHopStatus.Attempts, 30) -- Exponential backoff, max 30s
            updateStatus(string.format("Retrying in %d seconds...", retryDelay))
            wait(retryDelay)
            return serverHop()
        else
            updateStatus("Max attempts reached")
        end
    end
end
-- UI Setup
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UIListLayout = Instance.new("UIListLayout")
local Title = Instance.new("TextLabel")
local UIPadding = Instance.new("UIPadding")
local StatusLabel = Instance.new("TextLabel")
local SendPromptButton = Instance.new("TextButton")
local OfcButton = Instance.new("TextButton")
local AskDiscordButton = Instance.new("TextButton")
local AskArtButton = Instance.new("TextButton")
local ServerHopButton = Instance.new("TextButton")

-- Function to create a styled button
local function createButton(name, text, position)
    local button = Instance.new("TextButton")
    button.Name = name
    button.Text = text
    button.Size = UDim2.new(0.9, 0, 0, 40)
    button.Position = position
    button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.GothamBold
    button.TextSize = 14
    button.BorderSizePixel = 0
    button.Parent = ButtonContainer
    
    -- Button hover effect
    button.MouseEnter:Connect(function()
        game:GetService("TweenService"):Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(80, 80, 80)}):Play()
    end)
    button.MouseLeave:Connect(function()
        game:GetService("TweenService"):Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
    end)
    
    return button
end

ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 1  -- Lower display order than default
ScreenGui.IgnoreGuiInset = true  -- Don't affect game's UI insets
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling  -- Only respect relative ZIndex

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BackgroundTransparency = 0.3  -- Make slightly transparent
MainFrame.BorderSizePixel = 0
-- Position the frame lower on the screen with more height
MainFrame.Position = UDim2.new(0.65, -300, 0.7, -300)  -- Positioned lower on the screen
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)  -- Anchor to center
MainFrame.Size = UDim2.new(0, 650, 0, 250)  -- Wider to fit buttons and taller for better spacing
MainFrame.Active = true  -- Need this for input to work
MainFrame.Selectable = true  -- Need this for input to work

-- Create a container for the player list
local PlayerListContainer = Instance.new("Frame")
PlayerListContainer.Name = "PlayerListContainer"
PlayerListContainer.Parent = MainFrame
PlayerListContainer.BackgroundTransparency = 1
PlayerListContainer.Size = UDim2.new(0.75, 0, 1, 0)  -- 75% width for player list
PlayerListContainer.Position = UDim2.new(0, 0, 0, 40)  -- Below title

-- Create a container for the buttons
local ButtonContainer = Instance.new("Frame")
ButtonContainer.Name = "ButtonContainer"
ButtonContainer.Parent = MainFrame
ButtonContainer.BackgroundTransparency = 1
ButtonContainer.Size = UDim2.new(0.25, -30, 1, -80)  -- Adjusted height for status label
ButtonContainer.Position = UDim2.new(0.75, 0, 0, 40)
ButtonContainer.AnchorPoint = Vector2.new(0, 0)

-- Layout for player list
local PlayerListLayout = Instance.new("UIListLayout")
PlayerListLayout.Parent = PlayerListContainer
PlayerListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
PlayerListLayout.VerticalAlignment = Enum.VerticalAlignment.Top
PlayerListLayout.SortOrder = Enum.SortOrder.LayoutOrder
PlayerListLayout.Padding = UDim.new(0, 8)

-- Layout for buttons
local ButtonLayout = Instance.new("UIListLayout")
ButtonLayout.Parent = ButtonContainer
ButtonLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
ButtonLayout.VerticalAlignment = Enum.VerticalAlignment.Top
ButtonLayout.SortOrder = Enum.SortOrder.LayoutOrder
ButtonLayout.Padding = UDim.new(0, 8)

UIPadding.Parent = MainFrame
UIPadding.PaddingBottom = UDim.new(0, 5)
UIPadding.PaddingTop = UDim.new(0, 5)

-- Make title bar draggable
local UserInputService = game:GetService("UserInputService")
local dragging = false
local dragInput, mousePos, framePos

local function updateInput(input)
    local delta = input.Position - mousePos
    framePos = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
    MainFrame.Position = framePos
    mousePos = input.Position
end

Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Title.BackgroundTransparency = 0.3  -- Make title bar semi-transparent
Title.BorderSizePixel = 0
Title.Size = UDim2.new(1, -40, 0, 40)  -- Make room for close button
Title.Font = Enum.Font.GothamBold
Title.Text = "made by @2girls1jacob"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16.000
Title.Active = true
Title.Selectable = true

-- Create status label
StatusLabel.Name = "StatusLabel"
StatusLabel.Parent = MainFrame
StatusLabel.BackgroundTransparency = 1
StatusLabel.Position = UDim2.new(0, 10, 0, 45)
StatusLabel.Size = UDim2.new(0.7, -20, 0, 20)
StatusLabel.Font = Enum.Font.GothamMedium
StatusLabel.Text = "Status: Ready"
StatusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
StatusLabel.TextSize = 12

-- Create close button
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Parent = MainFrame
CloseButton.AnchorPoint = Vector2.new(1, 0)
CloseButton.Position = UDim2.new(1, -5, 0, 5)
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.BorderSizePixel = 0
CloseButton.Text = "X"
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 16

-- Close button hover effects
CloseButton.MouseEnter:Connect(function()
    game:GetService("TweenService"):Create(
        CloseButton,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundColor3 = Color3.fromRGB(255, 80, 80)}
    ):Play()
end)

CloseButton.MouseLeave:Connect(function()
    game:GetService("TweenService"):Create(
        CloseButton,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundColor3 = Color3.fromRGB(200, 50, 50)}
    ):Play()
end)

-- Close button functionality
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Connect input events for dragging
Title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        mousePos = input.Position
        framePos = MainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

Title.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        updateInput(input)
    end
end)

-- Create Send Prompt Button
SendPromptButton.Name = "SendPromptButton"
SendPromptButton.Parent = ButtonContainer
SendPromptButton.AnchorPoint = Vector2.new(0, 0)
SendPromptButton.Position = UDim2.new(0, 10, 0, 20)
SendPromptButton.Size = UDim2.new(0, 120, 0, 30)
SendPromptButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
SendPromptButton.BackgroundTransparency = 0.3
SendPromptButton.BorderSizePixel = 0
SendPromptButton.Text = "Send Prompt"
SendPromptButton.Font = Enum.Font.GothamBold
SendPromptButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SendPromptButton.TextSize = 14
SendPromptButton.TextWrapped = true

-- Position the Send Prompt button at the top
SendPromptButton.Position = UDim2.new(0, 10, 0, 20)  -- Top position

-- Configure Ofc button
OfcButton.Name = "OfcButton"
OfcButton.Parent = ButtonContainer
OfcButton.AnchorPoint = Vector2.new(0, 0)
OfcButton.Position = UDim2.new(0, 10, 0, 60)  -- Below Send Prompt
OfcButton.Size = UDim2.new(0, 60, 0, 30)
OfcButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
OfcButton.BackgroundTransparency = 0.3
OfcButton.BorderSizePixel = 0
OfcButton.Text = "ofc!!"
OfcButton.Font = Enum.Font.GothamBold
OfcButton.TextColor3 = Color3.fromRGB(255, 255, 255)
OfcButton.TextSize = 14
OfcButton.TextWrapped = true

-- Ofc button hover effect
OfcButton.MouseEnter:Connect(function()
    game:GetService("TweenService"):Create(
        OfcButton,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundTransparency = 0.1}
    ):Play()
end)

OfcButton.MouseLeave:Connect(function()
    game:GetService("TweenService"):Create(
        OfcButton,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundTransparency = 0.3}
    ):Play()
end)

-- Ofc button click functionality
OfcButton.MouseButton1Click:Connect(function()
    local TextChatService = game:GetService("TextChatService")
    local lastChat = TextChatService.ChatInputBarConfiguration.TargetTextChannel
    
    if lastChat and lastChat.Name ~= "RBXGeneral" and lastChat.Name ~= "RBXSystem" then
        TextChatService.ChatInputBarConfiguration.TargetTextChannel:SendAsync("ofc!!")
        
        game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
            Text = "Sent 'ofc!!' to private chat!",
            Color = Color3.fromRGB(0, 200, 0),
            Font = Enum.Font.GothamBold,
            TextSize = 14
        })
    else
        game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
            Text = "Please open a private chat first!",
            Color = Color3.fromRGB(255, 200, 100),
            Font = Enum.Font.GothamBold,
            TextSize = 14
        })
    end
end)

-- Configure Ask Art button (3rd position)
local AskArtButton = Instance.new("TextButton")
AskArtButton.Name = "AskArtButton"
AskArtButton.Parent = ButtonContainer
AskArtButton.AnchorPoint = Vector2.new(0, 0)
AskArtButton.Position = UDim2.new(0, 10, 0, 100)  -- 3rd position (Ask Art)
AskArtButton.Size = UDim2.new(0, 100, 0, 30)
AskArtButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
AskArtButton.BackgroundTransparency = 0.3
AskArtButton.BorderSizePixel = 0
AskArtButton.Text = "Ask Art"
AskArtButton.Font = Enum.Font.GothamBold
AskArtButton.TextColor3 = Color3.fromRGB(200, 200, 255)  -- Light purple color
AskArtButton.TextSize = 14
AskArtButton.TextWrapped = true

-- Ask Art button hover effect
AskArtButton.MouseEnter:Connect(function()
    game:GetService("TweenService"):Create(
        AskArtButton,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundTransparency = 0.1}
    ):Play()
end)

AskArtButton.MouseLeave:Connect(function()
    game:GetService("TweenService"):Create(
        AskArtButton,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundTransparency = 0.3}
    ):Play()
end)

-- Configure Ask Discord button (4th position)
local AskDiscordButton = Instance.new("TextButton")
AskDiscordButton.Name = "AskDiscordButton"
AskDiscordButton.Parent = ButtonContainer
AskDiscordButton.AnchorPoint = Vector2.new(0, 0)
AskDiscordButton.Position = UDim2.new(0, 10, 0, 140)  -- 4th position (Ask Discord)
AskDiscordButton.Size = UDim2.new(0, 100, 0, 30)  -- Slightly wider to fit text
AskDiscordButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
AskDiscordButton.BackgroundTransparency = 0.3
AskDiscordButton.BorderSizePixel = 0
AskDiscordButton.Text = "Ask Discord"
AskDiscordButton.Font = Enum.Font.GothamBold
AskDiscordButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AskDiscordButton.TextSize = 14
AskDiscordButton.TextWrapped = true

-- Ask Discord button hover effect
AskDiscordButton.MouseEnter:Connect(function()
    game:GetService("TweenService"):Create(
        AskDiscordButton,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundTransparency = 0.1}
    ):Play()
end)

AskDiscordButton.MouseLeave:Connect(function()
    game:GetService("TweenService"):Create(
        AskDiscordButton,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundTransparency = 0.3}
    ):Play()
end)

-- Ask Discord button click functionality
AskDiscordButton.MouseButton1Click:Connect(function()
    local TextChatService = game:GetService("TextChatService")
    local lastChat = TextChatService.ChatInputBarConfiguration.TargetTextChannel
    
    if lastChat and lastChat.Name ~= "RBXGeneral" and lastChat.Name ~= "RBXSystem" then
        TextChatService.ChatInputBarConfiguration.TargetTextChannel:SendAsync("okay!! whats ur decor d?")
        
        game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
            Text = "Sent 'okay!! whats ur decor d?' to private chat!",
            Color = Color3.fromRGB(0, 200, 0),
            Font = Enum.Font.GothamBold,
            TextSize = 14
        })
    else
        game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
            Text = "Please open a private chat first!",
            Color = Color3.fromRGB(255, 200, 100),
            Font = Enum.Font.GothamBold,
            TextSize = 14
        })
    end
end)

-- Ask Art button click functionality
AskArtButton.MouseButton1Click:Connect(function()
    local TextChatService = game:GetService("TextChatService")
    local lastChat = TextChatService.ChatInputBarConfiguration.TargetTextChannel
    
    if lastChat and lastChat.Name ~= "RBXGeneral" and lastChat.Name ~= "RBXSystem" then
        TextChatService.ChatInputBarConfiguration.TargetTextChannel:SendAsync("can i draw you?")
        
        game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
            Text = "Sent 'can i model you!!' to private chat!",
            Color = Color3.fromRGB(0, 200, 0),
            Font = Enum.Font.GothamBold,
            TextSize = 14
        })
    else
        game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
            Text = "Please open a private chat first!",
            Color = Color3.fromRGB(255, 200, 100),
            Font = Enum.Font.GothamBold,
            TextSize = 14
        })
    end
end)

-- Configure Server Hop button (5th position)
local ServerHopButton = Instance.new("TextButton")
ServerHopButton.Name = "ServerHopButton"
ServerHopButton.Parent = ButtonContainer
ServerHopButton.AnchorPoint = Vector2.new(0, 0)
ServerHopButton.Position = UDim2.new(0, 10, 0, 180)  -- 5th position (Server Hop)
ServerHopButton.Size = UDim2.new(0, 100, 0, 30)
ServerHopButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
ServerHopButton.BackgroundTransparency = 0.3
ServerHopButton.BorderSizePixel = 0
ServerHopButton.Text = "Server Hop"
ServerHopButton.Font = Enum.Font.GothamBold
ServerHopButton.TextColor3 = Color3.fromRGB(255, 120, 120)  -- Slightly red text to indicate it's a server action
ServerHopButton.TextSize = 14
ServerHopButton.TextWrapped = true

-- Server Hop button hover effect
ServerHopButton.MouseEnter:Connect(function()
    game:GetService("TweenService"):Create(
        ServerHopButton,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundTransparency = 0.1}
    ):Play()
end)

ServerHopButton.MouseLeave:Connect(function()
    game:GetService("TweenService"):Create(
        ServerHopButton,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundTransparency = 0.3}
    ):Play()
end)

-- Server Hop button click functionality
ServerHopButton.MouseButton1Click:Connect(function()
    -- Show a message that we're hopping servers
    game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
        Text = "Hopping to a new server...",
        Color = Color3.fromRGB(0, 200, 0),
        Font = Enum.Font.GothamBold,
        TextSize = 14
    })
    
    -- Call the server hop function
    serverHop()
end)

-- Button hover effect
SendPromptButton.MouseEnter:Connect(function()
    game:GetService("TweenService"):Create(
        SendPromptButton,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundTransparency = 0.1}
    ):Play()
end)

SendPromptButton.MouseLeave:Connect(function()
    game:GetService("TweenService"):Create(
        SendPromptButton,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundTransparency = 0.3}
    ):Play()
end)

-- Button click functionality
SendPromptButton.MouseButton1Click:Connect(function()
    -- Get chat and player services
    local TextChatService = game:GetService("TextChatService")
    local Players = game:GetService("Players")
    local localPlayer = Players.LocalPlayer
    
    -- Function to send message to private chat
    local function sendPrivateMessage(playerName, message)
        -- This will automatically open a private chat with the player if not already open
        TextChatService.ChatInputBarConfiguration.TargetTextChannel:SendAsync("/w " .. playerName .. " " .. message)
    end
    
    -- Try to get the last player you chatted with
    local lastChat = TextChatService.ChatInputBarConfiguration.TargetTextChannel
    if lastChat and lastChat.Name ~= "RBXGeneral" and lastChat.Name ~= "RBXSystem" then
        -- If we're in a private chat, send to that chat
        TextChatService.ChatInputBarConfiguration.TargetTextChannel:SendAsync("i love ur avatar its so cool!")
        
        game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
            Text = "Sent prompt to private chat!",
            Color = Color3.fromRGB(0, 200, 0),
            Font = Enum.Font.GothamBold,
            TextSize = 14
        })
    else
        -- If not in a private chat, try to find the last player you chatted with
        local success, err = pcall(function()
            -- This is a fallback method that might work in some games
            local chatBar = game:GetService("Players").LocalPlayer.PlayerGui.Chat.Frame.ChatBarParentFrame.Frame.BoxFrame.Frame.ChatBar
            local currentText = chatBar.Text
            
            -- Check if we're already in a private chat
            if currentText:sub(1, 4):lower() == "/w " or currentText:sub(1, 7):lower() == "/whis " then
                -- If we're already in a private chat, just send the message
                game:GetService("TextChatService").ChatInputBarConfiguration.TargetTextChannel:SendAsync("I LOVE YOUR AVATAR OMG!!")
            else
                -- Otherwise, show instructions
                game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
                    Text = "Please open a private chat with the player first, then click the button.",
                    Color = Color3.fromRGB(255, 200, 100),
                    Font = Enum.Font.GothamBold,
                    TextSize = 14
                })
            end
        end)
        
        if not success then
            -- If all else fails, show manual instructions
            game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
                Text = "Could not determine private chat. Please type manually: /w [username] I LOVE YOUR AVATAR OMG!!",
                Color = Color3.fromRGB(255, 100, 100),
                Font = Enum.Font.GothamBold,
                TextSize = 14
            })
        end
    end
end)

-- Function to create a player entry
local function createPlayerEntry(player, value)
    local PlayerFrame = Instance.new("Frame")
    PlayerFrame.Parent = PlayerListContainer  -- Changed parent to PlayerListContainer
    local Avatar = Instance.new("ImageButton")
    local Username = Instance.new("TextLabel")
    local ValueLabel = Instance.new("TextLabel")
    local SendPromptButton = Instance.new("TextButton")
    
    PlayerFrame.Name = player.Name
    PlayerFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    PlayerFrame.BackgroundTransparency = 0.3  -- Make player entries semi-transparent
    PlayerFrame.BorderSizePixel = 1
    PlayerFrame.BorderColor3 = Color3.fromRGB(70, 70, 70)
    PlayerFrame.Size = UDim2.new(1, -10, 0, 70)  -- Full width with small margin
    
    Avatar.Name = "Avatar"
    Avatar.Parent = PlayerFrame
    Avatar.BackgroundTransparency = 1
    Avatar.Size = UDim2.new(0, 50, 0, 50)  -- Increased size
    Avatar.Image = "rbxthumb://type=AvatarHeadShot&id=" .. player.UserId .. "&w=150&h=150"
    Avatar.AutoButtonColor = false
    
    -- Add hover effect
    local function onHover()
        Avatar.ImageTransparency = 0.3
    end
    
    local function onUnhover()
        Avatar.ImageTransparency = 0
    end
    
    Avatar.MouseEnter:Connect(onHover)
    Avatar.MouseLeave:Connect(onUnhover)
    
    -- Open chat when clicked
    Avatar.MouseButton1Click:Connect(function()
    -- Don't consume the click event
    task.wait()  -- Allow the click to pass through
        -- Get the display name (falls back to username if display name is empty)
        local displayName = player.DisplayName ~= "" and player.DisplayName or player.Name
        
        game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
            Text = "Opening chat with " .. displayName,
            Color = Color3.fromRGB(0, 255, 0),
            Font = Enum.Font.SourceSansBold,
            TextSize = 18
        })
        
        -- Open private chat with the player using their display name
        local success, result = pcall(function()
            game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync("/w " .. displayName .. " ")
        end)
        
        -- Fallback for older chat system or if display name fails
        if not success then
            -- Try with username as fallback
            local fallbackSuccess = pcall(function()
                game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync("/w " .. player.Name .. " ")
            end)
            
            if not fallbackSuccess then
                game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
                    Text = "Could not open chat. Please try clicking the chat bar and typing '/w " .. displayName .. " ' (with a space at the end)",
                    Color = Color3.fromRGB(255, 0, 0),
                    Font = Enum.Font.SourceSansBold,
                    TextSize = 18
                })
            end
        end
    end)
    
    Username.Name = "Username"
    Username.Parent = PlayerFrame
    Username.BackgroundTransparency = 1
    Username.Position = UDim2.new(0, 70, 0, 10)
    Username.Size = UDim2.new(1, -75, 0, 25)
    Username.TextTruncate = Enum.TextTruncate.AtEnd  -- Ensure long names don't overflow
    Username.Font = Enum.Font.GothamBold
    -- Show display name if available, otherwise show username
    Username.Text = player.DisplayName ~= "" and player.DisplayName or player.Name
    Username.TextColor3 = Color3.fromRGB(255, 255, 255)
    Username.TextSize = 14.000
    Username.TextXAlignment = Enum.TextXAlignment.Left
    Username.TextTruncate = Enum.TextTruncate.AtEnd
    
    ValueLabel.Name = "ValueLabel"
    ValueLabel.Parent = PlayerFrame
    ValueLabel.BackgroundTransparency = 1
    ValueLabel.Position = UDim2.new(0, 70, 0, 35)
    ValueLabel.Size = UDim2.new(1, -75, 0, 25)
    ValueLabel.Font = Enum.Font.GothamBold
    ValueLabel.Text = "Value: " .. tostring(value)
    ValueLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
    ValueLabel.TextSize = 14.000
    ValueLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    -- Removed value bars as requested
    ValueLabel.Font = Enum.Font.Gotham
    ValueLabel.Text = "Value: " .. tostring(value)
    ValueLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
    ValueLabel.TextSize = 14.000
    ValueLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    return PlayerFrame
end

-- Function to update UI
local PlayerFrames = {}
local function updateUI(playersData)
    -- Clear existing frames
    for _, frame in pairs(PlayerFrames) do
        frame:Destroy()
    end
    PlayerFrames = {}
    
    -- Sort players by value (highest first)
    local sortedPlayers = {}
    for player, value in pairs(playersData) do
        table.insert(sortedPlayers, {player = player, value = value})
    end
    table.sort(sortedPlayers, function(a, b) return a.value > b.value end)
    
    -- Create new frames
    for _, data in ipairs(sortedPlayers) do
        if data.value > 0 then
            local frame = createPlayerEntry(data.player, data.value)
            table.insert(PlayerFrames, frame)
        end
    end
    
    -- Resize the main frame based on content (keep width at 630, adjust height)
    local newHeight = math.max(100, math.min(800, #PlayerFrames * 75 + 100))  -- Cap height at 800, add 100px empty space at bottom
    MainFrame.Size = UDim2.new(0, 630, 0, newHeight)
    
    -- Value bar related code removed as requested
end

-- Function to scan players and update UI
local function scanAndUpdateUI()
    local playersData = {}
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= Players.LocalPlayer then
            local success, value = pcall(function()
                local total = 0
                local inventory = ReplicatedStorage.Remotes.Extras.GetFullInventory:InvokeServer(player)
                if inventory and inventory.Weapons and inventory.Weapons.Owned then
                    for name, amount in pairs(inventory.Weapons.Owned) do
                        if items[name] then
                            total = total + (items[name] * amount)
                        end
                    end
                end
                return total
            end)
            
            if success and value > 0 then
                playersData[player] = value
            end
        end
    end
    
    updateUI(playersData)
end

-- Update UI every 10 seconds
spawn(function()
    while wait(10) do
        scanAndUpdateUI()
    end
end)

-- Initial scan
scanAndUpdateUI()

-- Original server hop logic
if not FoundaPlayer and RejoinAfterFindingaValuablePlayer then
    serverHop()
end