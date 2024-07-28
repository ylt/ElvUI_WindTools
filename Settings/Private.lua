local W, F, E, L, V, P, G = unpack((select(2, ...)))

local norm = format("|cff1eff00%s|r", L["[ABBR] Normal"])
local hero = format("|cff0070dd%s|r", L["[ABBR] Heroic"])
local myth = format("|cffa335ee%s|r", L["[ABBR] Mythic"])
local lfr = format("|cffff8000%s|r", L["[ABBR] Looking for raid"])

V.combat = {}

V.item = {
    extendMerchantPages = {
        enable = false,
        numberOfPages = 2
    }
}

V.maps = {
    instanceDifficulty = {
        enable = false,
        hideBlizzard = true,
        align = "LEFT",
        font = {
            name = E.db.general.font,
            size = E.db.general.fontSize,
            style = "OUTLINE"
        },
        difficulty = {
            custom = false,
            customStrings = {
                ["PvP"] = format("|cffFFFF00%s|r", "PvP"),
                ["5-player Normal"] = "5" .. norm,
                ["5-player Heroic"] = "5" .. hero,
                ["10-player Normal"] = "10" .. norm,
                ["25-player Normal"] = "25" .. norm,
                ["10-player Heroic"] = "10" .. hero,
                ["25-player Heroic"] = "25" .. hero,
                ["LFR"] = lfr,
                ["Mythic Keystone"] = format("|cffff3860%s|r", L["[ABBR] Mythic Keystone"]) .. "%mplus%",
                ["40-player"] = "40",
                ["Normal Scenario"] = format("%s %s", norm, L["[ABBR] Scenario"]),
                ["Heroic Scenario"] = format("%s %s", hero, L["[ABBR] Scenario"]),
                ["Mythic Scenario"] = format("%s %s", myth, L["[ABBR] Scenario"]),
                ["Normal Raid"] = "%numPlayers%" .. norm,
                ["Heroic Raid"] = "%numPlayers%" .. hero,
                ["Mythic Raid"] = "%numPlayers%" .. myth,
                ["LFR Raid"] = "%numPlayers%" .. lfr,
                ["Event Scenario"] = L["[ABBR] Event Scenario"],
                ["Mythic Party"] = "5" .. myth,
                ["Timewalking"] = L["[ABBR] Timewalking"],
                ["World PvP Scenario"] = format("|cffFFFF00%s |r", "PvP"),
                ["PvEvP Scenario"] = "PvEvP",
                ["Timewalking Raid"] = L["[ABBR] Timewalking"],
                ["PvP Heroic"] = format("|cffFFFF00%s |r", "PvP"),
                ["Warfronts Normal"] = L["[ABBR] Warfronts"],
                ["Warfronts Heroic"] = format("|cffff7d0aH|r%s", L["[ABBR] Warfronts"]),
                ["Normal Scaling Party"] = L["[ABBR] Normal Scaling Party"],
                ["Visions of N'Zoth"] = L["[ABBR] Visions of N'Zoth"],
                ["Teeming Island"] = L["[ABBR] Teeming Island"],
                ["Torghast"] = L["[ABBR] Torghast"],
                ["Path of Ascension: Courage"] = L["[ABBR] Path of Ascension"],
                ["Path of Ascension: Loyalty"] = L["[ABBR] Path of Ascension"],
                ["Path of Ascension: Wisdom"] = L["[ABBR] Path of Ascension"],
                ["Path of Ascension: Humility"] = L["[ABBR] Path of Ascension"],
                ["World Boss"] = L["[ABBR] World Boss"],
                ["Challenge Level 1"] = L["[ABBR] Challenge Level 1"],
                ["Follower"] = L["[ABBR] Follower"],
                ["Delves"] = L["[ABBR] Delves"],
                ["Quest"] = L["[ABBR] Quest"],
                ["Story"] = L["[ABBR] Story"]
            }
        }
    },
    superTracker = {
        enable = true,
        noLimit = false,
        noUnit = true,
        autoTrackWaypoint = true,
        middleClickToClear = true,
        distanceText = {
            enable = true,
            name = E.db.general.font,
            size = E.db.general.fontSize + 2,
            style = "OUTLINE",
            color = {r = 1, g = 1, b = 1}
        },
        waypointParse = {
            enable = true,
            worldMapInput = true,
            command = true,
            virtualTomTom = true,
            commandKeys = {
                ["wtgo"] = true,
                ["goto"] = true
            }
        }
    },
    worldMap = {
        enable = true,
        reveal = {
            enable = true,
            useColor = false,
            color = {r = 1, g = 1, b = 1, a = 1}
        },
        scale = {
            enable = true,
            size = 1.24
        }
    },
    minimapButtons = {
        enable = true,
        mouseOver = false,
        buttonsPerRow = 6,
        buttonSize = 30,
        backdrop = true,
        backdropSpacing = 3,
        spacing = 2,
        inverseDirection = false,
        orientation = "HORIZONTAL",
        -- calendar = false,
        expansionLandingPage = false
    }
}

