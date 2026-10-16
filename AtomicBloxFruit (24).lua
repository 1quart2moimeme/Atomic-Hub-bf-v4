--[[
  ATOMIC BLOX FRUIT | FINAL
  Farm | Fruit | Travel | PvP | Visual | Auto Dungeon
  UI only (no hotkeys) — open via purple icon button
]]
print("[Atomic] starting...")

local okAll, errAll = pcall(function()

local Svc = {
	P = game:GetService("Players"),
	Run = game:GetService("RunService"),
	RS = game:GetService("ReplicatedStorage"),
	UIS = game:GetService("UserInputService"),
	VU = game:GetService("VirtualUser"),
	VIM = game:GetService("VirtualInputManager"),
	WS = game:GetService("Workspace"),
	Lit = game:GetService("Lighting"),
	Tween = game:GetService("TweenService"),
}
local LP = Svc.P.LocalPlayer
local PG = LP:WaitForChild("PlayerGui")
local Mouse, Cam = LP:GetMouse(), Svc.WS.CurrentCamera

local C = {
	HOP=300, HOP_CD=1.5, FLY=120, FFLY=400, DTWEEN=400,
	RANGE=200, GROUP=70, ARRIVE=14, ABOVE=14, DELAY=0.05, PIN=80, EQUIP=80, QNEED=8,
	CR=75, CSEG=40, CPRED=0.08, MAXD=5000, FAD=0.05, BOAT=180, CR_MIN=30, CR_MAX=250, FLY_MIN=40, FLY_MAX=500, BOAT_MIN=50, BOAT_MAX=400, WALK=16, JUMP=50, WALK_MIN=16, WALK_MAX=300, JUMP_MIN=50, JUMP_MAX=500,
	KF=300, APP=10, TPD=100, OH=20, OR=28, OS=7.5, DROP=1000, OH_MIN=10, OH_MAX=200, OR_MIN=5, OR_MAX=80,
	PHP=5000, PSPD=400, PDUR=10, PCD=15,
	TH=Color3.fromRGB(70,160,255), TH2=Color3.fromRGB(100,190,255),
	BG=Color3.fromRGB(18,24,38), BG2=Color3.fromRGB(24,32,50), BG3=Color3.fromRGB(32,42,64),
	TXT=Color3.fromRGB(230,238,255), TX2=Color3.fromRGB(140,155,185),
	LINE=Color3.fromRGB(40,55,85), OK=Color3.fromRGB(80,200,255),
	OFF=Color3.fromRGB(45,55,80), ON=Color3.fromRGB(50,150,255),
	NEON=Color3.fromRGB(70,170,255), MAG=Color3.fromRGB(100,190,255),
}

local St = {
	fastAttack=false, farm=false, fly=false, vacuum=true, fruitEsp=false, fruitMission=false,
	autoStore=true, buso=true, anchor=false, traveling=false, autoQuest=false, lockType=false,
	silent=false, circleAim=false, pvpFA=false, kill=false, esp=false, gray=false, fps=false, panic=false,
	dungeon=false, autoV4=true, boat=false, walkOn=false, jumpOn=false, waterWalk=false, panicAuto=true,
	weaponMode="sword", faRunning=false, farmRunning=false, pvpFaRunning=false, dungeonRunning=false,
	combo=0, silentHooked=false, busoOnThisLife=false, currentSea=1,
	lockTypeName=nil, questActive=false, questKills=0, questMobKey=nil,
	fruitToken=0, travelToken=0, dungeonToken=0,
	circleOn=true, circleTransparent=false, inCircle=false,
	killAngle=0, killPhase="approach", dropHolding=false, panicUntil=0, lastPanic=0,
	wasFarmBeforeFruit=false, savedFarmPos=nil, lastDoorId=nil, doorCooldown=0,
}

local R = {
	keys={W=false,A=false,S=false,D=false,Space=false,LeftShift=false},
	fruitDraws={}, fruitList={}, knownFruits={}, diedConns={}, circleSegs={}, espDraws={},
	toggles={}, panels={}, tabBtns={}, usedDoors={},
}

local H = {}

-- ========== DATA ==========
H.QM = {
	["bandit"]={"BanditQuest1",1},["trainee"]={"MarineQuest",1},["monkey"]={"JungleQuest",1},
	["gorilla"]={"JungleQuest",2},["pirate"]={"BuggyQuest1",1},["brute"]={"BuggyQuest1",2},
	["desert bandit"]={"DesertQuest",1},["desert officer"]={"DesertQuest",2},
	["snow bandit"]={"SnowQuest",1},["snowman"]={"SnowQuest",2},
	["chief petty officer"]={"MarineQuest2",1},["sky bandit"]={"SkyQuest",1},["dark master"]={"SkyQuest",2},
	["prisoner"]={"PrisonerQuest",1},["dangerous prisoner"]={"PrisonerQuest",2},
	["toga warrior"]={"ColosseumQuest",1},["gladiator"]={"ColosseumQuest",2},
	["military soldier"]={"MagmaQuest",1},["military spy"]={"MagmaQuest",2},
	["fishman warrior"]={"FishmanQuest",1},["fishman commando"]={"FishmanQuest",2},
	["god's guard"]={"SkyExp1Quest",1},["shanda"]={"SkyExp1Quest",2},
	["royal squad"]={"SkyExp2Quest",1},["royal soldier"]={"SkyExp2Quest",2},
	["galley pirate"]={"FountainQuest",1},["galley captain"]={"FountainQuest",2},
	["raider"]={"Area1Quest",1},["mercenary"]={"Area1Quest",2},
	["swan pirate"]={"Area2Quest",1},["factory staff"]={"Area2Quest",2},
	["marine lieutenant"]={"MarineQuest3",1},["marine captain"]={"MarineQuest3",2},
	["zombie"]={"ZombieQuest",1},["vampire"]={"ZombieQuest",2},
	["snow trooper"]={"SnowMountainQuest",1},["winter warrior"]={"SnowMountainQuest",2},
	["lab subordinate"]={"IceSideQuest",1},["horned warrior"]={"IceSideQuest",2},
	["magma ninja"]={"FireSideQuest",1},["lava pirate"]={"FireSideQuest",2},
	["ship deckhand"]={"ShipQuest1",1},["ship engineer"]={"ShipQuest1",2},
	["ship steward"]={"ShipQuest2",1},["ship officer"]={"ShipQuest2",2},
	["arctic warrior"]={"FrostQuest",1},["snow lumberjack"]={"FrostQuest",2},
	["water fighter"]={"ForgottenQuest",1},
	["pirate forest"]={"ForestPirateQuest",1},["forest pirate"]={"ForestPirateQuest",1},
	["mythological pirate"]={"MythologicalPirate",1},["fishman raider"]={"FishmanQuest2",1},
	["fishman captain"]={"FishmanQuest2",2},["jungle pirate"]={"JunglePirateQuest",1},
	["musketeer pirate"]={"MusketeerQuest",1},["reborn skeleton"]={"HauntedQuest1",1},
	["living zombie"]={"HauntedQuest1",2},["demonic soul"]={"HauntedQuest2",1},
	["possessed mummy"]={"HauntedQuest2",2},["peanut scout"]={"PeanutQuest1",1},
	["peanut president"]={"PeanutQuest2",1},["ice cream chef"]={"IceCreamQuest1",1},
	["ice cream commander"]={"IceCreamQuest2",1},["cookie crunch"]={"CookieQuest1",1},
	["cake guard"]={"CakeQuest1",1},["baking staff"]={"CakeQuest2",1},
	["head baker"]={"CakeQuest2",2},["cocoa warrior"]={"ChocQuest1",1},
	["chocolate bar battler"]={"ChocQuest2",1},["sweet thief"]={"CandyQuest1",1},
	["candy rebel"]={"CandyQuest1",2},["candy pirate"]={"CandyQuest2",1},
	["snowman pirate"]={"SnowQuest2",1},
}
H.SEAS = {
	[1]={
		{"Starter Island",Vector3.new(1071,16,1426)},{"Jungle",Vector3.new(-1618,36,149)},
		{"Pirate Village",Vector3.new(-1181,4,3803)},{"Desert",Vector3.new(944,20,4390)},
		{"Middle Town",Vector3.new(-655,7,1682)},{"Frozen Village",Vector3.new(1148,27,1289)},
		{"Marine Fortress",Vector3.new(-4810,20,4358)},{"Skylands",Vector3.new(-4607,872,-1667)},
		{"Prison",Vector3.new(4855,5,736)},{"Colosseum",Vector3.new(-1576,7,-2982)},
		{"Magma Village",Vector3.new(-5230,8,8504)},{"Underwater City",Vector3.new(61163,18,1569)},
		{"Fountain City",Vector3.new(5127,4,4035)},
	},
	[2]={
		{"Kingdom of Rose",Vector3.new(-3083,48,-2750)},{"Cafe",Vector3.new(-380,73,290)},
		{"Green Zone",Vector3.new(-2249,73,-2858)},{"Graveyard",Vector3.new(-5616,48,862)},
		{"Snow Mountain",Vector3.new(1298,452,-4390)},{"Hot and Cold",Vector3.new(-5906,18,-5000)},
		{"Cursed Ship",Vector3.new(923,125,32885)},{"Ice Castle",Vector3.new(5504,40,-6118)},
		{"Forgotten Island",Vector3.new(-3050,240,-10150)},{"Dark Arena",Vector3.new(1000,12,1600)},
	},
	[3]={
		{"Port Town",Vector3.new(-288,29,5590)},{"Hydra Island",Vector3.new(5220,604,344)},
		{"Great Tree",Vector3.new(2536,1610,-7071)},{"Castle on the Sea",Vector3.new(-5075,314,-3150)},
		{"Haunted Castle",Vector3.new(-9515,142,5780)},{"Sea of Treats",Vector3.new(-1100,120,-10700)},
		{"Tiki Outpost",Vector3.new(-16220,9,440)},{"Floating Turtle",Vector3.new(-13248,332,-7654)},
	},
}
H.KW = {
	fruit={"fruit","rocket","spin","bomb","spike","flame","ice","sand","dark","light","magma","quake","buddha","phoenix","rubber","barrier","ghost","smoke","blizzard","gravity","shadow","venom","control","spirit","dragon","leopard","dough","mammoth","kitsune","gas","yeti","eagle","diamond","spring","chop","pain","trex","t-rex"},
	ignore={"gacha","dealer","npc","seller","shop","quest","door","gate","chest","coffre","crate","box","island","ile","treasure","loot","spawn","pad","teleport","portal","bridge","wall","floor","boat","ship","building","tower","statue","raid","dungeon","puzzle"},
	fskill={"fruit","buzo","awaken","v4"},
	fight={"combat","black leg","electro","fishman karate","dragon claw","superhuman","death step","sharkman","dragon talon","godhuman","sanguine","electric claw"},
	gun={"gun","rifle","pistol","cannon","kabucha","acidum","serpentine","bazooka","musket"},
	sword={"sword","katana","cutlass","blade","dual","scythe","trident","buddy","shisui","saddi","wando","yama","rengoku","pole","jitte","pipe","dark dagger","tushita","hallow","canvander","cdk","shizu","gravity cane","dog blade","fox","midnight","bisento","iron mace"},
	door={"door","exit","entrance","gate","portal door","next room","leave","proceed","continue","pass","open door","next","room","chamber","floor","next floor","étage","stage","level","portal","ascend","descend","go up","go down"},
}

-- ========== HELPERS ==========
function H.hrp()
	local c=LP.Character
	if not c then return nil end
	return c:FindFirstChild("HumanoidRootPart"), c:FindFirstChildOfClass("Humanoid")
end
function H.status(t)
	if R.statusLbl then R.statusLbl.Text=tostring(t) end
end
function H.clean(model)
	if not model then return "" end
	local n=model.Name:lower()
	n=n:gsub("%d+",""):gsub("%s+"," "):gsub("^%s+",""):gsub("%s+$","")
	return n
end
function H.vis(btn,on)
	if not btn then return end
	local track=btn:FindFirstChild("Track") or btn
	local knob=track and track:FindFirstChild("Knob")
	if track and (track:IsA("Frame") or track:IsA("TextButton")) then
		track.BackgroundColor3=on and C.ON or C.OFF
		local st=track:FindFirstChildOfClass("UIStroke")
		if st then st.Color=on and C.NEON or C.LINE st.Transparency=on and 0.2 or 0.6 end
	end
	if knob then
		knob.Position=on and UDim2.new(0,20,0.5,0) or UDim2.new(0,2,0.5,0)
		knob.BackgroundColor3=on and Color3.fromRGB(10,20,25) or Color3.fromRGB(180,190,210)
	end
	local row=btn.Parent
	if row then
		local l=row:FindFirstChild("Lbl")
		if l then l.TextColor3=on and C.NEON or C.TX2 end
		local rs=row:FindFirstChildOfClass("UIStroke")
		if rs then rs.Color=on and C.NEON or C.LINE rs.Transparency=on and 0.35 or 0.7 end
	end
end
function H.mkCorner(p,r)
	local c=Instance.new("UICorner") c.CornerRadius=UDim.new(0,r or 6) c.Parent=p
end
function H.mkStroke(p,th,col)
	local s=Instance.new("UIStroke") s.Thickness=th or 1 s.Color=col or C.TH s.Parent=p
end

-- ========== MOBS ==========
function H.isMob(model)
	if not model or not model:IsA("Model") then return false end
	if model==LP.Character then return false end
	for _,plr in ipairs(Svc.P:GetPlayers()) do
		if plr.Character==model then return false end
	end
	local hum=model:FindFirstChildOfClass("Humanoid")
	local root=model:FindFirstChild("HumanoidRootPart")
	if not hum or not root or hum.Health<=0 then return false end
	-- never take anything under NPC folders
	local full=string.lower(model:GetFullName())
	if full:find("npc") and not full:find("enemies") then return false end
	local n=string.lower(model.Name)
	-- blacklist quest givers / shop / utility NPCs
	local ban={"quest","seller","dealer","gacha","shop","merchant","boat","adventure",
		"mysterious","luxury","capacity","awaken","trainer","instructor","coach",
		"title","color","coat","indra","wenlock","citizen","villager","civilian",
		"bartender","mayor","king","queen","princess","set home","home point",
		"detective","robot","talk","dialogue","helper","guide","vendor","clerk",
		"gorillo","kid","customer","set home","home point"}
	for _,b in ipairs(ban) do
		if n:find(b,1,true) then return false end
	end
	-- real BF farm mobs live in Enemies (or have combat tools / no ProximityPrompt only)
	local parent=model.Parent and string.lower(model.Parent.Name) or ""
	if parent=="npcs" or parent=="npc" then return false end
	return true
end
function H.allMobs()
	local out,seen={},{}
	local function add(m)
		if seen[m] or not H.isMob(m) then return end
		local root=m:FindFirstChild("HumanoidRootPart")
		if not root then return end
		seen[m]=true
		table.insert(out,{model=m,root=root,hum=m:FindFirstChildOfClass("Humanoid")})
	end
	-- preferred folders
	for _,fn in ipairs({"Enemies","Enemy","Mobs"}) do
		local f=Svc.WS:FindFirstChild(fn)
		if f then
			for _,m in ipairs(f:GetChildren()) do add(m) end
		end
	end
	local wo=Svc.WS:FindFirstChild("_WorldOrigin")
	if wo then
		for _,sub in ipairs({"Enemies","Enemy","Mobs","EnemyModels"}) do
			local f=wo:FindFirstChild(sub)
			if f then
				for _,m in ipairs(f:GetChildren()) do add(m) end
			end
		end
	end
	-- FALLBACK: scan Workspace children (standalone style) if folders empty
	if #out==0 then
		for _,m in ipairs(Svc.WS:GetChildren()) do
			add(m)
		end
	end
	return out
end
function H.near(pos,range)
	local out={}
	for _,e in ipairs(H.allMobs()) do
		if (e.root.Position-pos).Magnitude<=range then table.insert(out,e) end
	end
	return out
end
function H.nearestMob()
	local h=select(1,H.hrp()) if not h then return nil end
	local best,bd=nil,1e9
	for _,e in ipairs(H.allMobs()) do
		local d=(e.root.Position-h.Position).Magnitude
		if d<bd then best,bd=e,d end
	end
	return best,bd
end
function H.center()
	local h=select(1,H.hrp()) if not h then return nil end
	local nearest=H.nearestMob() if not nearest then return nil end
	local sum,cnt=nearest.root.Position,1
	for _,e in ipairs(H.allMobs()) do
		if (e.root.Position-nearest.root.Position).Magnitude<=C.GROUP then
			sum=sum+e.root.Position cnt=cnt+1
		end
	end
	return sum/cnt
end
function H.aimPart()
	local h=select(1,H.hrp()) if not h then return nil end
	local n=H.near(h.Position,C.RANGE) if #n==0 then return nil end
	return n[1].model:FindFirstChild("UpperTorso") or n[1].model:FindFirstChild("Head") or n[1].root
end
function H.hits()
	local out={} local h=select(1,H.hrp()) if not h then return out end
	for _,e in ipairs(H.near(h.Position,C.RANGE)) do
		table.insert(out,{e.model, e.model:FindFirstChild("UpperTorso") or e.model:FindFirstChild("Head") or e.root})
	end
	-- Fast Attack Players
	if St.pvpFA then
		for _,plr in ipairs(Svc.P:GetPlayers()) do
			if plr~=LP and plr.Character then
				local hum=plr.Character:FindFirstChildOfClass("Humanoid")
				local torso=plr.Character:FindFirstChild("UpperTorso") or plr.Character:FindFirstChild("Torso") or plr.Character:FindFirstChild("HumanoidRootPart")
				if hum and hum.Health>0 and torso and (torso.Position-h.Position).Magnitude<=C.RANGE then
					table.insert(out,{plr.Character, torso})
				end
			end
		end
	end
	return out
end
function H.primaryType()
	local h=select(1,H.hrp()) if not h then return nil end
	local counts={}
	for _,e in ipairs(H.near(h.Position,400)) do
		local k=H.clean(e.model)
		counts[k]=(counts[k] or 0)+1
	end
	local best,bn=nil,0
	for k,v in pairs(counts) do if v>bn then best,bn=k,v end end
	return best
end

-- ========== QUEST ==========
function H.clearDied()
	for _,c in pairs(R.diedConns) do pcall(function() c:Disconnect() end) end
	R.diedConns={}
end
function H.takeQuest(typeName, force)
	local key=string.lower(typeName or "")
	local entry=H.QM[key]
	if not entry then H.status("No quest: "..tostring(typeName)) return false end
	if St.questActive and St.questMobKey==key and not force then return true end
	local qName,qLevel=entry[1],entry[2]
	pcall(function()
		local rem=Svc.RS:FindFirstChild("Remotes")
		local rq=rem and (rem:FindFirstChild("CommF_") or rem:FindFirstChild("CommF"))
		if rq then rq:InvokeServer("StartQuest",qName,qLevel) end
		St.questActive,St.questKills,St.questMobKey=true,0,key
		if R.questLbl then R.questLbl.Text="quest :: "..key.." 0/"..C.QNEED end
		H.status("Quest: "..qName)
	end)
	return true
end
function H.onKill(hum)
	if not St.autoQuest or not St.questActive or not St.questMobKey then return end
	local model=hum and hum.Parent if not model then return end
	if H.clean(model)~=St.questMobKey then return end
	St.questKills=St.questKills+1
	if R.questLbl then R.questLbl.Text="quest :: "..St.questMobKey.." "..St.questKills.."/"..C.QNEED end
	if St.questKills>=C.QNEED then
		St.questActive,St.questKills=false,0
		local t=St.questMobKey
		task.delay(0.5,function() if St.autoQuest then H.takeQuest(t,true) end end)
	end
end
function H.hookDied(model)
	if not model or R.diedConns[model] then return end
	local hum=model:FindFirstChildOfClass("Humanoid")
	if not hum then return end
	R.diedConns[model]=hum.Died:Connect(function() H.onKill(hum) end)
end
function H.maintainQuest()
	if not St.autoQuest then return end
	local t=(St.lockType and St.lockTypeName) or H.primaryType()
	if t and (not St.questActive or St.questMobKey~=t) then H.takeQuest(t,false) end
	for _,e in ipairs(H.allMobs()) do H.hookDied(e.model) end
end

-- ========== WEAPON / BUSO / V4 ==========
function H.hasKW(n,list)
	for _,kw in ipairs(list) do if string.find(n,kw,1,true) then return true end end
	return false
end
function H.isGun(t)
	if not t then return false end
	return H.hasKW(string.lower(t.Name),H.KW.gun)
end
function H.isSword(t)
	if not t then return false end
	return H.hasKW(string.lower(t.Name),H.KW.sword)
end
function H.isFight(t)
	if not t then return false end
	return H.hasKW(string.lower(t.Name),H.KW.fight)
end
function H.isFruitTool(t)
	if not t or not t:IsA("Tool") then return false end
	if H.isGun(t) or H.isSword(t) or H.isFight(t) then return false end
	local n=string.lower(t.Name)
	-- BF fruit tools: "Flame-Flame", "Dough-Dough", contains Fruit, or fruit type kw
	if n:find("fruit",1,true) then return true end
	if n:find("-",1,true) then
		-- pattern Type-Type common for equipped devil fruits
		local a,b=n:match("^([%w%s]+)%-([%w%s]+)$")
		if a and b and a:gsub("%s","")==b:gsub("%s","") then return true end
	end
	for _,kw in ipairs(H.KW.fruit) do
		if kw~="fruit" and n:find(kw,1,true) then return true end
	end
	return false
end
function H.allTools()
	local list={} local char,bp=LP.Character,LP:FindFirstChild("Backpack")
	if bp then for _,t in ipairs(bp:GetChildren()) do if t:IsA("Tool") then table.insert(list,t) end end end
	if char then for _,t in ipairs(char:GetChildren()) do if t:IsA("Tool") then table.insert(list,t) end end end
	return list
end
function H.unequip()
	local hum=select(2,H.hrp())
	if hum then pcall(function() hum:UnequipTools() end) end
end
function H.equipThis(tool)
	if not tool then return end
	local hum=select(2,H.hrp())
	if hum then pcall(function() hum:EquipTool(tool) end) end
end
function H.equipWep()
	local tools=H.allTools()
	if St.weaponMode=="melee" then
		for _,t in ipairs(tools) do if H.isFight(t) then H.equipThis(t) return end end
	elseif St.weaponMode=="gun" then
		for _,t in ipairs(tools) do if H.isGun(t) then H.equipThis(t) return end end
	elseif St.weaponMode=="sword" then
		for _,t in ipairs(tools) do if H.isSword(t) then H.equipThis(t) return end end
	elseif St.weaponMode=="fruit" then
		for _,t in ipairs(tools) do if H.isFruitTool(t) then H.equipThis(t) return end end
		H.status("No fruit tool found")
		return
	end
	-- fallback any combat tool (not for fruit mode)
	for _,t in ipairs(tools) do
		if H.isSword(t) or H.isFight(t) or H.isGun(t) then H.equipThis(t) return end
	end
end
function H.buso()
	if not St.buso or St.busoOnThisLife then return end
	pcall(function()
		local rem=Svc.RS:FindFirstChild("Remotes")
		local c=rem and (rem:FindFirstChild("CommF_") or rem:FindFirstChild("CommF"))
		if c then c:InvokeServer("Buso") St.busoOnThisLife=true end
	end)
end
function H.getComm()
	local rem=Svc.RS:FindFirstChild("Remotes")
	if not rem then return nil end
	return rem:FindFirstChild("CommF_") or rem:FindFirstChild("CommF")
end
function H.isV4Active()
	local c=LP.Character
	if not c then return false end
	for _,n in ipairs({"RaceTransformed","V4","Awakened","UpperTransformed","Awakening"}) do
		if c:FindFirstChild(n) then return true end
	end
	pcall(function()
		if c:GetAttribute("RaceTransformed") then return true end
	end)
	return false
end
function H.tryV4()
	if not St.autoV4 then return end
	if St._v4Cd and tick()<St._v4Cd then return end
	St._v4Cd=tick()+0.5
	if H.isV4Active() then return end
	local c=H.getComm()
	pcall(function() if c then c:InvokeServer("Awakening") end end)
	pcall(function() if c then c:InvokeServer("RaceV4") end end)
	pcall(function() if c then c:InvokeServer("ActivateAbility","V4") end end)
	pcall(function() if c then c:InvokeServer("ActivateRace") end end)
	pcall(function() if c then c:InvokeServer("RaceV4Progress","Activate") end end)
	pcall(function() if c then c:InvokeServer("RaceV4Progress","Transform") end end)
	for _,k in ipairs({Enum.KeyCode.Y,Enum.KeyCode.LeftControl,Enum.KeyCode.T,Enum.KeyCode.B}) do
		pcall(function()
			Svc.VIM:SendKeyEvent(true,k,false,game)
			task.wait(0.04)
			Svc.VIM:SendKeyEvent(false,k,false,game)
		end)
	end
end
function H.ensureV4Loop()
	if St._v4Loop then return end
	St._v4Loop=true
	task.spawn(function()
		while true do
			task.wait(0.85)
			if St.autoV4 then pcall(H.tryV4) end
		end
	end)
end

function H.stopFly()
	St.fly=false
	if R.flyConn then R.flyConn:Disconnect() R.flyConn=nil end
	if R.flyBV then pcall(function() R.flyBV:Destroy() end) R.flyBV=nil end
	if R.flyBG then pcall(function() R.flyBG:Destroy() end) R.flyBG=nil end
	local root,hum=H.hrp()
	if root then pcall(function() root.AssemblyLinearVelocity=Vector3.zero end) end
	if hum and not St.kill and not St.panic and not St.dungeon then pcall(function() hum.PlatformStand=false end) end
end
function H.startFly()
	if R.flyConn then R.flyConn:Disconnect() R.flyConn=nil end
	if R.flyBV then pcall(function() R.flyBV:Destroy() end) R.flyBV=nil end
	if R.flyBG then pcall(function() R.flyBG:Destroy() end) R.flyBG=nil end
	St.fly=true
	local hrp,hum=H.hrp()
	if not hrp then St.fly=false return end
	if hum then
		pcall(function()
			hum.PlatformStand=true
			hum.Sit=false
		end)
	end
	R.flyConn=Svc.Run.RenderStepped:Connect(function(dt)
		if not St.fly then return end
		if St.kill or St.panic or St.dropHolding then return end
		local root,humanoid=H.hrp()
		if not root then return end
		if humanoid then
			pcall(function() humanoid.PlatformStand=true end)
		end
		local cam=Svc.WS.CurrentCamera
		if not cam then return end
		local move=Vector3.zero
		local look=cam.CFrame.LookVector
		local right=cam.CFrame.RightVector
		if R.keys.W then move=move+look end
		if R.keys.S then move=move-look end
		if R.keys.A then move=move-right end
		if R.keys.D then move=move+right end
		if R.keys.Space then move=move+Vector3.new(0,1,0) end
		if R.keys.LeftShift then move=move-Vector3.new(0,1,0) end
		pcall(function()
			root.AssemblyLinearVelocity=Vector3.zero
			root.AssemblyAngularVelocity=Vector3.zero
		end)
		local pos=root.Position
		if move.Magnitude>0.05 then
			pos=pos+move.Unit*C.FLY*dt
		end
		local flat=Vector3.new(look.X,0,look.Z)
		if flat.Magnitude>0.05 then
			root.CFrame=CFrame.new(pos,pos+flat)
		else
			root.CFrame=CFrame.new(pos)*CFrame.Angles(0,root.CFrame:ToEulerAnglesYXZ())
		end
	end)
end
function H.stopAnchor()
	St.anchor=false
	if R.anchorConn then R.anchorConn:Disconnect() R.anchorConn=nil end
	if R.anchorBV then pcall(function() R.anchorBV:Destroy() end) R.anchorBV=nil end
	local hrp,hum=H.hrp()
	if hrp then pcall(function() hrp.Anchored=false end) end
	if hum and not St.fly and not St.kill and not St.dungeon then pcall(function() hum.PlatformStand=false end) end
end
function H.startAnchor()
	H.stopAnchor() St.anchor=true
	local hrp,hum=H.hrp() if not hrp then St.anchor=false return end
	if hum then hum.PlatformStand=true end
	local pos=hrp.Position
	R.anchorBV=Instance.new("BodyVelocity") R.anchorBV.MaxForce=Vector3.new(4e4,4e4,4e4) R.anchorBV.Velocity=Vector3.zero R.anchorBV.Parent=hrp
	R.anchorConn=Svc.Run.Heartbeat:Connect(function()
		if not St.anchor then return end
		local root=select(1,H.hrp()) if not root then return end
		if not R.anchorBV or not R.anchorBV.Parent then
			R.anchorBV=Instance.new("BodyVelocity") R.anchorBV.MaxForce=Vector3.new(4e4,4e4,4e4) R.anchorBV.Parent=root
		end
		root.CFrame=CFrame.new(pos)
		R.anchorBV.Velocity=Vector3.zero
	end)
end
function H.stopPin()
	if R.pinConn then R.pinConn:Disconnect() R.pinConn=nil end
	if R.pinBV then pcall(function() R.pinBV:Destroy() end) R.pinBV=nil end
end
function H.cancelTween()
	if R.currentTween then
		pcall(function() R.currentTween:Cancel() end)
		R.currentTween=nil
	end
	if R.tweenConn then
		pcall(function() R.tweenConn:Disconnect() end)
		R.tweenConn=nil
	end
	St.tweening=false
end
function H.tweenTo(targetPos, speed, onDone)
	speed=speed or C.DTWEEN
	local hrp=select(1,H.hrp())
	if not hrp or not targetPos then
		if onDone then onDone(false) end
		return false
	end
	H.cancelTween()
	local goalCF
	if typeof(targetPos)=="CFrame" then
		goalCF=targetPos
	else
		goalCF=CFrame.new(targetPos)
	end
	local dist=(hrp.Position-goalCF.Position).Magnitude
	if dist<3 then
		pcall(function() hrp.CFrame=goalCF end)
		if onDone then onDone(true) end
		return true
	end
	local t=math.clamp(dist/math.max(speed,50),0.05,10)
	St.tweening=true
	local tw=Svc.Tween:Create(hrp,TweenInfo.new(t,Enum.EasingStyle.Linear),{CFrame=goalCF})
	R.currentTween=tw
	tw:Play()
	tw.Completed:Connect(function()
		St.tweening=false
		R.currentTween=nil
		if onDone then onDone(true) end
	end)
	return true
end
function H.hopTo(targetPos, speed, cd)
	speed=speed or C.FFLY
	cd=cd or C.HOP_CD
	local hrp=select(1,H.hrp()) if not hrp then return end
	while St.fruitMission or St.traveling do
		hrp=select(1,H.hrp()) if not hrp then break end
		local dist=(targetPos-hrp.Position).Magnitude
		if dist<=C.HOP then
			hrp.CFrame=CFrame.new(targetPos)
			break
		end
		local dir=(targetPos-hrp.Position).Unit
		local nextPos=hrp.Position+dir*C.HOP
		H.tweenTo(nextPos, speed)
		task.wait(cd)
	end
end

-- ========== FAST ATTACK ==========
function H.setupHooks()
	pcall(function()
		local Net=Svc.RS:FindFirstChild("Modules")
		Net=Net and Net:FindFirstChild("Net")
		if Net then
			R.RegisterAttack=Net:FindFirstChild("RE/RegisterAttack") or Net:FindFirstChild("RegisterAttack")
			R.RegisterHit=Net:FindFirstChild("RE/RegisterHit") or Net:FindFirstChild("RegisterHit")
		end
	end)
	if not R.RegisterAttack then
		pcall(function()
			for _,d in ipairs(Svc.RS:GetDescendants()) do
				if d:IsA("RemoteEvent") then
					local n=d.Name:lower()
					if n:find("registerattack") and not R.RegisterAttack then R.RegisterAttack=d end
					if n:find("registerhit") and not R.RegisterHit then R.RegisterHit=d end
				end
			end
		end)
	end
end
-- Fast M1 system (same as standalone Fast M1 + Farm script)
local BODY_PARTS={"RightLowerArm","RightUpperArm","LeftLowerArm","LeftUpperArm","RightHand","LeftHand","HumanoidRootPart","UpperTorso","Torso","Head"}
function H.getTool()
	local c=LP.Character
	return c and c:FindFirstChildOfClass("Tool")
end
function H.nextCombo()
	St.combo=(St.combo or 0)+1
	if St.combo>4 then St.combo=1 end
	return St.combo
end
function H.buildHits()
	local hits={}
	local hrp=select(1,H.hrp())
	if not hrp then return hits end
	local range=(St.dungeon and 80) or (St.farm and math.max(C.RANGE,70)) or C.RANGE
	-- mobs
	for _,e in ipairs(H.near(hrp.Position,range)) do
		local part=nil
		for _,bn in ipairs(BODY_PARTS) do
			part=e.model:FindFirstChild(bn)
			if part then break end
		end
		table.insert(hits,{e.model, part or e.root})
	end
	-- dungeon nearest force
	if St.dungeon then
		local mob=H.nearestMob()
		if mob then
			local part=mob.model:FindFirstChild("UpperTorso") or mob.model:FindFirstChild("Head") or mob.root
			table.insert(hits,1,{mob.model,part})
		end
	end
	-- players if pvp FA
	if St.pvpFA then
		for _,plr in ipairs(Svc.P:GetPlayers()) do
			if plr~=LP and plr.Character then
				local hum=plr.Character:FindFirstChildOfClass("Humanoid")
				local torso=plr.Character:FindFirstChild("UpperTorso") or plr.Character:FindFirstChild("Torso") or plr.Character:FindFirstChild("HumanoidRootPart")
				if hum and hum.Health>0 and torso and (torso.Position-hrp.Position).Magnitude<=range then
					table.insert(hits,{plr.Character,torso})
				end
			end
		end
	end
	return hits
end
function H.doAttack()
	H.setupHooks()
	local hrp,hum,char=H.hrp()
	if not hrp or not char then return end
	-- auto equip if no tool in hand
	local tool=H.getTool()
	if not tool then
		pcall(H.equipWep)
		tool=H.getTool()
	end
	local hits=H.buildHits()
	local c=H.nextCombo()
	-- Gun / tool LeftClickRemote (works with or without hits)
	if tool then
		pcall(function()
			local remote=tool:FindFirstChild("LeftClickRemote")
			if remote and remote:IsA("RemoteEvent") then
				if #hits>0 then
					local closest=hits[1][2]
					local dir=closest.Position-hrp.Position
					dir=dir.Magnitude<0.1 and Vector3.new(0,0,-1) or dir.Unit
					remote:FireServer(dir,c)
				else
					remote:FireServer(Vector3.new(0.01,-500,0.01),c,true)
				end
			end
		end)
	end
	-- RegisterAttack always when we have hits (core BF M1)
	if #hits>0 then
		pcall(function()
			if R.RegisterAttack then R.RegisterAttack:FireServer(0.5) end
		end)
		task.wait()
		pcall(function()
			if R.RegisterHit then
				R.RegisterHit:FireServer(hits[1][2], hits)
			end
		end)
		pcall(function()
			if R.RegisterHit then
				R.RegisterHit:FireServer(hits[1][2])
			end
		end)
	else
		-- still try click even without hits (keeps combo alive)
		pcall(function()
			if R.RegisterAttack then R.RegisterAttack:FireServer(0.5) end
		end)
	end
	pcall(function()
		Svc.VU:CaptureController()
		Svc.VU:Button1Down(Vector2.new(0,0))
		task.wait(0.02)
		Svc.VU:Button1Up(Vector2.new(0,0))
	end)
	if tool then
		pcall(function() tool:Activate() end)
	end
end
function H.ensureFA()
	if St.faRunning then return end
	St.faRunning=true
	task.spawn(function()
		local tickEquip=0
		while St.fastAttack or St.dungeon or St.pvpFA do
			if tick()-tickEquip>1.5 then
				tickEquip=tick()
				pcall(H.equipWep)
				pcall(H.setupHooks)
			end
			pcall(H.doAttack)
			task.wait(C.DELAY)
		end
		St.faRunning=false
	end)
end

-- ========== FARM ==========
function H.goAbove(root)
	local hrp,hum=H.hrp()
	if not hrp or not root then return end
	pcall(function()
		if hum then hum.PlatformStand=false hum.Sit=false end
		local pos=root.Position+Vector3.new(0,C.ABOVE,0)
		hrp.CFrame=CFrame.new(pos, root.Position)
		hrp.AssemblyLinearVelocity=Vector3.zero
		hrp.AssemblyAngularVelocity=Vector3.zero
	end)
end
function H.ensureFarm()
	if St.farmRunning then return end
	St.farmRunning=true
	task.spawn(function()
		while St.farm do
			if St.fruitMission or St.panic or St.dungeon then
				task.wait(0.3)
			else
				pcall(function()
					H.buso() H.equipWep() H.tryV4()
					local hrp=select(1,H.hrp()) if not hrp then return end
					local target=H.nearestMob()
					if St.lockType and St.lockTypeName then
						local best,bd=nil,1e9
						for _,e in ipairs(H.allMobs()) do
							if H.clean(e.model)==St.lockTypeName then
								local d=(e.root.Position-hrp.Position).Magnitude
								if d<bd then best,bd=e,d end
							end
						end
						target=best
					end
					if target and target.root then
						H.hookDied(target.model)
						-- vacuum nearby under target
						if St.vacuum then
							for _,e in ipairs(H.near(target.root.Position,C.GROUP)) do
								pcall(function()
									e.root.CFrame=CFrame.new(target.root.Position-Vector3.new(0,4,0))
								end)
							end
						end
						H.goAbove(target.root)
					end
				end)
				task.wait(0.12)
			end
		end
		St.farmRunning=false
	end)
end

function H.doorId(obj)
	if not obj then return nil end
	return tostring(obj:GetFullName())
end
function H.promptPart(prompt)
	if not prompt then return nil end
	local p=prompt.Parent
	-- Attachment / Model / anything → climb to BasePart
	for _=1,8 do
		if not p then break end
		if p:IsA("BasePart") then return p end
		if p:IsA("Model") then
			local pp=p.PrimaryPart or p:FindFirstChildWhichIsA("BasePart",true)
			if pp then return pp end
		end
		p=p.Parent
	end
	return nil
end
function H.isDoorPrompt(prompt)
	if not prompt or not prompt:IsA("ProximityPrompt") then return false end
	local full=string.lower(prompt:GetFullName())
	-- never shop/quest
	for _,bad in ipairs({"gacha","shop","seller","quest","merchant","boat dealer","luxury","color"}) do
		if full:find(bad,1,true) then return false end
	end
	return true -- dungeon mode will filter by distance; accept almost all prompts
end
-- ========== DUNGEON (Tween 400 system) ==========
function H.isFloorName(name)
	local n=string.lower(tostring(name or ""))
	return n:match("floor%s*%d+") or n:match("floor%d+") or n:find("nextfloor") or n:find("floorportal")
		or n:find("next floor") or n:find("door") and n:find("floor")
end
function H.getDoorPart(obj)
	if not obj then return nil end
	if obj:IsA("BasePart") then return obj end
	if obj:IsA("Model") then
		return obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart",true)
	end
	return obj:FindFirstChildWhichIsA("BasePart")
end
function H.findFloorDoors()
	local me=select(1,H.hrp())
	if not me then return {} end
	local list,seen={},{}
	local function push(obj,why)
		local part=H.getDoorPart(obj)
		if not part or seen[part] then return end
		seen[part]=true
		table.insert(list,{part=part,dist=(part.Position-me.Position).Magnitude,why=why})
	end
	pcall(function()
		local n=0
		for _,o in ipairs(Svc.WS:GetDescendants()) do
			if n>400 then break end
			local ok,name=pcall(function() return o.Name end)
			if not ok then continue end
			n=n+1
			if H.isFloorName(name) and (o:IsA("BasePart") or o:IsA("Model")) then
				push(o,name)
			end
			if o:IsA("TextLabel") or o:IsA("TextButton") then
				local txt=string.lower(o.Text or "")
				if H.isFloorName(txt) or txt:find("floor") then
					local ad=o.Parent
					local bb=o:FindFirstAncestorOfClass("BillboardGui")
					if bb and bb.Adornee then ad=bb.Adornee end
					while ad and not ad:IsA("BasePart") and not ad:IsA("Model") do
						ad=ad.Parent
					end
					if ad then push(ad,"ESP:"..tostring(o.Text or name)) end
				end
			end
		end
	end)
	table.sort(list,function(a,b) return a.dist<b.dist end)
	return list
end
function H.touchDoor(part)
	local me=select(1,H.hrp())
	if not me or not part then return end
	pcall(function()
		if firetouchinterest then
			for _=1,4 do
				firetouchinterest(me,part,0)
				task.wait(0.03)
				firetouchinterest(me,part,1)
				task.wait(0.03)
			end
		end
	end)
	-- also try proximity prompts on part
	pcall(function()
		for _,d in ipairs(part:GetDescendants()) do
			if d:IsA("ProximityPrompt") and fireproximityprompt then
				pcall(function() fireproximityprompt(d) end)
			end
		end
		if part.Parent then
			for _,d in ipairs(part.Parent:GetDescendants()) do
				if d:IsA("ProximityPrompt") and fireproximityprompt then
					pcall(function() fireproximityprompt(d) end)
				end
			end
		end
	end)
	pcall(function()
		Svc.VIM:SendKeyEvent(true,Enum.KeyCode.E,false,game)
		task.wait(0.1)
		Svc.VIM:SendKeyEvent(false,Enum.KeyCode.E,false,game)
	end)
end
function H.goToDoorTween(door)
	if St.doorBusy or St.doorDoneThisRoom or not door or not door.part then return end
	St.doorBusy=true
	local part,why=door.part,door.why
	H.status("Tween porte → "..tostring(why))
	local goal=part.CFrame*CFrame.new(0,0,-3)
	H.tweenTo(goal,C.DTWEEN,function()
		local me=select(1,H.hrp())
		if me then
			pcall(function()
				me.CFrame=part.CFrame*CFrame.new(0,0,-3)
				me.AssemblyLinearVelocity=Vector3.zero
			end)
			H.touchDoor(part)
			task.wait(0.08)
			pcall(function() me.CFrame=part.CFrame*CFrame.new(0,0,-5) end)
			H.touchDoor(part)
		end
		St.doorDoneThisRoom=true
		St.doorBusy=false
		H.status("Porte OK")
	end)
end
function H.takeNearestFloor()
	if St.doorDoneThisRoom then return end
	local doors=H.findFloorDoors()
	if #doors==0 then
		H.status("Aucune porte Floor")
		return
	end
	H.goToDoorTween(doors[1])
end
function H.dungeonAttack(t)
	-- equip sword preferentially in dungeon
	pcall(function()
		local char=LP.Character
		local bp=LP:FindFirstChild("Backpack")
		local hum=char and char:FindFirstChildOfClass("Humanoid")
		if not char or not hum then return end
		local held=char:FindFirstChildOfClass("Tool")
		local function isSw(tool)
			if not tool then return false end
			local n=string.lower(tool.Name)
			for _,k in ipairs(H.KW.sword) do if n:find(k,1,true) then return true end end
			return false
		end
		if not isSw(held) and bp then
			for _,t in ipairs(bp:GetChildren()) do
				if t:IsA("Tool") and isSw(t) then
					pcall(function() hum:EquipTool(t) end)
					break
				end
			end
		end
	end)
	local tool=LP.Character and LP.Character:FindFirstChildOfClass("Tool")
	if tool then pcall(function() tool:Activate() end) end
	pcall(function()
		Svc.VU:CaptureController()
		Svc.VU:ClickButton1(Vector2.new(0,0))
	end)
	pcall(function()
		if R.RegisterAttack then R.RegisterAttack:FireServer(C.DELAY) end
	end)
	pcall(function()
		if R.RegisterHit and t and t.root then
			R.RegisterHit:FireServer(t.root,{{t.model,t.root}})
		end
	end)
end
function H.dungeonSkills()
	for _,k in ipairs({Enum.KeyCode.Z,Enum.KeyCode.X,Enum.KeyCode.C,Enum.KeyCode.V}) do
		pcall(function()
			Svc.VIM:SendKeyEvent(true,k,false,game)
			task.wait(0.02)
			Svc.VIM:SendKeyEvent(false,k,false,game)
		end)
	end
end
function H.ensureDungeon()
	if St.dungeonRunning then return end
	St.dungeonRunning=true
	St.dungeonToken=St.dungeonToken+1
	local myTok=St.dungeonToken
	St.doorDoneThisRoom=false
	St.doorBusy=false
	St._dungLastSkill=0
	St._dungMobTarget=nil
	task.spawn(function()
		H.status("Dungeon ON")
		H.buso()
		H.equipWep()
		if not St.fastAttack then H.setFA(true) end
		while St.dungeon and myTok==St.dungeonToken do
			pcall(function()
				if St.panic then return end
				H.buso()
				H.tryV4()
				local hrp=select(1,H.hrp())
				if not hrp then return end
				if St.doorBusy then return end

				local mobs={}
				for _,e in ipairs(H.allMobs()) do
					local d=(e.root.Position-hrp.Position).Magnitude
					table.insert(mobs,{model=e.model,root=e.root,hum=e.hum,d=d})
				end
				table.sort(mobs,function(a,b) return a.d<b.d end)

				if #mobs>0 then
					if St.doorDoneThisRoom then St.doorDoneThisRoom=false end
					local t=mobs[1]
					H.status(string.format("Kill %s | %d",t.model.Name,#mobs))
					local goal=CFrame.new(t.root.Position+Vector3.new(0,C.ABOVE,0),t.root.Position)
					local dist=(hrp.Position-goal.Position).Magnitude
					if dist>8 then
						if not St.tweening or St._dungMobTarget~=t.model then
							St._dungMobTarget=t.model
							H.tweenTo(goal,C.DTWEEN,function() St._dungMobTarget=nil end)
						end
					else
						pcall(function()
							hrp.CFrame=goal
							hrp.AssemblyLinearVelocity=Vector3.zero
						end)
						H.dungeonAttack(t)
						for i=2,math.min(3,#mobs) do
							if mobs[i].d<35 then
								pcall(function()
									if R.RegisterHit then
										R.RegisterHit:FireServer(mobs[i].root,{{mobs[i].model,mobs[i].root}})
									end
								end)
							end
						end
					end
					if tick()-(St._dungLastSkill or 0)>0.9 then
						St._dungLastSkill=tick()
						H.dungeonSkills()
					end
					return
				end

				-- no mobs
				if St.doorDoneThisRoom then
					H.status("Clear · porte faite")
					return
				end
				if St.tweening then return end
				H.status("Clear → porte Floor")
				H.takeNearestFloor()
			end)
			task.wait(0.05)
		end
		H.cancelTween()
		St.dungeonRunning=false
		St.doorBusy=false
		H.status("Dungeon OFF")
	end)
end
function H.setDungeon(on)
	St.dungeon=on and true or false
	H.vis(R.toggles.dungeon,St.dungeon)
	if St.dungeon then
		if St.farm then St.wasFarmBeforeFruit=true H.setFarm(false) end
		St.doorDoneThisRoom=false
		St.doorBusy=false
		H.ensureDungeon()
	else
		St.dungeonToken=St.dungeonToken+1
		St.dungeonRunning=false
		St.doorBusy=false
		H.cancelTween()
		if St.wasFarmBeforeFruit then
			St.wasFarmBeforeFruit=false
			H.setFarm(true)
		end
	end
end

-- ========== FRUIT ==========
function H.isGFruit(obj)
	if not obj then return false end
	if obj:IsDescendantOf(LP) then return false end
	for _,plr in ipairs(Svc.P:GetPlayers()) do
		if plr.Character and obj:IsDescendantOf(plr.Character) then return false end
		local bp=plr:FindFirstChild("Backpack")
		if bp and obj:IsDescendantOf(bp) then return false end
	end
	if not (obj:IsA("Model") or obj:IsA("Tool")) then return false end
	local n=string.lower(obj.Name)
	for _,bad in ipairs(H.KW.ignore) do
		if n:find(bad,1,true) then return false end
	end
	if n:find("door",1,true) and not n:find("fruit",1,true) then return false end
	if n:find("chest",1,true) or n:find("coffre",1,true) then return false end
	if n:find("island",1,true) or n:find("ile",1,true) then return false end
	if n:find("gate",1,true) or n:find("crate",1,true) then return false end
	local hasFruitWord=n:find("fruit",1,true)~=nil
	local hasType=false
	for _,kw in ipairs(H.KW.fruit) do
		if kw~="fruit" and n:find(kw,1,true) then hasType=true break end
	end
	if not hasFruitWord and not hasType then return false end
	if not hasFruitWord and hasType then
		if obj:IsA("Tool") then return true end
		if n:find("-",1,true) then return true end
		return false
	end
	return true
end
function H.fPart(obj)
	if obj:IsA("BasePart") then return obj end
	if obj:IsA("Model") then return obj.PrimaryPart or obj:FindFirstChild("Handle") or obj:FindFirstChildWhichIsA("BasePart",true) end
	if obj:IsA("Tool") then return obj:FindFirstChild("Handle") end
end
function H.clearFESP()
	for _,d in pairs(R.fruitDraws) do
		pcall(function() if d.hl then d.hl:Destroy() end if d.bb then d.bb:Destroy() end end)
	end
	R.fruitDraws={}
	if R.fruitFolder then pcall(function() R.fruitFolder:Destroy() end) R.fruitFolder=nil end
end
function H.scanF()
	R.fruitList={}
	local h=select(1,H.hrp())
	local myPos=h and h.Position or Vector3.zero
	local function consider(obj)
		if H.isGFruit(obj) then
			local part=H.fPart(obj)
			if part then
				local dist=(part.Position-myPos).Magnitude
				table.insert(R.fruitList,{obj=obj,part=part,name=obj.Name,dist=dist})
			end
		end
	end
	-- common fruit containers
	for _,name in ipairs({"Fruits","Fruit","SpawnedFruits","_WorldOrigin","FloatingItems"}) do
		local f=Svc.WS:FindFirstChild(name)
		if f then for _,c in ipairs(f:GetDescendants()) do consider(c) end end
	end
	for _,c in ipairs(Svc.WS:GetChildren()) do
		consider(c)
		if c:IsA("Folder") or c:IsA("Model") then
			for _,d in ipairs(c:GetChildren()) do consider(d) end
		end
	end
	table.sort(R.fruitList,function(a,b) return a.dist<b.dist end)
	return #R.fruitList
end
function H.drawFESP()
	if not R.fruitFolder then
		R.fruitFolder=Instance.new("Folder") R.fruitFolder.Name="AtomicFruitESP" R.fruitFolder.Parent=PG
	end
	H.clearFESP()
	R.fruitFolder=Instance.new("Folder") R.fruitFolder.Name="AtomicFruitESP" R.fruitFolder.Parent=PG
	for _,f in ipairs(R.fruitList) do
		pcall(function()
			local hl=Instance.new("Highlight")
			hl.Adornee=f.obj hl.FillColor=Color3.fromRGB(255,200,0) hl.OutlineColor=Color3.fromRGB(255,255,100)
			hl.FillTransparency=0.5 hl.Parent=R.fruitFolder
			local bb=Instance.new("BillboardGui")
			bb.Size=UDim2.new(0,120,0,30) bb.AlwaysOnTop=true bb.Adornee=f.part bb.Parent=R.fruitFolder
			local tl=Instance.new("TextLabel")
			tl.Size=UDim2.new(1,0,1,0) tl.BackgroundTransparency=1
			tl.Text=f.name.." | "..math.floor(f.dist) tl.TextColor3=Color3.fromRGB(255,220,80)
			tl.TextStrokeTransparency=0.3 tl.Font=Enum.Font.GothamBold tl.TextSize=12 tl.Parent=bb
			R.fruitDraws[f.obj]={hl=hl,bb=bb}
		end)
	end
end
function H.startFESP()
	St.fruitEsp=true
	task.spawn(function()
		while St.fruitEsp do
			pcall(function()
				local n=H.scanF()
				H.drawFESP()
				if R.fruitInfo then R.fruitInfo.Text=n.." fruit(s)" end
				-- auto go if new fruit
				if St.fruitEsp and n>0 and not St.fruitMission and not St.dungeon then
					local f=R.fruitList[1]
					local key=tostring(f.obj)
					if not R.knownFruits[key] then
						R.knownFruits[key]=true
						H.goFruit(f)
					end
				end
			end)
			task.wait(1.2)
		end
	end)
end
function H.stopFESP()
	St.fruitEsp=false
	H.clearFESP()
end
function H.goFruit(entry)
	if not entry or not entry.part then return end
	St.fruitToken=St.fruitToken+1
	local tok=St.fruitToken
	St.fruitMission=true
	local wasFarm=St.farm
	if wasFarm then St.wasFarmBeforeFruit=true H.setFarm(false) end
	local hrp=select(1,H.hrp())
	if hrp then St.savedFarmPos=hrp.Position end
	H.status("Fruit → "..entry.name)
	task.spawn(function()
		H.hopTo(entry.part.Position+Vector3.new(0,4,0), C.FFLY, C.HOP_CD)
		if tok~=St.fruitToken then return end
		task.wait(0.8)
		-- try touch
		pcall(function()
			local h=select(1,H.hrp())
			if h and entry.part then h.CFrame=CFrame.new(entry.part.Position+Vector3.new(0,2,0)) end
		end)
		task.wait(1)
		St.fruitMission=false
		if St.savedFarmPos and St.wasFarmBeforeFruit then
			H.status("Return farm...")
			H.hopTo(St.savedFarmPos, C.FFLY, C.HOP_CD)
			St.wasFarmBeforeFruit=false
			H.setFarm(true)
		end
		H.status("Fruit done")
	end)
end
function H.autoStore()
	pcall(function()
		local rem=Svc.RS:FindFirstChild("Remotes")
		local c=rem and (rem:FindFirstChild("CommF_") or rem:FindFirstChild("CommF"))
		if not c then return end
		local bp=LP:FindFirstChild("Backpack")
		if not bp then return end
		for _,t in ipairs(bp:GetChildren()) do
			if t:IsA("Tool") and string.lower(t.Name):find("fruit") then
				-- store if not already owned duplicate check best-effort
				c:InvokeServer("StoreFruit", t.Name)
			end
		end
	end)
end

-- ========== TRAVEL ==========
function H.stopTravel()
	St.traveling=false
	St.travelToken=St.travelToken+1
end
function H.travelTo(pos, label)
	H.stopTravel()
	St.traveling=true
	local tok=St.travelToken
	H.status("Travel → "..tostring(label))
	task.spawn(function()
		H.hopTo(pos, C.FFLY, C.HOP_CD)
		if tok==St.travelToken then
			St.traveling=false
			H.status("Arrived: "..tostring(label))
		end
	end)
end

-- ========== PVP ==========
function H.getTorso(char)
	if not char then return nil end
	return char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso") or char:FindFirstChild("HumanoidRootPart")
end
function H.nearestPlr()
	local h=select(1,H.hrp()) if not h then return nil end
	local best,bp,bpos,bd=nil,nil,nil,C.MAXD
	for _,plr in ipairs(Svc.P:GetPlayers()) do
		if plr~=LP and plr.Character then
			local hum=plr.Character:FindFirstChildOfClass("Humanoid")
			local torso=H.getTorso(plr.Character)
			if hum and hum.Health>0 and torso then
				local d=(torso.Position-h.Position).Magnitude
				if d<bd then
					best=plr bp=torso
					local vel=torso.AssemblyLinearVelocity or Vector3.zero
					bpos=torso.Position+vel*C.CPRED
					bd=d
				end
			end
		end
	end
	return best,bp,bpos
end
function H.lockedOrNear()
	if R.lockedPlr then
		local hum=R.lockedPlr.Character and R.lockedPlr.Character:FindFirstChildOfClass("Humanoid")
		local torso=H.getTorso(R.lockedPlr.Character)
		if hum and hum.Health>0 and torso then
			local vel=torso.AssemblyLinearVelocity or Vector3.zero
			return R.lockedPlr, torso, torso.Position+vel*C.CPRED
		else
			R.lockedPlr=nil
		end
	end
	local p,part,pos=H.nearestPlr()
	if p then R.lockedPlr=p end
	return p,part,pos
end
function H.aimPos()
	-- global silent OR circle-only when target inside FOV
	if St.silent and R.tPos then return R.tPos, R.tPart end
	if St.circleAim and St.circleOn and St.inCircle and R.cPos then return R.cPos, R.cPart end
	return nil, nil
end
function H.hookSilent()
	if St.silentHooked then return end
	St.silentHooked=true
	pcall(function()
		local old
		old=hookmetamethod(game,"__namecall",newcclosure(function(self,...)
			local method=getnamecallmethod()
			if method=="FireServer" or method=="InvokeServer" then
				local pos=select(1,H.aimPos())
				if pos then
					local skip=false
					pcall(function() if checkcaller and checkcaller() then skip=true end end)
					if not skip then
						local args={...}
						for i,v in ipairs(args) do
							if typeof(v)=="Vector3" then args[i]=pos
							elseif typeof(v)=="CFrame" then args[i]=CFrame.new(pos) end
						end
						return old(self,unpack(args))
					end
				end
			end
			return old(self,...)
		end))
	end)
	pcall(function()
		local old
		old=hookmetamethod(game,"__index",newcclosure(function(self,key)
			if self==Mouse then
				local pos,part=H.aimPos()
				if pos then
					if key=="Hit" or key=="hit" then return CFrame.new(pos) end
					if (key=="Target" or key=="target") and part then return part end
				end
			end
			return old(self,key)
		end))
	end)
end
function H.setSilent(on)
	St.silent=on and true or false
	H.vis(R.toggles.silent,St.silent)
	if St.silent then H.hookSilent() end
end
function H.inCirc(mpos)
	local best,bp,bpos,bd=nil,nil,nil,C.CR
	for _,plr in ipairs(Svc.P:GetPlayers()) do
		if plr~=LP and plr.Character then
			local hum=plr.Character:FindFirstChildOfClass("Humanoid")
			local torso=H.getTorso(plr.Character)
			if hum and hum.Health>0 and torso then
				local sp,onScreen=Cam:WorldToViewportPoint(torso.Position)
				if onScreen then
					local dx,dy=sp.X-mpos.X, sp.Y-mpos.Y
					local d=math.sqrt(dx*dx+dy*dy)
					if d<bd then
						best=plr bp=torso
						local vel=torso.AssemblyLinearVelocity or Vector3.zero
						bpos=torso.Position+vel*C.CPRED
						bd=d
					end
				end
			end
		end
	end
	return best,bp,bpos
end
function H.updCirc(mpos)
	if not R.circleSegs or #R.circleSegs==0 then return end
	local trans=St.circleTransparent and 0.85 or 0
	local col=St.inCircle and Color3.fromRGB(255,60,60) or Color3.fromRGB(0,255,180)
	for i,seg in ipairs(R.circleSegs) do
		local ang=(i/C.CSEG)*math.pi*2
		local x=mpos.X+math.cos(ang)*C.CR
		local y=mpos.Y+math.sin(ang)*C.CR
		seg.Position=UDim2.new(0,x,0,y)
		seg.BackgroundColor3=col
		seg.BackgroundTransparency=trans
	end
	if R.circleGui then R.circleGui.Enabled=St.circleOn and St.circleAim end
end
function H.buildCircle()
	pcall(function()
		local o=PG:FindFirstChild("MouseCircleAim") if o then o:Destroy() end
	end)
	R.circleGui=Instance.new("ScreenGui")
	R.circleGui.Name="MouseCircleAim" R.circleGui.ResetOnSpawn=false
	R.circleGui.IgnoreGuiInset=true R.circleGui.DisplayOrder=9999 R.circleGui.Parent=PG
	R.circleSegs={}
	for i=1,C.CSEG do
		local f=Instance.new("Frame")
		f.AnchorPoint=Vector2.new(0.5,0.5) f.BorderSizePixel=0
		f.BackgroundColor3=Color3.fromRGB(0,255,180)
		f.Size=UDim2.new(0,4,0,2) f.Parent=R.circleGui
		H.mkCorner(f,2)
		R.circleSegs[i]=f
	end
end
function H.setCircle(on)
	St.circleAim=on and true or false
	H.vis(R.toggles.circle,St.circleAim)
	if St.circleAim then
		H.buildCircle()
		St.circleOn=true
		St.circleTransparent=false
		if R.circleGui then R.circleGui.Enabled=true end
		H.hookSilent()
	else
		St.circleOn=false
		St.inCircle=false
		R.cPos,R.cPart,R.cPlr=nil,nil,nil
		if R.circleGui then R.circleGui.Enabled=false end
	end
end
function H.stopKill()
	St.kill=false
	if R.killConn then R.killConn:Disconnect() R.killConn=nil end
	R.lockedPlr=nil
	local _,hum=H.hrp()
	if hum and not St.fly then pcall(function() hum.PlatformStand=false end) end
end
function H.startKill()
	H.stopKill() St.kill=true St.killPhase="approach" St.killAngle=0
	H.vis(R.toggles.kill,true)
	local _,hum=H.hrp() if hum then hum.PlatformStand=true end
	R.killConn=Svc.Run.Heartbeat:Connect(function(dt)
		if not St.kill or St.panic then return end
		local hrp=select(1,H.hrp()) if not hrp then return end
		local plr,part,pos=H.lockedOrNear()
		if not plr or not pos then return end
		R.tPlr,R.tPart,R.tPos=plr,part,pos
		local dist=(pos-hrp.Position).Magnitude
		if St.killPhase=="approach" then
			if dist>C.TPD then
				local dir=(pos-hrp.Position)
				if dir.Magnitude>0 then
					hrp.CFrame=hrp.CFrame:Lerp(CFrame.new(hrp.Position+dir.Unit*math.min(C.KF*dt*3,dist-C.APP)),0.4)
				end
			elseif dist>C.APP then
				hrp.CFrame=CFrame.new(pos+Vector3.new(0,C.OH,0))
				St.killPhase="orbit"
			else
				St.killPhase="orbit"
			end
		else
			St.killAngle=St.killAngle+C.OS*dt
			local x=math.cos(St.killAngle)*C.OR
			local z=math.sin(St.killAngle)*C.OR
			hrp.CFrame=CFrame.new(pos+Vector3.new(x,C.OH,z), pos)
		end
	end)
end
function H.setKillT(on)
	if on then H.startKill() else H.stopKill() H.vis(R.toggles.kill,false) end
end
function H.stopPanic()
	St.panic=false
	if R.panicConn then R.panicConn:Disconnect() R.panicConn=nil end
	if R.panicBV then pcall(function() R.panicBV:Destroy() end) R.panicBV=nil end
	local root,hum=H.hrp()
	if root then pcall(function() root.AssemblyLinearVelocity=Vector3.zero end) end
	if hum and not St.fly and not St.kill and not St.anchor then
		pcall(function() hum.PlatformStand=false end)
	end
	H.vis(R.toggles.panic, St.panicAuto)
end
function H.startPanic(manual)
	-- already in panic
	if St.panic then return end
	if not manual and tick()-St.lastPanic<C.PCD then return end
	St.lastPanic=tick()
	St.panic=true
	St.panicUntil=tick()+C.PDUR
	-- stop dangerous combat loops
	pcall(function() H.stopKill() end)
	pcall(function() if St.dungeon then H.setDungeon(false) end end)
	pcall(function() if St.farm then H.setFarm(false) end end)
	-- cancel fly movers so they don't fight panic
	if R.flyConn then R.flyConn:Disconnect() R.flyConn=nil end
	local hrp,hum=H.hrp()
	if hum then pcall(function() hum.PlatformStand=true hum.Sit=false end) end
	H.status("PANIC UP")
	H.vis(R.toggles.panic, true)
	-- CFrame rise = reliable on BF (BodyVelocity often stripped)
	R.panicConn=Svc.Run.RenderStepped:Connect(function(dt)
		if not St.panic then return end
		if tick()>St.panicUntil then
			H.stopPanic()
			H.status("Panic end")
			-- restore fly if it was on
			if St.fly then task.defer(H.startFly) end
			return
		end
		local root,humanoid=H.hrp()
		if not root then return end
		if humanoid and humanoid.Health<=0 then
			H.stopPanic()
			return
		end
		pcall(function()
			root.AssemblyLinearVelocity=Vector3.zero
			root.AssemblyAngularVelocity=Vector3.zero
		end)
		local up=C.PSPD*dt
		local pos=root.Position+Vector3.new(0,up,0)
		root.CFrame=CFrame.new(pos)
	end)
end
function H.setPanicT(on)
	-- toggle = enable AUTO panic on low HP (does not force start)
	St.panicAuto=on and true or false
	H.vis(R.toggles.panic, St.panicAuto)
	if not St.panicAuto and St.panic then H.stopPanic() end
	if St.panicAuto then
		local _,hum=H.hrp()
		if hum and hum.Health>0 and hum.Health<C.PHP then H.startPanic(false) end
	end
end
function H.clearESP()
	for plr,d in pairs(R.espDraws) do
		pcall(function() if d.hl then d.hl:Destroy() end end)
	end
	R.espDraws={}
end
function H.setESP(on)
	St.esp=on and true or false
	H.vis(R.toggles.esp,St.esp)
	if not St.esp then H.clearESP() return end
	task.spawn(function()
		while St.esp do
			pcall(function()
				for _,plr in ipairs(Svc.P:GetPlayers()) do
					if plr~=LP and plr.Character then
						if not R.espDraws[plr] then
							local hl=Instance.new("Highlight")
							hl.FillColor=Color3.fromRGB(255,40,40) hl.OutlineColor=Color3.fromRGB(255,100,100)
							hl.FillTransparency=0.4 hl.Adornee=plr.Character hl.Parent=PG
							R.espDraws[plr]={hl=hl}
						else
							R.espDraws[plr].hl.Adornee=plr.Character
						end
					end
				end
			end)
			task.wait(1)
		end
	end)
end
function H.applyGray()
	local GRAY=Color3.fromRGB(128,128,128)
	local function isPR(obj)
		for _,plr in ipairs(Svc.P:GetPlayers()) do
			if plr.Character and obj:IsDescendantOf(plr.Character) then return true end
		end
		return false
	end
	local function proc(obj)
		if isPR(obj) then return end
		pcall(function()
			if obj:IsA("BasePart") then obj.Color=GRAY obj.Material=Enum.Material.SmoothPlastic obj.Reflectance=0
			elseif obj:IsA("Decal") or obj:IsA("Texture") then obj.Transparency=1
			elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Fire") or obj:IsA("Smoke") then obj.Enabled=false end
		end)
	end
	for _,obj in ipairs(Svc.WS:GetDescendants()) do proc(obj) end
	pcall(function() Svc.Lit.GlobalShadows=false Svc.Lit.Brightness=2 Svc.Lit.FogEnd=1e6 end)
	Svc.WS.DescendantAdded:Connect(function(obj) if St.gray then task.defer(function() proc(obj) end) end end)
end


-- ========== BOAT SPEED ==========
function H.getBoatSeat()
	local char=LP.Character
	if not char then return nil end
	local hum=char:FindFirstChildOfClass("Humanoid")
	if not hum or not hum.SeatPart then return nil end
	local seat=hum.SeatPart
	if seat:IsA("VehicleSeat") then return seat end
	return nil
end
function H.stopBoat()
	St.boat=false
	if R.boatConn then R.boatConn:Disconnect() R.boatConn=nil end
end
function H.startBoat()
	H.stopBoat()
	St.boat=true
	R.boatConn=Svc.Run.Heartbeat:Connect(function()
		if not St.boat then return end
		local seat=H.getBoatSeat()
		if not seat then return end
		-- only boost while actually seated (prevents under-map glitch)
		local char=LP.Character
		local hum=char and char:FindFirstChildOfClass("Humanoid")
		if not hum or hum.Sit~=true then return end
		local root=char:FindFirstChild("HumanoidRootPart")
		if not root then return end
		local look=seat.CFrame.LookVector
		local flat=Vector3.new(look.X,0,look.Z)
		if flat.Magnitude<0.05 then return end
		flat=flat.Unit
		-- keep current Y velocity so we don't sink/clip
		local vy=root.AssemblyLinearVelocity.Y
		local spd=C.BOAT
		-- throttle from seat if moving forward/back
		local th=seat.Throttle or 0
		local st=seat.Steer or 0
		if th==0 and math.abs(root.AssemblyLinearVelocity.X)+math.abs(root.AssemblyLinearVelocity.Z)<2 then
			-- idle: don't force velocity
			return
		end
		local dir=flat
		if th<0 then dir=-flat end
		if th==0 then
			-- keep horizontal boost in look dir if already moving
			local hv=Vector3.new(root.AssemblyLinearVelocity.X,0,root.AssemblyLinearVelocity.Z)
			if hv.Magnitude>2 then dir=hv.Unit else return end
		end
		root.AssemblyLinearVelocity=Vector3.new(dir.X*spd, vy, dir.Z*spd)
		pcall(function() seat.MaxSpeed=spd end)
	end)
end
function H.setBoat(on)
	if on then H.startBoat() H.vis(R.toggles.boat,true)
	else H.stopBoat() H.vis(R.toggles.boat,false) end
end


-- ========== WALK / JUMP ==========
function H.stopWalk()
	St.walkOn=false
	if R.walkConn then R.walkConn:Disconnect() R.walkConn=nil end
	if R.walkHooked and R.walkOldIndex then
		-- leave hook in place; gated by St.walkOn
	end
end
function H.hookWalkSpeed()
	if R.walkHooked then return end
	R.walkHooked=true
	pcall(function()
		local mt=getrawmetatable(game)
		local old=mt.__newindex
		setreadonly(mt,false)
		mt.__newindex=newcclosure(function(self,k,v)
			if St.walkOn and k=="WalkSpeed" and typeof(self)=="Instance" and self:IsA("Humanoid") then
				local char=LP.Character
				if char and self:IsDescendantOf(char) then
					return old(self,k,C.WALK)
				end
			end
			if St.jumpOn and (k=="JumpPower" or k=="JumpHeight") and typeof(self)=="Instance" and self:IsA("Humanoid") then
				local char=LP.Character
				if char and self:IsDescendantOf(char) then
					if k=="JumpPower" then return old(self,k,C.JUMP) end
					if k=="JumpHeight" then return old(self,k,math.clamp(C.JUMP/5,7,100)) end
				end
			end
			return old(self,k,v)
		end)
		setreadonly(mt,true)
	end)
end
function H.startWalk()
	if R.walkConn then R.walkConn:Disconnect() R.walkConn=nil end
	St.walkOn=true
	H.hookWalkSpeed()
	-- RenderStepped = every frame (BF resets WalkSpeed constantly)
	R.walkConn=Svc.Run.RenderStepped:Connect(function(dt)
		if not St.walkOn or St.fly or St.panic then return end
		local root,hum=H.hrp()
		if not hum or not root then return end
		pcall(function() hum.WalkSpeed=C.WALK end)
		-- velocity assist if game still clamps walkspeed
		local moving=R.keys.W or R.keys.A or R.keys.S or R.keys.D
		if moving and hum.MoveDirection.Magnitude>0.05 then
			local md=hum.MoveDirection
			local target=md.Unit*C.WALK
			local cur=root.AssemblyLinearVelocity
			-- only boost horizontal, keep Y
			if Vector3.new(cur.X,0,cur.Z).Magnitude<C.WALK*0.85 then
				root.AssemblyLinearVelocity=Vector3.new(target.X, cur.Y, target.Z)
			end
		end
	end)
end
function H.setWalk(on)
	if on then H.startWalk() H.vis(R.toggles.walk,true)
	else H.stopWalk() H.vis(R.toggles.walk,false) end
end
function H.stopJump()
	St.jumpOn=false
	if R.jumpConn then R.jumpConn:Disconnect() R.jumpConn=nil end
end
function H.startJump()
	if R.jumpConn then R.jumpConn:Disconnect() R.jumpConn=nil end
	St.jumpOn=true
	H.hookWalkSpeed()
	R.jumpConn=Svc.Run.RenderStepped:Connect(function()
		if not St.jumpOn then return end
		local _,hum=H.hrp()
		if not hum then return end
		pcall(function()
			hum.UseJumpPower=true
			hum.JumpPower=C.JUMP
			hum.JumpHeight=math.clamp(C.JUMP/5,7,100)
		end)
	end)
end
function H.setJump(on)
	if on then H.startJump() H.vis(R.toggles.jump,true)
	else H.stopJump() H.vis(R.toggles.jump,false) end
end


-- ========== WALK ON WATER ==========
function H.stopWater()
	St.waterWalk=false
	if R.waterConn then R.waterConn:Disconnect() R.waterConn=nil end
	if R.waterPart then pcall(function() R.waterPart:Destroy() end) R.waterPart=nil end
end
function H.ensureWaterPart()
	if R.waterPart and R.waterPart.Parent then return R.waterPart end
	local p=Instance.new("Part")
	p.Name="AtomicWaterPlatform"
	p.Size=Vector3.new(14,1.2,14)
	p.Anchored=true
	p.CanCollide=true
	p.CanQuery=false
	p.CanTouch=false
	p.Transparency=1
	p.CastShadow=false
	p.Material=Enum.Material.SmoothPlastic
	p.TopSurface=Enum.SurfaceType.Smooth
	p.BottomSurface=Enum.SurfaceType.Smooth
	p.Parent=Svc.WS
	R.waterPart=p
	return p
end
function H.terrainHasWater(pos)
	local ok, result=pcall(function()
		local r=Region3.new(pos-Vector3.new(2,6,2), pos+Vector3.new(2,2,2)):ExpandToGrid(4)
		local mats=Svc.WS.Terrain:ReadVoxels(r,4)
		for x=1,#mats do
			for y=1,#mats[x] do
				for z=1,#mats[x][y] do
					if mats[x][y][z]==Enum.Material.Water then return true end
				end
			end
		end
		return false
	end)
	return ok and result==true
end
function H.isOverWater(root,hum)
	if not root then return false, nil end
	local origin=root.Position
	local params=RaycastParams.new()
	params.FilterType=Enum.RaycastFilterType.Exclude
	local filter={LP.Character}
	if R.waterPart then table.insert(filter, R.waterPart) end
	params.FilterDescendantsInstances=filter
	params.IgnoreWater=false
	-- several rays (center + sides)
	local offsets={
		Vector3.new(0,0,0), Vector3.new(3,0,0), Vector3.new(-3,0,0),
		Vector3.new(0,0,3), Vector3.new(0,0,-3),
	}
	for _,off in ipairs(offsets) do
		local ray=Svc.WS:Raycast(origin+off+Vector3.new(0,2,0), Vector3.new(0,-60,0), params)
		if ray then
			if ray.Material==Enum.Material.Water then
				return true, ray.Position
			end
			local n=string.lower(ray.Instance.Name)
			local mat=tostring(ray.Material):lower()
			if n:find("water") or n:find("sea") or n:find("ocean") or n:find("wave") or mat:find("water") then
				return true, ray.Position
			end
		end
	end
	if H.terrainHasWater(origin) then
		return true, origin-Vector3.new(0,4,0)
	end
	if hum then
		local st=hum:GetState()
		if st==Enum.HumanoidStateType.Swimming then
			return true, origin-Vector3.new(0,3.5,0)
		end
		pcall(function()
			if hum.FloorMaterial==Enum.Material.Water then
				return true
			end
		end)
		if hum.FloorMaterial==Enum.Material.Water then
			return true, origin-Vector3.new(0,3,0)
		end
	end
	return false, nil
end
function H.startWater()
	if R.waterConn then R.waterConn:Disconnect() R.waterConn=nil end
	St.waterWalk=true
	H.ensureWaterPart()
	R.waterConn=Svc.Run.RenderStepped:Connect(function()
		if not St.waterWalk then return end
		if St.fly or St.panic then return end
		local root,hum=H.hrp()
		if not root then return end
		local over, hitPos=H.isOverWater(root, hum)
		local plat=H.ensureWaterPart()
		if over then
			local surfaceY
			if hitPos then
				surfaceY=hitPos.Y+0.6
			else
				surfaceY=root.Position.Y-3
			end
			-- keep platform under feet, follow XZ
			plat.Size=Vector3.new(14,1.2,14)
			plat.CanCollide=true
			plat.CFrame=CFrame.new(root.Position.X, surfaceY, root.Position.Z)
			-- force out of swim + stop sinking
			if hum then
				pcall(function()
					local st=hum:GetState()
					if st==Enum.HumanoidStateType.Swimming or st==Enum.HumanoidStateType.Freefall then
						hum:ChangeState(Enum.HumanoidStateType.Running)
					end
				end)
			end
			local v=root.AssemblyLinearVelocity
			if v.Y<-1 then
				root.AssemblyLinearVelocity=Vector3.new(v.X, 0, v.Z)
			end
			-- if still below surface, nudge up
			if root.Position.Y < surfaceY+2.2 then
				root.CFrame=CFrame.new(root.Position.X, surfaceY+2.5, root.Position.Z) * CFrame.Angles(0, select(2, root.CFrame:ToEulerAnglesYXZ()), 0)
			end
		else
			plat.CanCollide=false
			plat.CFrame=CFrame.new(0,-1000,0)
		end
	end)
end
function H.setWater(on)
	if on then H.startWater() H.vis(R.toggles.water,true) H.status("Walk on Water ON")
	else H.stopWater() H.vis(R.toggles.water,false) H.status("Walk on Water OFF") end
end

-- ========== SETTERS ==========
function H.setFA(on)
	St.fastAttack=on and true or false
	H.vis(R.toggles.fa,St.fastAttack)
	if St.fastAttack then
		pcall(H.setupHooks)
		if R.aimConn then R.aimConn:Disconnect() end
		R.aimConn=Svc.Run.RenderStepped:Connect(function()
			if not St.fastAttack or St.fruitMission then return end
			local p=H.aimPart()
			if p then
				local h=select(1,H.hrp())
				if h then
					local t=p.Position
					h.CFrame=CFrame.new(h.Position,Vector3.new(t.X,h.Position.Y,t.Z))
				end
			end
		end)
		H.ensureFA() H.buso()
	else
		if R.aimConn then R.aimConn:Disconnect() R.aimConn=nil end
	end
end
function H.setFarm(on)
	St.farm=on and true or false
	H.vis(R.toggles.farm,St.farm)
	if St.farm then
		if not St.fastAttack then H.setFA(true) end
		H.ensureFarm() H.buso() H.equipWep()
		if St.autoQuest and not St.questActive then
			local t=(St.lockType and St.lockTypeName) or H.primaryType()
			if t then H.takeQuest(t,true) end
		end
	else H.stopPin() end
end
function H.setVac(on) St.vacuum=on and true or false H.vis(R.toggles.vac,St.vacuum) end
function H.setFlyT(on)
	if on then H.startFly() H.vis(R.toggles.fly,true)
	else H.stopFly() H.vis(R.toggles.fly,false) end
end
function H.setAnc(on)
	if on then H.startAnchor() H.vis(R.toggles.anchor,true)
	else H.stopAnchor() H.vis(R.toggles.anchor,false) end
end
function H.setFESP(on)
	if on then H.startFESP() H.vis(R.toggles.fesp,true)
	else H.stopFESP() H.vis(R.toggles.fesp,false) end
end
function H.setStore(on) St.autoStore=on and true or false H.vis(R.toggles.store,St.autoStore) end
function H.setBuso(on) St.buso=on and true or false H.vis(R.toggles.buso,St.buso) if on then St.busoOnThisLife=false H.buso() end end
function H.setQuest(on)
	St.autoQuest=on and true or false H.vis(R.toggles.quest,St.autoQuest)
	if on then
		local t=(St.lockType and St.lockTypeName) or H.primaryType()
		if t then H.takeQuest(t,true) end
	end
end
function H.setLock(on)
	St.lockType=on and true or false H.vis(R.toggles.lock,St.lockType)
	if on then St.lockTypeName=H.primaryType() H.status("Lock: "..tostring(St.lockTypeName)) end
end
function H.setGray(on)
	St.gray=on and true or false H.vis(R.toggles.gray,St.gray)
	if on then H.applyGray() end
end
function H.setFPS(on)
	St.fps=on and true or false H.vis(R.toggles.fps,St.fps)
	if on then
		pcall(function()
			Svc.Lit.GlobalShadows=false Svc.Lit.FogEnd=1e6
			settings().Rendering.QualityLevel=Enum.QualityLevel.Level01
		end)
	end
end
function H.setV4(on)
	St.autoV4=on and true or false
	H.vis(R.toggles.v4,St.autoV4)
	if St.autoV4 then
		H.ensureV4Loop()
		H.status("Auto V4 ON")
		task.defer(H.tryV4)
	else
		H.status("Auto V4 OFF")
	end
end
function H.setWep(mode)
	St.weaponMode=mode
	for _,m in ipairs({"melee","sword","gun","fruit"}) do
		if R.toggles["wep_"..m] then H.vis(R.toggles["wep_"..m], mode==m) end
	end
	H.equipWep()
end
function H.stopAll()
	H.setFarm(false) H.setFA(false) H.setDungeon(false) H.stopTravel() H.stopBoat() H.stopWalk() H.stopJump() H.stopWater() H.stopPanic()
	St.fruitMission=false St.fruitToken=St.fruitToken+1
	H.stopKill() H.stopPanic() H.stopFly() H.stopAnchor()
	H.status("STOP ALL")
end

-- ========== UI (OVAZ HUB STYLE) ==========
function H.addValueRow(parent, label, getVal, setVal, step, minV, maxV, key)
	local row=Instance.new("Frame")
	row.Size=UDim2.new(1,0,0,36)
	row.BackgroundColor3=C.BG3
	row.BorderSizePixel=0
	row.Parent=parent
	H.mkCorner(row,8)
	local l=Instance.new("TextLabel")
	l.Size=UDim2.new(0.5,0,1,0)
	l.Position=UDim2.new(0,14,0,0)
	l.BackgroundTransparency=1
	l.Text=label
	l.TextColor3=C.TXT
	l.Font=Enum.Font.Gotham
	l.TextSize=13
	l.TextXAlignment=Enum.TextXAlignment.Left
	l.Parent=row
	local val=Instance.new("TextLabel")
	val.Name="Val"
	val.Size=UDim2.new(0,42,1,0)
	val.Position=UDim2.new(1,-108,0,0)
	val.BackgroundTransparency=1
	val.Text=tostring(math.floor(getVal()+0.5))
	val.TextColor3=C.TH2
	val.Font=Enum.Font.GothamBold
	val.TextSize=13
	val.Parent=row
	local function refresh() val.Text=tostring(math.floor(getVal()+0.5)) end
	local function mk(txt,x)
		local b=Instance.new("TextButton")
		b.Size=UDim2.new(0,28,0,24)
		b.Position=UDim2.new(1,x,0.5,-12)
		b.BackgroundColor3=C.BG2
		b.Text=txt
		b.TextColor3=C.TXT
		b.Font=Enum.Font.GothamBold
		b.TextSize=14
		b.Parent=row
		H.mkCorner(b,6)
		return b
	end
	local minus=mk("-",-62)
	local plus=mk("+",-30)
	minus.MouseButton1Click:Connect(function() setVal(math.clamp(getVal()-step,minV,maxV)) refresh() end)
	plus.MouseButton1Click:Connect(function() setVal(math.clamp(getVal()+step,minV,maxV)) refresh() end)
	if key then R.toggles[key]=val end
	return row
end

function H.addToggle(parent, text, key, callback, sub)
	local row=Instance.new("TextButton")
	row.Size=UDim2.new(1,0,0,36)
	row.BackgroundColor3=C.BG3
	row.BorderSizePixel=0
	row.Text=""
	row.AutoButtonColor=false
	row.Parent=parent
	H.mkCorner(row,8)
	local l=Instance.new("TextLabel")
	l.Name="Lbl"
	l.Size=UDim2.new(1,-70,1,0)
	l.Position=UDim2.new(0,14,0,0)
	l.BackgroundTransparency=1
	l.Text=text
	l.TextColor3=C.TXT
	l.Font=Enum.Font.Gotham
	l.TextSize=13
	l.TextXAlignment=Enum.TextXAlignment.Left
	l.Parent=row
	-- Ovaz-style pill toggle
	local track=Instance.new("Frame")
	track.Name="Track"
	track.Size=UDim2.new(0,42,0,22)
	track.Position=UDim2.new(1,-54,0.5,-11)
	track.BackgroundColor3=C.OFF
	track.BorderSizePixel=0
	track.Parent=row
	H.mkCorner(track,11)
	local knob=Instance.new("Frame")
	knob.Name="Knob"
	knob.Size=UDim2.new(0,18,0,18)
	knob.AnchorPoint=Vector2.new(0,0.5)
	knob.Position=UDim2.new(0,2,0.5,0)
	knob.BackgroundColor3=Color3.fromRGB(255,255,255)
	knob.BorderSizePixel=0
	knob.Parent=track
	H.mkCorner(knob,9)
	R.toggles[key]=track
	row.MouseButton1Click:Connect(function() pcall(callback) end)
	return row
end

function H.addBtn(parent, text, cb)
	local b=Instance.new("TextButton")
	b.Size=UDim2.new(1,0,0,34)
	b.BackgroundColor3=C.BG3
	b.Text=text
	b.TextColor3=C.TXT
	b.Font=Enum.Font.Gotham
	b.TextSize=13
	b.Parent=parent
	H.mkCorner(b,8)
	b.MouseButton1Click:Connect(cb)
	b.MouseEnter:Connect(function() b.BackgroundColor3=Color3.fromRGB(40,55,85) end)
	b.MouseLeave:Connect(function() b.BackgroundColor3=C.BG3 end)
	return b
end

function H.addSection(parent, title)
	local s=Instance.new("TextLabel")
	s.Size=UDim2.new(1,0,0,28)
	s.BackgroundTransparency=1
	s.Text=title
	s.TextColor3=C.TXT
	s.Font=Enum.Font.GothamBold
	s.TextSize=15
	s.TextXAlignment=Enum.TextXAlignment.Left
	s.Parent=parent
	return s
end

function H.addCard(parent, title, tag)
	local wrap=Instance.new("Frame")
	wrap.Size=UDim2.new(1,0,0,0)
	wrap.AutomaticSize=Enum.AutomaticSize.Y
	wrap.BackgroundTransparency=1
	wrap.Parent=parent
	local lay=Instance.new("UIListLayout")
	lay.Padding=UDim.new(0,6)
	lay.SortOrder=Enum.SortOrder.LayoutOrder
	lay.Parent=wrap
	H.addSection(wrap, title)
	return wrap
end

function H.vis(btn,on)
	if not btn then return end
	local track=btn:FindFirstChild("Track") or btn
	local knob=track and track:FindFirstChild("Knob")
	if track and (track:IsA("Frame") or track:IsA("TextButton")) then
		track.BackgroundColor3=on and C.ON or C.OFF
	end
	if knob then
		knob.Position=on and UDim2.new(0,22,0.5,0) or UDim2.new(0,2,0.5,0)
		knob.BackgroundColor3=Color3.fromRGB(255,255,255)
	end
	local row=btn.Parent
	if row then
		local l=row:FindFirstChild("Lbl")
		if l then l.TextColor3=C.TXT end
	end
end

function H.buildUI()
	pcall(function()
		for _,n in ipairs({"AtomicBloxFruit","AtomicFruitESP","MouseCircleAim"}) do
			local o=PG:FindFirstChild(n) if o then o:Destroy() end
		end
	end)

	local gui=Instance.new("ScreenGui")
	gui.Name="AtomicBloxFruit"
	gui.ResetOnSpawn=false
	gui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
	gui.IgnoreGuiInset=true
	gui.Parent=PG

	-- main window
	local frame=Instance.new("Frame")
	frame.Name="Main"
	frame.Size=UDim2.new(0,580,0,420)
	frame.Position=UDim2.new(0.5,-290,0.5,-210)
	frame.BackgroundColor3=C.BG
	frame.BorderSizePixel=0
	frame.Parent=gui
	H.mkCorner(frame,12)

	-- title bar
	local top=Instance.new("Frame")
	top.Size=UDim2.new(1,0,0,36)
	top.BackgroundColor3=C.BG2
	top.BorderSizePixel=0
	top.Parent=frame
	H.mkCorner(top,12)
	local topFix=Instance.new("Frame")
	topFix.Size=UDim2.new(1,0,0,14)
	topFix.Position=UDim2.new(0,0,1,-14)
	topFix.BackgroundColor3=C.BG2
	topFix.BorderSizePixel=0
	topFix.Parent=top

	local title=Instance.new("TextLabel")
	title.Size=UDim2.new(0,280,1,0)
	title.Position=UDim2.new(0,14,0,0)
	title.BackgroundTransparency=1
	title.Text="Atomic Hub : Blox Fruit"
	title.TextColor3=C.TXT
	title.Font=Enum.Font.GothamMedium
	title.TextSize=13
	title.TextXAlignment=Enum.TextXAlignment.Left
	title.Parent=top

	R.statusLbl=Instance.new("TextLabel")
	R.statusLbl.Size=UDim2.new(0,160,1,0)
	R.statusLbl.Position=UDim2.new(1,-200,0,0)
	R.statusLbl.BackgroundTransparency=1
	R.statusLbl.Text="ready"
	R.statusLbl.TextColor3=C.OK
	R.statusLbl.Font=Enum.Font.Gotham
	R.statusLbl.TextSize=12
	R.statusLbl.TextXAlignment=Enum.TextXAlignment.Right
	R.statusLbl.Parent=top

	local closeBtn=Instance.new("TextButton")
	closeBtn.Size=UDim2.new(0,28,0,28)
	closeBtn.Position=UDim2.new(1,-34,0.5,-14)
	closeBtn.BackgroundTransparency=1
	closeBtn.Text="×"
	closeBtn.TextColor3=C.TX2
	closeBtn.Font=Enum.Font.GothamBold
	closeBtn.TextSize=18
	closeBtn.Parent=top
	closeBtn.MouseButton1Click:Connect(function() frame.Visible=false end)

	-- left sidebar
	local SIDE=168
	local side=Instance.new("ScrollingFrame")
	side.Size=UDim2.new(0,SIDE,1,-44)
	side.Position=UDim2.new(0,8,0,40)
	side.BackgroundTransparency=1
	side.BorderSizePixel=0
	side.ScrollBarThickness=2
	side.ScrollBarImageColor3=C.TH
	side.CanvasSize=UDim2.new(0,0,0,400)
	side.Parent=frame
	local sideLay=Instance.new("UIListLayout")
	sideLay.Padding=UDim.new(0,5)
	sideLay.Parent=side
	sideLay:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		side.CanvasSize=UDim2.new(0,0,0,sideLay.AbsoluteContentSize.Y+10)
	end)

	-- right content
	local content=Instance.new("Frame")
	content.Size=UDim2.new(1,-SIDE-20,1,-48)
	content.Position=UDim2.new(0,SIDE+14,0,42)
	content.BackgroundTransparency=1
	content.BorderSizePixel=0
	content.Parent=frame

	local tabs={
		{"Farm","Tab Farming"},
		{"Dungeon","Tab Dungeon"},
		{"Fruit","Tab Fruit"},
		{"Travel","Tab Teleport"},
		{"PvP","Tab PvP"},
		{"Move","Tab Local Player"},
		{"Visual","Tab Setting"},
	}

	local function showTab(name)
		for n,p in pairs(R.panels) do p.Visible=(n==name) end
		for n,b in pairs(R.tabBtns) do
			local on=(n==name)
			b.BackgroundColor3=on and Color3.fromRGB(40,70,120) or C.BG3
			b.TextColor3=on and Color3.fromRGB(180,220,255) or C.TX2
		end
	end

	for i,info in ipairs(tabs) do
		local name,label=info[1],info[2]
		local b=Instance.new("TextButton")
		b.Size=UDim2.new(1,-4,0,34)
		b.BackgroundColor3=C.BG3
		b.Text="  "..label
		b.TextColor3=C.TX2
		b.Font=Enum.Font.Gotham
		b.TextSize=12
		b.TextXAlignment=Enum.TextXAlignment.Left
		b.AutoButtonColor=false
		b.LayoutOrder=i
		b.Parent=side
		H.mkCorner(b,8)
		R.tabBtns[name]=b

		local panel=Instance.new("ScrollingFrame")
		panel.Size=UDim2.new(1,0,1,0)
		panel.BackgroundTransparency=1
		panel.BorderSizePixel=0
		panel.ScrollBarThickness=3
		panel.ScrollBarImageColor3=C.TH
		panel.CanvasSize=UDim2.new(0,0,0,600)
		panel.Visible=false
		panel.Parent=content
		local lay=Instance.new("UIListLayout")
		lay.Padding=UDim.new(0,6)
		lay.Parent=panel
		local pd=Instance.new("UIPadding")
		pd.PaddingTop=UDim.new(0,4)
		pd.PaddingBottom=UDim.new(0,16)
		pd.PaddingRight=UDim.new(0,6)
		pd.Parent=panel
		lay:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			panel.CanvasSize=UDim2.new(0,0,0,lay.AbsoluteContentSize.Y+20)
		end)
		R.panels[name]=panel
		b.MouseButton1Click:Connect(function() showTab(name) end)
	end

	-- FARM
	local pf=R.panels.Farm
	H.addSection(pf,"Farming")
	H.addToggle(pf,"Fast Attack","fa",function() H.setFA(not St.fastAttack) end)
	H.addToggle(pf,"Auto Farm","farm",function() H.setFarm(not St.farm) end)
	H.addToggle(pf,"Vacuum","vac",function() H.setVac(not St.vacuum) end)
	H.addSection(pf,"Quest")
	H.addToggle(pf,"Accept Quests","quest",function() H.setQuest(not St.autoQuest) end)
	H.addToggle(pf,"Lock Mob Type","lock",function() H.setLock(not St.lockType) end)
	H.addToggle(pf,"Buso Auto","buso",function() H.setBuso(not St.buso) end)
	R.questLbl=Instance.new("TextLabel")
	R.questLbl.Size=UDim2.new(1,0,0,18)
	R.questLbl.BackgroundTransparency=1
	R.questLbl.Text="Quest: -"
	R.questLbl.TextColor3=C.TX2
	R.questLbl.Font=Enum.Font.Gotham
	R.questLbl.TextSize=12
	R.questLbl.TextXAlignment=Enum.TextXAlignment.Left
	R.questLbl.Parent=pf
	H.addSection(pf,"Weapon")
	H.addBtn(pf,"Melee",function() H.setWep("melee") end)
	H.addBtn(pf,"Sword",function() H.setWep("sword") end)
	H.addBtn(pf,"Gun",function() H.setWep("gun") end)
	H.addBtn(pf,"Fruit M1",function() H.setWep("fruit") end)

	-- DUNGEON
	local pd=R.panels.Dungeon
	H.addSection(pd,"Dungeon")
	H.addToggle(pd,"Auto Dungeon","dungeon",function() H.setDungeon(not St.dungeon) end)
	H.addToggle(pd,"Auto V4","v4",function() H.setV4(not St.autoV4) end)
	H.addBtn(pd,"Reset Floors",function()
		St.doorDoneThisRoom=false St.doorBusy=false
		H.status("Floors reset")
	end)

	-- FRUIT
	local pfr=R.panels.Fruit
	H.addSection(pfr,"Fruit")
	H.addToggle(pfr,"Fruit ESP + Auto Go","fesp",function() H.setFESP(not St.fruitEsp) end)
	H.addToggle(pfr,"Auto Store","store",function() H.setStore(not St.autoStore) end)
	R.fruitInfo=Instance.new("TextLabel")
	R.fruitInfo.Size=UDim2.new(1,0,0,18)
	R.fruitInfo.BackgroundTransparency=1
	R.fruitInfo.Text="0 fruit(s)"
	R.fruitInfo.TextColor3=C.TH2
	R.fruitInfo.Font=Enum.Font.Gotham
	R.fruitInfo.TextSize=12
	R.fruitInfo.TextXAlignment=Enum.TextXAlignment.Left
	R.fruitInfo.Parent=pfr
	H.addBtn(pfr,"Scan + Go nearest",function()
		H.scanF()
		if R.fruitList[1] then H.goFruit(R.fruitList[1]) else H.status("No fruit") end
	end)

	-- TRAVEL
	local pt=R.panels.Travel
	H.addSection(pt,"Sea")
	local seaBox=Instance.new("TextLabel")
	seaBox.Size=UDim2.new(1,0,0,18)
	seaBox.BackgroundTransparency=1
	seaBox.Text="Sea "..St.currentSea
	seaBox.TextColor3=C.TXT
	seaBox.Font=Enum.Font.GothamBold
	seaBox.TextSize=13
	seaBox.TextXAlignment=Enum.TextXAlignment.Left
	seaBox.Parent=pt
	H.addBtn(pt,"Sea 1",function() St.currentSea=1 seaBox.Text="Sea 1" H.refreshIslands() end)
	H.addBtn(pt,"Sea 2",function() St.currentSea=2 seaBox.Text="Sea 2" H.refreshIslands() end)
	H.addBtn(pt,"Sea 3",function() St.currentSea=3 seaBox.Text="Sea 3" H.refreshIslands() end)
	H.addSection(pt,"Islands")
	R.islandFolder=Instance.new("Frame")
	R.islandFolder.Size=UDim2.new(1,0,0,0)
	R.islandFolder.AutomaticSize=Enum.AutomaticSize.Y
	R.islandFolder.BackgroundTransparency=1
	R.islandFolder.Parent=pt
	Instance.new("UIListLayout",R.islandFolder).Padding=UDim.new(0,5)
	function H.refreshIslands()
		for _,c in ipairs(R.islandFolder:GetChildren()) do
			if c:IsA("TextButton") then c:Destroy() end
		end
		local list=H.SEAS[St.currentSea] or {}
		for _,isle in ipairs(list) do
			H.addBtn(R.islandFolder,isle[1],function() H.travelTo(isle[2],isle[1]) end)
		end
		H.status("Sea "..St.currentSea.." | "..#list.." islands")
	end
	H.refreshIslands()

	-- PVP
	local pp=R.panels.PvP
	H.addSection(pp,"Aim")
	H.addToggle(pp,"Silent Aim","silent",function() H.setSilent(not St.silent) end)
	H.addToggle(pp,"Circle Aim","circle",function() H.setCircle(not St.circleAim) end)
	H.addValueRow(pp,"Circle size",function() return C.CR end,function(v) C.CR=v end,10,C.CR_MIN,C.CR_MAX,"crVal")
	H.addToggle(pp,"Fast Attack Players","pvpfa",function()
		St.pvpFA=not St.pvpFA
		H.vis(R.toggles.pvpfa,St.pvpFA)
		if St.pvpFA then
			if not St.fastAttack then H.setFA(true) end
			H.ensureFA()
		end
	end)
	H.addSection(pp,"Kill")
	H.addToggle(pp,"Auto Kill Orbit","kill",function() H.setKillT(not St.kill) end)
	H.addValueRow(pp,"Kill height",function() return C.OH end,function(v) C.OH=v end,5,C.OH_MIN,C.OH_MAX,"ohVal")
	H.addValueRow(pp,"Kill radius",function() return C.OR end,function(v) C.OR=v end,2,C.OR_MIN,C.OR_MAX,"orVal")
	H.addToggle(pp,"Player ESP","esp",function() H.setESP(not St.esp) end)
	H.addToggle(pp,"Auto Panic","panic",function() H.setPanicT(not St.panicAuto) end)

	-- MOVE
	local pm=R.panels.Move
	H.addSection(pm,"Fly / Boat")
	H.addToggle(pm,"Fly","fly",function() H.setFlyT(not St.fly) end)
	H.addValueRow(pm,"Fly speed",function() return C.FLY end,function(v) C.FLY=v end,20,C.FLY_MIN,C.FLY_MAX,"flyVal")
	H.addToggle(pm,"Speed Boat","boat",function() H.setBoat(not St.boat) end)
	H.addValueRow(pm,"Boat speed",function() return C.BOAT end,function(v) C.BOAT=v end,20,C.BOAT_MIN,C.BOAT_MAX,"boatVal")
	H.addSection(pm,"Ground")
	H.addToggle(pm,"Walk Speed","walk",function() H.setWalk(not St.walkOn) end)
	H.addValueRow(pm,"Walk value",function() return C.WALK end,function(v) C.WALK=v end,5,C.WALK_MIN,C.WALK_MAX,"walkVal")
	H.addToggle(pm,"Walk on Water","water",function() H.setWater(not St.waterWalk) end)
	H.addToggle(pm,"Jump Power","jump",function() H.setJump(not St.jumpOn) end)
	H.addValueRow(pm,"Jump value",function() return C.JUMP end,function(v) C.JUMP=v end,10,C.JUMP_MIN,C.JUMP_MAX,"jumpVal")
	H.addToggle(pm,"Anchor","anchor",function() H.setAnc(not St.anchor) end)
	H.addBtn(pm,"STOP ALL",function() H.stopAll() end)

	-- VISUAL
	local pv=R.panels.Visual
	H.addSection(pv,"Render")
	H.addToggle(pv,"Gray Map","gray",function() H.setGray(not St.gray) end)
	H.addToggle(pv,"FPS Boost","fps",function() H.setFPS(not St.fps) end)

	showTab("Farm")

	-- drag
	local dragging,dstart,spos=false,nil,nil
	top.InputBegan:Connect(function(input)
		if input.UserInputType==Enum.UserInputType.MouseButton1 then
			dragging=true dstart=input.Position spos=frame.Position
		end
	end)
	top.InputEnded:Connect(function(input)
		if input.UserInputType==Enum.UserInputType.MouseButton1 then dragging=false end
	end)
	Svc.UIS.InputChanged:Connect(function(input)
		if dragging and input.UserInputType==Enum.UserInputType.MouseMovement then
			local d=input.Position-dstart
			frame.Position=UDim2.new(spos.X.Scale,spos.X.Offset+d.X,spos.Y.Scale,spos.Y.Offset+d.Y)
		end
	end)

	-- floating open button (top center)
	local openBtn=Instance.new("TextButton")
	openBtn.Size=UDim2.new(0,48,0,48)
	openBtn.Position=UDim2.new(0.5,-24,0,12)
	openBtn.AnchorPoint=Vector2.new(0,0)
	openBtn.BackgroundColor3=C.BG2
	openBtn.Text="A"
	openBtn.TextColor3=C.TH
	openBtn.Font=Enum.Font.GothamBold
	openBtn.TextSize=20
	openBtn.ZIndex=50
	openBtn.Parent=gui
	H.mkCorner(openBtn,12)
	H.mkStroke(openBtn,1.5,C.TH)
	openBtn.MouseButton1Click:Connect(function() frame.Visible=not frame.Visible end)

	R.mainFrame=frame
end

-- ========== INPUT ==========
-- No feature hotkeys: control everything from the UI button only.
-- WASD / Space / LeftShift still tracked for Fly movement.
Svc.UIS.InputBegan:Connect(function(input,gp)
	if input.KeyCode==Enum.KeyCode.W then R.keys.W=true end
	if input.KeyCode==Enum.KeyCode.A then R.keys.A=true end
	if input.KeyCode==Enum.KeyCode.S then R.keys.S=true end
	if input.KeyCode==Enum.KeyCode.D then R.keys.D=true end
	if input.KeyCode==Enum.KeyCode.Space then R.keys.Space=true end
	if input.KeyCode==Enum.KeyCode.LeftShift then R.keys.LeftShift=true end
end)
Svc.UIS.InputEnded:Connect(function(input)
	if input.KeyCode==Enum.KeyCode.W then R.keys.W=false end
	if input.KeyCode==Enum.KeyCode.A then R.keys.A=false end
	if input.KeyCode==Enum.KeyCode.S then R.keys.S=false end
	if input.KeyCode==Enum.KeyCode.D then R.keys.D=false end
	if input.KeyCode==Enum.KeyCode.Space then R.keys.Space=false end
	if input.KeyCode==Enum.KeyCode.LeftShift then R.keys.LeftShift=false end
end)

Svc.Run.RenderStepped:Connect(function()
	if St.circleAim and St.circleOn then
		local mp=Svc.UIS:GetMouseLocation()
		local plr,part,pos=H.inCirc(mp)
		R.cPlr,R.cPart,R.cPos=plr,part,pos
		St.inCircle=plr~=nil
		H.updCirc(mp)
	elseif R.circleGui then
		R.circleGui.Enabled=false
	end
end)
Svc.Run.Heartbeat:Connect(function()
	if St.silent or St.kill then
		if not St.panic then
			local plr,part,pos
			if St.kill then plr,part,pos=H.lockedOrNear() else plr,part,pos=H.nearestPlr() end
			R.tPlr,R.tPart,R.tPos=plr,part,pos
		end
	end
	if St.panicAuto and not St.panic then
		local _,hum=H.hrp()
		if hum and hum.Health>0 and hum.Health<C.PHP then
			H.startPanic(false)
		end
	end
end)

task.spawn(function()
	while true do
		task.wait(1)
		if St.autoQuest then pcall(H.maintainQuest) end
		if St.autoStore then pcall(H.autoStore) end
	end
end)

LP.CharacterAdded:Connect(function()
	H.stopPin() H.stopAnchor() H.stopFly() H.stopTravel() H.stopKill() H.stopPanic()
	St.busoOnThisLife=false
	St.fruitToken=St.fruitToken+1 St.fruitMission=false
	local wasDungeon=St.dungeon
	if wasDungeon then
		St.dungeonToken=St.dungeonToken+1
		St.dungeonRunning=false
		St.doorBusy=false
		St.doorDoneThisRoom=false
		H.cancelTween()
	end
	H.clearDied()
	task.wait(1.2)
	Mouse=LP:GetMouse()
	-- Buso spam like standalone
	for i=1,5 do
		H.buso()
		task.wait(0.35)
	end
	H.equipWep()
	if St.fly then H.startFly() end
	if St.anchor then H.startAnchor() end
	if St.walkOn then H.startWalk() end
	if St.jumpOn then H.startJump() end
	if St.waterWalk then H.startWater() end
	if St.boat then H.startBoat() end
	if St.fastAttack then H.setFA(true) end
	if St.farm then H.setFarm(true) end
	if St.kill then H.startKill() end
	if St.esp then H.setESP(true) end
	if wasDungeon then
		task.wait(0.5)
		St.doorDoneThisRoom=false
		St.doorBusy=false
		H.setDungeon(true)
	end
end)

H.buildUI()
H.setupHooks()
H.ensureV4Loop()

-- Panic ON by default
task.defer(function()
	pcall(function()
		if St.panicAuto then
			H.vis(R.toggles.panic, true)
			local _,hum=H.hrp()
			if hum and hum.Health>0 and hum.Health<C.PHP then
				H.startPanic(false)
			end
		end
	end)
end)

print("[Atomic Blox Fruit] LOADED OK")
print("UI only — click the icon to open. No hotkeys.")

end) -- pcall

if not okAll then
	warn("[Atomic] ERROR: "..tostring(errAll))
	pcall(function()
		game:GetService("StarterGui"):SetCore("SendNotification",{
			Title="Atomic Error", Text=tostring(errAll):sub(1,120), Duration=12
		})
	end)
else
	print("[Atomic] all good")
end