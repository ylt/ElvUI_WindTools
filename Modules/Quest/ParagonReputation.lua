local W, F, E, L = unpack(select(2, ...))
local PR = W:NewModule("ParagonReputation", "AceHook-3.0", "AceEvent-3.0")
local S = W:GetModule("Skins")

local _G = _G
local floor = floor
local format = format
local mod = mod
local select = select
local tremove = tremove
local unpack = unpack

local BreakUpLargeNumbers = BreakUpLargeNumbers
local CreateFrame = CreateFrame
local FauxScrollFrame_GetOffset = FauxScrollFrame_GetOffset
local GameTooltip_AddQuestRewardsToTooltip = GameTooltip_AddQuestRewardsToTooltip
local GameTooltip_SetDefaultAnchor = GameTooltip_SetDefaultAnchor
local GetFactionInfo = GetFactionInfo
local GetFactionInfoByID = GetFactionInfoByID
local GetItemInfo = GetItemInfo
local GetNumFactions = GetNumFactions
local GetQuestLogCompletionText = GetQuestLogCompletionText
local GetQuestLogIndexByID = GetQuestLogIndexByID
local GetSelectedFaction = GetSelectedFaction
local GetWatchedFactionInfo = GetWatchedFactionInfo
local PlaySound = PlaySound
local UIFrameFadeIn = UIFrameFadeIn
local UIFrameFadeOut = UIFrameFadeOut

local C_QuestLog_GetLogIndexForQuestID = C_QuestLog.GetLogIndexForQuestID
local C_Reputation_GetFactionParagonInfo = C_Reputation.GetFactionParagonInfo
local C_Reputation_IsFactionParagon = C_Reputation.IsFactionParagon
local C_Timer_After = C_Timer.After

local FONT_COLOR_CODE_CLOSE = FONT_COLOR_CODE_CLOSE
local HIGHLIGHT_FONT_COLOR = HIGHLIGHT_FONT_COLOR
local HIGHLIGHT_FONT_COLOR_CODE = HIGHLIGHT_FONT_COLOR_CODE
local NUM_FACTIONS_DISPLAYED = NUM_FACTIONS_DISPLAYED
local REPUTATION_PROGRESS_FORMAT = REPUTATION_PROGRESS_FORMAT

local ACTIVE_TOAST = false
local WAITING_TOAST = {}

