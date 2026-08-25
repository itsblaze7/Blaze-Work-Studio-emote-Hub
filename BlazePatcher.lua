--[[
    BLAZE WORK STUDIO – GitHub Patcher
    This script fetches the original Vexro Emotes script from a GitHub raw URL,
    applies all modifications, and either saves or executes the result.
]]

local ORIGINAL_RAW_URL = "https://raw.githubusercontent.com/itsblaze7/Blaze-Work-Studio-emote-Hub/refs/heads/main/VexroEmotesOriginal.lua"
-- ⚠️ Replace YOUR_USERNAME with your actual GitHub username.

-- Fetch the original script
local original, err = pcall(game.HttpGet, game, ORIGINAL_RAW_URL)
if not original then
    print("❌ Failed to fetch original script: " .. tostring(err))
    return
end

if type(original) ~= "string" or #original < 1000 then
    print("❌ Invalid or empty script fetched.")
    return
end

print("✅ Original script loaded. Size: " .. #original .. " characters.")

-- ------------------------------------------------------------------
-- Apply modifications
-- ------------------------------------------------------------------

local modified = original

-- 1. Replace all "Vexro" with "Blaze"
modified = modified:gsub("Vexro", "Blaze")
modified = modified:gsub("VEXRO", "BLAZE")

-- 2. Discord link
modified = modified:gsub("4Bs9WYSabf", "EskE2gPy3D")
modified = modified:gsub("discord%.gg/4Bs9WYSabf", "discord.gg/EskE2gPy3D")
modified = modified:gsub("discord%.gg/[a-zA-Z0-9]+", "discord.gg/EskE2gPy3D")

-- 3. Title and branding
modified = modified:gsub("Vexro Emotes", "Blaze Emotes")
modified = modified:gsub("Vexro Cloud", "Blaze Cloud")
modified = modified:gsub("Made by Zyrovell Roblox:Oyuncu15q Discord:_ege%.", "Made by Dvlpr Blaze • BLAZE WORK STUDIO")

-- 4. Insert Key System (after the initial comment block)
local keySystem = [[
-- // ============================================================
-- // KEY SYSTEM
-- // ============================================================
local Key = "BLAZESAEOP"
local KeyFile = "BlazeWorkStudioKey.txt"
local KeyValid = false

local function saveKey(key)
    if isfile and writefile then
        pcall(function() writefile(KeyFile, key) end)
    end
end

local function loadKey()
    if isfile and readfile then
        local content = pcall(readfile, KeyFile)
        if content then
            return content == Key
        end
    end
    return false
end

if not loadKey() then
    local CoreGui = game:GetService("CoreGui")
    local TweenService = game:GetService("TweenService")

    local KeyGui = Instance.new("ScreenGui")
    KeyGui.Name = "BlazeKeyWindow"
    KeyGui.Parent = CoreGui
    KeyGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
    KeyGui.DisplayOrder = 999

    local Main = Instance.new("Frame")
    Main.Size = UDim2.new(0, 400, 0, 250)
    Main.Position = UDim2.new(0.5, -200, 0.5, -125)
    Main.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
    Main.BackgroundTransparency = 0.05
    Main.BorderSizePixel = 2
    Main.BorderColor3 = Color3.fromRGB(255, 69, 0)
    Main.Active = true
    Main.Draggable = true
    Main.Parent = KeyGui

    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 15)
    MainCorner.Parent = Main

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 50)
    Title.Position = UDim2.new(0, 0, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = "🔥 BLAZE WORK STUDIO"
    Title.TextColor3 = Color3.fromRGB(255, 69, 0)
    Title.TextSize = 24
    Title.Font = Enum.Font.GothamBlack
    Title.Parent = Main

    local Input = Instance.new("TextBox")
    Input.Size = UDim2.new(0, 300, 0, 40)
    Input.Position = UDim2.new(0.5, -150, 0, 70)
    Input.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    Input.PlaceholderText = "Enter Key"
    Input.Text = ""
    Input.TextColor3 = Color3.fromRGB(255, 255, 255)
    Input.Font = Enum.Font.Gotham
    Input.TextSize = 16
    Input.Parent = Main
    local InputCorner = Instance.new("UICorner")
    InputCorner.CornerRadius = UDim.new(0, 8)
    InputCorner.Parent = Input

    local ErrorLabel = Instance.new("TextLabel")
    ErrorLabel.Size = UDim2.new(1, 0, 0, 20)
    ErrorLabel.Position = UDim2.new(0, 0, 0, 115)
    ErrorLabel.BackgroundTransparency = 1
    ErrorLabel.Text = ""
    ErrorLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
    ErrorLabel.TextSize = 13
    ErrorLabel.Font = Enum.Font.Gotham
    ErrorLabel.Parent = Main

    local EnterBtn = Instance.new("TextButton")
    EnterBtn.Size = UDim2.new(0, 120, 0, 40)
    EnterBtn.Position = UDim2.new(0.5, -160, 0, 150)
    EnterBtn.BackgroundColor3 = Color3.fromRGB(255, 69, 0)
    EnterBtn.Text = "ENTER KEY"
    EnterBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    EnterBtn.TextSize = 16
    EnterBtn.Font = Enum.Font.GothamBold
    EnterBtn.Parent = Main
    local EnterCorner = Instance.new("UICorner")
    EnterCorner.CornerRadius = UDim.new(0, 8)
    EnterCorner.Parent = EnterBtn

    local GetKeyBtn = Instance.new("TextButton")
    GetKeyBtn.Size = UDim2.new(0, 120, 0, 40)
    GetKeyBtn.Position = UDim2.new(0.5, 40, 0, 150)
    GetKeyBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    GetKeyBtn.Text = "Get Key"
    GetKeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    GetKeyBtn.TextSize = 16
    GetKeyBtn.Font = Enum.Font.GothamBold
    GetKeyBtn.Parent = Main
    local GetKeyCorner = Instance.new("UICorner")
    GetKeyCorner.CornerRadius = UDim.new(0, 8)
    GetKeyCorner.Parent = GetKeyBtn

    local DiscordBtn = Instance.new("TextButton")
    DiscordBtn.Size = UDim2.new(0, 100, 0, 30)
    DiscordBtn.Position = UDim2.new(1, -110, 1, -35)
    DiscordBtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
    DiscordBtn.Text = "Discord"
    DiscordBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    DiscordBtn.TextSize = 14
    DiscordBtn.Font = Enum.Font.GothamBold
    DiscordBtn.Parent = Main
    local DiscCorner = Instance.new("UICorner")
    DiscCorner.CornerRadius = UDim.new(0, 8)
    DiscCorner.Parent = DiscordBtn

    local function ShakeInput()
        local orig = Input.Position
        for i = 1, 4 do
            TweenService:Create(Input, TweenInfo.new(0.05), {
                Position = UDim2.new(0.5, -150 + (i%2==0 and 10 or -10), 0, 70)
            }):Play()
            task.wait(0.05)
        end
        TweenService:Create(Input, TweenInfo.new(0.05), {Position = orig}):Play()
    end

    EnterBtn.MouseButton1Click:Connect(function()
        if Input.Text == Key then
            KeyValid = true
            saveKey(Key)
            KeyGui:Destroy()
            LoadMainGUI()
        else
            ErrorLabel.Text = "❌ Wrong key! Please try again."
            ShakeInput()
            Input.Text = ""
        end
    end)

    GetKeyBtn.MouseButton1Click:Connect(function()
        local link = "https://discord.gg/EskE2gPy3D"
        if setclipboard then setclipboard(link) end
        if syn and syn.set_clipboard then syn.set_clipboard(link) end
        ErrorLabel.Text = "✅ Discord link copied!"
        task.wait(2)
        ErrorLabel.Text = ""
    end)

    DiscordBtn.MouseButton1Click:Connect(function()
        local link = "https://discord.gg/EskE2gPy3D"
        if setclipboard then setclipboard(link) end
        if syn and syn.set_clipboard then syn.set_clipboard(link) end
        pcall(function() game:GetService("GuiService"):OpenBrowser(link) end)
        ErrorLabel.Text = "✅ Discord link copied!"
        task.wait(2)
        ErrorLabel.Text = ""
    end)

    Input.Focused:Connect(function() ErrorLabel.Text = "" end)
    Input.FocusLost:Connect(function(enter)
        if enter then EnterBtn.MouseButton1Click:Fire() end
    end)

    wait(9e9)
else
    LoadMainGUI()
end

-- // ============================================================
-- // MAIN GUI FUNCTION (REBRANDED)
-- // ============================================================
]]