V.misc = {
    autoScreenshot = false,
    moveSpeed = false,
    noKanjiMath = false,
    pauseToSlash = true,
    skipCutScene = false,
    onlyStopWatched = true,
    tags = true,
    hotKeyAboveCD = false,
    guildNewsItemLevel = true,
    addCNFilter = false,
    autoToggleChatBubble = false,
    moveFrames = {
        enable = true,
        elvUIBags = true,
        tradeSkillMasterCompatible = true,
        rememberPositions = false,
        framePositions = {}
    },
    mute = {
        enable = false,
        mount = {
            [63796] = false,
            [229385] = false,
            [339588] = false,
            [312762] = false
        },
        other = {
            ["Crying"] = false,
            ["Tortollan"] = false,
            ["Smolderheart"] = false,
            ["Elegy of the Eternals"] = false,
            ["Dragon"] = false,
            ["Jewelcrafting"] = false
        }
    },
    lfgList = {
        enable = true,
        icon = {
            enable = true,
            hideDefaultClassCircle = true,
            leader = true,
            reskin = true,
            pack = "SQUARE",
            size = 16,
            border = false,
            alpha = 1
        },
        line = {
            enable = true,
            tex = "WindTools Glow",
            width = 16,
            height = 3,
            offsetX = 0,
            offsetY = -1,
            alpha = 1
        },
        additionalText = {
            enable = true,
            target = "DESC",
            shortenDescription = true,
            template = "{{score}} {{text}}"
        },
        partyKeystone = {
            enable = true,
            font = {
                name = E.db.general.font,
                size = 12,
                style = "OUTLINE"
            }
        },
        rightPanel = {
            enable = true,
            autoRefresh = true
        }
    }
}

V.quest = {
    objectiveTracker = {
        enable = true,
        noDash = true,
        colorfulProgress = true,
        percentage = false,
        colorfulPercentage = false,
        backdrop = {
            enable = false,
            transparent = true,
            topLeftOffsetX = 0,
            topLeftOffsetY = 0,
            bottomRightOffsetX = 0,
            bottomRightOffsetY = 0
        },
        header = {
            name = E.db.general.font,
            size = E.db.general.fontSize + 2,
            style = "OUTLINE",
            classColor = false,
            color = {r = 1, g = 1, b = 1},
            shortHeader = true
        },
        cosmeticBar = {
            enable = true,
            texture = "WindTools Glow",
            widthMode = "ABSOLUTE",
            heightMode = "ABSOLUTE",
            width = 250,
            height = 2,
            offsetX = 0,
            offsetY = -12,
            border = "SHADOW",
            borderAlpha = 1,
            color = {
                mode = "GRADIENT",
                normalColor = {r = 0.000, g = 0.659, b = 1.000, a = 1},
                gradientColor1 = {r = 0.32941, g = 0.52157, b = 0.93333, a = 1},
                gradientColor2 = {r = 0.25882, g = 0.84314, b = 0.86667, a = 1}
            }
        },
        title = {
            name = E.db.general.font,
            size = E.db.general.fontSize + 1,
            style = "OUTLINE"
        },
        info = {
            name = E.db.general.font,
            size = E.db.general.fontSize - 1,
            style = "OUTLINE"
        },
        titleColor = {
            enable = true,
            classColor = false,
            customColorNormal = {r = 0.000, g = 0.659, b = 1.000},
            customColorHighlight = {r = 0.282, g = 0.859, b = 0.984}
        },
        menuTitle = {
            enable = true,
            classColor = true,
            color = {r = 0.000, g = 0.659, b = 1.000},
            font = {
                name = E.db.general.font,
                size = E.db.general.fontSize,
                style = "OUTLINE"
            }
        }
    }
}