local PARAGON_QUEST_ID = {
	--Legion
	[48976] = {
		-- Argussian Reach
		factionID = 2170,
		cache = 152922
	},
	[46777] = {
		-- Armies of Legionfall
		factionID = 2045,
		cache = 152108,
		rewards = {
			{
				-- Orphaned Felbat
				type = PET,
				itemID = 147841
			}
		}
	},
	[48977] = {
		-- Army of the Light
		factionID = 2165,
		cache = 152923,
		rewards = {
			{
				-- Avenging Felcrushed
				type = MOUNT,
				itemID = 153044,
				mountID = 985
			},
			{
				-- Blessed Felcrushed
				type = MOUNT,
				itemID = 153043,
				mountID = 984
			},
			{
				-- Glorious Felcrushed
				type = MOUNT,
				itemID = 153042,
				mountID = 983
			},
			{
				-- Holy Lightsphere
				type = TOY,
				itemID = 153182
			}
		}
	},
	[46745] = {
		-- Court of Farondis
		factionID = 1900,
		cache = 152102,
		rewards = {
			{
				-- Cloudwing Hippogryph
				type = MOUNT,
				itemID = 147806,
				mountID = 943
			}
		}
	},
	[46747] = {
		-- Dreamweavers
		factionID = 1883,
		cache = 152103,
		rewards = {
			{
				-- Wild Dreamrunner
				type = MOUNT,
				itemID = 147804,
				mountID = 942
			}
		}
	},
	[46743] = {
		-- Highmountain Tribes
		factionID = 1828,
		cache = 152104,
		rewards = {
			{
				-- Highmountain Elderhorn
				type = MOUNT,
				itemID = 147807,
				mountID = 941
			}
		}
	},
	[46748] = {
		-- The Nightfallen
		factionID = 1859,
		cache = 152105,
		rewards = {
			{
				-- Leywoven Flying Carpet
				type = MOUNT,
				itemID = 143764,
				mountID = 905
			}
		}
	},
	[46749] = {
		-- The Wardens
		factionID = 1894,
		cache = 152107,
		rewards = {
			{
				-- Sira's Extra Cloak
				type = TOY,
				itemID = 147843
			}
		}
	},
	[46746] = {
		-- Valarjar
		factionID = 1948,
		cache = 152106,
		rewards = {
			{
				-- Valarjar Stormwing
				type = MOUNT,
				itemID = 147805,
				mountID = 944
			}
		}
	},
	--Battle for Azeroth
	--Neutral
	[54453] = {
		--Champions of Azeroth
		factionID = 2164,
		cache = 166298,
		rewards = {
			{
				-- Azerite Firework Launcher
				type = TOY,
				itemID = 166877
			}
		}
	},
	[58096] = {
		--Rajani
		factionID = 2415,
		cache = 174483,
		rewards = {
			{
				-- Jade Defender
				type = PET,
				itemID = 174479
			}
		}
	},
	[55348] = {
		--Rustbolt Resistance
		factionID = 2391,
		cache = 170061,
		rewards = {
			{
				-- Blueprint: Microbot XD
				type = BINDING_HEADER_OTHER,
				itemID = 169171,
				questID = 55079
			},
			{
				-- Blueprint: Holographic Digitalization Relay
				type = BINDING_HEADER_OTHER,
				itemID = 168906,
				questID = 56086
			},
			{
				-- Blueprint: Rustbolt Resistance Insignia
				type = BINDING_HEADER_OTHER,
				itemID = 168494,
				questID = 55073
			}
		}
	},
	[54451] = {
		--Tortollan Seekers
		factionID = 2163,
		cache = 166245,
		rewards = {
			{
				-- Bowl of Glowing Pufferfish
				type = TOY,
				itemID = 166704
			}
		}
	},
	[58097] = {
		--Uldum Accord
		factionID = 2417,
		cache = 174484,
		rewards = {
			{
				-- Cursed Dune Watcher
				type = PET,
				itemID = 174481
			}
		}
	},
	--Horde
	[54460] = {
		--Talanji's Expedition
		factionID = 2156,
		cache = 166282,
		rewards = {
			{
				-- For da Blood God!
				type = TOY,
				itemID = 166308
			},
			{
				-- Pair of Tiny Bat Wings
				type = PET,
				itemID = 166716
			}
		}
	},
	[54455] = {
		--The Honorbound
		factionID = 2157,
		cache = 166299,
		rewards = {
			{
				-- Rallying War Banner
				type = TOY,
				itemID = 166879
			}
		}
	},
	[53982] = {
		--The Unshackled
		factionID = 2373,
		cache = 169940,
		rewards = {
			{
				-- Royal Snapdragon
				type = MOUNT,
				itemID = 169198,
				mountID = 1237
			},
			{
				-- Flopping Fish
				type = TOY,
				itemID = 170203
			},
			{
				-- Memento of the Deeps
				type = TOY,
				itemID = 170469
			}
		}
	},
	[54461] = {
		--Voldunai
		factionID = 2158,
		cache = 166290,
		rewards = {
			{
				-- Goldtusk Inn Breakfast Buffet
				type = TOY,
				itemID = 166703
			},
			{
				-- Meerah's Jukebox
				type = TOY,
				itemID = 166880
			}
		}
	},
	[54462] = {
		--Zandalari Empire
		factionID = 2103,
		cache = 166292,
		rewards = {
			{
				-- Warbeast Kraal Dinner Bell
				type = TOY,
				itemID = 166701
			}
		}
	},
	--Alliance
	[54456] = {
		--Order of Embers
		factionID = 2161,
		cache = 166297,
		rewards = {
			{
				-- Bewitching Tea Set
				type = TOY,
				itemID = 166808
			},
			{
				-- Cobalt Raven Hatchling
				type = PET,
				itemID = 166718
			}
		}
	},
	[54458] = {
		--Proudmoore Admiralty
		factionID = 2160,
		cache = 166295,
		rewards = {
			{
				-- Proudmoore Music Box
				type = TOY,
				itemID = 166702
			},
			{
				-- Albatross Feather
				type = PET,
				itemID = 166714
			}
		}
	},
	[54457] = {
		--Storm's Wake
		factionID = 2162,
		cache = 166294,
		rewards = {
			{
				-- Violet Abyssal Eel
				type = PET,
				itemID = 166719
			}
		}
	},
	[54454] = {
		--The 7th Legion
		factionID = 2159,
		cache = 166300,
		rewards = {
			{
				-- Rallying War Banner
				type = TOY,
				itemID = 166879
			}
		}
	},
	[55976] = {
		--Waveblade Ankoan
		factionID = 2400,
		cache = 169939,
		rewards = {
			{
				-- Royal Snapdragon
				type = MOUNT,
				itemID = 169198,
				mountID = 1237
			},
			{
				-- Flopping Fish
				type = TOY,
				itemID = 170203
			},
			{
				-- Memento of the Deeps
				type = TOY,
				itemID = 170469
			}
		}
	},
	--Shadowlands
	[61100] = {
		--Court of Harvesters
		factionID = 2413,
		cache = 180648,
		rewards = {
			{
				-- Stonewing Dredwing Pup
				type = PET,
				itemID = 180601
			}
		}
	},
	[64012] = {
		--Death's Advance
		factionID = 2470,
		cache = 186650,
		rewards = {
			{
				-- Beryl Shardhide
				type = MOUNT,
				itemID = 186644,
				mountID = 1455
			},
			{
				-- Fierce Razorwing
				type = MOUNT,
				itemID = 186649,
				mountID = 1508
			},
			{
				-- Mosscoated Hopper
				type = PET,
				itemID = 186541
			}
		}
	},
	[64266] = {
		--The Archivist's Codex
		factionID = 2472,
		cache = 187028,
		rewards = {
			{
				-- Tamed Mauler
				type = MOUNT,
				itemID = 186641,
				mountID = 1454
			},
			{
				-- Gnashtooth
				type = PET,
				itemID = 186538
			}
		}
	},
	[61097] = {
		--The Ascended
		factionID = 2407,
		cache = 180647,
		rewards = {
			{
				-- Malfunctioning Goliath Gauntlet
				type = TOY,
				itemID = 184396
			},
			{
				-- Mark of Purity
				type = TOY,
				itemID = 184435
			},
			{
				-- Larion Cub
				type = PET,
				itemID = 184399
			}
		}
	},
	[61095] = {
		--The Undying Army
		factionID = 2410,
		cache = 180646,
		rewards = {
			{
				-- Reins of the Colossal Slaughterclaw
				type = MOUNT,
				itemID = 182081,
				mountID = 1350
			},
			{
				-- Infested Arachnid Casing
				type = TOY,
				itemID = 184495
			},
			{
				-- Micromancer's Mystical Cowl
				type = PET,
				itemID = 181269
			}
		}
	},
	[61098] = {
		--The Wild Hunt
		factionID = 2465,
		cache = 180649,
		rewards = {
			{
				-- Amber Ardenmoth
				type = MOUNT,
				itemID = 183800,
				mountID = 1428
			},
			{
				-- Hungry Burrower
				type = PET,
				itemID = 180635
			}
		}
	},
	[64267] = {
		--Ve'nari
		factionID = 2432,
		cache = 187029,
		rewards = {
			{
				-- Soulbound Gloomcharger's Reins
				type = MOUNT,
				itemID = 186657,
				mountID = 1501
			},
			{
				-- Rook
				type = PET,
				itemID = 186552
			}
		}
	}
}