local insertPos = modified:find("local Players = game:GetService%(\"Players\"%)")
if insertPos then
    modified = modified:sub(1, insertPos - 1) .. keySystem .. "\n\n" .. modified:sub(insertPos)
else
    modified = keySystem .. "\n\n" .. modified
end

-- 5. Replace AnimationPacks with new ones (including Annoying Mini-Me)
local newAnimPacks = [[
    -- // ============================================================
    -- // ANIMATION DATABASE WITH TAGS
    -- // ============================================================
    local AnimationPacks = {
        {
            id = "anim_annoying",
            name = "Annoying Mini-Me",
            bundleId = 13847677942977,
            isAnimationPack = true,
            tags = {"🔥 Hot", "🆕 New", "⭐ Most Used"},
            tagColors = {Color3.fromRGB(255, 69, 0), Color3.fromRGB(0, 200, 255), Color3.fromRGB(255, 215, 0)},
            Idle = nil,
            Walk = nil,
            Run = nil,
            Jump = nil,
            Fall = nil,
            Swim = nil,
            Climb = nil,
            _loaded = false,
        },
        -- other packs...
    }
]]
-- We'll replace the entire LoadAnimations function
local loadAnimStart = modified:find("local function LoadAnimations()")
if loadAnimStart then
    -- Find the end of the function (simple heuristic: find the first "end" after the function body)
    local depth = 0
    local endPos = nil
    for i = loadAnimStart + 1, #modified do
        if modified:sub(i, i+2) == "end" and depth == 0 and modified:sub(i-1, i-1) ~= "_" then
            endPos = i + 2
            break
        end
        if modified:sub(i, i) == "{" or modified:sub(i, i) == "(" then depth = depth + 1 end
        if modified:sub(i, i) == "}" or modified:sub(i, i) == ")" then depth = depth - 1 end
    end
    if endPos then
        local newFunc = [[
local function LoadAnimations()
    -- Override with new AnimationPacks table
    AnimationPacks = {
        {
            id = "anim_annoying",
            name = "Annoying Mini-Me",
            bundleId = 13847677942977,
            isAnimationPack = true,
            tags = {"🔥 Hot", "🆕 New", "⭐ Most Used"},
            tagColors = {Color3.fromRGB(255, 69, 0), Color3.fromRGB(0, 200, 255), Color3.fromRGB(255, 215, 0)},
            Idle = nil,
            Walk = nil,
            Run = nil,
            Jump = nil,
            Fall = nil,
            Swim = nil,
            Climb = nil,
            _loaded = false,
        },
        {
            id = "anim_ninja",
            name = "Ninja Pack",
            isAnimationPack = true,
            tags = {"⭐ Most Used", "💎 Rare"},
            tagColors = {Color3.fromRGB(255, 215, 0), Color3.fromRGB(180, 80, 255)},
            Idle = 658832408,
            Walk = 658831143,
            Run = 658830056,
            Jump = 658832070,
            Fall = 658831500,
            Swim = 658832807,
            Climb = 658833139
        },
        {
            id = "anim_mage",
            name = "Mage Pack",
            isAnimationPack = true,
            tags = {"💎 Rare", "🎯 Featured"},
            tagColors = {Color3.fromRGB(180, 80, 255), Color3.fromRGB(0, 150, 255)},
            Idle = 707742142,
            Walk = 707897309,
            Run = 707861613,
            Jump = 707853694,
            Fall = 707829716,
            Swim = 707876443,
            Climb = 707826056
        },
        {
            id = "anim_zombie",
            name = "Zombie Pack",
            isAnimationPack = true,
            tags = {"🔥 Hot"},
            tagColors = {Color3.fromRGB(255, 69, 0)},
            Idle = 5077711793,
            Walk = 5077711261,
            Run = 5077712029,
            Jump = nil,
            Fall = nil,
            Swim = nil,
            Climb = nil
        },
        {
            id = "anim_fancy",
            name = "Fancy Pack",
            isAnimationPack = true,
            tags = {"⭐ Most Used"},
            tagColors = {Color3.fromRGB(255, 215, 0)},
            Idle = 5077711517,
            Walk = 5077710997,
            Run = nil,
            Jump = nil,
            Fall = nil,
            Swim = nil,
            Climb = nil
        },
        {
            id = "anim_cartoon",
            name = "Cartoon Pack",
            isAnimationPack = true,
            tags = {"🆕 New"},
            tagColors = {Color3.fromRGB(0, 200, 255)},
            Idle = 5077708921,
            Walk = 5077709109,
            Run = 5077709397,
            Jump = 5077709681,
            Fall = nil,
            Swim = nil,
            Climb = nil
        }
    }
end
]]
        modified = modified:sub(1, loadAnimStart - 1) .. newFunc .. modified:sub(endPos + 1)
    end
