  --++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
  --						Release 16							  --
  -- 						07.20.2011							  --
  -- 				 Protonova of Rexxar - US					  --
  --															  --
  --   These are modifcations and functions taken from multiple	  --
  --   sources and have been properly accredited. You are free 	  --
  --   to modify these at your own risk. Please look over the	  --
  --   settings before logging into the game because some of 	  --
  --   may not be to your liking :P  Have fun n.n				  --
  --++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--

-- ===================== --
-- [[CONFIG VARIABLES]]  --
-- ===================== --
local cLogToggle		= true
local rDisband			= true
local rcSound			= true
local CVarTweaks		= true
local visiAFK			= true
local xUMemTrim			= true
local classColored		= true
local declineDuels		= true
local autoConfirmDE		= true
local questRewards		= true
local DX11Enable		= false		-- No longer necessary
local CPUCores			= 'EIGHT'	-- Available Options: 'SINGLE' | 'DUAL' | 'TRI' | 'QUAD'  | 'EIGHT'
local M2Threads			= 'TRI'		-- Available Options: 'NONE' | 'SINGLE' | 'DUAL' | 'TRI'

-----------------------------------
-- DO NOT MODIFY THE LINES BELOW --
-----------------------------------
local INTVL = 10; -- the minimum interval between updates in seconds (default is 10 seconds)
local report = false; -- change this to true if you want a memory report (default is false)
local lastcycle, lastmem = 0,0;

local addonName, eventHandlers = ..., { }
local toggle = {};

