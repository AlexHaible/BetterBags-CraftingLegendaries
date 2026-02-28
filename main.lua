-- Variables --
---@class BetterBags: AceAddon
local BetterBags = LibStub('AceAddon-3.0'):GetAddon("BetterBags")
assert(BetterBags, "BetterBags - Crafting Legendaries requires BetterBags")

---@class Categories: AceModule
local categories = BetterBags:GetModule('Categories')

---@class Localization: AceModule
local L = BetterBags:GetModule('Localization')

---@class CraftingLegendaries: AceModule
local CraftingLegendaries = BetterBags:NewModule('CraftingLegendaries')

-- Make a table of tables to store legendary items in.
local legendary = {
    atiesh = {
        22589, -- Atiesh, Greatstaff of the Guardian (Mage)
        22630, -- Atiesh, Greatstaff of the Guardian (Warlock)
        22631, -- Atiesh, Greatstaff of the Guardian (Priest)
        22632, -- Atiesh, Greatstaff of the Guardian (Druid)
        22726, -- Splinter of Atiesh
        22727, -- Frame of Atiesh
        22733, -- Staff Head of Atiesh
        22734, -- Base of Atiesh
        22737, -- Atiesh, Greatstaff of the Guardian (Quest)
    },
    sulfuras = {
        17182, -- Sulfuras, Hand of Ragnaros
        17193, -- Sulfuron Hammer
        17203, -- Sulfuron Ingot
        17204, -- Eye of Sulfuras
    },
    thunderfury = {
        17771, -- Enchanted Elementium Bar
        18562, -- Elementium Ingot
        18563, -- Bindings of the Windseeker (Left)
        18564, -- Bindings of the Windseeker (Right)
        19017, -- Essence of the Firelord
        19019, -- Thunderfury, Blessed Blade of the Windseeker
    },
    warglaives = {
        32837, -- Warglaive of Azzinoth
        32838, -- Warglaive of Azzinoth
    },
    thoridal = {
        34334, -- Thori'dal, the Stars' Fury
    },
    valanyr = {
        45038, -- Fragment of Val'anyr
        45039, -- Shattered Fragments of Val'anyr
        45896, -- Unbound Fragments of Val'anyr
        46017, -- Val'anyr, Hammer of Ancient Kings
    },
    shadowmourne = {
        49623, -- Shadowmourne
        49888, -- Shadow's Edge
        49869, -- Light's Vengeance
        50226, -- Festergut's Acidic Blood
        50231, -- Rotface's Acidic Blood
        50274, -- Shadowfrost Shard
    },
    dragonwrath = {
        69646, -- Branch of Nordrassil (Quest)
        69815, -- Seething Cinder
        69848, -- Heart of Flame
        70994, -- Pyreshell Fragment
        70995, -- Dull Pyreshell Focus
        70996, -- Dull Rhyolite Focus
        70997, -- Rhyolite Fragment
        70998, -- Dull Chitinous Focus
        70999, -- Obsidian-Flecked Chitin Fragment
        71000, -- Emberstone Fragment
        71001, -- Dull Emberstone Focus
        71008, -- Charged Rhyolite Focus
        71015, -- Charged Emberstone Focus
        71016, -- Charged Pyreshell Focus
        71017, -- Charged Chitinous Focus
        71084, -- Branch of Nordrassil (Staff 1)
        71085, -- Branch of Nordrassil (Staff 2)
        71086, -- Dragonwrath, Tarecgosa's Rest
        71141, -- Eternal Ember
    },
    fangs = {
        74246, -- Cryptomancer's Decoder Ring
        74748, -- Charged Decoder Ring
        74750, -- Singed Cipher
        77945, -- Fear
        77946, -- Vengeance
        77947, -- The Sleeper
        77948, -- The Dreamer
        77949, -- Golad, Twilight of Aspects
        77950, -- Tiriosh, Nightmare of Ages
        77951, -- Shadowy Gem
        77952, -- Elementium Gem Cluster
    },
    ashjrakamas = {
        169223, -- Ashjra'kamas, Shroud of Resolve
        171335, -- Corrupting Core
        174777, -- The Curse of Stone
        171353, -- Torn Page of 'The Curse of Stone'
        171354, -- Horrific Core
        174782, -- Fear and Flesh
        174783, -- Torn Page of 'Fear and Flesh'
        174784, -- The Final Truth
        174785, -- Torn Page of 'The Final Truth'
        171355, -- Voidborn Core
        175062, -- Malefic Core
    },
    raeshalare = {
        186414, -- Rae'shalare, Death's Whisper
    },
    naszuro = {
        204177, -- Nasz'uro, Bond of the Tormented
        204255, -- Cracked Titan Gem
        205257, -- Temporal Vestigial
        204832, -- Reclaimed Gauntlet Chassis
        204854, -- Immaculate Coalescing Dracothyst
        204856, -- Inspired Order Recalibrator
        204857, -- Ancient Elementium Fragment
        205260, -- Fleeting Glowspores
        205258, -- Everburning Shadowflame
    },
    fyralath = {
        206448, -- Fyr'alath, the Dreamrender (Complete)
        207728, -- Fyr'alath, the Dreamrender (Incomplete)
        208577, -- Symbiotic Glowspore Grip
        208593, -- Shadowed Dreamleaf
        209351, -- Erden's Dreamleaf Grip
        210009, -- Prototype Dreamleaf Grip
        208578, -- Concentrated Sophic Vellum
        208581, -- Radiant Fleck of Ash
        210001, -- Prototype Order Vellum
        210003, -- Shalasar's Sophic Vellum
        208592, -- Rune of Shadowbinding
        208595, -- Taut Tethercoil
        209352, -- Prototype Binding Rune
        209998, -- Lydiara's Binding Rune
    },
    mists = {
        102245, -- Qian-Le, Courage of Niuzao
        102246, -- Xing-Ho, Breath of Yu'lon
        102247, -- Jina-Kang, Kindness of Chi-Ji
        102248, -- Fen-Yu, Fury of Xuen
        102249, -- Gong-Lu, Strength of Xuen
        102250, -- Qian-Ying, Fortitude of Niuzao
    },
    wod = {
        114780, -- Pure Solium Band
        118290, -- Solium Band of Might
        118291, -- Solium Band of Wisdom
        118292, -- Solium Band of Dexterity
        118293, -- Solium Band of Endurance
        118294, -- Solium Band of Mending
        113682, -- Core of Flame
        114107, -- Core of Iron
        114138, -- Core of Life
        114240, -- Corrupted Blood of Teron'gor
        115280, -- Abrogator Stone
        115288, -- Felbreaker's Tome
        115289, -- Sigil of the Sorcerer King
        115479, -- Heart of the Fury
        115493, -- Flamebender's Tome
        115494, -- Draenic Thaumaturgical Orb
        115509, -- Elemental Tablet
        115510, -- Elemental Rune
        115523, -- Blackhand's Severed Arm
        115981, -- Abrogator Stone Cluster
        118295, -- Timeless Solium Band of Brutality
        118296, -- Timeless Solium Band of the Archmage
        118297, -- Timeless Solium Band of the Assassin
        118298, -- Timeless Solium Band of the Bulwark
        118299, -- Timeless Solium Band of Lifegiving
        118300, -- Spellbound Solium Band of Sorcerous Strength
        118301, -- Spellbound Solium Band of the Kirin-Tor
        118302, -- Spellbound Solium Band of Fatal Strikes
        118303, -- Spellbound Solium Band of Sorcerous Invincibility
        118304, -- Spellbound Solium Band of the Immortal Spirit
        118305, -- Spellbound Runic Band of Elemental Power
        118306, -- Spellbound Runic Band of the All-Seeing Eye
        118307, -- Spellbound Runic Band of Unrelenting Slaughter
        118308, -- Spellbound Runic Band of Elemental Invincibility
        118309, -- Spellbound Runic Band of Infinite Preservation
        122155, -- Orb of Dominion
        124634, -- Thorasus, the Stone Heart of Draenor
        124635, -- Nithramus, the All-Seer
        124636, -- Maalus, the Blood Drinker
        124637, -- Sanctus, Sigil of the Unbroken
        124638, -- Etheralus, the Eternal Reward
        127115, -- Tome of Chaos
        127785, -- Crystallized Fel
        128693, -- Draenic Sea Chart
    },
    legion = {
        132452, -- Sephuz's Secret
        132444, -- Prydaz, Xavaric's Magnum Opus
        151801, -- Behemoth Headdress
        151644, -- Soul of the Highlord
        132443, -- Aggramar's Stride
        144258, -- Velen's Future Sight
        144361, -- Butcher's Bone Apron
        144385, -- Wakener's Loyalty
        144303, -- MKII Gyroscopic Stabilizer
        151821, -- The Master Harvester
        132374, -- Kazzak's Final Curse
        137038, -- Anger of the Half-Giants
        132375, -- Odr, Shawl of the Ymirjar
        137033, -- Ullr's Feather Snowshoes
        151802, -- Fury of Nature
        151800, -- Radiant Moonlight
        137382, -- The Apex Predator's Claw
        132410, -- Shard of the Exodar
        133977, -- Belo'vir's Final Stand
        132379, -- Sin'dorei Spite
        137042, -- Tearstone of Elune
        137072, -- Aman'Thul's Wisdom
        141321, -- Shivarran Symmetry
        137047, -- Heathcliff's Immortality
        132407, -- Magistrike Restraints
        133974, -- Lana'thel's Lament
        137094, -- The Wildshaper's Clutch
        154172, -- Aman'Thul's Vision
        146669, -- The Sentinel's Eternal Refuge
        137061, -- Raddon's Cascading Eyes
        146666, -- Celumbra, the Night's Dichotomy
        146667, -- Rethu's Incessant Courage
        151824, -- Valarjar Berserkers
        137064, -- The Shadow Hunter's Voodoo Mask
        143728, -- Timeless Stratagem
        143732, -- Uncertain Reminder
        137088, -- Ceann-Ar Charger
        137109, -- X'anshi, Shroud of Archbishop Benedictus
        144369, -- Lessons of Space-Time
        132409, -- Anund's Seared Shackles
        137015, -- Ekowraith, Creator of Worlds
        151636, -- Soul of the Archdruid
        137076, -- Obsidian Stone Spaulders
        144259, -- Kil'jaeden's Burning Wish
        144279, -- Delusions of Grandeur
        144358, -- Ashes to Dust
        151814, -- Heart of the Void
        137020, -- Whisper of the Nathrezim
        151812, -- Pillars of Inmost Light
        137084, -- Akainu's Absolute Justice
        137098, -- Zoldyck Family Training Shackles
        140846, -- Aegisjalmur, the Armguards of Awe
        151650, -- Soul of the Battlelord
        137108, -- Kakushan's Stormscale Gauntlets
        146668, -- Vigilance Perch
        151811, -- The Wind Blows
        132863, -- Darckli's Dragonfire Diadem
        151823, -- The Great Storm's Eye
        137062, -- The Emerald Dreamcatcher
        152626, -- Insignia of the Grand Army
        132436, -- Skjoldr, Sanctuary of Ivagont
        144281, -- Skullflower's Haemostasis
        132376, -- Acherus Drapes
        137017, -- Breastplate of the Golden Val'kyr
        137039, -- Impeccable Fel Essence
        141353, -- Magnetized Blasting Cap Launcher
        133800, -- Cord of Maiev, Priestess of the Moon
        133973, -- The Twins' Painful Touch
        137059, -- Tyr's Hand of Faith
        137107, -- Mannoroth's Bloodletting Manacles
        144280, -- Death March
        151641, -- Soul of the Huntmaster
        132406, -- Marquee Bindings of the Sun King
        132454, -- Koralon's Burning Touch
        132455, -- Norgannon's Foresight
        137065, -- Justice Gaze
        137066, -- Cloak of Fel Flames
        137069, -- Will of Valeera
        137105, -- Uther's Guard
        144326, -- The Mantle of Command
        132411, -- Lady Vashj's Grasp
        137052, -- Ayala's Stone Heart
        137056, -- Luffa Wrappings
        137083, -- Pristine Proto-Scale Girdle
        144244, -- Kam Xi'raff
        144249, -- Archimonde's Hatred Reborn
        151784, -- Doorway to Nowhere
        151817, -- The Curse of Restlessness
        132449, -- Phyrix's Embrace
        132466, -- Roots of Shaladrassil
        133976, -- Cinidaria, the Symbiote
        137092, -- Oneth's Intuition
        137100, -- Denial of the Half-Giants
        132413, -- Rhonin's Assaulting Armwraps
        137014, -- Achor, the Eternal Hunger
        137074, -- Echoes of the Great Sundering
        151639, -- Soul of the Slayer
        151798, -- Chaos Theory
        132453, -- Rattlegore Bone Legplates
        137026, -- Essence of Infusion
        137045, -- Eye of Collidus the Warp-Watcher
        144355, -- Pyrotex Ignition Cloth
        144438, -- Zeks Exterminatus
        132437, -- Mother Shahraz's Seduction
        151783, -- Chameleon Song
        151795, -- Soulflayer's Corruption
        132394, -- Hood of Eternal Disdain
        132459, -- Perseverance of the Ebon Martyr
        133971, -- Zenk'aram, Iridi's Anadem
        137031, -- Thraxi's Tricksy Treads
        137037, -- Uvanimor, the Unbeautiful
        137051, -- Focuser of Jonat, the Elder
        137060, -- Archavon's Heavy Hand
        137089, -- Thundergod's Vigor
        138140, -- Magtheridon's Banished Bracers
        151782, -- The Topless Tower
        132445, -- Al'maiesh, the Cord of Hope
        132861, -- Estel, Dejahna's Inspiration
        137050, -- Eye of the Twisting Nether
        137090, -- Mo'arg Bionic Stabilizers
        137101, -- Call of the Wild
        151649, -- Soul of the Netherlord
        151796, -- Cold Heart
        151809, -- Contained Infernal Core
        151813, -- Scarlet Inquisitor's Expurgation
        132357, -- Pillars of the Dark Portal
        132448, -- The Instructor's Fourth Lesson
        137024, -- Ailuro Pouncers
        137036, -- Elemental Rebalancers
        137048, -- Liadrin's Fury Unleashed
        137095, -- Edraith, Bonds of Aglaya
        137097, -- Drinking Horn Cover
        151803, -- Celerity of the Windrunners
        144274, -- Gravity Spiral
        144295, -- Lady and the Child
        151788, -- Stormstout's Last Gasp
        132378, -- Sacrolash's Dark Strike
        132441, -- Draugr, Girdle of the Everlasting King
        132456, -- Feretory of Souls
        137019, -- Cenedril, Reflector of Hatred
        137041, -- Dual Determination
        137057, -- Hidden Master's Forbidden Touch
        137053, -- Tak'theritrix's Shoulderpads
        137082, -- Weight of the Earth
        137086, -- War Belt of the Sentinel Army
        137104, -- The Defiler's Lost Vambraces
        144236, -- March of the Legion
        151646, -- Kirel Narak
        151808, -- The Empty Crown
        151822, -- The First of the Dead
        132366, -- Recurrent Ritual
        132381, -- Promise of Elune, the Moon Goddess
        132458, -- Ei'thas, Lunar Glides of Eramas
        137018, -- Unison Spaulders
        137068, -- Emalon's Charged Core
        137087, -- Ice Time
        137223, -- Soul of the Archmage
        138879, -- The Alabaster Lady
        144275, -- Parsel's Tongue
        144292, -- Power Cord of Lethtendris
        151786, -- The Dreadlord's Deceit
        151799, -- Firestone Walkers
        132450, -- Kazzalax, Fujieda's Fury
        137025, -- Helbrine, Rope of the Mist Marauder
        137032, -- Chain of Thrayn
        137044, -- Nobundo's Redemption
        137054, -- Mantle of the Master Assassin
        137078, -- Soul of the High Priest
        137102, -- Mantle of the First Kirin Tor
        144239, -- Ararat's Bloodmirror
        144242, -- Koltira's Newfound Will
        144364, -- Streten's Sleepless Shackles
        144432, -- Toravon's Whiteout Bindings
        151819, -- Destiny Driver
        132460, -- Leggings of The Black Flame
        137055, -- Naj'entus's Vertebrae
        137058, -- Seal of Necrofantasia
        137067, -- Ovyd's Winter Wrap
        137080, -- Saruan's Resolve
        151640, -- Spirit of the Darkness Flame
        151785, -- Inner Hallation
        132447, -- Oblivion's Embrace
        132451, -- Muze's Unwavering Will
        132461, -- Skysec's Hold
        137022, -- Shadow Satyr's Walk
        137029, -- Jewel of the Lost Abbey
        137030, -- The Walls Fell
        137035, -- The Dark Titan's Advice
        137046, -- Al'Akir's Acrimony
        137085, -- The Emperor's Capacitor
        137099, -- X'oni's Caress
        137276, -- Reap and Sow
        144293, -- Oakheart's Puny Quods
        132365, -- Smoldering Heart
        132864, -- Alythess's Pyrogenics
        137049, -- Zevrim's Hunger
        144247, -- Praetorian's Tidecallers
        144277, -- Elize's Everlasting Encasement
        144340, -- Roar of the Seven Lions
        144354, -- Soul of the Deathlord
        151810, -- Fire in the Deep
        133970, -- Entrancing Trousers of An'juna
        137040, -- Mystic Kilt of the Rune Master
        137070, -- Xalan the Feared's Clench
        137079, -- Loramus Thalipedes' Sacrifice
        151647, -- Katsuo's Eclipse
        132367, -- Duskwalker's Footpads
        132442, -- The Deceiver's Blood Pact
        137063, -- Ilterendi, Crown Jewel of Silvermoon
        137096, -- Intact Nazjatar Molting
        132369, -- Greenskin's Waterlogged Wristcuffs
        137016, -- N'ero, Band of Promises
        137227, -- Consort's Cold Core
        138117, -- Shackles of Bryndaor
        150936, -- Mangaza's Madness
        151643, -- Insignia of Ravenholdt
        151807, -- Rammal's Ulterior Motive
        137034, -- Anvil-Hardened Wristwraps
        137043, -- Shelter of Rin
        137071, -- Fiery Red Maimers
        137103, -- Shattered Fragments of Sindragosa
        144273, -- Zann'esu Journey
        138854, -- Chatoyant Signet
        132452, -- Tyelca, Ferren Marcus's Stature
        132444, -- Gai Plin's Soothing Sash
        151801, -- Soul of the Farseer
        151644, -- Service of Gorefiend
        132443, -- Cord of Infinity
        144258, -- Fundamental Observation
        144361, -- Petrichor Lagniappe
        144385, -- Wilfred's Sigil of Superior Summoning
        144303, -- Sal'salabim's Lost Tunic
        151821, -- Qa'pla, Eredun War Order
        132374, -- Spiritual Journey
        137038, -- Soul of the Shadowblade
        132375, -- Soul of the Grandmaster
        137033, -- Unseen Predator's Cloak
        151802, -- Nesingwary's Trapping Treads
        151800, -- Frizzo's Fingertrap
        137382, -- Runemaster's Pauldrons
        132410, -- Storm Tempests
        133977, -- Maraad's Dying Breath
        132379, -- Fragment of the Betrayer's Prison
    },
    runecrafted = {
        190464, -- Cinch of Unity (Mage)
        190465, -- Cinch of Unity (Druid)
        190466, -- Cinch of Unity (Hunter)
        190467, -- Cinch of Unity (Death Knight)
        190468, -- Cinch of Unity (Priest)
        190469, -- Cinch of Unity (Warlock)
        190470, -- Cinch of Unity (Demon Hunter)
        190471, -- Cinch of Unity (Rogue)
        190472, -- Cinch of Unity (Monk)
        190473, -- Cinch of Unity (Shaman)
        190474, -- Cinch of Unity (Paladin)
        190475, -- Cinch of Unity (Warrior)
        178927, -- Shadowghast Necklace
        178926, -- Shadowghast Ring
        171417, -- Shadowghast Pauldrons
        171418, -- Shadowghast Waistguard
        171412, -- Shadowghast Breastplate
        171415, -- Shadowghast Helm
        171413, -- Shadowghast Sabatons
        171419, -- Shadowghast Armguards
        171416, -- Shadowghast Greaves
        171414, -- Shadowghast Gauntlets
        173241, -- Grim-Veiled Robe
        173245, -- Grim-Veiled Hood
        173242, -- Grim-Veiled Cape
        173248, -- Grim-Veiled Belt
        173247, -- Grim-Veiled Spaulders
        173243, -- Grim-Veiled Sandals
        173244, -- Grim-Veiled Mittens
        173249, -- Grim-Veiled Bracers
        173246, -- Grim-Veiled Pants
        172317, -- Umbrahide Helm
        172321, -- Umbrahide Armguards
        172319, -- Umbrahide Pauldrons
        172314, -- Umbrahide Vest
        172315, -- Umbrahide Treads
        172316, -- Umbrahide Gauntlets
        172318, -- Umbrahide Leggings
        172320, -- Umbrahide Waistguard
        172322, -- Boneshatter Vest
        172327, -- Boneshatter Pauldrons
        172326, -- Boneshatter Greaves
        172325, -- Boneshatter Helm
        172323, -- Boneshatter Treads
        172329, -- Boneshatter Armguards
        172328, -- Boneshatter Waistguard
        172324, -- Boneshatter Gauntlets
    },
    memories = {
        183243, -- Memory of the Arbiter's Judgment
        183284, -- Memory of Escaping from Reality
        183325, -- Memory of Archbishop Benedictus
        183244, -- Memory of the Rattle of the Maw
        183349, -- Memory of the Deeptremor Stone
        190590, -- Memory of Unity
        183353, -- Memory of the Windspeaker's Lava Resurgence
        183264, -- Memory of the Rylakstalker's Strikes
        183305, -- Memory of the Shock Barrier
        183223, -- Memory of the Circle of Life and Death
        183375, -- Memory of the Diabolic Raiment
        183226, -- Memory of the Balance of All Things
        190584, -- Memory of Unity
        183263, -- Memory of Poisonous Injectors
        183342, -- Memory of Akaari's Soul Fragment
        182636, -- Memory of the Deadliest Coil
        183253, -- Memory of the Soulforge Embers
        183293, -- Memory of the Morning's Tear
        183330, -- Memory of Bloodfang's Essence
        183393, -- Memory of an Unbreakable Will
        187231, -- Memory of the Fragments of the Elder Antlers
        183239, -- Memory of an Unending Growth
        183380, -- Memory of a Seismic Reverberation
        186687, -- Memory of Celestial Spirits
        183221, -- Memory of the Dark Flame Spirit
        183249, -- Memory of a Vital Sacrifice
        183296, -- Memory of the Last Emperor
        183339, -- Memory of a Concealed Blunderbuss
        183356, -- Memory of the Primal Lava Actuators
        183364, -- Memory of Sacrolash's Dark Strike
        186712, -- Memory of the Deathspike
        187223, -- Memory of the Seeds of Rampant Growth
        182638, -- Memory of a Frenzied Monstrosity
        183262, -- Memory of the Butcher's Bone Fragments
        183390, -- Memory of a Reprisal
        183242, -- Memory of Eonar
        183302, -- Memory of the Sunwell's Bloom
        183316, -- Memory of the Twins of the Sun Priestess
        183331, -- Memory of Invigorating Shadowdust
        186568, -- Memory of an Abomination's Frenzy
        182634, -- Memory of a Frozen Champion's Rage
        183285, -- Memory of the Swiftsure Wraps
        183306, -- Memory of the Righteous Bulwark
        183346, -- Memory of an Ancestral Reminder
        183357, -- Memory of the Witch Doctor
        183360, -- Memory of the Primal Tide Core
        182630, -- Memory of Gorefiend's Domination
        183236, -- Memory of Ursoc
        183240, -- Memory of the Mother Tree
        183248, -- Memory of Jailer's Eye
        183328, -- Memory of Talbadar
        186570, -- Memory of Glory
        190596, -- Memory of Unity
        183215, -- Memory of an Erratic Fel Core
        183218, -- Memory of a Fortified Fel Flame
        183241, -- Memory of the Dark Titan
        183280, -- Memory of Fragments of Ice
        183310, -- Memory of the Vanguard's Momentum
        183369, -- Memory of Wilfred's Sigil of Superior Summoning
        186591, -- Memory of the Harmonic Echo
        187127, -- Memory of Radiant Embers
        183267, -- Memory of an Expanded Potential
        183299, -- Memory of the Sun's Cycles
        183320, -- Memory of the Kiss of Death
        183340, -- Memory of Greenskin
        183362, -- Memory of a Malefic Wrath
        182617, -- Memory of Death's Embrace
        182632, -- Memory of Absolute Zero
        183237, -- Memory of the Sleeper
        183291, -- Memory of Yu'lon
        183313, -- Memory of the Lightbringer's Tempest
        183359, -- Memory of Jonat
        183383, -- Memory of an Enduring Blow
        183389, -- Memory of the Berserker's Will
        186565, -- Memory of Rampant Transference
        190587, -- Memory of Unity
        190589, -- Memory of Unity
        182627, -- Memory of Superstrain
        183229, -- Memory of a Timeworn Dreambinder
        183270, -- Memory of an Arcane Bombardment
        183281, -- Memory of Slick Ice
        183283, -- Memory of the Invoker
        183289, -- Memory of Stormstout
        183312, -- Memory of a Relentless Inquisitor
        183318, -- Memory of a Clear Mind
        183334, -- Memory of the Dashing Scoundrel
        183344, -- Memory of Finality
        183347, -- Memory of Devastating Chains
        183348, -- Memory of Deeply Rooted Elements
        183352, -- Memory of the Demise of Skybreaker
        183358, -- Memory of an Earthen Harmony
        183372, -- Memory of the Grim Inquisitor
        183376, -- Memory of Azj'Aqir's Madness
        183382, -- Memory of a Battlelord
        187280, -- Memory of the Fae Heart
        190588, -- Memory of Unity
        182629, -- Memory of the Crimson Runes
        183216, -- Memory of a Burning Wound
        183220, -- Memory of Razelikh's Defilement
        183238, -- Memory of the Verdant Infusion
        183245, -- Memory of Norgannon
        183258, -- Memory of Eagletalon's True Focus
        183259, -- Memory of the Unblinking Vigil
        183261, -- Memory of Surging Shots
        183275, -- Memory of the Firestorm
        183277, -- Memory of the Sun King
        183278, -- Memory of the Cold Front
        183287, -- Memory of Charred Passions
        183300, -- Memory of the Magistrate's Judgment
        183315, -- Memory of Measured Contemplation
        183370, -- Memory of the Core of the Balespider
        183384, -- Memory of the Exploiter
        186566, -- Memory of the Final Sentence
        186609, -- Memory of Sinful Indulgence
        186621, -- Memory of Death's Fathom
        187217, -- Memory of the Bountiful Brew
        187226, -- Memory of the Shards of Annihilation
        190595, -- Memory of Unity
        183222, -- Memory of the Elder Druid
        183246, -- Memory of Sephuz
        183309, -- Memory of the Ardent Protector
        183324, -- Memory of a Harmonious Apparatus
        183367, -- Memory of Demonic Synergy
        183378, -- Memory of the Leaper
        187118, -- Memory of the Demonic Oath
        187163, -- Memory of the Spheres' Harmony
        187228, -- Memory of the Contained Perpetual Explosion
        187229, -- Memory of the Pact of the Soulstalkers
        187258, -- Memory of the Faeline Harmony
        187259, -- Memory of the Raging Vesper Vortex
        182640, -- Memory of a Reanimated Shambler
        183214, -- Memory of the Chaos Theory
        183225, -- Memory of Lycara
        183227, -- Memory of Oneth
        183232, -- Memory of a Symmetrical Eye
        183235, -- Memory of the Natural Order
        183256, -- Memory of the Eredun War Order
        183273, -- Memory of a Temporal Warp
        183286, -- Memory of Shaohao
        183288, -- Memory of a Celestial Infusion
        183298, -- Memory of the Mad Paragon
        183304, -- Memory of the Shadowbreaker
        183308, -- Memory of the Endless Kings
        183311, -- Memory of the Final Verdict
        183322, -- Memory of a Divine Image
        183329, -- Memory of a Prism of Shadow and Fire
        183333, -- Memory of Tiny Toxic Blade
        183343, -- Memory of the Deathly Shadows
        183373, -- Memory of an Implosive Potential
        183374, -- Memory of Azj'Aqir's Cinders
        183388, -- Memory of a Reckless Defense
        183391, -- Memory of the Wall
        186567, -- Memory of Insatiable Hunger
        186676, -- Memory of the Toxic Onslaught
        186710, -- Memory of the Obedient
        187105, -- Memory of the Agonizing Gaze
        187107, -- Memory of the Duty-Bound Gavel
        187161, -- Memory of Bwonsamdi's Pact
        187232, -- Memory of the Pouch of Razor Fragments
        187277, -- Memory of Sinister Teachings
        190593, -- Memory of Unity
        190598, -- Memory of Unity
        182625, -- Memory of an Everlasting Grip
        183211, -- Memory of the Hour of Darkness
        183212, -- Memory of a Darkglare Medallion
        183219, -- Memory of Soul of Fire
        183224, -- Memory of a Deep Focus Draught
        183252, -- Memory of a Trapping Apparatus
        183254, -- Memory of a Dire Command
        183279, -- Memory of the Freezing Winds
        183282, -- Memory of the Fatal Touch
        183292, -- Memory of Clouded Focus
        183294, -- Memory of the Jade Ignition
        183321, -- Memory of the Penitent One
        183332, -- Memory of the Master Assassin's Mark
        183335, -- Memory of the Doomblade
        183341, -- Memory of a Guile Charm
        183351, -- Memory of an Elemental Equilibrium
        183355, -- Memory of the Frost Witch
        183361, -- Memory of the Spiritwalker's Tidal Totem
        183365, -- Memory of the Consuming Wrath
        183368, -- Memory of the Dark Portal
        187511, -- Memory of Elysian Might
        182628, -- Memory of Bryndaor
        182635, -- Memory of Koltira
        183217, -- Memory of my Darker Nature
        183233, -- Memory of the Frenzyband
        183234, -- Memory of a Luffa-Infused Embrace
        183251, -- Memory of a Craven Strategem
        183255, -- Memory of the Flamewaker
        183265, -- Memory of a Wildfire Cluster
        183268, -- Memory of a Grisly Icicle
        183272, -- Memory of a Siphoning Storm
        183274, -- Memory of a Fevered Incantation
        183276, -- Memory of the Molten Sky
        183295, -- Memory of Keefer
        183301, -- Memory of Uther
        183319, -- Memory of my Crystalline Reflection
        183326, -- Memory of the Void's Eternal Call
        183377, -- Memory of the Ymirjar
        186572, -- Memory of the Sinful Surge
        186689, -- Memory of the Splintered Elements
        187111, -- Memory of Blind Faith
        187132, -- Memory of the Seasons of Plenty
        187162, -- Memory of Shadow Word: Manipulation
        187224, -- Memory of the Elemental Conduit
        187225, -- Memory of the Languishing Soul Detritus
        190591, -- Memory of Unity
        190592, -- Memory of Unity
        191635, -- Memory of Unity
        191641, -- Memory of Unity
        182626, -- Memory of the Phearomones
        182633, -- Memory of the Biting Cold
        182637, -- Memory of Death's Certainty
        183213, -- Memory of the Anguish of the Collective
        183228, -- Memory of Arcane Pulsars
        183230, -- Memory of the Apex Predator
        183231, -- Memory of a Cat-Eye Curio
        183250, -- Memory of the Wild Call
        183260, -- Memory of the Serpentstalker's Trickery
        183269, -- Memory of the Triune Ward
        183314, -- Memory of Cauterizing Shadows
        183317, -- Memory of a Heavenly Vault
        183337, -- Memory of the Zoldyck Insignia
        183345, -- Memory of the Rotten
        183363, -- Memory of Azj'Aqir's Agony
        183366, -- Memory of the Claw of Endereth
        183381, -- Memory of the Tormented Kings
        183387, -- Memory of the Deathmaker
        186577, -- Memory of the Unbridled Swarm
        186673, -- Memory of Kindred Affinity
        191645, -- Memory of Unity
        183257, -- Memory of the Rylakstalker's Fangs
        183266, -- Memory of the Disciplinary Command
        183297, -- Memory of Xuen
        183303, -- Memory of Maraad's Dying Breath
        183336, -- Memory of the Duskwalker's Patch
        186576, -- Memory of Nature's Fury
        186775, -- Memory of Resounding Clarity
        187109, -- Memory of a Blazing Slaughter
        187160, -- Memory of Pallid Command
        187227, -- Memory of the Decaying Soul Satchel
        187230, -- Memory of the Bag of Munitions
        187237, -- Memory of a Call to Arms
        190594, -- Memory of Unity
        191637, -- Memory of Unity
        191638, -- Memory of Unity
        182631, -- Memory of a Vampiric Aura
        183210, -- Memory of a Fel Bombardment
        183247, -- Memory of a Stable Phantasma Lure
        183271, -- Memory of the Infinite Arcane
        183290, -- Memory of Ancient Teachings
        183323, -- Memory of Flash Concentration
        183350, -- Memory of the Great Sundering
        183354, -- Memory of the Doom Winds
        183371, -- Memory of the Horned Nightmare
        183379, -- Memory of the Misshapen Mirror
        183386, -- Memory of Fujieda
        183392, -- Memory of the Thunderlord
        191640, -- Memory of Unity
        183307, -- Memory of a Holy Sigil
        183327, -- Memory of the Painbreaker Psalm
        183338, -- Memory of Celerity
        183385, -- Memory of the Unhinged
        186635, -- Memory of Sinful Delight
        187106, -- Memory of Divine Resonance
        191636, -- Memory of Unity
        191639, -- Memory of Unity
        191634, -- Memory of Unity
        191642, -- Memory of Unity
        191643, -- Memory of Unity
        191644, -- Memory of Unity
    },
}