end

-- 6. Replace all other references (variables, GUI names, etc.)
modified = modified:gsub("lastVexroAnimationPack", "lastBlazeAnimationPack")
modified = modified:gsub("_genv().Vexro", "_genv().Blaze")
modified = modified:gsub("VexroEmotesCleanup", "BlazeEmotesCleanup")
modified = modified:gsub("VexroSessionToken", "BlazeSessionToken")
modified = modified:gsub("_genv().VexroKicked", "_genv().BlazeKicked")
modified = modified:gsub("_genv().VexroServerAccessible", "_genv().BlazeServerAccessible")
modified = modified:gsub("_genv().VexroBroadcastSync", "_genv().BlazeBroadcastSync")
modified = modified:gsub("_genv().VexroBroadcastStop", "_genv().BlazeBroadcastStop")
modified = modified:gsub("_genv().VexroPlaylistPlaying", "_genv().BlazePlaylistPlaying")
modified = modified:gsub("_genv().VexroPlaylistPlayingId", "_genv().BlazePlaylistPlayingId")
modified = modified:gsub("_genv().lastVexroEmote", "_genv().lastBlazeEmote")
modified = modified:gsub('"VexroEmotes"', '"BlazeEmotes"')
modified = modified:gsub('"VexroBrand"', '"BlazeBrand"')
modified = modified:gsub('"VexroTrendingDropdown"', '"BlazeTrendingDropdown"')
modified = modified:gsub('"VexroKeybindOverlay"', '"BlazeKeybindOverlay"')
modified = modified:gsub('"VexroSavePlaylistOverlay"', '"BlazeSavePlaylistOverlay"')
modified = modified:gsub('"VexroInfoPanel"', '"BlazeInfoPanel"')
modified = modified:gsub('"VexroHUD"', '"BlazeHUD"')
modified = modified:gsub('"VexroMainGrad"', '"BlazeMainGrad"')
modified = modified:gsub('"VexroGradFrame"', '"BlazeGradFrame"')
modified = modified:gsub('"VexroGlassNoise"', '"BlazeGlassNoise"')
modified = modified:gsub('"VexroGlassBlur"', '"BlazeGlassBlur"')
modified = modified:gsub('"VexroGlassBlurFolder"', '"BlazeGlassBlurFolder"')
modified = modified:gsub('"VexroGlassBody"', '"BlazeGlassBody"')
modified = modified:gsub("ReloadVexro", "ReloadBlaze")
modified = modified:gsub("VEXRO_REMOTE_URL", "BLAZE_REMOTE_URL")
modified = modified:gsub("VEXRO_LOCAL_RELOAD_PATHS", "BLAZE_LOCAL_RELOAD_PATHS")
modified = modified:gsub("RunVexroSource", "RunBlazeSource")
modified = modified:gsub("VexroAcrylic", "BlazeAcrylic")
modified = modified:gsub("_glassApplyBase", "_blazeApplyBase")
modified = modified:gsub("VexroCopyEmotePrompt", "BlazeCopyEmotePrompt")