function PR:ColorWatchbar(bar)
	if not PR.db.enable then
		return
	end

	local factionID = select(6, GetWatchedFactionInfo())
	if factionID and C_Reputation_IsFactionParagon(factionID) then
		bar:SetBarColor(PR.db.color.r, PR.db.color.g, PR.db.color.b)
	end
end

function PR:SetupParagonTooltip(tt)
	if not PR.db.enable then
		return
	end

	local _, _, rewardQuestID, hasRewardPending = C_Reputation_GetFactionParagonInfo(tt.factionID)
	if hasRewardPending then
		local factionName = GetFactionInfoByID(tt.factionID)
		local questIndex = C_QuestLog_GetLogIndexForQuestID(rewardQuestID)
		local description = GetQuestLogCompletionText(questIndex) or ""
		_G.EmbeddedItemTooltip:SetText(L["Paragon"])
		_G.EmbeddedItemTooltip:AddLine(description, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b, 1)
		GameTooltip_AddQuestRewardsToTooltip(_G.EmbeddedItemTooltip, rewardQuestID)
		_G.EmbeddedItemTooltip:Show()
	else
		_G.EmbeddedItemTooltip:Hide()
	end
end

function PR:Tooltip(bar, event)
	if not bar.questID or not PARAGON_QUEST_ID[bar.questID] then
		return
	end

	if event == "OnEnter" then
		local name, link, quality = GetItemInfo(PARAGON_QUEST_ID[bar.questID].cache)
		if link then
			_G.GameTooltip:SetOwner(bar, "ANCHOR_NONE")
			_G.GameTooltip:SetPoint("LEFT", bar, "RIGHT", 10, 0)
			_G.GameTooltip:SetHyperlink(link)
			_G.GameTooltip:Show()
		end
	elseif event == "OnLeave" then
		GameTooltip_SetDefaultAnchor(_G.GameTooltip, E.UIParent)
		_G.GameTooltip:Hide()
	end