local legendaryCategories = {
    atiesh = "Atiesh, Greatstaff of the Guardian",
    sulfuras = "Sulfuras, Hand of Ragnaros",
    thunderfury = "Thunderfury, Blessed Blade of the Windseeker",
    warglaives = "Warglaives of Azzinoth",
    thoridal = "Thori'dal, the Stars' Fury",
    valanyr = "Val'anyr, Hammer of Ancient Kings",
    shadowmourne = "Shadowmourne",
    dragonwrath = "Dragonwrath, Tarecgosa's Rest",
    fangs = "Fangs of the Father",
    ashjrakamas = "Ashjra'kamas, Shroud of Resolve",
    raeshalare = "Rae'shalare, Death's Whisper",
    naszuro = "Nasz'uro, Bond of the Tormented",
    fyralath = "Fyr'alath, the Dreamrender",
    mists = "Mists of Pandaria Legendary Capes",
    wod = "Warlords of Draenor Legendary Rings",
    legion = "Legion Legendaries",
    runecrafted = "Shadowlands Runecrafted Legendaries",
    memories = "Shadowlands Runecrafting Memories",
}

function CraftingLegendaries:GetCategoryName(name)
    local theName = legendaryCategories[name]
    return self:WrapLegendaryCategoryText(L:G(theName))