-- 7. Replace changelog text
modified = modified:gsub('"• Asenkron emote yükleme .-\\n• Animasyon paketlerinde hareket eşleşmesi .-\\n• Menü açılış ve küçültme kırpma düzeltmesi .-\\n• Kart çerçeveleri imleç ayrılma düzeltmesi\\n• %100 Açık kaynak & Vexro Cloud Entegrasyonu"', 
    '"• Rebranded: BLAZE WORK STUDIO\\n• Key System added\\n• Annoying Mini-Me Animation Pack\\n• Tag system for animations\\n• Full Vexro Cloud integration"')

-- 8. Ensure the API URL stays original (don't change BASE_URL)
-- We already changed it earlier; revert it.
modified = modified:gsub('"https://blazescripts.com.tr/api"', '"https://vexroscripts.com.tr/api"')

-- 9. Add a final print
modified = modified .. [[

print("========================================")
print("BLAZE WORK STUDIO HUB LOADED!")
print("Key: BLAZESAEOP")
print("Discord: https://discord.gg/EskE2gPy3D")
print("========================================")
]]

-- ------------------------------------------------------------------
-- Execute or save the modified script
-- ------------------------------------------------------------------
-- If writefile is available, save it; otherwise just execute it.
if writefile then
    local success, err = pcall(writefile, "BlazeWorkStudioEmotes.lua", modified)
    if success then
        print("✅ Modified script saved as: BlazeWorkStudioEmotes.lua")
        -- Optionally load it
        loadstring(modified)()
    else
        print("❌ Failed to save file: " .. tostring(err))
        print("Executing directly...")
        loadstring(modified)()
    end
else
    print("⚠️ writefile not available. Executing directly...")
    loadstring(modified)()
end