end

function PR:HookReputationBars()
	for n = 1, NUM_FACTIONS_DISPLAYED do
		if _G["ReputationBar" .. n] then
			_G["ReputationBar" .. n]:HookScript(
				"OnEnter",
				function(self)
					PR:Tooltip(self, "OnEnter")
				end
			)
			_G["ReputationBar" .. n]:HookScript(
				"OnLeave",
				function(self)
					PR:Tooltip(self, "OnLeave")
				end
			)
		end
	end
end

function PR:ShowToast(name, text)
	ACTIVE_TOAST = true
	if self.db.toast.sound then
		PlaySound(44295, "master", true)
	end
	PR.toast:EnableMouse(false)
	PR.toast.title:SetText(name)
	PR.toast.title:SetAlpha(0)
	PR.toast.description:SetText(text)
	PR.toast.description:SetAlpha(0)
	UIFrameFadeIn(PR.toast, .5, 0, 1)
	C_Timer_After(
		.5,
		function()
			UIFrameFadeIn(PR.toast.title, .5, 0, 1)
		end
	)
	C_Timer_After(
		.75,
		function()
			UIFrameFadeIn(PR.toast.description, .5, 0, 1)
		end
	)
	C_Timer_After(
		PR.db.toast.fade_time,
		function()
			UIFrameFadeOut(PR.toast, 1, 1, 0)
		end
	)
	C_Timer_After(
		PR.db.toast.fade_time + 1.25,
		function()
			PR.toast:Hide()
			ACTIVE_TOAST = false
			if #WAITING_TOAST > 0 then
				PR:WaitToast()
			end
		end
	)
end

function PR:WaitToast()
	local name, text = unpack(WAITING_TOAST[1])
	tremove(WAITING_TOAST, 1)
	PR:ShowToast(name, text)
end

function PR:CreateToast()
	local toast = CreateFrame("FRAME", "ParagonReputation_Toast", E.UIParent, "BackdropTemplate")
	toast:SetPoint("BOTTOM", E.UIParent, "BOTTOM", 0, 250)
	toast:SetSize(302, 70)
	toast:SetClampedToScreen(true)
	toast:Hide()

	-- [Toast] Create Background Texture
	toast:CreateBackdrop("Transparent")
	if E.private.WT.skins.enable and E.private.WT.skins.windtools and E.private.WT.skins.shadow and toast.backdrop then
		S:CreateBackdropShadow(toast)
	end

	-- [Toast] Create Title Text
	toast.title = toast:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	toast.title:SetPoint("TOPLEFT", toast, "TOPLEFT", 23, -10)
	toast.title:SetWidth(260)
	toast.title:SetHeight(16)
	toast.title:SetJustifyV("TOP")
	toast.title:SetJustifyH("LEFT")

	-- [Toast] Create Description Text
	toast.description = toast:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	toast.description:SetPoint("TOPLEFT", toast.title, "TOPLEFT", 1, -23)
	toast.description:SetWidth(258)
	toast.description:SetHeight(32)
	toast.description:SetJustifyV("TOP")
	toast.description:SetJustifyH("LEFT")

	PR.toast = toast