V.skins = {
    enable = true,
    windtools = true,
    removeParchment = true,
    merathilisUISkin = true,
    shadow = true,
    weakAurasShadow = true,
    increasedSize = 0,
    rollResult = {
        name = F.GetCompatibleFont("Accidental Presidency"),
        size = 13,
        style = "OUTLINE"
    },
    bigWigsSkin = {
        queueTimer = {
            smooth = true,
            spark = true,
            colorLeft = {r = 0.32941, g = 0.52157, b = 0.93333, a = 1},
            colorRight = {r = 0.25882, g = 0.84314, b = 0.86667, a = 1},
            countDown = {
                name = F.GetCompatibleFont("Montserrat"),
                size = 16,
                style = "OUTLINE",
                offsetX = 0,
                offsetY = -3
            }
        },
        normalBar = {
            smooth = true,
            spark = true,
            colorOverride = true,
            colorLeft = {r = 0.32941, g = 0.52157, b = 0.93333, a = 1},
            colorRight = {r = 0.25882, g = 0.84314, b = 0.86667, a = 1}
        },
        emphasizedBar = {
            smooth = true,
            spark = true,
            colorOverride = true,
            colorLeft = {r = 0.92549, g = 0.00000, b = 0.54902, a = 1},
            colorRight = {r = 0.98824, g = 0.40392, b = 0.40392, a = 1}
        }
    },
    color = {
        r = 0,
        g = 0,
        b = 0
    },
    ime = {
        label = {
            name = F.GetCompatibleFont("Montserrat"),
            size = 14,
            style = "OUTLINE"
        },
        candidate = {
            name = E.db.general.font,
            size = E.db.general.fontSize,
            style = "OUTLINE"
        }
    },
    actionStatus = {
        name = E.db.general.font,
        size = 15,
        style = "OUTLINE"
    },
    widgets = {
        button = {
            enable = true,
            backdrop = {
                enable = true,
                texture = "WindTools Glow",
                classColor = false,
                color = {r = 0.145, g = 0.353, b = 0.698},
                alpha = 1,
                animationType = "FADE",
                animationDuration = 0.2,
                removeBorderEffect = true
            },
            selected = {
                enable = true,
                backdropClassColor = false,
                backdropColor = {r = 0.322, g = 0.608, b = 0.961},
                backdropAlpha = 0.4,
                borderClassColor = false,
                borderColor = {r = 0.145, g = 0.353, b = 0.698},
                borderAlpha = 1
            },
            text = {
                enable = true,
                font = {
                    name = E.db.general.font,
                    style = "OUTLINE"
                }
            }
        },
        tab = {
            enable = true,
            backdrop = {
                enable = true,
                texture = "WindTools Glow",
                classColor = false,
                color = {r = 0.145, g = 0.353, b = 0.698},
                alpha = 1,
                animationType = "FADE",
                animationDuration = 0.2
            },
            selected = {
                enable = true,
                texture = "WindTools Glow",
                backdropClassColor = false,
                backdropColor = {r = 0.322, g = 0.608, b = 0.961},
                backdropAlpha = 0.4,
                borderClassColor = false,
                borderColor = {r = 0.145, g = 0.353, b = 0.698},
                borderAlpha = 1
            },
            text = {
                enable = true,
                normalClassColor = false,
                normalColor = {r = 1, g = 0.82, b = 0},
                selectedClassColor = false,
                selectedColor = {r = 1, g = 1, b = 1},
                font = {
                    name = E.db.general.font,
                    style = "OUTLINE"
                }
            }
        },
        checkBox = {
            enable = true,
            texture = "WindTools Glow",
            classColor = false,
            color = {r = 0.322, g = 0.608, b = 0.961, a = 0.8}
        },
        slider = {
            enable = true,
            texture = "WindTools Glow",
            classColor = false,
            color = {r = 0.322, g = 0.608, b = 0.961, a = 0.8}
        },
        treeGroupButton = {
            enable = true,
            backdrop = {
                enable = true,
                texture = "WindTools Glow",
                classColor = false,
                color = {r = 0.145, g = 0.353, b = 0.698},
                alpha = 1,
                animationType = "FADE",
                animationDuration = 0.2,
                removeBorderEffect = true
            },
            selected = {
                enable = true,
                texture = "WindTools Glow",
                backdropClassColor = false,
                backdropColor = {r = 0.322, g = 0.608, b = 0.961},
                backdropAlpha = 0.4,
                borderClassColor = false,
                borderColor = {r = 0.145, g = 0.353, b = 0.698},
                borderAlpha = 0
            },
            text = {
                enable = true,
                normalClassColor = false,
                normalColor = {r = 1, g = 0.82, b = 0},
                selectedClassColor = false,
                selectedColor = {r = 1, g = 1, b = 1},
                font = {
                    name = E.db.general.font,
                    style = "OUTLINE"
                }
            }
        }
    },
    addons = {
        ace3 = true,
        ace3DropdownBackdrop = true,
        adiBags = true,
        angryKeystones = true,
        auctionator = true,
        bigWigs = true,
        bigWigsQueueTimer = true,
        bugSack = true,
        hekili = true,
        immersion = true,
        myslot = true,
        mythicDungeonTools = true,
        omniCD = true,
        omniCDIcon = true,
        omniCDStatusBar = true,
        postal = true,
        premadeGroupsFilter = true,
        raiderIO = true,
        rareScanner = true,
        rematch = true,
        simpleAddonManager = true,
        simulationcraft = true,
        tinyInspect = true,
        tldrMissions = true,
        tomCats = true,
        warpDeplete = true,
        weakAuras = true,
        weakAurasOptions = true
    },
    blizzard = {
        enable = true,
        achievements = true,
        addonManager = true,
        adventureMap = true,
        alerts = true,
        animaDiversion = true,
        artifact = true,
        auctionHouse = true,
        azerite = true,
        azeriteEssence = true,
        azeriteRespec = true,
        bags = true,
        barberShop = true,
        binding = true,
        blackMarket = true,
        calendar = true,
        challenges = true,
        channels = true,
        character = true,
        chromieTime = true,
        classTalent = true,
        clickBinding = true,
        collections = true,
        communities = true,
        covenantPreview = true,
        covenantRenown = true,
        covenantSanctum = true,
        debugTools = true,
        dressingRoom = true,
        editModeManager = true,
        encounterJournal = true,
        eventTrace = true,
        expansionLandingPage = true,
        flightMap = true,
        friends = true,
        garrison = true,
        genericTraits = true,
        gossip = true,
        guild = true,
        guildBank = true,
        help = true,
        inputMethodEditor = true,
        inspect = true,
        itemInteraction = true,
        itemSocketing = true,
        itemUpgrade = true,
        lookingForGroup = true,
        loot = true,
        lossOfControl = true,
        macro = true,
        mail = true,
        majorFactions = true,
        merchant = true,
        microButtons = true,
        mirrorTimers = true,
        misc = true,
        objectiveTracker = true,
        orderHall = true,
        perksProgram = true,
        petBattle = true,
        playerChoice = true,
        playerSpells = true,
        professions = true,
        professionBook = true,
        professionsCustomerOrders = true,
        quest = true,
        raidInfo = true,
        scenario = true,
        scrappingMachine = true,
        settingsPanel = true,
        soulbinds = true,
        stable = true,
        staticPopup = true,
        subscriptionInterstitial = true,
        talkingHead = true,
        taxi = true,
        ticketStatus = true,
        timeManager = true,
        tooltips = true,
        trade = true,
        trainer = true,
        tutorial = true,
        warboard = true,
        weeklyRewards = true,
        worldMap = true
    },
    elvui = {
        enable = true,
        actionBarsBackdrop = true,
        actionBarsButton = true,
        afk = true,
        altPowerBar = true,
        auras = true,
        bags = true,
        castBars = true,
        chatCopyFrame = true,
        chatDataPanels = true,
        chatPanels = true,
        chatVoicePanel = true,
        classBars = true,
        dataBars = true,
        dataPanels = true,
        lootRoll = true,
        miniMap = true,
        option = true,
        panels = true,
        raidUtility = true,
        staticPopup = true,
        statusReport = true,
        totemTracker = true,
        unitFrames = true
    }
}

