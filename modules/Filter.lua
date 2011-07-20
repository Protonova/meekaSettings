  --++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
  --						Release 16							  --
  -- 						07.20.2011							  --
  -- 				 Protonova of Rexxar - US					  --
  --															  --
  --   This module was taken from CTools for use with			  --
  --   meekaSettings.											  --
  --															  --
  --   Module: Displays a few stats for the user			 	  --
  --   Credits: Naberius (Mysterio of Perenolde-US) and			  --
  --			Caellian for blizzard/storm peaks.				  --
  --++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--

local useMOD = true		--if you want to use this module leave it as true
if not useMOD then return end


-- edit/add/remove strings below to filter from your chat

local playernames = {
	"playerone",
	"playertwo",
	"playerthree",
	"etcetcetc",
}

local triggers = {
	"%[.*%].*anal",
	".*delivery",
	".cqm",
	"100%.*safe",
	"1000g=",
	"24/7",
	"51uoo",
	"Dear.*"..UnitName('player'),
	"anal.*%[.*%]",
	"cheapest.*gold",
	"cheapmmogold",
	"chuck.*norris",
	"clearance.*sale",
	"dear.*players",
	"discount.*",
	"discount.*code",
	"fasteve",
	"gamesky2",
	"gold.*for.*$",
	"gold.*in.*stock",
	"gold.*orders",
	"ignaccount",
	"ignah",
	"ignsky",
	"joygold",
	"k4gold",
	"mmoggg",
	"pet-prize",
	"please.*visit.*account",
	"powerlevel.*",
	"powerleveling.*",
	"receive.*your.*gift",
	"susanexpress",
	"t10/t10.5.*for.*sale",
	"wowgold",
	"wowisle",
}
-- do not edit below this line unless you know what you're doing
local gsub, find, match, lower = string.gsub, string.find, string.match, string.lower

local spam = {
	"Welcome to patch 4.2: Rage of the Firelands!",
	"The world has been changed forever with",
	"the emergence of Deathwing. Please see",
	"Please see the .+",
	".*% patch information, .+",
	".*% common issues and concerns.",
	"You have .+ the title '.atron "..UnitName('player').."'%.",
	"Interface action failed because of an AddOn",
	"You have learned a new spell: .+.",
	"You have learned a new ability: .+",
	"You have unlearned .+.",
	"Your pet has unlearned .+",
}

local system_filter = function(self, event, ...)

   local msg = ...

   for _, v in ipairs(spam) do
	if msg:find(v) then
	   result = true
	   return true, ...					-- found a trigger, filter it
	end
   end

	return false, ...
end

ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", system_filter)

   local chatLines, chatPlayers, prevLineId = {}, {}, 0

   local function filter(_, event, msg, player, _, _, _, _, channelId, channelNum, _, _, lineId)


   plyr = string.lower(player)			-- lowercase all text
   msg = string.lower(msg)				-- lowercase all text
   msg = strreplace(msg, " ", "")		-- remove spaces

   local preMSG = msg

   -- multi-line filtering + channel registered to multiple chatframe fix from badboy
   if lineId == prevLineId then
      return result
   else
      prevLineId = lineId

      for i=1, #chatLines do
         if chatLines[i] == msg and chatPlayers[i] == player then
            result = true
            return true
         end
         if i == 1 then tremove(chatLines, 1) tremove(chatPlayers, 1) end
      end
      tinsert(chatLines, msg) tinsert(chatPlayers, player)
   end

   if UnitName("player") == player then result = nil return end

   for i = 1, GetNumFriends() do
      if GetFriendInfo(i) == player then result = nil return end	-- if person is on your friends list then do nothing
   end

   for i = 1, BNGetNumFriends() do
      if BNGetFriendInfo(i) == player then result = nil return end	-- if person is on your friends list then do nothing
   end										-- battle.net friend support


   for k, v in ipairs(playernames) do
	if plyr:find(v) then
	   result = true
	   return true							-- found a trigger, filter it
	end
   end

   for k, v in ipairs(triggers) do
	if msg:find(v) then
	   result = true
	   return true							-- found a trigger, filter it
	end
   end
   result = nil

end

ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", filter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY", filter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", filter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", filter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_EMOTE", filter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_DND", filter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_AFK", filter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_GUILD", filter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID", filter)