local ADDON, ns = ...
local P = Polestar
local AUTHOR = "Suncoast Developer Guild"
local packs = { Mining = "gathering-mining-routes", Herbalism = "gathering-herbalism-routes" }

for _, profession in ipairs({ "Mining", "Herbalism" }) do
	local ok, reason = P.RegisterPack({
		addon = ADDON, id = packs[profession], format = 10,
		title = profession .. " Routes", author = AUTHOR, version = "0.1.0",
		license = "MIT",
		source = "Circuits adapted from Icy Veins WoW Forever " .. profession .. " maps.",
	})
	if not ok then error("Gathering Routes: pack refused: " .. tostring(reason)) end
end

for _, route in ipairs(ns.Routes) do
	local profession = route.profession or "Mining"
	local pack = packs[profession]
	local minSkill, maxSkill
	for _, range in ipairs(route.skillRanges) do
		minSkill = minSkill and math.min(minSkill, range.min) or range.min
		maxSkill = maxSkill and math.max(maxSkill, range.max) or range.max
	end
	local steps = {}
	for i = 1, #route.points + 1 do
		local closing = i > #route.points
		local point = route.points[closing and 1 or i]
		steps[i] = {
			title = closing and "Return to circuit start" or ("%s area %d/%d"):format(profession, i, #route.points),
			note = closing and "Circuit complete. Restart this guide to repeat."
				or ((profession == "Herbalism" and "Gather visible herbs" or "Mine visible veins")
					.. " along the circuit. These are approximate farming areas, not guaranteed spawns."
					.. (i == 1 and (route.calibrated
						and " Best-effort coordinates; not verified on foot."
						or " Uncalibrated map alignment; check placement before following.") or "")),
			goals = { {
				t = "goto", text = closing and "Circuit start" or ("Gathering area %d"):format(i),
				map = route.map, x = point.x, y = point.y, f = route.frame, r = point.radius,
			} },
		}
	end
	local ok, reason = P.RegisterGuide({
		id = pack .. "/" .. route.id, pack = pack,
		title = ("%s (%d-%d)"):format(route.title, minSkill, maxSkill),
		category = "Professions", zone = route.map, faction = route.faction,
		folder = profession .. "/" .. (route.faction or "Shared"),
		author = AUTHOR, version = 1,
		pitch = ("%s skill %d-%d"):format(profession, minSkill, maxSkill),
		keywords = { profession:lower(), "gathering", "circuit" }, steps = steps,
	})
	if not ok then error("Gathering Routes: guide " .. route.id .. " refused: " .. tostring(reason)) end
end

ns.Routes = nil