V.tooltips = {
    modifier = "SHIFT",
    icon = true,
    factionIcon = true,
    petIcon = true,
    petId = true,
    tierSet = true,
    objectiveProgress = true,
    objectiveProgressAccuracy = 1,
    progression = {
        enable = true,
        header = "TEXTURE",
        raids = {
            enable = true,
            ["Vault of the Incarnates"] = false,
            ["Aberrus, the Shadowed Crucible"] = true,
            ["Amirdrassil, the Dream's Hope"] = true
        },
        special = {
            enable = true,
            ["Dragonflight Keystone Master: Season One"] = false,
            ["Dragonflight Keystone Hero: Season One"] = false,
            ["Dragonflight Keystone Master: Season Two"] = false,
            ["Dragonflight Keystone Hero: Season Two"] = false,
            ["Dragonflight Keystone Master: Season Three"] = true,
            ["Dragonflight Keystone Hero: Season Three"] = true,
            ["Dragonflight Keystone Master: Season Four"] = true,
            ["Dragonflight Keystone Hero: Season Four"] = true
        },
        mythicDungeons = {
            enable = true,
            markHighestScore = true,
            showNoRecord = true,
            ["Ruby Life Pools"] = true,
            ["The Nokhud Offensive"] = true,
            ["The Azure Vault"] = true,
            ["Algeth'ar Academy"] = true,
            ["Uldaman: Legacy of Tyr"] = true,
            ["Neltharus"] = true,
            ["Brackenhide Hollow"] = true,
            ["Halls of Infusion"] = true
        }
    }
}

V.social = {
    smartTab = {
        whisperTargets = {}
    }
}

V.unitFrames = {
    quickFocus = {
        enable = false,
        modifier = "shift",
        button = "BUTTON1"
    },
    roleIcon = {
        enable = true,
        roleIconStyle = "SUNUI"
    }
}
