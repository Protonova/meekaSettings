-- tool:		Alerts you of missing buffs
-- credits: 	Naberius (Mysterio of Perenolde-US)

local useMOD = true			-- if you want to use this tool leave true
if not useMOD then return end

local party = true			-- do the buff checking not only in a raid but also a party
local waiter = 5			-- threshold timer for your food, flask & wep enchant buff in minutes
local ignore_bgs = true			-- ignore buff checks in a battleground/arena/voa/tol barad

local reminder = CreateFrame('Frame')
local pClass = select(2, UnitClass('player'))


local function grouped()

   if GetNumPartyMembers() > 0 then return true end
   return false
end

local function inRaid(class)

   local gt = 'none'

   if (GetNumRaidMembers() > 0) then
      totalMems = GetNumRaidMembers()
      gt = 'raid'
   elseif (GetNumPartyMembers() > 0) then
      totalMems = GetNumPartyMembers()
      gt = 'party'
   end

   if (totalMems) then
      for i = 1, totalMems do
         local unit = gt..i
         if not UnitIsPlayer('unit') and select(2, UnitClass(unit)) == class then return true end
      end
   end

   return false
end

local function classCount(class)

   local cc = 0

   if (GetNumRaidMembers() > 0) then
      totalMems = GetNumRaidMembers()
      gt = 'raid'
   elseif (GetNumPartyMembers() > 0) then
      totalMems = GetNumPartyMembers()
      gt = 'party'
   end

   if (totalMems) then
      for i = 1, totalMems do
         local unit = gt..i
         if not UnitIsPlayer('unit') and select(2, UnitClass(unit)) == class then cc = cc + 1 end
      end
   end

   return cc
end

local function buffCheck(name)

   return UnitAura("player", name, nil, "HELPFUL")
end

local function food(name)

   local name, _, _, _, _, _, expirationTime = UnitAura("player", "Well Fed", nil, "HELPFUL")
	
   if name then return true end
   return false
end

local function foodTimer(name)

   local name, _, _, _, _, _, expirationTime = UnitAura("player", "Well Fed", nil, "HELPFUL")
	
   if name then return expirationTime - GetTime() <= (waiter*60) end
end

local function flask()

   for i = 1, BUFF_MAX_DISPLAY do
      local name, _, _, _, _, _, expirationTime = UnitAura("player", i, "HELPFUL|CANCELABLE")
	
      if name then
         if (name:sub(1, 5) == "Flask") then return true end			
      else return false end
   end
end

local function flaskTimer()

   for i = 1, BUFF_MAX_DISPLAY do
      local name, _, _, _, _, _, expirationTime = UnitAura("player", i, "HELPFUL|CANCELABLE")
	
      if name then
         if (name:sub(1, 5) == "Flask") then return expirationTime - GetTime() <= (waiter*60) end			
      else return false end
   end
end

local function hasValidWeapon(offHand)

   local weaponClass = select(1, GetAuctionItemClasses())
   local fishingPoleClass = select(17, GetAuctionItemSubClasses(1))
   local link = GetInventoryItemLink("player", offHand and 17 or 16)
		
   if link then
      local class, subClass = select(6, GetItemInfo(link))
      return class == weaponClass and subClass ~= fishingPoleClass
   end
end

local function enchantTimer(offHand)

   local hasMainHandEnchant, mainHandExpiration, _, hasOffHandEnchant, offHandExpiration = GetWeaponEnchantInfo()
		
   if offHand then
      return hasOffHandEnchant and (offHandExpiration / 1000) or -1
   else
      return hasMainHandEnchant and (mainHandExpiration / 1000) or -1
   end
end

local function hasTalent(tabIndex, talentIndex, rankRequired)

   return select(5, GetTalentInfo(tabIndex, talentIndex)) >= (rankRequired or 1)
end

local function bgORarena()

   local zone = GetZoneText()

   if (zone == "Warsong Gulch" or zone == "Battle for Gilneas" or zone == "Twin Peaks" or zone == "Arathi Basin" or 
       zone == "Eye of the Storm" or zone == "Strand of the Ancients" or zone == "Wintergrasp" or zone == "Alterac Valley" 
       or zone == "Isle of Conquest") then
         return true
   elseif (zone == "The Circle of Blood" or zone == "Dalaran Sewers" or zone == "Ruins of Lordaeron" or 
       zone == "The Ring of Trials" or zone == "The Ring of Valor") then
         return true
   elseif (zone == "Vault of Archavon" or zone == "Tol Barad") then
         return true
   end

   return false
