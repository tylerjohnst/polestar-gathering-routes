local ADDON = ...
local P = Polestar
local AUTHOR = "SDG"
local PACK = "community-grinding-spots"

local spots = {
	{
		id = "stonetalon-grimtotem-post", zone = "Stonetalon Mountains", location = "Grimtotem Post",
		map = 1442, x = 74, y = 85, min = 14, max = 16,
		mobs = "Tauren humanoids", drops = "Wool, Tin, Wild Steelbloom",
		risk = "Moderate - Tent clusters; casters can chain-pull",
		difficulty = "Easy-Moderate - Manageable if pulled outside tents",
	},
	{
		id = "loch-modan-crocolisks", zone = "Loch Modan", location = "Loch Crocolisks",
		map = 1432, x = 55, y = 42, min = 14, max = 16,
		mobs = "Beasts", drops = "Light Leather, Tin, Mageroyal",
		risk = "Low - Well-spaced along islands and shoreline",
		difficulty = "Very Easy - Slow melee beasts with no ranged attacks",
	},
	{
		id = "westfall-shore-crabs", zone = "Westfall", location = "Westfall Shore Crabs",
		map = 1436, x = 30, y = 62, min = 16, max = 19,
		mobs = "Beasts", drops = "Light Leather, Clam Meat, Tin",
		risk = "Low - Spread out cleanly along the open beach",
		difficulty = "Very Easy - Passive/low-damage melee crawlers",
	},
	{
		id = "redridge-althers-mill", zone = "Redridge Mountains", location = "Alther's Mill",
		map = 1433, x = 52, y = 45, min = 20, max = 23,
		mobs = "Beasts", drops = "Light/Medium Leather, Spider's Silk",
		risk = "Moderate - Dense field, but mostly single pulls",
		difficulty = "Easy - Low armor; watch for poison stacks",
	},
	{
		id = "alterac-misty-shore", zone = "Alterac Mountains", location = "Misty Shore",
		map = 1416, x = 21, y = 47, min = 30, max = 32,
		mobs = "Beasts", drops = "Heavy/Thick Leather, Turtle Scales, Mithril",
		risk = "Low - Isolated turtles roaming the shoreline",
		difficulty = "Very Easy - High armor, but very low damage output",
	},
	{
		id = "alterac-crushridge-hold", zone = "Alterac Mountains", location = "Crushridge Hold",
		map = 1416, x = 52, y = 46, min = 33, max = 36,
		mobs = "Humanoid ogres", drops = "Silk, Iron/Mithril/Truesilver",
		risk = "Moderate - Ruins have pairs and patrolling brutes",
		difficulty = "Moderate-Hard - Hard-hitting melee and spellcasters",
	},
	{
		id = "arathi-inner-binding-circle", zone = "Arathi Highlands", location = "Inner Binding Circle",
		map = 1417, x = 51, y = 50, min = 38, max = 39,
		mobs = "Elementals", drops = "Elemental Earth/Fire/Water, Mithril",
		risk = "Moderate - Circular layout with wandering elementals",
		difficulty = "Moderate - Elemental casters hit hard; interrupt/LoS",
	},
	{
		id = "badlands-lesser-rock-elementals", zone = "Badlands", location = "Lesser Rock Elementals",
		map = 1418, x = 16, y = 40, min = 38, max = 42,
		mobs = "Elementals", drops = "Elemental Earth, Solid Stone, Mithril",
		risk = "Low - Well-spaced along the western ridge",
		difficulty = "Easy - Pure melee mobs with predictable swings",
	},
	{
		id = "azshara-legashi-encampment", zone = "Azshara", location = "Legashi Encampment",
		map = 1447, x = 53, y = 19, min = 50, max = 54,
		mobs = "Demon satyrs", drops = "Felcloth, Runecloth, Rich Thorium",
		risk = "Moderate - Campfire groups and roaming rogues",
		difficulty = "Moderate - Watch for stealth satyrs and mana burns",
	},
	{
		id = "felwood-jadefire-run", zone = "Felwood", location = "Jadefire Run",
		map = 1448, x = 41, y = 18, min = 51, max = 53,
		mobs = "Demon satyrs", drops = "Felcloth, Runecloth, Gromsblood",
		risk = "Moderate - Tree cover hides patrolling satyrs",
		difficulty = "Moderate - Manageable 1v1; interrupt Shadow Bolts",
	},
	{
		id = "felwood-jaedenar-irontree", zone = "Felwood", location = "Jaedenar / Irontree Woods",
		map = 1448, x = 38, y = 58, min = 53, max = 58,
		mobs = "Beasts / Demons", drops = "Rugged Leather, Rich Thorium",
		risk = "Low-Moderate - Bears/wolves are spaced; camps are tight",
		difficulty = "Easy-Moderate - Stick to outer beasts for effortless soloing",
	},
}

local ok, reason = P.RegisterPack({
	addon = ADDON, id = PACK, format = 10,
	title = "Community Grinding Spots", author = AUTHOR, version = "0.2.0",
	license = "MIT", source = "Community-provided grinding locations and recommendations.",
})
if not ok then error("PolestarPack_Grinding: grinding pack refused: " .. tostring(reason)) end

for _, spot in ipairs(spots) do
	local ok, reason = P.RegisterGuide({
		id = PACK .. "/" .. spot.id, pack = PACK,
		title = ("%s: %s (%d-%d)"):format(spot.zone, spot.location, spot.min, spot.max),
		category = "Leveling", folder = "Community Grinding",
		zone = spot.map, zoneName = spot.zone, minLevel = spot.min, maxLevel = spot.max,
		author = AUTHOR, version = 1,
		pitch = ("Grind from level %d to %d at %s"):format(spot.min, spot.max, spot.location),
		keywords = { "grind", "grinding", "farming", "community", spot.zone, spot.location },
		steps = { {
			title = ("Grind to level %d at %s"):format(spot.max, spot.location),
			note = ("Recommended levels: %d-%d\nMob type: %s\nDrops / nearby resources: %s\nAdd / social pull risk: %s\nSolo difficulty: %s\n\nCommunity reports; locations, drops, and difficulty are not verified in game. Ore and herbs are gathering resources, not promised mob drops; leather requires Skinning. Coordinates use the WoW Forever live zone map. Pick a suitable spot independently; this is not a travel circuit."):format(
				spot.min, spot.max, spot.mobs, spot.drops, spot.risk, spot.difficulty),
			when = { { k = "level", op = "<", n = spot.max } },
			goals = {
				{ t = "goto", text = spot.location, map = spot.map, x = spot.x, y = spot.y },
				{ t = "level", level = spot.max, map = spot.map, x = spot.x, y = spot.y,
					note = "Kill suitable mobs in this area until you reach the target level." },
			},
		} },
	})
	if not ok then error("PolestarPack_Grinding: grinding guide " .. spot.id .. " refused: " .. tostring(reason)) end
end