end

function PR:QUEST_ACCEPTED(event, questID)
	if self.db.toast.enable and PARAGON_QUEST_ID[questID] then
		local name = GetFactionInfoByID(PARAGON_QUEST_ID[questID].factionID)
		local text = GetQuestLogCompletionText(C_QuestLog_GetLogIndexForQuestID(questID))
		if ACTIVE_TOAST then
			WAITING_TOAST[#WAITING_TOAST + 1] = {name, text} --Toast is already active, put this info on the line.
		else
			self:ShowToast(name, text)
		end
	end
end

function PR:CreateBarOverlay(factionBar)
	if factionBar.ParagonOverlay then
		return
	end
	local overlay = CreateFrame("FRAME", nil, factionBar)
	overlay:SetAllPoints(factionBar)
	overlay:SetFrameLevel(3)
	overlay.bar = overlay:CreateTexture("ARTWORK", nil, nil, -1)
	overlay.bar:SetTexture(E.media.normTex)
	overlay.bar:SetPoint("TOP", overlay)
	overlay.bar:SetPoint("BOTTOM", overlay)
	overlay.bar:SetPoint("LEFT", overlay)
	overlay.edge = overlay:CreateTexture("ARTWORK", nil, nil, -1)
	overlay.edge:SetTexture("Interface\\CastingBar\\UI-CastingBar-Spark")
	overlay.edge:SetPoint("CENTER", overlay.bar, "RIGHT")
	overlay.edge:SetBlendMode("ADD")
	overlay.edge:SetSize(38, 38) --Arbitrary value, I hope there isn't an AddOn that skins the bar and the glow doesnt look right with this size.
	factionBar.ParagonOverlay = overlay
end

function PR:ChangeReputationBars()
	if not PR.db.enable then
		return
	end

	local ReputationFrame = _G.ReputationFrame
	ReputationFrame.paragonFramesPool:ReleaseAll()
	local factionOffset = FauxScrollFrame_GetOffset(_G.ReputationListScrollFrame)
	for n = 1, NUM_FACTIONS_DISPLAYED, 1 do
		local factionIndex = factionOffset + n
		local factionRow = _G["ReputationBar" .. n]
		local factionBar = _G["ReputationBar" .. n .. "ReputationBar"]
		local factionStanding = _G["ReputationBar" .. n .. "ReputationBarFactionStanding"]
		if factionIndex <= GetNumFactions() then
			local name, _, _, _, _, _, _, _, _, _, _, _, _, factionID = GetFactionInfo(factionIndex)
			if factionID and C_Reputation_IsFactionParagon(factionID) then
				local currentValue, threshold, rewardQuestID, hasRewardPending = C_Reputation_GetFactionParagonInfo(factionID)
				factionRow.questID = rewardQuestID
				if currentValue then
					local r, g, b = PR.db.color.r, PR.db.color.g, PR.db.color.b
					local value = mod(currentValue, threshold)
					if hasRewardPending then
						local paragonFrame = ReputationFrame.paragonFramesPool:Acquire()
						paragonFrame.factionID = factionID
						paragonFrame:SetPoint("RIGHT", factionRow, 11, 0)
						paragonFrame.Glow:SetShown(true)
						paragonFrame.Check:SetShown(true)
						paragonFrame:Show()
						-- If value is 0 we force it to 1 so we don't get 0 as result, math...
						local over = ((value <= 0 and 1) or value) / threshold
						if not factionBar.ParagonOverlay then
							PR:CreateBarOverlay(factionBar)
						end
						factionBar.ParagonOverlay:Show()
						factionBar.ParagonOverlay.bar:SetWidth(factionBar.ParagonOverlay:GetWidth() * over)
						factionBar.ParagonOverlay.bar:SetVertexColor(r + .15, g + .15, b + .15)
						factionBar.ParagonOverlay.edge:SetVertexColor(r + .2, g + .2, b + .2, (over > .05 and .75) or 0)
						value = value + threshold
					else
						if factionBar.ParagonOverlay then
							factionBar.ParagonOverlay:Hide()
						end
					end
					factionBar:SetMinMaxValues(0, threshold)
					factionBar:SetValue(value)
					factionBar:SetStatusBarColor(r, g, b)
					factionRow.rolloverText =
						HIGHLIGHT_FONT_COLOR_CODE ..
						" " ..
							format(REPUTATION_PROGRESS_FORMAT, BreakUpLargeNumbers(value), BreakUpLargeNumbers(threshold)) ..
								FONT_COLOR_CODE_CLOSE

					local count = floor(currentValue / threshold)
					if hasRewardPending then
						count = count - 1
					end
					if PR.db.text == "PARAGON" then
						factionStanding:SetText(L["Paragon"])
						factionRow.standingText = L["Paragon"]
					elseif PR.db.text == "EXALTED" then
						factionStanding:SetText(L["Exalted"])
						factionRow.standingText = L["Exalted"]
					elseif PR.db.text == "CURRENT" then
						factionStanding:SetText(BreakUpLargeNumbers(value))
						factionRow.standingText = BreakUpLargeNumbers(value)
					elseif PR.db.text == "PARAGONPLUS" then
						if count > 0 then
							factionStanding:SetText(L["Paragon"] .. " x " .. count)
							factionRow.standingText = (L["Paragon"] .. " x " .. count)
						else
							factionStanding:SetText(L["Paragon"] .. " + ")
							factionRow.standingText = (L["Paragon"] .. " + ")
						end
					elseif PR.db.text == "VALUE" then
						factionStanding:SetText(" " .. BreakUpLargeNumbers(value) .. " / " .. BreakUpLargeNumbers(threshold))
						factionRow.standingText = (" " .. BreakUpLargeNumbers(value) .. " / " .. BreakUpLargeNumbers(threshold))
						factionRow.rolloverText = nil
					elseif PR.db.text == "DEFICIT" then
						if hasRewardPending then
							value = value - threshold
							factionStanding:SetText("+" .. BreakUpLargeNumbers(value))
							factionRow.standingText = "+" .. BreakUpLargeNumbers(value)
						else
							value = threshold - value
							factionStanding:SetText(BreakUpLargeNumbers(value))
							factionRow.standingText = BreakUpLargeNumbers(value)
						end
						factionRow.rolloverText = nil
					end
					if factionIndex == GetSelectedFaction() and _G.ReputationDetailFrame:IsShown() then
						if count > 0 then
							_G.ReputationDetailFactionName:SetText(name .. " |cffffffffx" .. count .. "|r")
						end
					end
				end
			else
				factionRow.questID = nil
				if factionBar.ParagonOverlay then
					factionBar.ParagonOverlay:Hide()
				end
			end
		else
			factionRow:Hide()
		end
	end
end

function PR:Initialize()
	self.db = E.db.WT.quest.paragonReputation
	if not self.db.enable or self.initialized then
		return
	end

	self:RegisterEvent("QUEST_ACCEPTED")

	self:SecureHook(_G.ReputationBarMixin, "Update", "ColorWatchbar")
	self:SecureHook("ReputationParagonFrame_SetupParagonTooltip", "SetupParagonTooltip")
	self:SecureHook("ReputationFrame_Update", "ChangeReputationBars")
	PR:HookReputationBars()
	PR:CreateToast()
	E:CreateMover(
		PR.toast,
		"WTParagonReputationToastFrameMover",
		L["Paragon Reputation Toast"],
		nil,
		nil,
		nil,
		"WINDTOOLS,ALL",
		function()
			return PR.db.toast.enable
		end,
		"WindTools,quest,paragonReputation"
	)

	self.initialized = true
end

function PR:ProfileUpdate()
	self:Initialize()

	if not self.db.enable then
		self:UnregisterEvent("QUEST_ACCEPTED")
	end
end

W:RegisterModule(PR:GetName())