end

local gb, sb = {}, {}

local function bufforama()

   if not grouped then return end
   if not party and grouped then return end
   if ignore_bgs and bgORarena then return end

   -- group buff checks

   if inRaid("DRUID") then
      if not buffCheck("Mark of the Wild") then table.insert(gb, "Mark of the Wild") end
   end

   if inRaid("PALADIN") then
      if not inRaid("DRUID") then
         if not buffCheck("Blessing of Kings") then table.insert(gb, "Blessing of Kings") end
      else
         if not buffCheck("Blessing of Might") then table.insert(gb, "Blessing of Might") end
      end
   end

   if inRaid("MAGE") then
      if not inRaid("PALADIN") then
         if not buffCheck("Arcane Brilliance") or not buffCheck("Dalaran Brilliance") then table.insert(gb, "Arcane Brilliance") end
      end
   end

   if inRaid("PRIEST") then
      if not buffCheck("Power Word: Fortitude") then table.insert(gb, "Power Word: Fortitude") end
   end

   if inRaid("WARRIOR") then
      if not inRaid("PRIEST") and not inRaid("WARLOCK") then
         if not buffCheck("Commanding Shout") then table.insert(gb, "Commanding Shout") end
      end
   end

   if inRaid("WARLOCK") then
      if not inRaid("PRIEST") and not inRaid("WARRIOR") then
         if not buffCheck("Blood Pact") then table.insert(gb, "Blood Pact") end
      end
   end

   -- self buff checks

   if not food("Well Fed") or foodTimer("Well Fed") then table.insert(sb, "Food") end
   if not flask or flaskTimer then table.insert(sb, "Flask") end

   if pClass == "DEATHKNIGHT" then
      local _, _, isActive = GetShapeshiftFormInfo(1)
      if not buffCheck("Blood Presence") and not buffCheck("Frost Presence") and not buffCheck("Unholy Presence") then table.insert(sb, "Presence") end
      local _, _, _, _, pts1 = GetTalentTabInfo(1, false, false,  GetActiveTalentGroup() or 1);
      local _, _, _, _, pts2 = GetTalentTabInfo(2, false, false,  GetActiveTalentGroup() or 1);
      local _, _, _, _, pts3 = GetTalentTabInfo(3, false, false,  GetActiveTalentGroup() or 1);
      if UnitLevel("player") >= 10 then
         if pts3 > pts1 and pts3 > pts2 then if not (IsMounted() or PetHasActionBar()) then table.insert(sb, "Ghoul") end end
         if pts1 > pts2 and pts1 > pts3 then if not (isActive == 1) then table.insert(sb, "Wrong Presence") end end
      end
   end

   if pClass == "HUNTER" then
      if not buffCheck("Aspect of the Hawk") and not buffCheck("Aspect of the Cheetah") and not buffCheck("Aspect of the Pack") and 
         not buffCheck("Aspect of the Wild") and not buffCheck("Aspect of the Fox") then table.insert(sb, "Aspect") end
      if not (IsMounted() or PetHasActionBar()) then table.insert(sb, "Pet") end
   end

   if pClass == "MAGE" then
      if not buffCheck("Mage Armor") and not buffCheck("Molten Armor") and not buffCheck("Frost Armor") then table.insert(sb, "Armor") end
      local _, _, _, _, pts1 = GetTalentTabInfo(1, false, false,  GetActiveTalentGroup() or 1);
      local _, _, _, _, pts2 = GetTalentTabInfo(2, false, false,  GetActiveTalentGroup() or 1);
      local _, _, _, _, pts3 = GetTalentTabInfo(3, false, false,  GetActiveTalentGroup() or 1);
      if UnitLevel("player") >= 10 then
         if pts3 > pts1 and pts3 > pts2 then if not (IsMounted() or PetHasActionBar()) then table.insert(sb, "Elemental") end end
      end
   end

   if pClass == "PALADIN" then
      if not buffCheck("Concentration Aura") and not buffCheck("Devotion Aura") and not buffCheck("Resistance Aura") and 
         not buffCheck("Retribution Aura") and not buffCheck("Crusader Aura") then table.insert(sb, "Aura") end
      if not buffCheck("Seal of Insight") and not buffCheck("Seal of Justice") and not buffCheck("Seal of Righteousness") and 
         not buffCheck("Seal of Truth") then table.insert(sb, "Seal") end
      local _, _, _, _, pts1 = GetTalentTabInfo(1, false, false,  GetActiveTalentGroup() or 1);
      local _, _, _, _, pts2 = GetTalentTabInfo(2, false, false,  GetActiveTalentGroup() or 1);
      local _, _, _, _, pts3 = GetTalentTabInfo(3, false, false,  GetActiveTalentGroup() or 1);
      if UnitLevel("player") >= 10 then
         if pts2 > pts1 and pts2 > pts3 then if not buffCheck("Righteous Fury") then table.insert(sb, "Righteous Fury") end end
      end
   end

   if pClass == "PRIEST" then
      if not buffCheck("Inner Fire") then table.insert(sb, "Inner Fire") end
      if not buffCheck("Vampiric Embrace") and hasTalent(3, 12) then table.insert(sb, "Vampiric Embrace") end
   end

   if pClass == "ROGUE" then
      if hasValidWeapon() and enchantTimer() > 0 and enchantTimer() <= (waiter * 60) or 
         hasValidWeapon() and enchantTimer() == -1 then table.insert(sb, "MH Poison") end
      if hasValidWeapon(true) and enchantTimer(true) > 0 and enchantTimer(true) <= (waiter * 60) or 
         hasValidWeapon(true) and enchantTimer(true) == -1 then table.insert(sb, "OH Poison") end
   end

   if pClass == "SHAMAN" then
      if not buffCheck("Water Shield") and not buffCheck("Lightning Shield") and not buffCheck("Earth Shield") then table.insert(sb, "Shield") end
      if hasValidWeapon() and enchantTimer() > 0 and enchantTimer() <= (waiter * 60) or 
         hasValidWeapon() and enchantTimer() == -1 then table.insert(sb, "MH Imbue") end
      local _, _, _, _, pts1 = GetTalentTabInfo(1, false, false,  GetActiveTalentGroup() or 1);
      local _, _, _, _, pts2 = GetTalentTabInfo(2, false, false,  GetActiveTalentGroup() or 1);
      local _, _, _, _, pts3 = GetTalentTabInfo(3, false, false,  GetActiveTalentGroup() or 1);
      if UnitLevel("player") >= 10 then
         if pts2 > pts1 and pts2 > pts3 then
            if hasValidWeapon(true) and enchantTimer(true) > 0 and enchantTimer(true) <= (waiter * 60) or 
               hasValidWeapon(true) and enchantTimer(true) == -1 then table.insert(sb, "OH Poison") end
         end
      end
   end

   if pClass == "WARLOCK" then
      if not buffCheck("Fel Armor") and not buffCheck("Demon Armor") then table.insert(sb, "Armor") end
      if UnitLevel("player") >= 20 then if not buffCheck("Soul Link") then table.insert(sb, "Soul Link") end end
      if not (IsMounted() or PetHasActionBar()) then table.insert(sb, "Demon") end
   end

   if pClass == "WARRIOR" then
      local _, _, isActive = GetShapeshiftFormInfo(2)
      if not buffCheck("Battle Stance") and not buffCheck("Defensive Stance") and not buffCheck("Beserker Stance") then table.insert(sb, "Stance") end
      local _, _, _, _, pts1 = GetTalentTabInfo(1, false, false,  GetActiveTalentGroup() or 1);
      local _, _, _, _, pts2 = GetTalentTabInfo(2, false, false,  GetActiveTalentGroup() or 1);
      local _, _, _, _, pts3 = GetTalentTabInfo(3, false, false,  GetActiveTalentGroup() or 1);
      if UnitLevel("player") >= 10 then
         if pts3 > pts1 and pts3 > pts2 then if not (isActive == 1) then table.insert(sb, "Wrong Stance") end end
      end
   end


   local group_output = table.concat(gb, ", ")
   local self_output = table.concat(sb, ", ")

   if #gb > 0 or #sb > 0 then print('|cffcd0000Missing the following buffs!|r') end
   if #gb > 0 then print('|cffcd0000Group:|r '..group_output) end
   if #sb > 0 then print('|cffcd0000Self:|r '..self_output) end
   wipe(gb)
   wipe(sb)
end

reminder:RegisterEvent('READY_CHECK')
reminder:SetScript('OnEvent', bufforama)