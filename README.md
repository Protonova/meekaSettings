meekaSettings
=============

Description
-----------
This addon tweaks many aspects of the UI. It improves performance and general easy of use in WoW for any type of raider. The performance tweaks range from visual quality mods to system mods all to improve FPS during raids or in general. All of these tweaks can be found on my personal UIs.

Features
----------
All these features can be enabled/disabled via the `CONFIG VARIABLES` section at the top of `meekaSettings.lua`.

-	AFK Nameplate modification - Show your own nameplate text if you are AFK.
-	Auto Decline Duels - Automatically deny any duel request.
-	Auto Disenchant/Greed Confirmation - Automatically accept greed or disenchant confirmations.
-	Automated Group Disband-er - Disband full groups automatically kicking everyone in group by using the `/rd` slash command.
-	Buffed - Let you know what buffs you're missing in groups. Also checks your own buffs and lets you know what you need to buff.
-	Class Color Everything - Adds class based colors to every aspect of the blizzard UI. Meaning friends list, chat, BGs, etc.
-	CombatLog Fix - Every once in a while the combat log bugs out and is just blank. This basically kills MSBT, Omen, Recount, etc and is really annoying.
-	Constant Memory Dumps - An addon that constantly clears junk addon usage. Constant memory dumps to keep your UI running smoothly.
-	DX11 Enabler - Force DirectX 11 of WoW's gfx engine. No longer a hidden option as of patch 4.2.
-	Forces Audible Ready Check Warning Sounds - Makes sure that when a readycheck is used to invoke the readycheck sound. Will not work if all sound is disabled.
-	Hides Minimap Clock - Gets rid of the minimap clock if you are not using a minimap addon like chinchilla.
-	Loads of shortcut slash commands.
	1.	`/cal` - Toggles Calendar.
	2.	`/cl on` or `off` - Combatlog On or off toggle.
	3.	`/clfix` - resets combatlog entries
	4.	`/dgr` - Dungeon Reset, shortcut to reset dungeons (obviously not heroics).
	5.	`/dgt` - Dungeon Teleport, shortcut to teleporting in and out of dungeons.
	6.	`/dungeontele` - Dungeon Teleport, look at /dgt.
	7.	`/gl` - Group Lead, transfers leader of group to target.
	8.	`/gm` - Game Master, shortcut to help section.
	9.	`/gn` - Get name, prints out the name of the frame the mouse is currently over. /frame will do the same.
	10.	`/gp` - Get Parent, prints out the name of the parent frame where the mouse is currently hovering over.
	11.	`/h10` - Sets raid to heroic 10 man.
	12.	`/h25` - Sets raid to heroic 25 man.
	13.	`/lg` - Leave Group, command to leave any group.
	14.	`/r10` - Sets raid to normal 10 man.
	15.	`/r25` - Sets raid to normal 25 man.
	16.	`/rc` - Ready Check, shortcut to commence raid check.
	17.	`/rd` - Raid Disband, will alert raid that group is disbanding and kicks everyone off one by one (very fast).
	18.	`/rdiff` - Displays what mode your current raid is set to, ie 10N/10H 25N/25H.
	19.	`/ri` - Raid Info, shortcut to raid info tab.
	20.	`/rl` - Reload UI, command to reload your UI.
	21.	`/sc` - Show Cloak, easy way to toggle show cloak.
	22.	`/sh` - Show Helmet, easy way to toggle your helm showing.
	23.	`/vk` - Vote Kick aka Group Kick, shortcut to commencing dungeon group kicks.
-	Raid Difficulty Viewer - Don't know what your raid is set to? Type in `/rdiff`.
-	SYSTEM (aka console) Tweaks - From nameplates to buffs/debuffs, combat, controls, display, EoU, social, sound, and system modifications.
-	QuestRewards - Select highest value quest reward when turning in quests.

CONFIG VARIABLES
----------------
<pre><code>
local cLogToggle        = true
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
</code></pre>