end

function CraftingLegendaries:WrapLegendaryCategoryText(category)
    return WrapTextInColorCode(category, "ffff8000")
end

function CraftingLegendaries:KillOldCategories()
    for key, category in pairs(legendaryCategories) do
        categories:WipeCategory(category)
        categories:WipeCategory(L:G(category))
        categories:WipeCategory(self:GetCategoryName(key))
        --@debug@
        print("Category \"" .. self:GetCategoryName(key) .. "\" deleted.")
        --@end-debug@
    end
end

function CraftingLegendaries:AddTablesToCategories()
    -- Loop through the tables in the legendary table.
    for categoryName, categoryContents in pairs(legendary) do
        local resolvedCategoryName = self:GetCategoryName(categoryName)
        --@debug@
        print("Category \"" .. resolvedCategoryName .. "\" created.")
        --@end-debug@

        -- Loop through the items in the category and add to correct category.
        for _, itemID in ipairs(categoryContents) do
            categories:AddItemToCategory(itemID, resolvedCategoryName)
            --@debug@
            print("Added " .. itemID .. " to category " .. resolvedCategoryName)
            --@end-debug@
        end
    end
end

-- On plugin load, wipe the categories we've added, then repopulate them.
function CraftingLegendaries:OnInitialize()
    --@debug@
    print("We crafting some legendaries? I hope so.")
    --@end-debug@
    self:KillOldCategories()
    self:AddTablesToCategories()
end