-- =================== --
-- [[Addon Functions]] --
-- =================== --
if CVarTweaks then
	eventHandlers['PLAYER_LOGIN'] = function(name)
		-- Nameplates
		SetCVar("bloatnameplates", 1)					-- Makes nameplates larger depending on threat percentage.
		SetCVar("bloattest", 1) 						-- Might make nameplates larger but it fixes the disappearing ones.
		SetCVar("bloatthreat", 1)						-- Makes nameplates resize depending on threat gain/loss. Only active when a mob has multiple units on its threat table.
		SetCVar("nameplateMotion", 3)					-- Forces nameplates to spreading around the screen. Like Virtual Plates used to do.
		SetCVar("nameplateShowEnemies", 1)				-- Turns on enemy nameplates.
		SetCVar("nameplateShowEnemyGuardians", 1)		-- Turns on enemy guardian nameplates.
		SetCVar("nameplateShowEnemyPets", 1)			-- Turns on enemy pet nameplates.
		SetCVar("nameplateShowEnemyTotems", 1)			-- Turns on enemy totem nameplates.
		SetCVar("nameplateShowFriendlyGuardians", 0)	-- Turns off friendly guardian nameplates.
		SetCVar("nameplateShowFriendlyPets", 0)			-- Turns off friendly pet nameplates.
		SetCVar("nameplateShowFriendlyTotems", 0)		-- Turns off friendly totem nameplates.
		SetCVar("nameplateShowFriends", 0)				-- Turns off friendly nameplates.
		SetCVar("ShowClassColorInNameplate", 1)			-- Turns on class coloring in nameplates.
		SetCVar("showVKeyCastbar", 1)					-- Show target's cast bar under nameplates.
		SetCVar("UnitNameEnemyGuardianName", 0)			-- Turns off Enemy Pet Names.
		SetCVar("UnitNameEnemyPetName", 0)				-- Turns off Enemeny pet names.
		SetCVar("UnitNameEnemyPlayerName", 1)			-- Turns on Enemy Player Names.
		SetCVar("UnitNameEnemyTotemName", 1 or 0)		-- Turn off Enemy Totem Names.
		SetCVar("UnitNameFriendlyPetName", 1)			-- Turns on Friendly Pet Names.
		SetCVar("UnitNameFriendlyPlayerName", 1)		-- Turns on Friendly Player Names.
		SetCVar("UnitNameFriendlyTotemName", 1 or 0)	-- Turns off Friendly Totem Names.
		SetCVar("UnitNameNPC", 0)						-- Turns off NPC Names.
		SetCVar("UnitNameOwn", 0)						-- Turns off Own Name.
		SetCVar("UnitNamePlayerGuild", 1)				-- Turns off Own Guild Tags.
		SetCVar("UnitNamePlayerPVPTitle", 1)			-- Turns on PvP Player Titles.
		-- Buffs/Debuffs
		SetCVar("buffDurations", 1)						-- Show buff durations. (Buff Timers)
		SetCVar("consolidateBuffs", 0) 					-- Turns off Consolidated Buffs (the UI uses Satrina's Buff Bars).
		-- Combat
		if IsAddOnLoaded("MikScrollingBattleText") then
			SetCVar("enableCombatText", 0)				-- Turns off Combat Text.
			SetCVar("CombatDamage", 0)					-- Turns off Combat Text - Damage.
			SetCVar("CombatHealing", 0)					-- Turns off Combat Text - Healing.
		end
		-- Controls
		SetCVar("autoSelfCast", 1)						-- Right clicking skills causes it to target you even with a target selected.
		SetCVar("chatMouseScroll", 1)					-- Turns on mousewheel-scrolling in chat.
		SetCVar("lootUnderMouse", 1)					-- Force loot window to open up where mouse is.
		-- Display
		SetCVar("baseMip", 1)							-- Base level for mip mapping ("Texture Resolution" slider).
		SetCVar("CameraDistanceMax", 50)				-- Camera's max zoom out Distance. 50 is max.
		SetCVar("CameraDistanceMaxFactor", 3.4)			-- Sets the factor by which cameraDistanceMax is multiplied.
		SetCVar("cameraSmoothStyle", 0)					-- Controls the automatic camera adjustment (following) style.
		SetCVar("cameraSmoothTrackingStyle", 0)			-- ??
		SetCVar("cameraView", 1);						-- Stores the last saved camera position the camera was in. 1 is default viewindex position.
		SetCVar("cameraViewBlendStyle", 1)				-- Controls if the camera moves from saved positions smoothly or instantly. 1 is for smooth.
		SetCVar("emphasizeMySpellEffects", 0)			-- Turns off whether other player's spell impacts are toned down or not.
		SetCVar("environmentDetail", 100)				-- Controls the amount of detail on the objects surrounding you.
		SetCVar("farclip", 507)							-- Sets the view distance of the 3D environment. Anything past this distance will be covered in fog.
		SetCVar("ffxDeath", 0)							-- Turns off full screen death effect.
		SetCVar("ffxGlow", 0)							-- Turns off full screen glow effect.
		SetCVar("groundEffectDensity", 16)				-- Set the density of ground effects such as ferns, flowers, grass, and rocks.
		SetCVar("groundEffectDist", 1)					-- Set the maximum distance from the player at which to render ground effects such as ferns, flowers, grass, and rocks.
		SetCVar("gxMultisample", "1")					-- Sets anti-aliasing to 1x sampling.
		SetCVar("gxMultisampleQuality", "0.100000")		-- Sets the Quality for anti-aliasing.
		SetCVar("gxTextureCacheSize", 400)				-- Sets how much of your graphics card's onboard memory is allocated to textures in-game. 
		SetCVar("gxTripleBuffer", "1")					-- Enables Triple Buffering.
		SetCVar("gxVSync", 0)							-- Disables VSync. Having it on caps your FPS at your monitor's refresh rate.
		SetCVar("gxWindow", 1)							-- Makes WoW go into windowed mode.
		SetCVar("hwPCF", 0)								-- Use hardware-based Percentage Closer Filtering for shadows.
		SetCVar("maxFPSbk", 5)							-- Framerate Limitation while WoW isn't in focus (minimized or playing in windowed mode, and have something running on top of it).
		SetCVar("objectFade", 0.5)						-- Enables the smooth fading of objects after a certain distance.
		SetCVar("particleDensity", 40)					-- Controls the density of visual effects in the game world. 
		SetCVar("projectedTextures", 1)					-- Enables projected spell effects on the ground.
		SetCVar("screenshotQuality", 8)					-- Screenshot quality (0-10).
		SetCVar("showArenaEnemyFrames", 0)				-- Hide the default Blizzard Arena Frames.
		SetCVar("shadowMode", 0)						-- Turns off the detail level of in-game shadows.
		SetCVar("shadowTextureSize", "1024")			-- Shadow texture size.
		SetCVar("skycloudlod", 1)						-- Level of detail for Sky.
		SetCVar("SpellTooltip_DisplayAvgValues", 0)		-- Turns off Display Points As Average
		SetCVar("terrainMipLevel", 1)					-- Texture resolution for terrain.
		SetCVar("textureCacheSize", "8000000")			-- Controls how much of your graphics card's onboard memory is allocated to textures in-game. 
		SetCVar("textureFilteringMode", "0")			-- Texture filtering mode.
		SetCVar("useUiScale", 1)						-- Turns on the ability to scale down the User Interface.
		--SetCVar("uiScale", 0.64999997615814)			-- Controls the scale the User Interface.
		SetCVar("useWeatherShaders", 0)					-- Turns off weather shaders.
		SetCVar("weatherDensity", 0)					-- Turns off the Level of weather effects.
		-- Ease of Use
		SetCVar("autoLootDefault", 1)					-- Turns on Auto loot when looting a corpse.
		SetCVar("autoQuestProgress", 1)					-- Automatically watch all quests when they are updated.
		SetCVar("autoQuestWatch", 1)					-- Automatically watch all quests when they are obtained.
		SetCVar("deselectOnClick", 1)					-- Turns off Sticky Targeting. (inverted)
		SetCVar("mapQuestDifficulty", 1)				-- Color quest titles by difficulty in the World Map.
		SetCVar("removeChatDelay", 1)					-- ??
		SetCVar("showLootSpam", 1)						-- Shows a message in the combat log with the amount of money looted when looting.
		-- Help
		SetCVar("displaySpellActivationOverlays", 1)	-- Turns on Spell Alerts.
		SetCVar("showNewbieTips", 0)					-- Turns off Begginer Tooltips.
		SetCVar("showTutorials", 0)						-- Turns off Tutorials.
		SetCVar("UberTooltips", 1)						-- Turns on Enhanced Tooltips.
		-- Social
		SetCVar("chatBubbles", 1)						-- Turns on Chat Bubbles.
		SetCVar("chatBubblesParty", 1)					-- Turns on Party Chat Bubbles.
		SetCVar("chatStyle", "classic");				-- Turns chat into what it used to be before 4.0.1.
		SetCVar("conversationMode", "inline");			-- Conversation Mode = "In-line".
		SetCVar("guildMemberNotify", 1)					-- Receive notification when guild members log on/off.
		--SetCVar("guildRecruitmentChannel", 0)			-- Turns off Guild Recruitment Channel.
		SetCVar("guildShowOffline", 0)					-- Hides Offline Guild Members.
		SetCVar("WholeChatWindowClickable", 0)			-- ??
		-- Sound
		SetCVar("Sound_ListenerAtCharacter", 1)			-- Sets sound center at player.
		-- System
		SetCVar("componentTextureLevel", 2)				-- Number of mip levels used for character component textures.
		SetCVar("componentThread", 2)					-- Multi thread character component processing.
		SetCVar("M2UseThreads", 2)						-- Multithread model animations.
		SetCVar("reducedLagTolerance", 1)				-- Turns on Custom Lag Tolerance slider.
		SetCVar("scriptErrors", 1)						-- Turns on Display Lua Errors.
		SetCVar("synchronizeBindings", 0)				-- Turns off the saving of key bindings to the server.
		SetCVar("synchronizeConfig", 0)					-- Turns off the saving of CVars to the server.
		SetCVar("synchronizeMacros", 0)					-- Turns off the saving of macros to the server.
		SetCVar("synchronizeSettings", 0)				-- Turns off the saving of UI settings to the server.
		SetCVar("timingMethod", 1)						-- Sets the CPU timing method used. 0 lets the game decide, 1 is normal precision(fps limited to 64), 2 is high precision.

		-- Force enable new DX 11 experimental engine - only works with Vista and Win7. Also Enables World of Warcraft to use Shader Model 4 and 5.
		if DX11Enable then SetCVar("6", "d3d11") end
		
		-- Defines M2Faster via M2Threads variable
		-- Adds additional threads used in rendering models on screen (0 no additon threads, 1 - 3 adds additional threads)
		-- Reduces the unique number of vertex shader permutations that we will choose to use in rendering.
		-- Sorts the drawing of items in the scene a little differently to reduce the number of times we re-program the vertex shader hardware.
		if M2Threads == "TRI" then 
			SetCVar("M2Faster", 3) --3 is for Quad Cores and Up
		else
			if M2Threads == "DUAL" then 
				SetCVar("M2Faster", 2)
			else 
				if M2Threads == "SINGLE"  then 
					SetCVar("M2Faster", 1)
				end
			end	
		end
		
		-- Defines Affinity Mask via CPUCores variable
		if (CPUCores == "EIGHT") then
			SetCVar("processAffinityMask", 255)					-- i7 Processors.
			else if (CPUCores == "QUAD") then 
				SetCVar("processAffinityMask", 15)				-- Quad-cores & i5s.
				else if (CPUCores == "TRI") then 
					SetCVar("processAffinityMask", 7)			-- Tri-cores & HTs.
					else if (CPUCores == "DUAL")  then 
						SetCVar("processAffinityMask", 3)	 	-- Dual-core.
						else if (CPUCores == "SINGLE") then 
							SetCVar("processAffinityMask", 1)	-- Single core.
						end
					end
				end
			end
		end

		-- Setup ChatFrame1 Window
		ChatFrame_RemoveAllMessageGroups(ChatFrame1)
		ChatFrame_RemoveChannel(ChatFrame1, "GuildRecruitment")
		ChatFrame_RemoveChannel(ChatFrame1, "LookingForGroup")
		ChatFrame_AddMessageGroup(ChatFrame1, "ACHIEVEMENT")
		ChatFrame_AddMessageGroup(ChatFrame1, "AFK")
		ChatFrame_AddMessageGroup(ChatFrame1, "BATTLEGROUND")
		ChatFrame_AddMessageGroup(ChatFrame1, "BATTLEGROUND_LEADER")
		ChatFrame_AddMessageGroup(ChatFrame1, "BG_ALLIANCE")
		ChatFrame_AddMessageGroup(ChatFrame1, "BG_HORDE")
		ChatFrame_AddMessageGroup(ChatFrame1, "BG_NEUTRAL")
		ChatFrame_AddMessageGroup(ChatFrame1, "BN_CONVERSATION")
		ChatFrame_AddMessageGroup(ChatFrame1, "BN_INLINE_TOAST_ALERT")
		ChatFrame_AddMessageGroup(ChatFrame1, "BN_WHISPER")
		ChatFrame_AddMessageGroup(ChatFrame1, "BN_WHISPER_INFORM")
		ChatFrame_AddMessageGroup(ChatFrame1, "BN_WHISPER_PLAYER_OFFLINE")
		ChatFrame_AddMessageGroup(ChatFrame1, "CHANNEL")
		ChatFrame_AddMessageGroup(ChatFrame1, "COMBAT_FACTION_CHANGE")
		ChatFrame_AddMessageGroup(ChatFrame1, "CURRENCY")
		ChatFrame_AddMessageGroup(ChatFrame1, "DND")
		ChatFrame_AddMessageGroup(ChatFrame1, "EMOTE")
		ChatFrame_AddMessageGroup(ChatFrame1, "ERRORS")
		ChatFrame_AddMessageGroup(ChatFrame1, "GUILD_ACHIEVEMENT")
		ChatFrame_AddMessageGroup(ChatFrame1, "IGNORED")
		ChatFrame_AddMessageGroup(ChatFrame1, "LOOT")
		ChatFrame_AddMessageGroup(ChatFrame1, "MONEY")
		ChatFrame_AddMessageGroup(ChatFrame1, "MONSTER_BOSS_EMOTE")
		ChatFrame_AddMessageGroup(ChatFrame1, "MONSTER_BOSS_WHISPER")
		ChatFrame_AddMessageGroup(ChatFrame1, "MONSTER_EMOTE")
		ChatFrame_AddMessageGroup(ChatFrame1, "MONSTER_SAY")
		ChatFrame_AddMessageGroup(ChatFrame1, "MONSTER_WHISPER")
		ChatFrame_AddMessageGroup(ChatFrame1, "MONSTER_YELL")
		ChatFrame_AddMessageGroup(ChatFrame1, "RAID_WARNING")
		ChatFrame_AddMessageGroup(ChatFrame1, "SKILL")
		ChatFrame_AddMessageGroup(ChatFrame1, "SYSTEM")
		ChatFrame_AddMessageGroup(ChatFrame1, "TARGETICONS")
		ChatFrame_AddMessageGroup(ChatFrame1, "WHISPER")
		-- Setup ChatFrame3 Window
		ChatFrame_RemoveAllMessageGroups(ChatFrame3)
		ChatFrame_AddMessageGroup(ChatFrame3, "CHANNEL")
		ChatFrame_AddMessageGroup(ChatFrame3, "GUILD")
		ChatFrame_AddMessageGroup(ChatFrame3, "OFFICER")
		ChatFrame_AddMessageGroup(ChatFrame3, "PARTY")
		ChatFrame_AddMessageGroup(ChatFrame3, "PARTY_LEADER")
		ChatFrame_AddMessageGroup(ChatFrame3, "RAID")
		ChatFrame_AddMessageGroup(ChatFrame3, "RAID_LEADER")
		ChatFrame_AddMessageGroup(ChatFrame3, "SAY")
		ChatFrame_AddMessageGroup(ChatFrame3, "YELL")
		-- Enable Classcolor Automatically On Login
		ToggleChatColorNamesByClassGroup(true, "SAY")
		ToggleChatColorNamesByClassGroup(true, "EMOTE")
		ToggleChatColorNamesByClassGroup(true, "YELL")
		ToggleChatColorNamesByClassGroup(true, "GUILD")
		ToggleChatColorNamesByClassGroup(true, "OFFICER")
		ToggleChatColorNamesByClassGroup(true, "GUILD_ACHIEVEMENT")
		ToggleChatColorNamesByClassGroup(true, "ACHIEVEMENT")
		ToggleChatColorNamesByClassGroup(true, "WHISPER")
		ToggleChatColorNamesByClassGroup(true, "PARTY")
		ToggleChatColorNamesByClassGroup(true, "PARTY_LEADER")
		ToggleChatColorNamesByClassGroup(true, "RAID")
		ToggleChatColorNamesByClassGroup(true, "RAID_LEADER")
		ToggleChatColorNamesByClassGroup(true, "RAID_WARNING")
		ToggleChatColorNamesByClassGroup(true, "BATTLEGROUND")
		ToggleChatColorNamesByClassGroup(true, "BATTLEGROUND_LEADER")	
		ToggleChatColorNamesByClassGroup(true, "CHANNEL1")
		ToggleChatColorNamesByClassGroup(true, "CHANNEL2")
		ToggleChatColorNamesByClassGroup(true, "CHANNEL3")
		ToggleChatColorNamesByClassGroup(true, "CHANNEL4")
		ToggleChatColorNamesByClassGroup(true, "CHANNEL5")
		ToggleChatColorNamesByClassGroup(true, "CHANNEL6")
		ToggleChatColorNamesByClassGroup(true, "CHANNEL7")
		ToggleChatColorNamesByClassGroup(true, "CHANNEL8")
		ToggleChatColorNamesByClassGroup(true, "CHANNEL9")
		ToggleChatColorNamesByClassGroup(true, "CHANNEL10")
		ToggleChatColorNamesByClassGroup(true, "CHANNEL11")
	end
end

----------------------------------------------------------------------------
-- Memory Cleaner abstract idea founded by Everglow - Sisters of Elune/US --
----------------------------------------------------------------------------
if xUMemTrim then
	eventHandlers['ZONE_CHANGED' or 'PLAYER_DEAD' or 'ZONE_CHANGED_NEW_AREA'] = function(name)
		local newtime = time(); -- tonumber(date("%j%H%M%S"));
		local elapsed = difftime(newtime,lastcycle);
		if elapsed > INTVL then
			local before = collectgarbage("count");
			local growth = (before-lastmem)/elapsed;
			collectgarbage();
			local after =  collectgarbage("count");
			if report then DEFAULT_CHAT_FRAME:AddMessage("memory recycled by xUtils:\nmemory freed: |c00FFFF66"..tostring(math.floor((before-after)+.5)).." kb|r\ncurrent memory use: |c00FFFF66"..tostring(math.floor((after/100)+.5)/10).." MB|r\nmemory growth rate: |c00FFFF66"..tostring((math.floor((growth*10)+.5)/10)).." kb|r/second."); end
			lastcycle = newtime;
			lastmem=after;
		end
	end
end

---------------------------------------
-- Classcolored Names On Blizz Frame --
---------------------------------------
if classColored then
	local eventFrame = CreateFrame("Frame")
	eventFrame:RegisterEvent("PLAYER_LOGIN")
	eventFrame:SetScript("OnEvent", function(self, event, ...)
		hooksecurefunc("UnitFrame_Update", function(self)
			if UnitIsPlayer(self.unit) then
				local classcolor = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[select(2,UnitClass(self.unit))]
				self.name:SetTextColor(classcolor.r,classcolor.g,classcolor.b,1)
			end
		end)

		hooksecurefunc("UnitFrame_OnEvent", function(self, event, unit)
			if event == "UNIT_PORTRAIT_UPDATE" and UnitIsPlayer(self.unit) then
				local classcolor = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[select(2,UnitClass(self.unit))]
				self.name:SetTextColor(classcolor.r,classcolor.g,classcolor.b,1)
			end
		end)
	end)
end

------------------------
-- Auto Decline Duels --
------------------------
if declineDuels then
    local dd = CreateFrame("Frame")
    dd:RegisterEvent("DUEL_REQUESTED")
    dd:SetScript("OnEvent", function(self, event, name)
		HideUIPanel(StaticPopup1)
		CancelDuel()
		aInfoText_ShowText(L_DUEL..name)
		print(format("|cff00ffff"..L_DUEL..name))
    end)
end

-----------------------------------
-- AFK Modification (by Recluse) --
-----------------------------------
if visiAFK then
	local af = CreateFrame("Frame")
	af:SetScript("OnEvent", function(self, event, ...)
		local message = select(1, ...)

		if string.find(message, CLEARED_AFK) or string.find(message, "Welcome to the World of Warcraft") then
			SetCVar("UnitNameOwn", 0)
		elseif string.find(message, string.gsub(MARKED_AFK_MESSAGE, "%%s", ".*")) or string.find(message, MARKED_AFK) then
			SetCVar("UnitNameOwn", 1)
		end
	end)
	af:RegisterEvent("CHAT_MSG_SYSTEM")
end

------------------------------------------------
-- Auto Disenchant/Greed Confirmation by Tekkub --
------------------------------------------------
if autoConfirmDE then
	local acd = CreateFrame("Frame")
	acd:RegisterEvent("CONFIRM_DISENCHANT_ROLL")
	acd:SetScript("OnEvent", function(self, event, id, rollType)
		for i=1,STATICPOPUP_NUMDIALOGS do
			local frame = _G["StaticPopup"..i]
			if frame.which == "CONFIRM_LOOT_ROLL" and frame.data == id and frame.data2 == rollType and frame:IsVisible() then StaticPopup_OnClick(frame, 1) end
		end
	end)
	
	StaticPopupDialogs["LOOT_BIND"].OnCancel = function(self, slot)
	if GetNumPartyMembers() == 0 and GetNumRaidMembers() == 0 then ConfirmLootSlot(slot) end
	end
end

------------------------------
-- Force Readycheck Warning --
------------------------------
if rcSound then
	local ShowReadyCheckHook = function(self, initiator, timeLeft)
		if initiator ~= "player" then
			PlaySound("ReadyCheck")
		end
	end
	hooksecurefunc("ShowReadyCheck", ShowReadyCheckHook)
end

----------------------------------------
-- Disband Party or Raid (by Monolit) --
----------------------------------------
if rDisband then
	SlashCmdList["GROUPDISBAND"] = function()
			local pName = UnitName("player")
			SendChatMessage("Disbanding group.", "RAID" or "PARTY")
			if UnitInRaid("player") then
				for i = 1, GetNumRaidMembers() do
					local name, _, _, _, _, _, _, online = GetRaidRosterInfo(i)
					if online and name ~= pName then
						UninviteUnit(name)
					end
				end
			else
				for i = MAX_PARTY_MEMBERS, 1, -1 do
					if GetPartyMember(i) then
						UninviteUnit(UnitName("party"..i))
					end
				end
			end
			LeaveParty()
	end
	SLASH_GROUPDISBAND1 = "/rd"
end

---------------------------------------------
-- Combatlogging Toggler (by Suicidalkatt) --
---------------------------------------------
if cLogToggle then
	toggle.on = function() 
		if (LoggingCombat()) then
			print("Combat logging is already enabled.")
		else
			print("Combat logging is now enabled.")
			LoggingCombat(1)
		end
	end
	toggle.off = function() 
		if not (LoggingCombat()) then
			print("Combat logging is already disabled.")
		else
			print("Combat logging is now disabled.")
			LoggingCombat(0)
		end
	end
	
	function osCL(arg)
		if type(toggle[arg]) == 'function' then 
			toggle[arg]()
		else 
			print("Available commands are /cl 'on' or 'off'.")
		end
	end
	SLASH_CL1 = "/cl";
	SlashCmdList["CL"] = osCL
end

--------------------------------------------------
-- AutoQuest Rewards Selector (by Everglow)		--
--------------------------------------------------
if questRewards then
	local choices, high, hLink, hID = GetNumQuestChoices(), 0
		if(choices > 1) then
			for i=1, choices do
				local link	= GetQuestItemLink("choice", i);
				local _, _, _, _, _, _, _, _, _, _, value = GetItemInfo(link);
				if(value >= high) then
					high  = value;
					hLink = link;
					hID   = i;
				end
			end
		end
		if(high > 0) then
			local choice = _G["QuestInfoItem"..hID];
			QuestInfoFrame.itemChoice = hID;
			QuestInfoItemHighlight:SetPoint("TOPLEFT", choice, "TOPLEFT", -8, 7);
			QuestInfoItemHighlight:Show();
		end
	end
end

-- =========================== --
-- [[Slash Command Functions]] --
-- =========================== --
local function CLFIX()-- By TUKUI
	CombatLogClearEntries()
	print("|cffcd00003|r CombatLog Refreshed! ^_^")
end

function osDGR()-- By Suicidalkatt
	ResetInstances();
end

function osDGT()-- By Suicidalkatt
	local inInstance, _ = IsInInstance()
	if inInstance then
		LFGTeleport(true);
	else
		LFGTeleport();
	end
end

function osGK()-- By Suicidalkatt
	UninviteUnit(UnitName("target"))
end

function osGL()-- By Suicidalkatt
	PromoteToLeader("target")
end

function osLG()-- By Suicidalkatt
	LeaveParty();
end

function osRI()-- By Suicidalkatt
	if ( RaidInfoFrame:IsShown() ) and ( FriendsFrame:IsShown() ) then
		ToggleFriendsFrame(4)
		RaidInfoFrame:Hide();
	else
		ToggleFriendsFrame(4)
		RaidInfoFrame:Show();
	end
end

function osSC()-- By Suicidalkatt
	if ShowingCloak() then
		ShowCloak(false)
	else
		ShowCloak()
	end
end

function osSH()-- By Suicidalkatt
	if ShowingHelm() then 
		ShowHelm(false) 
	else 
		ShowHelm() 
	end
end

function raidD() -- By Protonova
	if ((GetNumPartyMembers() > 0) or (GetNumRaidMembers() > 0)) then 
		if GetRaidDifficulty() == (1) then 
				print("|cffcd0000Currently set to:|r 10 players normal");
			else
				if GetRaidDifficulty() == (2) then 
					print("|cffcd0000Currently set to:|r 25 players normal");
				else 
					if GetRaidDifficulty() == (3)  then 
						print("|cffcd0000Currently set to:|r 10 players heroic");
					else
						if GetRaidDifficulty() == (4) then 
							print("|cffcd0000Currently set to:|r 25 players heroic");
						end
					end
				end	
		end
	end
end

-- ========================= --
-- [[Custom Slash Commands]] --
-- ========================= --
SlashCmdList["CLFIX"] = CLFIX
SLASH_CLFIX1 = "/clfix"

SlashCmdList["FRAME"] = function(arg)
	if arg ~= "" then
		arg = _G[arg]
	else
		arg = GetMouseFocus()
	end
	if arg ~= nil and arg:GetName() ~= nil then
		local point, relativeTo, relativePoint, xOfs, yOfs = arg:GetPoint()
		ChatFrame1:AddMessage("|cffCC0000~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
		ChatFrame1:AddMessage("Name: |cffFFD100"..arg:GetName())
		if arg:GetParent() then
			ChatFrame1:AddMessage("Parent: |cffFFD100"..arg:GetParent():GetName())
		end
		ChatFrame1:AddMessage("Width: |cffFFD100"..format("%.2f",arg:GetWidth()).."      |cffffffff".."Height: |cffFFD100"..format("%.2f",arg:GetHeight()))
		ChatFrame1:AddMessage("Strata: |cffFFD100"..arg:GetFrameStrata().."      |cffffffff".."Level: |cffFFD100"..arg:GetFrameLevel())
		if xOfs then
			ChatFrame1:AddMessage("X: |cffFFD100"..format("%.2f",xOfs))
		end
		if yOfs then
			ChatFrame1:AddMessage("Y: |cffFFD100"..format("%.2f",yOfs))
		end
		if relativeTo then
			ChatFrame1:AddMessage("Point: |cffFFD100"..point.."|r anchored to "..relativeTo:GetName().."'s |cffFFD100"..relativePoint)
		end
		ChatFrame1:AddMessage("|cffCC0000~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
	elseif arg == nil then
		ChatFrame1:AddMessage("Invalid frame name")
	else
		ChatFrame1:AddMessage("Could not find frame info")
	end
end
SLASH_FRAME1 = "/gn"
SLASH_FRAME2 = "/frame"

SlashCmdList["RELOADUI"] = function() ReloadUI() end
SLASH_RELOADUI1 = "/rl"

SlashCmdList["RCSLASH"] = function() DoReadyCheck() end
SLASH_RCSLASH1 = "/rc"
SLASH_RCSLASH2 = '/rdy'

SlashCmdList["ROLECHECK"] = function() if (((IsRaidLeader() or IsRaidOfficer()) and GetNumRaidMembers() > 0) or (IsPartyLeader() and GetNumPartyMembers() > 0) ) then InitiateRolePoll() end end
SLASH_ROLECHECK1="/rolecheck"
SLASH_ROLECHECK2="/roc"

SlashCmdList["TICKET"] = function() ToggleHelpFrame() end
SLASH_TICKET1 = "/ticket"
SLASH_TICKET2 = "/gm"

SlashCmdList["DGR"] = function() osDGR() end
SLASH_DGR1 = "/dgr"
SLASH_DGR2 = "/dungeonreset"

SlashCmdList["DGT"] = function() osDGT() end
SLASH_DGT1 = "/dgt"
SLASH_DGT2 = "/dungeontele"
SLASH_DGT3 = "/tele"

SlashCmdList["GK"] = function() osGK() end
SLASH_GK1 = "/vk";
SLASH_GK2 = "/votekick";
SLASH_GK3 = "/gk";
SLASH_GK4 = "/groupkick";

SlashCmdList["GL"] = function() osGL() end
SLASH_GL1 = "/gl"
SLASH_GL2 = "/grouplead"

SlashCmdList["LG"] = function() osLG() end
SLASH_LG1 = "/lg";

SlashCmdList["RI"] = function() osRI() end
SLASH_RI1 = "/ri";

SlashCmdList["SC"] = function() osSC() end
SLASH_SC1 = "/sc";
SLASH_SC2 = "/showcloak";

SlashCmdList["SH"] = function() osSH() end
SLASH_SH1 = "/sh";
SLASH_SH2 = "/showhelm";

SlashCmdList["CAL"] = function() ToggleCalendar() end
SLASH_CAL1 = "/cal"

SlashCmdList["RDIFF"]= function() raidD() end
SLASH_RDIFF1 = "/rdiff"

-- The Following was written by Tim (Schitzo of Perenolde-US)
SlashCmdList.REGTEN = function() if GetNumPartyMembers() > 0 or GetNumRaidMembers() > 0 then if IsRaidLeader() then SetRaidDifficulty(1) else print("|cffcd0000Error: You aren't the Raid Leader.|r") end else print("|cffcd0000Error: Not in a group.|r") end end
SLASH_REGTEN1 = "/r10"

SlashCmdList.HEROICTEN = function() if GetNumPartyMembers() > 0 or GetNumRaidMembers() > 0 then if IsRaidLeader() then SetRaidDifficulty(3) else print("|cffcd0000Error: You aren't the Raid Leader.|r") end else print("|cffcd0000Error: Not in a group.|r") end end
SLASH_HEROICTEN1 = "/h10"

SlashCmdList.REGTWENTYFIVE = function() if GetNumPartyMembers() > 0 or GetNumRaidMembers() > 0 then if IsRaidLeader() then SetRaidDifficulty(2) else print("|cffcd0000Error: You aren't the Raid Leader.|r") end else print("|cffcd0000Error: Not in a group.|r") end end
SLASH_REGTWENTYFIVE1 = "/r25"

SlashCmdList.HEROICTWENTYFIVE = function() if GetNumPartyMembers() > 0 or GetNumRaidMembers() > 0 then if IsRaidLeader() then SetRaidDifficulty(4) else print("|cffcd0000Error: You aren't the Raid Leader.|r") end else print("|cffcd0000Error: Not in a group.|r") end end
SLASH_HEROICTWENTYFIVE1 = "/h25"

--[[-----------------------------------------------------------------------------
Initialize Event handlers
-------------------------------------------------------------------------------]]
if next(eventHandlers) then
	local frame = CreateFrame('Frame')
	frame:Hide()

	for event, handler in pairs(eventHandlers) do
		frame[event] = handler
		frame:RegisterEvent(event)
		eventHandlers[event] = nil
	end

	frame:SetScript('OnEvent', function(self, event, ...)
		self[event](...)
	end)
end