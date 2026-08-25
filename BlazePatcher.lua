--[[
    BLAZE WORK STUDIO – Patcher Script
    This script reads the original Vexro Emotes script, applies all modifications,
    and outputs a fully rebranded version with key system and new animation packs.
]]

local ORIGINAL_FILE = "VexroEmotesOriginal.lua"  -- Change this if needed
local OUTPUT_FILE = "BlazeWorkStudioEmotes.lua"

-- Check if readfile and writefile are available
if not readfile or not writefile then
    print("❌ Your executor does not support readfile/writefile.")
    print("Please paste the original script into the variable below and run again.")
    return
end

-- Read the original script
local original, err = pcall(readfile, ORIGINAL_FILE)
if not original then
    print("❌ Could not read file: " .. tostring(err))
    print("Make sure '" .. ORIGINAL_FILE .. "' exists in the current folder.")
    return
end

if type(original) ~= "string" or #original < 1000 then
    print("❌ File is empty or too short. Please check the file.")
    return
end

print("✅ Original script loaded. Size: " .. #original .. " characters.")

-- ------------------------------------------------------------------
-- Apply modifications
-- ------------------------------------------------------------------

local modified = original

-- 1. Replace all "Vexro" with "Blaze" (case-sensitive)
modified = modified:gsub("Vexro", "Blaze")
modified = modified:gsub("VEXRO", "BLAZE")

-- 2. Replace Discord link (the old one is "4Bs9WYSabf")
modified = modified:gsub("4Bs9WYSabf", "EskE2gPy3D")
modified = modified:gsub("discord%.gg/4Bs9WYSabf", "discord.gg/EskE2gPy3D")
modified = modified:gsub("discord%.gg/[a-zA-Z0-9]+", "discord.gg/EskE2gPy3D")  -- fallback

-- 3. Replace the title "Vexro Emotes" with "Blaze Emotes"
modified = modified:gsub("Vexro Emotes", "Blaze Emotes")
modified = modified:gsub("Vexro Cloud", "Blaze Cloud")

-- 4. Replace the made-by text
modified = modified:gsub("Made by Zyrovell Roblox:Oyuncu15q Discord:_ege%.", "Made by Dvlpr Blaze • BLAZE WORK STUDIO")

-- 5. Replace the ASCII art logo with a smaller one? We'll just leave it but rebrand.

-- 6. Insert the key system at the very top (after the initial comment block)
-- We'll add a header comment and the key system after the first comment.
local keySystem = [[
-- // ============================================================
-- // KEY SYSTEM (Added by Patcher)
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

-- Insert the key system after the opening comment block.
-- Find the first occurrence of "--Made by" or the initial comment block.
-- We'll insert after the ASCII art (which ends with a line of `]]`).
-- A robust approach: search for the first line that starts with "local Players" and insert before it.
local insertPos = modified:find("local Players = game:GetService%(\"Players\"%)")
if insertPos then
    modified = modified:sub(1, insertPos - 1) .. keySystem .. "\n\n" .. modified:sub(insertPos)
else
    print("⚠️ Could not find insertion point for key system. Appending at top.")
    modified = keySystem .. "\n\n" .. modified
end

-- 7. Replace the AnimationPacks definition with the new one (with tags and Annoying pack)
-- We'll search for "AnimationPacks = {" and replace the entire table.
local newAnimationPacks = [[
    -- // ============================================================
    -- // ANIMATION DATABASE WITH TAGS (MODIFIED)
    -- // ============================================================
    local AnimationPacks = {
        -- 🔥 HOT & NEW - Annoying Mini-Me (appears first)
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
        -- Classic Ninja Pack
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
        -- Mage Pack
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
        -- Zombie Pack
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
        -- Fancy Pack
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
        -- Cartoon Pack
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
]]

-- Find where AnimationPacks is defined and replace
local packStart = modified:find("AnimationPacks = {")
if packStart then
    local packEnd = modified:find("}", packStart) -- find the matching closing brace (simple)
    -- But to be safe, we need to find the entire table definition. We'll do a balanced match.
    -- Since it's Lua, we can use a simple search: find the first "local AnimationPacks = {" and then find the matching "}" using a counter.
    -- However, a simpler approach: find the line that starts with "local function LoadAnimations" and insert before it, but that might be different.
    -- Let's just replace the entire block from "AnimationPacks = {" to the next line that contains "}" with the new table.
    -- We'll use a quick and dirty approach: we'll search for the exact string and replace.
    -- But because the original has a different structure, we need to locate the end.
    -- We'll do a more precise replacement using pattern matching.
    -- For simplicity, we'll just do a global replace of "AnimationPacks = {" with the new table.
    -- This might not remove the old entries, so we'll delete the old table by finding the whole block.
    -- Let's do a safer method: we'll replace the entire LoadAnimations function with a new one that defines the new table.
    -- Actually, we can just overwrite the AnimationPacks variable after it's defined.
    -- In the script, AnimationPacks is defined inside LoadAnimations. We can replace that function.
    -- So we'll replace the entire LoadAnimations function with a new one that sets AnimationPacks to the new table.
    -- That's more reliable.
    local loadAnimStart = modified:find("local function LoadAnimations()")
    if loadAnimStart then
        local loadAnimEnd = modified:find("end", loadAnimStart + 20) -- find the matching end
        -- Actually, we need to find the end of the function.
        -- We'll use a simple pattern: find the next "end" that is at the correct level.
        -- Since we know the function is relatively simple, we can just replace from "local function LoadAnimations()" to the next "end" at the same indentation.
        -- We'll do a quick search for the end of the function.
        local function findMatchingEnd(start)
            local depth = 0
            local i = start
            while i <= #modified do
                local ch = modified:sub(i, i)
                if ch == "(" or ch == "{" or ch == "[" then
                    -- ignore for simplicity
                elseif ch == ")" or ch == "}" or ch == "]" then
                    -- ignore
                elseif modified:sub(i, i+4) == "local" then
                    -- ignore
                elseif modified:sub(i, i+2) == "end" and depth == 0 then
                    return i + 2
                end
                i = i + 1
            end
            return start
        end
        -- Actually, the function ends with "end" after the if/else blocks. We'll just replace until the first "end" that is not inside a block.
        -- A simpler approach: since we have the original script and we know the new AnimationPacks, we can just comment out the old LoadAnimations and insert a new one.
        -- Let's do a brute force: replace the whole LoadAnimations function with a new one.
        local newLoadAnim = [[
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
        -- Replace the function
        local startFunc = modified:find("local function LoadAnimations()")
        if startFunc then
            -- Find the end of the function: we'll search for the first "end" after the function body that is at the same level.
            -- A simple approach: find the next "end" that is not inside a string or comment.
            -- For simplicity, we'll replace from "local function LoadAnimations()" to the next "end" that is not part of another function.
            -- We'll use a counter for nested blocks.
            local depth = 0
            local endPos = nil
            local inString = false
            local inComment = false
            for i = startFunc + 1, #modified do
                local char = modified:sub(i, i)
                -- Check for string start/end
                if char == "'" or char == '"' then
                    inString = not inString
                end
                if not inString and not inComment then
                    if modified:sub(i, i+1) == "--" then
                        inComment = true
                    elseif char == "{" or char == "(" then
                        depth = depth + 1
                    elseif char == "}" or char == ")" then
                        depth = depth - 1
                    elseif modified:sub(i, i+2) == "end" and depth == 0 and modified:sub(i-1, i-1) ~= "_" then
                        endPos = i + 2
                        break
                    end
                end
                if char == "\n" then
                    inComment = false
                end
            end
            if endPos then
                modified = modified:sub(1, startFunc - 1) .. newLoadAnim .. modified:sub(endPos + 1)
            else
                print("⚠️ Could not find end of LoadAnimations function. Skipping replacement.")
            end
        else
            print("⚠️ Could not find LoadAnimations function. Skipping animation pack replacement.")
        end
    end
end

-- 8. Also replace the EquipAnimationPack function to use lastBlazeAnimationPack variable
modified = modified:gsub("lastVexroAnimationPack", "lastBlazeAnimationPack")
modified = modified:gsub("_genv().Vexro", "_genv().Blaze")

-- 9. Replace any remaining references to "Vexro" in strings (like in Notify messages, etc.)
-- But careful: we already did global replacement, which may affect variable names that are not supposed to change (like "VexroGlassBlur").
-- That's okay; we want to rebrand those too.

-- 10. Fix the API URL? We'll keep it as "blazescripts.com.tr" but the original uses "vexroscripts.com.tr". We can change it, but it might break the API. We'll leave it as is.

-- 11. Update the cleanup function name
modified = modified:gsub("VexroEmotesCleanup", "BlazeEmotesCleanup")
modified = modified:gsub("VexroSessionToken", "BlazeSessionToken")

-- 12. Update the global session token variable
modified = modified:gsub("_genv().VexroSessionToken", "_genv().BlazeSessionToken")
modified = modified:gsub("_genv().VexroKicked", "_genv().BlazeKicked")
modified = modified:gsub("_genv().VexroServerAccessible", "_genv().BlazeServerAccessible")
modified = modified:gsub("_genv().VexroBroadcastSync", "_genv().BlazeBroadcastSync")
modified = modified:gsub("_genv().VexroBroadcastStop", "_genv().BlazeBroadcastStop")
modified = modified:gsub("_genv().VexroPlaylistPlaying", "_genv().BlazePlaylistPlaying")
modified = modified:gsub("_genv().VexroPlaylistPlayingId", "_genv().BlazePlaylistPlayingId")
modified = modified:gsub("_genv().lastVexroEmote", "_genv().lastBlazeEmote")

-- 13. Update the GUI name
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

-- 14. Update the Discord button text
modified = modified:gsub('"Discord: [%w]+"', '"Discord: EskE2gPy3D"')

-- 15. Update the splash screen title
modified = modified:gsub('"Vexro Emotes"', '"Blaze Emotes"')
modified = modified:gsub('"V5 - Vexro Cloud"', '"V3 - Blaze Cloud"')

-- 16. Update the made-by label in splash
modified = modified:gsub('"Made by ' .. 'Oyuncu15q"', '"Made by Dvlpr Blaze • BLAZE WORK STUDIO"')

-- 17. Update the notification container name
modified = modified:gsub('"NotificationContainer"', '"BlazeNotificationContainer"')

-- 18. Fix the reload function names
modified = modified:gsub("ReloadVexro", "ReloadBlaze")
modified = modified:gsub("VEXRO_REMOTE_URL", "BLAZE_REMOTE_URL")
modified = modified:gsub("VEXRO_LOCAL_RELOAD_PATHS", "BLAZE_LOCAL_RELOAD_PATHS")
modified = modified:gsub("RunVexroSource", "RunBlazeSource")

-- 19. Update the glass acrylic function names
modified = modified:gsub("VexroAcrylic", "BlazeAcrylic")
modified = modified:gsub("_glassApplyBase", "_blazeApplyBase")

-- 20. Update the friend request panel brand
modified = modified:gsub('"Vexro Emote Player"', '"Blaze Emote Player"')

-- 21. Update the brand label in the main menu
modified = modified:gsub('"Vexro Emote V5 - Vexro Cloud"', '"Blaze Emotes V3 - Blaze Cloud"')

-- 22. Update the copy prompt tag
modified = modified:gsub("VexroCopyEmotePrompt", "BlazeCopyEmotePrompt")

-- 23. Update the settings panel's verRow text (the changelog)
-- We'll replace the changelog text with a new one
modified = modified:gsub('"• Asenkron emote yükleme .-\\n• Animasyon paketlerinde hareket eşleşmesi .-\\n• Menü açılış ve küçültme kırpma düzeltmesi .-\\n• Kart çerçeveleri imleç ayrılma düzeltmesi\\n• %100 Açık kaynak & Vexro Cloud Entegrasyonu"', 
    '"• Rebranded: BLAZE WORK STUDIO\\n• Key System added\\n• Annoying Mini-Me Animation Pack\\n• Tag system for animations\\n• Full Vexro Cloud integration"')

-- 24. Fix any leftover "Vexro" in comments or strings
-- We'll do a final pass to catch any remaining
modified = modified:gsub("Vexro", "Blaze")  -- one more time, but careful not to break URLs
-- But we want to keep the API URL as is, so we'll revert the BASE_URL
modified = modified:gsub('"https://blazescripts.com.tr/api"', '"https://vexroscripts.com.tr/api"') -- keep original API

-- 25. Add a final print message
modified = modified .. [[

print("========================================")
print("BLAZE WORK STUDIO HUB LOADED!")
print("Key: BLAZESAEOP")
print("Discord: https://discord.gg/EskE2gPy3D")
print("========================================")
]]

-- ------------------------------------------------------------------
-- Save the modified script
-- ------------------------------------------------------------------
local success, err = pcall(writefile, OUTPUT_FILE, modified)
if success then
    print("✅ Modified script saved as: " .. OUTPUT_FILE)
    print("Size: " .. #modified .. " characters.")
    print("You can now run '" .. OUTPUT_FILE .. "' with your executor.")
else
    print("❌ Failed to save file: " .. tostring(err))
    print("The modified script is printed below (you can copy it manually).")
    print("========================================")
    print(modified)
    print("========================================")
end
