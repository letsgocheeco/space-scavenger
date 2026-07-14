pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
//init
 
function _init()
 //init objects
 iply()
 ispace()
 iscraps()
 //tmp stuff
-- highscrapvlu=scraps[1]
-- highscraptier=scraps[2]
 
 //tick counter
	t=0
	
	//stars and scraps base speed 
	basespdcf=0.04

 //stage info
 stage=1
 fadeinit=true
 fadedir="left"
 imptax=100
 
 //gameinfo
 gmstate="init"
 initanim=false
 
end

function iply()
 ply={
		x=63*63, 
		y=63*31,
		inispd=0.2,
		spd=0.2,
		money=0,
		maxmoney=0,
		taxpaid=0,
		mnmade=0,
		maxstorage=5,
		storage=0,
		storagevlu=0,
		onturbo=false,
		spr=1,
		mvm=false,
		tempcore=0
	}
	
	//tempcore
	maxtempcore=6
	
	//no upgrade
	noeng={
		typ=0,
	 name="basic",
	 clr=7,
		turbo=0,
		accdly=1
	}
	
	//tier 1 upgrade
	quantumeng={
	 typ=1,
	 name="quantum",
	 clr=11,
	 turbo=0.5,
	 accdly=120,
	 uplyanim={13,29,45,61,14,30},
	 lplyanim={46,62,15,31,47,63},
	 ulplyanim={112,113,114,115,116,117},
	 dlplyanim={118,119,120,121,122,123}
	}
	
	//tier 2 upgrade
	lseng={
		typ=2,
		name="lightspeed",
	 clr=8,
		turbo=0.75,
		accdly=90,
		uplyanim={80,81,82,83,84,85},
	 lplyanim={86,87,88,89,90,91},
	 ulplyanim={96,97,98,99,100,101},
	 dlplyanim={102,103,104,105,106,107}
	}
	
	//tier 3 upgrade
	ftleng={
	 typ=3,
	 name="ftl",
	 clr=10,
	 turbo=1,
	 accdly=60,
	 uplyanim={13,81,19,61,84,22},
	 lplyanim={46,87,25,31,90,28},
	 ulplyanim={112,97,35,115,100,38},
	 dlplyanim={118,103,41,121,106,44}
	}
	
 engine=noeng
	
	uplyanim={17,18,19,20,21,22}
	lplyanim={23,24,25,26,27,28}
	ulplyanim={33,34,35,36,37,38}
	dlplyanim={39,40,41,42,43,44}
	
	plyanim={
	 x=ply.x,
	 y=ply.y+8,
	 spr=uplyanim,
	 xflip=false,
	 yflip=false,
	 shockwave=false,
	}
	
	shockwaves={}
	explosions={}
	shockwaveclr={8,10,11,12,14}
	
	//turbo shakecam
	shakedly=100
	shaketimer=0
	shakestrength=2
	
	camxoffset=0
	camyoffset=0
	
	//ship deceleration
	dcldly=60
	dclpercentage=0.09
	dcltimer=0
	
	//fictional pos
	xpos=ply.x
	ypos=ply.y
	
	//deny scrap pickup
	denydly=40
	denytimer=denydly
	denyclr={8,8,8,8,8}
	
	//money blink timer
	mnblinkdly=100
	mnblinktimer=0
	stvlublinkdly=100
	stvlublinktimer=0
	
 music(0)
end

function ispace()
 stars={}
 planets={}
 
 //space station
 station={
  x=ply.x-127+rnd(4000)-2000,
 	y=ply.y-127+rnd(4000)-2000,
 	spr=136,
 	spd=5,
 	rate=0
 }
 
 wypt={
  x=ply.x-5,
  y=ply.y-5,
		exs=false,
	 spr=57 
 }
 
 //planet
 for i=0,2 do
  xflip=rnd(2)-1
  yflip=rnd(2)-1
  xflip=(xflip>0) and true or false
  yflip=(yflip>0) and true or false
 	planet={
 	 x=ply.x-127+rnd(2000)-1000,
 	 y=ply.y-127+rnd(2000)-1000,
 	 xflip=xflip,
 	 yflip=yflip,
 		spr=76+i*64,
 		spd=5,
 		rate=1+flr(rnd(25))
 	}
 	add(planets,planet)
 end
 
 //stars
	for i=0,100 do
		star={
		 x=ply.x-127+rnd(255),
		 y=ply.y-127+rnd(255),
		 spd=2.6,
		 clr=7,
	 }
	 add(stars,star)
	end
	for i=0,75 do
		star={
		 x=ply.x-127+rnd(255),
		 y=ply.y-127+rnd(255),
		 spd=10,
		 clr=5,
	 }
	 add(stars,star)
	end
	for i=0,50 do
		star={
		 x=ply.x-127+rnd(255),
		 y=ply.y-127+rnd(255),
		 spd=0.5,
		 clr=1,
	 }
	 add(stars,star)
	end
	for i=0,5 do
		star={
		 x=ply.x-127+rnd(255),
		 y=ply.y-127+rnd(255),
		 spd=1,
		 clr=8,
	 }
	 add(stars,star)
	end
	for i=0,10 do
		star={
		 x=ply.x-127+rnd(255),
		 y=ply.y-127+rnd(255),
		 spd=1.6,
		 clr=11,
	 }
	 add(stars,star)
	end
	for i=0,10 do
		star={
		 x=ply.x-127+rnd(255),
		 y=ply.y-127+rnd(255),
		 spd=1.3,
		 clr=12,
	 }
	 add(stars,star)
	end
	for i=0,10 do
		star={
		 x=ply.x-127+rnd(255),
		 y=ply.y-127+rnd(255),
		 spd=1.9,
		 clr=10,
	 }
	 add(stars,star)
	end
end

function iscraps()

	pickupdly=240
	pickuptimer=0
	
	spwanscrapdly=5*60
	spawnscraptimer=0
	maxscraps=7
 scraps={}
 scraptypes={
 	"broken wing",
 	"carburator",
 	"photon absorber",
 	"quantum orb",
 	"alien adapter",
 	"laser weapon",
 	"battery cable",
 	"microprocessor"
 }
 
 for i=0,maxscraps do
 	spawnscrap()
 end
end
-->8
//update

function _update60()
 t+=1
 //title screen
 if gmstate=="init" then
  mv(stars,basespdcf)
  resetelem(stars,160,255)
 	if btnp(❎) then
 	 sfx(29)
 		gmstate="level"
-- 		music(0)
		end
 end
 //level
 if gmstate=="level" then
		mvply()
		turboply()
		mv(stars,basespdcf)
		mv(scraps,basespdcf)
		mv(planets,basespdcf)
		mv({station},basespdcf)
		mvshockwave()
		mvexplosion()
		resetelem(stars,150,255)
		resetelem(scraps,1000,375)
		resetelem(planets,2000,1000)
		resetelem({station},4000,2000)
		pickup()
		sellscraps()
		waypoint()
		timer()
	end
	
	if gmstate=="fade" then
	 camxoffset=0
	 camyoffset=0
	 if ttmp==nil then
	  ttmp=t
  end
		if t-ttmp>5 and fadeinit==true then
		 gmstate=nxtstate
			ttmp=nil
		end
	end
	
	//stage complete
	if gmstate=="stcmpl" then
	 if stcmplprint and btnp(❎) then
	  tmpt=t
	  goshop=true
 	 setstage()
		 ispace()
		 iscraps()
 		stcmplprint=false
 		fktotal=nil
  end
  if tmpt!=nil and t-tmpt==1 and goshop then
		 tmpt=nil
		 goshop=false
			gmstate="shop"
		end
	end
	
	//game over
	if gmstate=="gmover" then
		if gmoverprint and btnp(❎) then
		 iply()
 	 ispace()
 	 iscraps()
 	 resetstage()
			tmpt=nil
			gmoverprint=false
			fktotal=nil
			gmstate="init"
		end
	end
	
	//shop
	if gmstate=="shop" then
	
	 //init shop
	 if shopset==nil then
	  shopset=true
	 	setshop()
	 	
	 	menu={
		 typ="main",
		 choice=1,
		 maxchoice=3,
		 choicenames={"buy","sell","next stage"}
		}
  end

		//move cursor
		if btnp(⬇️) then
			if menu.choice<menu.maxchoice then
			 sfx(23)
				menu.choice+=1
			end
		end
		if btnp(⬆️) then
			if menu.choice>1 then
			 sfx(23)
				menu.choice-=1
			end
		end
		
		//navigate menus
		if btnp(❎) then
		 
		 //navigate main menu
			if menu.typ=="main" then
			 
			 //buy
				if menu.choice==1 then
					menu={
					 typ="buy",
					 choice=1,
					 maxchoice=buymaxchoice,
					 choicenames=buychoicenames
					}
				 sfx(23)
				 
				//sell
				elseif menu.choice==2 then
					if ply.storagevlu>0 then				
						sellscraps()
					else
						sfx(27)
					end
					
				//next stage
				elseif menu.choice==3 then
				 shopset=nil
					gmstate="level"
					sfx(29)
				end
				
			//navigate buy menu
			elseif menu.typ=="buy" then
			
			 //buy storage
				if menu.choice==1 then
					if ply.money>=shop.storageprice then
					 sfx(18)
						ply.money-=shop.storageprice
						ply.maxstorage+=1
					else
						sfx(27)
					end
					mnblinktimer=mnblinkdly
					
				//buy temporal core or engine
				elseif menu.choice==2 then
					if ply.tempcore<maxtempcore then
					 if ply.money>=shop.tempcoreprice then
							sfx(18)
							ply.money-=shop.tempcoreprice
							ply.tempcore+=1
							if ply.tempcore==maxtempcore then
								menu.maxchoice-=1
								buymaxchoice-=1
								menu.choice-=1
								if engine==ftleng then
									buychoicenames={"storage"}
									menu.choicenames={"storage"}
								else
									buychoicenames={"storage",shop.eng.name.." engine"}
									menu.choicenames={"storage",shop.eng.name.." engine"}
								end
							end
						end
					elseif ply.money>=shop.engprice then
					 sfx(18)
						ply.money-=shop.engprice
						engine=shop.eng
						menu.maxchoice-=1
						buymaxchoice-=1
						menu.choice-=1
						if ply.tempcore==maxtempcore then
							buychoicenames={"storage"}
							menu.choicenames={"storage"}
						else
							buychoicenames={"storage","temporal core"}
							menu.choicenames={"storage","temporal core"}
						end
					else
						sfx(27)
					end
					mnblinktimer=mnblinkdly
				//buy engine
				elseif menu.choice==3 then
					if ply.money>=shop.engprice then
					 sfx(18)
						ply.money-=shop.engprice
						engine=shop.eng
						menu.maxchoice-=1
						buymaxchoice-=1
						menu.choice-=1
						if ply.tempcore==maxtempcore then
							buychoicenames={"storage"}
							menu.choicenames={"storage"}
						else
							buychoicenames={"storage","temporal core"}
							menu.choicenames={"storage","temporal core"}
						end
					else
						sfx(27)
					end
					mnblinktimer=mnblinkdly
					
				end
			end
		end
		if btnp(🅾️) then
		 sfx(23)
			menu={
		 	typ="main",
		 	choice=1,
		 	maxchoice=3,
		 	choicenames={"buy","sell","next stage"}
		 }
		end
		shopblink()
	end
end

function mvply()
	if btn(⬅️) or btn(➡️) or btn(⬆️) or btn(⬇️) then
		ply.mvm=true
		dcltimer=dcldly
		if ply.onturbo then
			if ply.shockwave then
				newshockwave()
			end
			if ply.explosion then
				newexplosion()
			end
			if shaketimer>0 then
				shake()
				shaketimer-=1
			else
				camxoffset=0
				camyoffset=0
			end
		end
	else
		ply.mvm=false
		camxoffset=0
		camyoffset=0
	end
	if dcltimer>0 then
		dcltimer-=(dclpercentage*dcltimer)
	end
	
	if btn(⬅️) and not btn(⬆️) and not btn(⬇️) then
		xpos-=scrap.spd*ply.spd
		ply.spr=3
		plyanim.spr=lplyanim
		plyanim.x=ply.x+8
		plyanim.y=ply.y
		plyanim.xflip=false
		plyanim.yflip=false
	end
	if btn(➡️) and not btn(⬆️) and not btn(⬇️) then
		xpos+=scrap.spd*ply.spd
		ply.spr=7
		plyanim.spr=lplyanim
		plyanim.x=ply.x-8
		plyanim.y=ply.y
		plyanim.xflip=true
		plyanim.yflip=false
	end
	if btn(⬆️) and not btn(➡️) and not btn(⬅️) then
		ypos-=scrap.spd*ply.spd
		ply.spr=1
		plyanim.spr=uplyanim
		plyanim.x=ply.x
		plyanim.y=ply.y+8
		plyanim.xflip=false
		plyanim.yflip=false
	end
	if btn(⬇️) and not btn(➡️) and not btn(⬅️) then
		ypos+=scrap.spd*ply.spd
		ply.spr=5
		plyanim.spr=uplyanim
		plyanim.x=ply.x
		plyanim.y=ply.y-7
		plyanim.xflip=false
		plyanim.yflip=true
	end
	if btn(⬆️) and btn(⬅️) then
		xpos-=scrap.spd*ply.spd
		ypos-=scrap.spd*ply.spd
		ply.spr=2
		plyanim.spr=ulplyanim
		plyanim.x=ply.x+7
		plyanim.y=ply.y+7
		plyanim.xflip=false
		plyanim.yflip=false
	end
	if btn(⬇️) and btn(⬅️) then
		xpos-=scrap.spd*ply.spd
		ypos+=scrap.spd*ply.spd
		ply.spr=4
		plyanim.spr=dlplyanim
		plyanim.x=ply.x+7
		plyanim.y=ply.y-7
		plyanim.xflip=false
		plyanim.yflip=false
	end
	if btn(⬇️) and btn(➡️) then
		xpos+=scrap.spd*ply.spd
		ypos+=scrap.spd*ply.spd
		ply.spr=6
		plyanim.spr=dlplyanim
		plyanim.x=ply.x-7
		plyanim.y=ply.y-7
		plyanim.xflip=true
		plyanim.yflip=false
	end
	if btn(⬆️) and btn(➡️) then
		xpos+=scrap.spd*ply.spd
		ypos-=scrap.spd*ply.spd
		ply.spr=8
		plyanim.spr=ulplyanim
		plyanim.x=ply.x-7
		plyanim.y=ply.y+7
		plyanim.xflip=true
		plyanim.yflip=false
	end
end

function mv(coll,cf)
	staticmv(coll,cf)
	dynamicmv(coll)
	
	//deceleration
	if dcltimer>0 and not ply.mvm then
		staticmv(coll,dcltimer/250)
	end
end

function staticmv(coll,cf)
	if ply.spr==1 then
		for el in all(coll) do
			el.y+=el.spd*cf
		end
	elseif ply.spr==2 then
		for el in all(coll) do
			el.x+=el.spd*cf
			el.y+=el.spd*cf
		end
	elseif ply.spr==3 then
		for el in all(coll) do
			el.x+=el.spd*cf
		end
	elseif ply.spr==4 then
		for el in all(coll) do
			el.x+=el.spd*cf
		 el.y-=el.spd*cf
		end
	elseif ply.spr==5 then
		for el in all(coll) do
			el.y-=el.spd*cf
		end
	elseif ply.spr==6 then
		for el in all(coll) do
		 el.x-=el.spd*cf
			el.y-=el.spd*cf
		end
	elseif ply.spr==7 then
	 for el in all(coll) do
			el.x-=el.spd*cf
		end
	elseif ply.spr==8 then
		for el in all(coll) do
			el.x-=el.spd*cf
			el.y+=el.spd*cf
		end
	end
end

function dynamicmv(coll)
 if btn(⬅️) and not btn(⬆️) and not btn(⬇️) then
		for elem in all(coll) do
			elem.x+=elem.spd*ply.spd
		end
	end
	if btn(➡️) and not btn(⬆️) and not btn(⬇️) then
		for elem in all(coll) do
			elem.x-=elem.spd*ply.spd
		end
	end
	if btn(⬆️) and not btn(➡️) and not btn(⬅️) then
		for elem in all(coll) do
			elem.y+=elem.spd*ply.spd
		end
	end
	if btn(⬇️) and not btn(➡️) and not btn(⬅️) then
		for elem in all(coll) do
			elem.y-=elem.spd*ply.spd
		end
	end
	if btn(⬆️) and btn(⬅️) then
	 for elem in all(coll) do
			elem.x+=elem.spd*ply.spd
			elem.y+=elem.spd*ply.spd
		end
	end
	if btn(⬇️) and btn(⬅️) then
	 for elem in all(coll) do
			elem.x+=elem.spd*ply.spd
			elem.y-=elem.spd*ply.spd
		end
	end
	if btn(⬇️) and btn(➡️) then
	 for elem in all(coll) do
			elem.x-=elem.spd*ply.spd
			elem.y-=elem.spd*ply.spd
		end
	end
	if btn(⬆️) and btn(➡️) then
	 for elem in all(coll) do
			elem.x-=elem.spd*ply.spd
			elem.y+=elem.spd*ply.spd
		end
	end
end

function resetelem(coll,deldist,newdist)
	for elem in all(coll) do
		if abs(elem.x-ply.x)>deldist or abs(elem.y-ply.y)>deldist then
		 local newx=ply.x
		 local newy=ply.y
		 repeat
    newx=ply.x-127+rnd(newdist*2)-newdist
    newy=ply.y-127+rnd(newdist*2)-newdist
   until abs(newx-ply.x)>63 or abs(newy-ply.y)>63
			elem.x=newx
			elem.y=newy
		end
	end
end

function spawnscrap()
	if #scraps>=maxscraps then
 	return
 end
 local x
 local y
 repeat
  x=ply.x+rnd(750)-375
  y=ply.y+rnd(750)-375
 until abs(x-ply.x)>63 or abs(y-ply.y)>63
	//tier probabilities
	tier=flr(rnd(101))
	if tier<60 then
		tier="common"
		rtier=1
	elseif tier<85 then
		tier="rare"
		rtier=2
	elseif tier<95 then
		tier="epic"
		rtier=3
	elseif tier<100 then
		tier="legendary"
		rtier=4
	elseif tier==100 then
		tier="mythic"
		rtier=5
	end
	scrap={
		x=x,
		y=y,
		spd=5,
		typ=scraptypes[flr(rnd(#scraptypes))+1],
		tier=tier,
		rtier=rtier
	}
	
	//type stuff
	if scrap.typ=="broken wing" then
		scrap.spr=10
		scrap.value=3
	elseif scrap.typ=="carburator" then
		scrap.spr=11
		scrap.value=5
	elseif scrap.typ=="photon absorber" then
		scrap.spr=12
		scrap.value=10
	elseif scrap.typ=="quantum orb" then
		scrap.spr=13
		scrap.value=30
	elseif scrap.typ=="alien adapter" then
		scrap.spr=14
		scrap.value=35
	elseif scrap.typ=="laser weapon" then
		scrap.spr=15
		scrap.value=20
	elseif scrap.typ=="battery cable" then
		scrap.spr=29
		scrap.value=7
	elseif scrap.typ=="microprocessor" then
		scrap.spr=30
		scrap.value=25
	end
	
	//tier stuff
	if scrap.tier=="common" then
		scrap.clr=6
	elseif scrap.tier=="rare" then
		scrap.value=flr(scrap.value*2)
		scrap.clr=12
	elseif scrap.tier=="epic" then
		scrap.value=flr(scrap.value*4)
		scrap.clr=8
	elseif scrap.tier=="legendary" then
		scrap.value=flr(scrap.value*10)
		scrap.clr=9
	elseif scrap.tier=="mythic" then
		scrap.value=flr(scrap.value*50)
		scrap.clr=10
	end
	add(scraps,scrap)
end

function turboply()
	if engine.typ!=0 and btn(🅾️) and (btn(⬆️) or btn(⬅️) or btn(➡️) or btn(⬇️)) then
	 if acctimer<engine.accdly then
	 	acctimer+=1
  end
  if acctimer==1 then
  	sfx(1)
  end
	else
		ply.spd=ply.inispd
		ply.onturbo=false
		acctimer=0
	end
	if acctimer==engine.accdly then
	 if engine.typ>=2 then
			ply.shockwave=true
		end
		ply.explosion=true
	 acctimer+=1
		ply.spd=engine.turbo
		ply.onturbo=true
		shaketimer=shakedly
		sfx(0)
	end
end

function newshockwave()
	for i=0,2 do
		shockwave={
		x=ply.x,
		y=ply.y,
		rad=i*0,
		clr=7
		}
		add(shockwaves,shockwave)
	end
	ply.shockwave=false
end

function newexplosion()
	for i=0,3+rnd(4) do
		local x=ply.x
		local y=ply.y
	 if ply.spr==1 then
	 	x+=4
	 	y+=8
  elseif ply.spr==2 then
  	x+=8
	 	y+=8
  elseif ply.spr==3 then
  	x+=8
	 	y+=4
  elseif ply.spr==4 then
  	x+=8
  elseif ply.spr==5 then
  	x+=4
  elseif ply.spr==6 then
  	//nothing
  elseif ply.spr==7 then
  	y+=4
  elseif ply.spr==8 then
  	y+=8
  end
		explosion={
		 x=x,
		 y=y,
		 rad=5+rnd(3),
		 spd=5+rnd(3),
		 age=0+rnd(3),
		 clr=7
		}
		add(explosions,explosion)
	end
	ply.explosion=false
end

function mvshockwave()
	for shockwave in all(shockwaves) do
		shockwave.rad+=5
		shockwave.clr=shockwaveclr[t%5+1]
		if shockwave.rad>100 then
			del(shockwaves,shockwave)
		end
	end
end

function mvexplosion()
	for expl in all(explosions) do
		expl.age+=1
		expl.rad-=1
		if expl.age>5 then
			expl.clr=10
		end
		if expl.age>10 then
			expl.clr=9
		end
		if expl.age>15 then
			expl.clr=8
		end
		if expl.age>20 then
			expl.clr=1
		end
		if expl.age>25 then
			del(explosions,expl)
		end
	end
end

function shake()
	camxoffset=rnd(2*shakestrength)-shakestrength
	camyoffset=rnd(2*shakestrength)-shakestrength
end

function collides(a,b)
	local a_x1=a.x
	local a_y1=a.y
	local a_x2=a.x+7
	local a_y2=a.y+7
	
	local b_x1=b.x
	local b_y1=b.y
	local b_x2=b.x+7
	local b_y2=b.y+7
	
	if a_y1>b_y2 then return false end
	if b_y1>a_y2 then return false end
	if a_x1>b_x2 then return false end
	if b_x1>a_x2 then return false end
	
	return true
end

function pickup()
	for scrap in all(scraps) do
		if collides(ply,scrap) then
		 if ply.storage<ply.maxstorage then
		 	pickupsfx(scrap.tier)
		 	stvlublinktimer=stvlublinkdly
		 	ply.storage+=1
			 ply.storagevlu+=scrap.value
			 pickuptimer=pickupdly
			 
			 //for stats
			 if highscrapvlu==nil then
			 	highscrapvlu=scrap
    elseif scrap.value>highscrapvlu.value then
    	highscrapvlu=scrap
    end
			 if highscraptier==nil then
			 	highscraptier=scrap
    elseif scrap.rtier>highscraptier.rtier then
    	highscraptier=scrap
    end
    if runhighscrapvlu==nil then
    	runhighscrapvlu=scrap
    elseif scrap.value>runhighscrapvlu.value then
    	runhighscrapvlu=scrap
    end
    if runhighscraptier==nil then
    	runhighscraptier=scrap
    elseif scrap.rtier>runhighscraptier.rtier then
    	runhighscraptier=scrap
    end
			 
			 displayscrap={
				typ=scrap.typ,
				tier=scrap.tier,
				clr=scrap.clr,
				value=scrap.value
			 }
			 
				del(scraps,scrap)
				spawnscrap()
   else
   	if denytimer==denydly then
   		sfx(17)
   		denytimer=0
   		denyclr={6,7,8,8,8}
				end
   end
		end
	end
	if denytimer<denydly then
 	denytimer+=1
 end
 if denytimer==denydly then
 	denyclr={8,8,8,8,8}
 end
end

function pickupsfx(tier)
	if tier=="common" then
		sfx(2)
	elseif tier=="rare" then
		sfx(3)
	elseif tier=="epic" then
		sfx(4)
	elseif tier=="legendary" then
		sfx(5)
	elseif tier=="mythic" then
		sfx(6)
	end
end

function shopnear()
 if gmstate=="shop" then
 	return shop
 end
	for plt in all(planets) do
	 pltx=plt.x+16
	 plty=plt.y+16
	 if abs(pltx-ply.x)<30 and abs(plty-ply.y)<30 then
	 	return plt
	 end
	end
	stax=station.x+16
	stay=station.y+16
	if abs(stax-ply.x)<30 and abs(stay-ply.y)<30 then 
		return station
	end
	return false
end

function sellscraps()
	if shopnear()!=false and btn(❎) and ply.storagevlu!=0 then
	 mnblinktimer=mnblinkdly
	 rate=shopnear().rate
	 ply.money+=flr(ply.storagevlu+ply.storagevlu*rate/100)
	 ply.maxmoney+=flr(ply.storagevlu+ply.storagevlu*rate/100)
	 ply.mnmade+=flr(ply.storagevlu+ply.storagevlu*rate/100)
	 ply.storage=0
	 ply.storagevlu=0
	 sfx(18)
	end
	if mnblinktimer>0 then
		mnblinktimer-=1
	end
	if stvlublinktimer>0 then
		stvlublinktimer-=1
	end
end

//eve's waypoint formula <3
function waypoint()
  stax=station.x+16
  stay=station.y+16
  dtx=flr(stax-ply.x)
  dty=flr(stay-ply.y)
  if abs(dtx)>75 or abs(dty)>75 then 
   wypt.exs=true
   if abs(dtx)>abs(dty) then
   	if dtx>0 then
   	 //right
   	 wypt.spr=56
   	 wyptoffset=max(-63,58/dtx*dty)
   	 wyptoffset=min(58,wyptoffset)
   		wypt.x=ply.x+58
   		wypt.y=ply.y+wyptoffset
				else
				 //left
				 wypt.spr=54
				 wyptoffset=max(-58,58/dtx*dty)
   	 wyptoffset=min(63,wyptoffset)
					wypt.x=ply.x-65
   		wypt.y=ply.y-wyptoffset
				end
   else
   	if dty>0 then
   	 //down
   	 wypt.spr=55
   	 wyptoffset=max(-63,58/dty*dtx)
   	 wyptoffset=min(58,wyptoffset)
   	 wypt.x=ply.x+wyptoffset
   		wypt.y=ply.y+58
				else
				 //up
				 wypt.spr=53
				 wyptoffset=max(-58,58/dty*dtx)
   	 wyptoffset=min(63,wyptoffset)
				 wypt.x=ply.x-wyptoffset
					wypt.y=ply.y-65
				end
   end
  else
  	wypt.exs=false
  end
end

function setstage()
	ply.spr=1
	ply.mnmade=0
	ply.money-=imptax
	ply.taxpaid+=imptax
	stage+=1
	maxscraps+=1
	imptax+=100
	highscrapvlu=nil
	highscraptier=nil
end

function resetstage()
	stage=1
	imptax=100
	highscrapvlu=nil
	highscraptier=nil
end

function timer()
 if lvltimer==nil then
 	lvltimer=7260+(ply.tempcore*60*10)
--		lvltimer=100
 end
 if lvltimer>0 then
 	lvltimer-=1
 	for i=2,6 do
 		if lvltimer==60*i then
 			sfx(23)
			end
		end
 end
 if lvltimer==55 then
  music(-1)
  sfx(24)
 	lvltimer=nil
 	if ply.money>=imptax then
	 	nxtstate="stcmpl"
  else
  	nxtstate="gmover"
  end
 	gmstate="fade"
 end
end

function setshop()
 shop={
	 rate=1+flr(rnd(25)),
	 eng=nxteng,
	 engprice=nxtengprice,
	 storageprice=50+flr(rnd(50)),
	 tempcoreprice=50+flr(rnd(200))
	}
 
 //sets shop buyable engine
 if ply.tempcore==maxtempcore then
 	buymaxchoice=2
 else 
 	buymaxchoice=3
 end

 if engine==noeng then
 	shop.eng=quantumeng
 	shop.engprice=200+flr(rnd(100))
 	if ply.tempcore==maxtempcore then
 		buychoicenames={"storage ",shop.eng.name.." engine"}
		else
			buychoicenames={"storage ","temporal core",shop.eng.name.." engine"}
		end
 elseif engine==quantumeng then
 	shop.eng=lseng
 	shop.engprice=200+flr(rnd(200))
 	if ply.tempcore==maxtempcore then
 		buychoicenames={"storage ",shop.eng.name.." engine"}
		else
			buychoicenames={"storage ","temporal core",shop.eng.name.." engine"}
		end
 elseif engine==lseng then
 	shop.eng=ftleng
 	shop.engprice=200+flr(rnd(300))
 	if ply.tempcore==maxtempcore then
 		buychoicenames={"storage ",shop.eng.name.." engine"}
		else
			buychoicenames={"storage ","temporal core",shop.eng.name.." engine"}
		end
 elseif engine==ftleng then
 	shop.eng=nil
 	if ply.tempcore==maxtempcore then
 		buychoicenames={"storage "}
 		buymaxchoice=1
		else
			buychoicenames={"storage ","temporal core"}
			buymaxchoice=2
		end
 end
end

function shopblink()
	if mnblinktimer>0 then
		mnblinktimer-=1
	end
	if stvlublinktimer>0 then
		stvlublinktimer-=1
	end
end
-->8
//draw

function _draw()
 if gmstate=="init" then
 	cls(0)
 	camera(ply.x-63+camxoffset,ply.y-63-camyoffset)
 	
 	// stars
		for star in all(stars) do 
			pset(star.x,star.y,star.clr)
		end
		
		//title
		spr(128,ply.x-31,ply.y-40,8,4)
		pressclr={5,6,7,7,7,7,7,7}
		print("press ❎ to start a new run",ply.x-53,ply.y+30,pressclr[flr(t/4)%6+1])
 	
 elseif gmstate=="level" then
 	cls()
		camera(ply.x-63+camxoffset,ply.y-63-camyoffset)
		
		//tmp stuff
--		print(turboprc(),ply.x-10,ply.y-10)
		
		// stars
		for star in all(stars) do 
			pset(star.x,star.y,star.clr)
		end
		
		// planets, station and waypoint
		for plt in all(planets) do
			spr(plt.spr,plt.x,plt.y,4,4,plt.xflip,plt.yflip)
		end
		
		spr(station.spr,station.x,station.y,4,4)
		
		if wypt.exs then
			spr(wypt.spr,wypt.x,wypt.y)
		end
		
		// shockwaves
		for shockwave in all(shockwaves) do
			circ(shockwave.x,shockwave.y,shockwave.rad,shockwave.clr)
		end
		
		// explosions
		for expl in all(explosions) do
			circfill(expl.x,expl.y,expl.rad,expl.clr)
		end
		
		// scraps
		for scrap in all(scraps) do
			spr(scrap.spr,scrap.x,scrap.y)
		end
		
		// player
		spr(ply.spr,ply.x,ply.y)
		if ply.mvm then
		 if ply.onturbo then
		 	if engine==quantumeng then
		 		pal(12,11)
				elseif engine==lseng then
				 pal(12,8)
				elseif engine==ftleng then
					pal(12,10)
				end
   end
			spr(plyanim.spr[flr(t/1.4)%6+1],plyanim.x,plyanim.y,1,1,plyanim.xflip,plyanim.yflip)
			pal()
		end
		
		//money
		money=fmtmoney(ply.money)
		tax=fmtmoney(imptax)
		moneyclr={11,11,11,11,11,11,11,11}
		if mnblinktimer>0 then
			moneyclr={6,7,11,11,11,11,11,11}
		end
		print(money,ply.x+40,ply.y-60,moneyclr[flr(t/4)%6+1])
		print("tax:"..tax,ply.x+24,ply.y-53,6)
		stvlu=fmtmoney(ply.storagevlu)
		stvluclr={6,6,6,6,6,6,6,6}
		if stvlublinktimer>0 then
			stvluclr={7,5,6,6,6,6,6,6}
		end
		if shopnear()!=false and shopnear().rate>1 and ply.storagevlu>0 then
		 rateclr={7,5,6,6,6,6,6,6}
		 ratestvlu=fmtmoney(ply.storagevlu+ply.storagevlu*shopnear().rate/100)
			print(stvlu.." -> "..ratestvlu,ply.x-60,ply.y+45,rateclr[flr(t/4)%6+1])
		else
		 print(stvlu,ply.x-60,ply.y+45,stvluclr[flr(t/4)%6+1])
		end
		printpickup()
		
		//selling ui
		if shopnear()!=false then
			if ply.storagevlu>0 then
				sellclr={5,6,7,7,7,7,7,7}
			 print("press ❎ to sell",ply.x-29,ply.y-15,sellclr[flr(t/4)%6+1])
			end
			if shopnear().rate>0 then
			 pickuptimer=0
				print("planet rate: "..shopnear().rate.."%",ply.x-60,ply.y-60,7)
			end
		end
	
		// storage ui
	 if ply.storage==ply.maxstorage then
	 	print("full",ply.x-60,ply.y+53,denyclr[flr(t/2)%3+1])
	 else
	 	print("storage",ply.x-60,ply.y+53,7)
	 end
	 if storageprc()==0 then
	 	stclr=7
	 elseif storageprc()==50 then
	 	stclr=10
	 elseif storageprc()==75 then
	 	stclr=9
	 elseif storageprc()==100 then
	 	stclr=8
	 end
	 stcf=flr(36*storageprc()/100)
	 x1=ply.x-60+1
		y1=ply.y+57+3
		x2=ply.x-60+1+stcf
		y2=ply.y+57+4
	 spr(48,ply.x-60,ply.y+57,5,1)
	 if stcf!=0 then
			rectfill(x1,y1,x2,y2,stclr)
		end
		
		// turbo ui
  engineclr=7
  if ply.onturbo then
   engineclr=engine.clr
  end
  
  //charge bar name
  	
  if engine==quantumeng then
 		print(engine.name,ply.x+32,ply.y+53,engineclr)
		elseif engine==lseng then
			print(engine.name,ply.x+20,ply.y+53,engineclr)
		elseif engine==ftleng then
			print(engine.name,ply.x+48,ply.y+53,engineclr)
		end
		
		//charge bar qt and color
		
		if engine!=noeng then
			turboclr={7,7,7,7,7,7,7}
			if turboprc()>=25 then
				turboclr={10,10,10,10,10,10,10}
			end
			if turboprc()>=50 then
				turboclr={9,9,9,9,9,9,9}
			end
			if turboprc()>=75 then
				turboclr={8,8,8,8,8,8,8}
			end
			if turboprc()>=100 then
			 if engine==quantumeng then
			 	turboclr={13,12,11,3,2,1}
	   elseif engine==lseng then
	   	turboclr={8,9,10,4,2,14}
	   elseif engine==ftleng then
	   	turboclr={8,9,10,11,12,13,14}
	   end
			end
			lscf=flr(36*turboprc()/100)
			x1=ply.x+20+1
			y1=ply.y+57+3
			x2=ply.x+20+1+lscf
			y2=ply.y+57+4
			spr(48,ply.x+20,ply.y+57,5,1)
			if lscf!=0 then
				rectfill(x1,y1,x2,y2,turboclr[t%7+1])
			end
		end
	
		//speed ui
		if ply.mvm then
			if ply.onturbo then
				if engine==quantumeng then
					fmtspd="150 u/s"
				elseif engine==lseng then
					fmtspd="300 u/s"
				elseif engine==ftleng then
				 spr(9,ply.x+37,ply.y+45)
					fmtspd="    u/s"
				end
			else
				fmtspd="085 u/s"
			end
		else
			fmtspd="001 u/s"
		end
		if engine!=noeng then
			print(fmtspd,ply.x+32,ply.y+45,7)
		else
			print(fmtspd,ply.x+32,ply.y+59,7)
		end

 	
 	//level timer ui
 	if lvltimer!=nil then
 		lvltimerclr=7
 	if lvltimer<=360 then
 		lvltimerclr=8
			end
	 	print(fmttimer(lvltimer),ply.x-10,ply.y+59,lvltimerclr)
		end
 	
 //fade
 elseif gmstate=="fade" then
  fade()
  
 //stage completed
 elseif gmstate=="stcmpl" then
  cls()
  local ltnc=15
 	if tmpt==nil then
 		tmpt=t
		end
		if t-tmpt==ltnc*2 then
			sfx(19)
		end
		if t-tmpt>=ltnc*2 then
		 rectfill(ply.x-60-1,ply.y-60-1,ply.x+60+1,ply.y+60+1,12)
		 rectfill(ply.x-60,ply.y-60,ply.x+60,ply.y+60,1)
		 print("stage "..stage.." completed!",ply.x-33,ply.y-55,7)
		 rectfill(ply.x-33,ply.y-48,ply.x+36,ply.y-48)
		end
		if t-tmpt==ltnc*10 or t-tmpt==ltnc*12 or t-tmpt==ltnc*14 or t-tmpt==ltnc*16 then
			sfx(20)
		end
		if t-tmpt>=ltnc*10 then
			print("most valuable scrap found:",ply.x-55,ply.y-35,7)
			if highscrapvlu!=nil then
		 	print(highscrapvlu.tier.." "..highscrapvlu.typ.." "..highscrapvlu.value.."$",ply.x-55,ply.y-25,highscrapvlu.clr)
   else
   	print("none",ply.x-55,ply.y-25,7)
   end
			
		end
		if t-tmpt>=ltnc*12 then
			print("shiniest scrap found:",ply.x-55,ply.y-15,7)
			if highscraptier!=nil then
				print(highscraptier.tier.." "..highscraptier.typ.." "..highscraptier.value.."$",ply.x-55,ply.y-5,highscraptier.clr)
			else
				print("none",ply.x-55,ply.y-5,7)
			end
		end
		if t-tmpt>=ltnc*14 then
			print("money before tax: "..ply.money.."$",ply.x-55,ply.y+5,7)
		end
		if t-tmpt>=ltnc*16 then
			print("imperial tax: "..imptax.."$",ply.x-55,ply.y+15,7)
		end
		if t-tmpt>=ltnc*18 then
		 if fktotal==nil then
		 	fktotal=ply.money
   end
		 if fktotal>(ply.money-imptax) then
		 	fktotal-=2
		 	sfx(21)
   end
			print("total money: "..fktotal.."$",ply.x-55,ply.y+25,11)
		end
		if fktotal==(ply.money-imptax) then
		 stcmplprint=true
		 pressclr={5,6,7,7,7,7,7,7}
			print("press ❎ to continue",ply.x-39,ply.y+45,pressclr[flr(t/4)%6+1])
		end
		
	//game over
 elseif gmstate=="gmover" then
 	cls()
  local ltnc=15
 	if tmpt==nil then
 		tmpt=t
		end
		if t-tmpt==ltnc*2 then
			sfx(22)
		end
		if t-tmpt>=ltnc*2 then
		 rectfill(ply.x-60-1,ply.y-60-1,ply.x+60+1,ply.y+60+1,8)
		 rectfill(ply.x-60,ply.y-60,ply.x+60,ply.y+60,2)
		 print("game over...",ply.x-21,ply.y-55,7)
		end
		if t-tmpt==ltnc*10 or t-tmpt==ltnc*12 or t-tmpt==ltnc*14 or t-tmpt==ltnc*16 then
			sfx(20)
		end
		if t-tmpt>=ltnc*10 then
			print("most valuable scrap found:",ply.x-55,ply.y-35,7)
			if runhighscrapvlu!=nil then
		 	print(runhighscrapvlu.tier.." "..runhighscrapvlu.typ.." "..runhighscrapvlu.value.."$",ply.x-55,ply.y-25,runhighscrapvlu.clr)
   else
   	print("none",ply.x-55,ply.y-25,7)
   end
			
		end
		if t-tmpt>=ltnc*12 then
			print("best tier scrap found:",ply.x-55,ply.y-15,7)
			if runhighscraptier!=nil then
				print(runhighscraptier.tier.." "..runhighscraptier.typ.." "..runhighscraptier.value.."$",ply.x-55,ply.y-5,runhighscraptier.clr)
			else
				print("none",ply.x-55,ply.y-5,7)
			end
		end
		if t-tmpt>=ltnc*14 then
			print("stage reached: "..stage,ply.x-55,ply.y+5,7)
		end
		if t-tmpt>=ltnc*16 then
			print("total money earned: "..ply.maxmoney.."$",ply.x-55,ply.y+15,7)
		end
		if t-tmpt>=ltnc*18 then
		 if fktotal==nil then
		 	fktotal=0
   end
		 if fktotal<ply.taxpaid then
		 	fktotal+=2
		 	sfx(21)
   end
			print("total taxes paid: "..fktotal.."$",ply.x-55,ply.y+25,8)
		end
		if fktotal==ply.taxpaid then
		 gmoverprint=true
		 pressclr={5,6,7,7,7,7,7,7}
			print("press ❎ to play again",ply.x-43,ply.y+45,pressclr[flr(t/4)%6+1])
		end
		
	//shop
 elseif gmstate=="shop" then
 	cls()
 	alienspr={224,226,228}
 	
 	//alien and desk
 	spr(64,ply.x-32,ply.y-32,8,4)
 	spr(alienspr[flr(t/17)%3+1],ply.x-8,ply.y-27,2,2)
 	
 	//money and info ui
 	money=fmtmoney(ply.money)
		tax=fmtmoney(imptax)
		stvlu=fmtmoney(ply.storagevlu)
		ratestvlu=fmtmoney(ply.storagevlu+ply.storagevlu*shopnear().rate/100)
		moneyclr={11,11,11,11,11,11,11,11}
		stvluclr={6,6,6,6,6,6,6,6}
		if mnblinktimer>0 then
			moneyclr={6,7,11,11,11,11,11,11}
		end
		print(money,ply.x+40,ply.y-60,moneyclr[flr(t/4)%6+1])
		print("tax:"..tax,ply.x+24,ply.y-53,6)
		print("shop rate: "..shop.rate.."%",ply.x-60,ply.y-60,7)
		print(stvlu.." -> "..ratestvlu,ply.x-60,ply.y-53,stvluclr[flr(t/4)%6+1])
		print("storage: "..ply.maxstorage,ply.x-60,ply.y-46)
		print("temporal cores: "..ply.tempcore,ply.x-60,ply.y+52)
		print("current engine: "..engine.name,ply.x-60,ply.y+59)
 	
 	//main menu
 	if menu.typ=="main" then
			for i=1,menu.maxchoice do
			 if i==menu.choice then
			 	itemclr={5,6,7,7,7,7}
		  else
		  	itemclr={7,7,7,7,7,7}
		  end
				rect(ply.x-60,ply.y+i*10+i+1,ply.x+60,ply.y+i*10+10+i,itemclr[flr(t/3)%6+1])
				print(menu.choicenames[i],ply.x-55,ply.y+i*10+3+i)
			end
			
		//buy menu
		elseif menu.typ=="buy" then
		 for i=1,menu.maxchoice do
		  if i==1 then
		  	price=shop.storageprice
    elseif i==2 and ply.tempcore==maxtempcore then
    	price=shop.engprice
    else
    	price=shop.tempcoreprice
    end
    if i==3 then
    	price=shop.engprice
    end
			 if i==menu.choice then
			 	itemclr={5,6,7,7,7,7}
		  else
		  	itemclr={7,7,7,7,7,7}
		  end
				rect(ply.x-60,ply.y+i*10+i+1,ply.x+60,ply.y+i*10+10+i,itemclr[flr(t/3)%6+1])
				print(menu.choicenames[i],ply.x-55,ply.y+i*10+3+i)
				if ply.money>=price then
					priceclr=11
				else
					priceclr=8
				end
				print(fmtmoney(price),ply.x+35,ply.y+i*10+3+i,priceclr)
			end
		end
 end
end

function turboprc()
	return flr(acctimer/engine.accdly*100)
end

function storageprc() 
	return flr(ply.storage/ply.maxstorage*100)
end

--function fmtspd()
--	if ply.mvm then
--		spd=min(300,flr(1+ply.spd*300))
--	else
--		spd=1
--	end
--	spd=tostring(spd)
--	while #spd<3 do
--		spd="0"..spd
--	end
--	return spd.." u/s"
--end

function printpickup()
	if pickuptimer>0 then
	 clr={6,7,displayscrap.clr,displayscrap.clr,displayscrap.clr,displayscrap.clr}
	 pickuptimer-=1
		print(displayscrap.typ,ply.x-60,ply.y-60,clr[flr(t/2)%#clr+1])
  print(displayscrap.tier,ply.x-60,ply.y-50,clr[flr(t/2)%#clr+1])
  print("+"..displayscrap.value.."$",ply.x-60,ply.y-40,clr[flr(t/2)%#clr+1])
	end
end

function fmtmoney(amount)
  local str=tostring(flr(amount))
  while #str<5 do
    str="0"..str
  end
  return str.."$"
end

function fade()
 sqsize=10
	if fadeinit then
		fadex1=ply.x+64
		fadex2=fadex1-sqsize
  fadey1=ply.y-63
  fadey2=fadey1+sqsize
  fadeinit=false
	else
	 rectfill(fadex1,fadey1,fadex2,fadey2,0)
		if fadedir=="left" then
			if fadex2>ply.x-63 then
				fadex1-=sqsize
				fadex2-=sqsize
			elseif fadey2<ply.y+63 then
				fadey1+=sqsize
				fadey2+=sqsize
				fadedir="right"
			else
			 fadeinit=true
			end
		end
		rectfill(fadex1,fadey1,fadex2,fadey2,0)
		if fadedir=="right" then
			if fadex1<=ply.x+63 then
				fadex1+=sqsize
				fadex2+=sqsize
			elseif fadey1<ply.y+63 then
				fadey1+=sqsize
				fadey2+=sqsize
				fadedir="left"
			else 
			 fadeinit=true
			end
		end
	end
end

function fmttimer(tmr)
 //get minutes and seconds
 sec=tmr\60
 minu=sec\60
 sec=sec%60
 
 //to string
 minu=tostring(minu)
 sec=tostring(sec)
 while #minu<2 do
 	minu="0"..minu
 end
 while #sec<2 do
 	sec="0"..sec
 end
 
 //format
 return minu..":"..sec
end
__gfx__
00000000000000000000000000000a00000aa00000022000000aa00000a000000000000007707700000000000000000000000000000000000000000000000000
00000000000c700000000000000000a00000e8200a8885a0028500000a000000000000007007007000000000000000000d0dd0d0001cc000000aa1c000005528
00700700000cc00000c7000000002e8000028880a0e8880a08882000058200000000cc007007007006355616000b0b000c0a902001cc7c00000a400000055000
000770000008800000cc820a07c888820008885a00288200ae88800028888cc0a028c7007007007006036010005c0c501cba982e1cccc7c0b3aaaa3bcb350000
0007700000288200000888ea0cc88882007c820a00088000a028cc0028888c70a58880000770770006535100005151501cba982e1cccc7c000aa400000055000
00700700a0888e0a000288800000285000cc0000000cc00000007c0008e20000088820000000000006566000000161000c0a902001cccc00c1aaaa1c00005528
000000000a5888a000005820000000a0000000000007c000000000000a000000028e00000000000000500000000060000d0dd0d0001cc000000a400000000000
0000000000022000000aa00000000a0000000000000000000000000000a00000000aa0000000000006000000000000000000000000000000000aa3b000000000
000000000007700000077000000770000007700000c77c0000c77c00000000000000000000000000000000000000000000000000000000000000000000000000
00000000000cc000000770000007700000c77c0000cccc00000cc000000000000000000000000000000000000000000000000000c0c000000c11100000000000
0000000000000000000cc000000cc00000cccc00000cc000000000000000000000000000000000000cc00000cc000000c000000001000c0c000d13b000000000
000000000000000000000000000cc000000cc00000000000000000007c00000077c0000077cc000077cc00007cc000007c000000050000100b33100000000000
000000000000000000000000000000000000000000000000000000007c00000077c0000077cc000077cc00007cc000007c00000005000050000d128000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000cc00000cc000000c0000000050055000822100000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000055000000ad11c000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000007000000070000000770000007700000077c000007c000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000c00000007c0000077c00000777c000077c00000c0000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000c0000000cc00000077c0000cc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000cc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000cc000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000c0000000cc00000077c0000cc00000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000c00000007c0000077c00000777c000077c00000c0000000000000000000000000000000
000000000000000000000000000000000000000000000000000000007000000070000000770000007700000077c000007c000000000000000000000000000000
00000000000000000000000000000000000000000000000000000500000000000050000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000005d500000000005d5000000000000000000000000000000000000000000000000000000000000
0555555555555555555555555555555555555500000550000005dd500555555005dd500000055500000000000000000000000000000000000000000000000000
5000000000000000000000000000000000000050005dd500005ddd505dddddd505ddd500005ddd50000000000000000000000000000000000000000000000000
500000000000000000000000000000000000005005dddd50005ddd5005dddd5005ddd500005ddd50000000000000000000000000000000000000000000000000
05555555555555555555555555555555555555005dddddd50005dd50005dd50005dd5000005ddd50000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000555555000005d500005500005d5000000055500000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000500000000000050000000000000000000000000000000000000000000000000000000000000
77777777777777777777777777777777777777777777777777777777777777770000000000000000000000000000000000000000000000000000000000000000
70100000000000000000000000000000001000000000000000000000000000070000000000000000000000000000000000000000000000044440000000000000
70000070000000000010000000000000000000700000000000100000000000070000000000000000000000000000000000000000000004499e94400000000000
70000000000000000000000000000000000000000000007000000000000000070000000000000000000000000000000000000000000448d99e44444000000000
70000000000000000000000000000000000000000000000000000000000000070000000000000000000000000000000000000000044da8d94449999440000000
7000000000000000000000000000000000000000000000000000000000000007000000000000000000000000000000000000000048ad89d44ea9a99994000000
700000000000000000000000000000000000000000000000000000000000000700000000000000000000000000000000000000088aadd4449eee9a4444400000
700000000089d00000000000000000000000000000000000000000000000000700000000000000000000000000000000000000488984449d8894444999940000
70000000088d8800000000000000000000000000000000000000000000000007000000000000000000000000000000000000049884448d8d4444e9aa99994000
7007000088ed999000000000000000000000000000000000bcc0d00000000007000000000000000000000000000000000000499944888dd44d98e9999a999400
7000000099d998900000000000000000000000000000000bbc7cd000000000070000000000000000000000000000000000004944498aa4448dd8e99999444440
700000000d9e8800000070000000000000000000000000bb7ccbd000000000070000000000000000000000000000000000049449988444d888dde9a444499940
7000000000988000000000000000000000000000000000ccccbdc0000700000700000000000000000000000000000000000449aaaa4499d999adda44999a9994
7000000100000000000000000000000000000000000000dbb7db0000000000070000000000000000000000000000000000499aa9444999d99eeedd499aaa9994
7000000000000000000000000000000000000000000000d0bdc00000000000070000000000000000000000000000000000499994499aa9d9ee44448888aaa994
70000000000000000000000000000000000000000000000dd000000000000007000000000000000000000000000000000499a94499aaa9dde4488daaa8884444
700000000000000000000000000000000100000000000000000000000000000700000000000000000000000000000000049a94998888889d448a8da888444894
70000700000000000000000000000000000007000000000000000000000000070000000000000000000000000000000004994498999a9844488a8d8884488894
70000000000000000000000000000000000000000000000000000000000000070000000000000000000000000000000004944a8aaaaa9449988aad8444aa8840
7000000100000000007700000700000000000001000000000000000007000007000000000000000000000000000000000044aa8aa88444ea9a88dd44aaa88840
7000000000000000007000000000000000000000000000000000000000000007000000000000000000000000000000000049a8888844aae99dddd4499a888400
7dddddddddddddddd7ddddddddddddddddddddddddddddddddddddddddddddd700000000000000000000000000000000000488888448a8eeddd44aa898884400
7ddd7777771ddddd1dddddddddddddddddddddddddddddddddddddddddddddd70000000000000000000000000000000000049aa8448888ddd9449aa884444000
7ddd7117171dddd1ddddddddddddddddddddddddcdcddddddddddddc111dddd700000000000000000000000000000000000048a44888ddde944aa99444884000
7ddd7777771dddd1ddddddddddddddddddddddddd1dddcdcddbdbddddd13bdd70000000000000000000000000000000000004844888ddaae449daa44a9940000
7ddd7171171ddd1dddddddddddddddddddddddddd5dddd1dd5cdc5db331dddd7000000000000000000000000000000000000044888dd88a4499dd44999400000
7ddd7777771dd44dddddddddddddddddddddddddd5dddd5dd51515dddd128dd700000000000000000000000000000000000004488dd8a844e99944dd94000000
7ddd7111771d1111ddddddddddddddddddddddddd5dd55dddd161dd8221dddd70000000000000000000000000000000000000004dd888449ee94499d40000000
7ddd7777771d1111dddddddddddddddddddddddddd55ddddddd6ddddad11cdd700000000000000000000000000000000000000004488448aae44a94000000000
7ddd1111111d1111ddddddddddddddddddddddddddddddddddddddddddddddd70000000000000000000000000000000000000000004444899444440000000000
7dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd70000000000000000000000000000000000000000000000444440000000000000
77777777777777777777777777777777777777777777777777777777777777770000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000222200000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000005050000000000000000000000000022ee2222000000000000
0000000000000000ccc00088882000bbb3000cccc10088882000000000000000000000000000001505d0000000000000000000000022ee112222220000000000
000000000000000cc11c108222820bb33b30cc11110822222000000000000000000000000000001505d0000000000000000000002255ee1ee222882200000000
000000000000000c1000008200820b300b30c100000820000000000000000000000000000000051505d50000000000000000000211e5511eee22222220000000
000000000000000ccc00008200820b000b30c100000820000000000000000000000000000000051505d55000000000000000002ee1eee1555e22222222000000
00000000000000000ccc108888200bbbbb30c100000888000000000000000000000000000000d55505d5500000000000000002eee11ee1ee5522882228200000
0000000000000000000c108200000bb30b30c100000820000000000000000000000000000000d5550555d0000000000000002ee2ee1ee11eee28828228820000
000000000000000c100c108200000b300b30c100000820000000000000000000000000000005d5150515d5000000000000002e22221eee1eeee2888882220000
000000000000000cc1cc108200000b300b30c100000820000000000000000000000000000005d5150515d500000000000002228822222222eeee222222222000
0000000000000000ccc1008200000b300b300cccc100888820000000000000000000000000d5d5150555d5d000000000000288288882222222eee5eee1112000
0000000000000000000000000000000000000000000000000000000000000000000000000000d51505d5d0000000000000222888222222222222255ee1eee200
0000000000000000000000000000000000000000000000000000000000000000000000000510001585d0001500000000002ee222222222228888222211eee200
0000000000000000000000000000000000000000000000000000000000000000000000000515d008880055150000000002eeee5eee1eee222222228222222220
000000000000000000000000000000000000000000000000000000000000000000000000d51555889885d515d000000002eeee555e1eeee11eee222222222820
000000000000000000000000000000000000000000000000000000000000000000000000d5155589a985d515d0000000021111ee522222ee11eee11eee222220
0ccc10008888200bbb300c100c1008888200b300b300cccc1000888820bbbb3000000005d555d889a988d555d500000002eee1122222222ee11e111eee55ee20
cc11c108822220bb33b30c100c108222220bb300b30c1111c108222220b333b3000000000000089a7a9800000000000002ee22222228222111111e1122222e20
c1000008200000b300b30c100c108200000b3b30b30c10001108200000b300b3000000d555d5889a7a988555d5500000002222222222222eeee1ee2222222200
ccc00008200000b000b30c100c108200000b3b30b30c10000008200000b300b3000000d555d58999999985d5d5500000002822288288222eeee2222882828200
00ccc108200000bbbbb30c100c108880000b30b3b30c10cc1008880000bbbb30000005d515d88888888888d5551500000002222822822255ee28822822822000
0000c108200000bb30b30c100c108200000b30b3b30c1000c108200000b3b300000005551500d55505d550055515000000022828222222e5e228222282822000
c100c108200000b300b30cc1cc108200000b30b3b30c1000c108200000b30b30000015550005d55505d5d5000515d000000022222e1eeee55222828222220000
cc1cc108200000b300b300ccc1008200000b300bb30c1000c108200000b300b3000015d005d5551505d555150015d00000002222ee11eeeee222222222220000
0ccc1000888820b300b3000c10000888820b3000b300cccc1000888820b300b30005150015d5551505d55515d005d500000002eeeee1eeeee282822222200000
0000000000000000000000000000000000000000000000000000000000000000000500051555d5150555d515d50005000000002e555115555222822222000000
0000000000000000000000000000000000000000000000000000000000000000000005d55555d5150555d515d5d50000000000025eee111ee222228220000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000022eeee111e28222200000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000022eeee1e22220000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000022ee1122000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000222200000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000bbb0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000bbb00000000bb00bbbbb00bb003b0000bbb0000b30000000000000000000000000000000000000000000000000000000000000000b3300ddddddd00000
3bb00bbbbb00bb30300bbbbbbbbb003000b00bbbbb00b0000000000000000000000000000000000000000000000000000000000000000333bb33355555dd5000
000bbbbbbbbb0000000b30bb03bb0000000bbbbbbbbb000000000000000000000000000000000000000000000000000000000000000bbb333b777b00005dd500
000b07bb07bb0000000b30bb03bb0000000bb3bb3bbb00000000000000000000000000000000000000000000000000000000000003bbbbb33bbb3bb00000dd00
000b00bb00bb0000000b30bb03bb0000000bb3bb3bbb000000000000000000000000000000000000000000000000000000000000b33bb773bb3b33b330005d50
000b00bb00bb0000000bbbbbbbbb0000000bb3bb3bbb00000000000000000000000000000000000000000000000000000000000cbb33bbbb333bb3bb30000dd0
000bbbbbbbbb0000000bbbbbbbbb0000000bbbbbbbbb000000000000000000000000000000000000000000000000000000000011cbb3b333b777bb3b330005d0
000bbbbbbbbb0000000bbbbbbbbb0000000bbbbbbbbb000000000000000000000000000000000000000000000000000000000cc11cb333bbb3333b3bbb0005d0
000bbbbbbbbb0000000bbb00bbbb0000000bbbbbbbbb00000000000000000000000000000000000000000000000000000000ccc777bb333bbb333bbbbbc05dd0
000bbb00bbbb00000000bbbbbbb00000000bbb00bbbb0000000000000000000000000000000000000000000000000000000cccccc1cb3b33bbb33b33bbcc5d50
0000bbbbbbb0000000000bbbbb0000000000bbbbbbb000000000000000000000000000000000000000000000000000000001111cc11cbbb3bbb3b33bbcc5dd00
00000bbbbb000000000000bbb000000000000bbbbb000000000000000000000000000000000000000000000000000000000ccc11cc11cbb777bbbbbbccc5d500
000000bbb0000000000000bbb0000000000000bbb000000000000000000000000000000000000000000000000000000000bbccc1ccc11bbb3bbbbbbcc15d5000
000000bbb0000000000000bbb0000000000000bbb000000000000000000000000000000000000000000000000000000000bbccc77cccccbb33bbbbcc11dd5c00
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000033bccc11ccccbbbbbbbb111dd5cc00
0000000000000000000000bbb0000000000000000000000000000000000000000000000000000000000000000000000000b33bbcc11cc7ccbbbb3bbcdd5ccc00
000000bbb00000000bb00bbbbb00bb003b0000bbb0000b30000000000000000000000000000000000000000000000000000b33bbcc111ccc33b333bdd55cc000
3bb00bbbbb00bb30300bbbbbbbbb003000b00bbbbb00b000000000000000000000000000000000000000000000000000000bb777cccc1cb3bbbbb3dd55111000
000bbbbbbbbb0000000b07bb07bb0000000bbbbbbbbb000000000000000000000000000000000000000000000000000000ddb33bbccc1bbbb3775dd551cc0000
000b07bb07bb0000000b00bb00bb0000000b07bb07bb000000000000000000000000000000000000000000000000000000d5bb333bccbbbb33b5dd551ccc0000
000b00bb00bb0000000b00bb00bb0000000b00bb00bb000000000000000000000000000000000000000000000000000000d55bbb333bb3b333ddd55bcccc0000
000b00bb00bb0000000bbbbbbbbb0000000b00bb00bb000000000000000000000000000000000000000000000000000000d500bbbb3bbb33bdd5553bbcc00000
000bbbbbbbbb0000000bbbbbbbbb0000000bbbbbbbbb000000000000000000000000000000000000000000000000000000dd000bbbb3333ddd55bb3bbb000000
000bbbbbbbbb0000000bbbbbbbbb0000000bbbbbbbbb0000000000000000000000000000000000000000000000000000005d500bbb373ddd555bbb33b0000000
000bbbbbbbbb0000000bbb00bbbb0000000bbbbbbbbb0000000000000000000000000000000000000000000000000000005dd5000bdddd555533bbb000000000
000bbb00bbbb00000000bbbbbbb00000000bbb00bbbb000000000000000000000000000000000000000000000000000000055dddddd555553337300000000000
0000bbbbbbb0000000000bbbbb0000000000bbbbbbb000000000000000000000000000000000000000000000000000000000555555555b773330000000000000
00000bbbbb000000000000bbb000000000000bbbbb00000000000000000000000000000000000000000000000000000000000000000000bbb000000000000000
000000bbb0000000000000bbb0000000000000bbb000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000bbb0000000000000bbb0000000000000bbb000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__label__
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
88888eeeeee888777777888eeeeee888888888888888888888888888888888888888888888888888888ff8ff8888228822888222822888888822888888228888
8888ee888ee88778877788ee888ee88888888888888888888888888888888888888888888888888888ff888ff888222222888222822888882282888888222888
888eee8e8ee8777787778eeeee8ee88888e88888888888888888888888888888888888888888888888ff888ff888282282888222888888228882888888288888
888eee8e8ee8777787778eee888ee8888eee8888888888888888888888888888888888888888888888ff888ff888222222888888222888228882888822288888
888eee8e8ee8777787778eee8eeee88888e88888888888888888888888888888888888888888888888ff888ff888822228888228222888882282888222288888
888eee888ee8777888778eee888ee888888888888888888888888888888888888888888888888888888ff8ff8888828828888228222888888822888222888888
888eeeeeeee8777777778eeeeeeee888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
111111111eee1eee11111bbb1bbb1bb11bbb117111666661117111111eee1e1e1eee1ee111111111111111111111111111111111111111111111111111111111
1111111111e11e1111111b1b11b11b1b1b1b1711166161661117111111e11e1e1e111e1e11111111111111111111111111111111111111111111111111111111
1111111111e11ee111111bb111b11b1b1bbb1711166616661117111111e11eee1ee11e1e11111111111111111111111111111111111111111111111111111111
1111111111e11e1111111b1b11b11b1b1b111711166161661117111111e11e1e1e111e1e11111111111111111111111111111111111111111111111111111111
111111111eee1e1111111bbb11b11b1b1b111171116666611171111111e11e1e1eee1e1e11111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
1111111111111666166116661666166616611666166611111ccc1ccc1c1c1ccc1111111111111111111111111111111111111111111111111111111111111111
11111111111111611616116111611616161611611666177711c11c1c1c1c1c111111111111111111111111111111111111111111111111111111111111111111
11111111111111611616116111611666161611611616111111c11cc11c1c1cc11111111111111111111111111111111111111111111111111111111111111111
11111111111111611616116111611616161611611616177711c11c1c1c1c1c111111111111111111111111111111111111111111111111111111111111111111
11111111111116661616166611611616161616661616111111c11c1c11cc1ccc1111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111bb1bbb1b1b11711ccc1ccc11711111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
1111111111111b111b111b1b1711111c1c1c11171111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
1111111111111bbb1bb111b117111ccc1ccc11171111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
111111111111111b1b111b1b17111c11111c11171111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
1111111111111bb11b111b1b11711ccc111c11711111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
111111111111111111111ddd1d1d11dd1ddd11dd11d11ddd11d11111111111111111111111111111111111111111111111111111111111111111111111111111
111111111111111111111ddd1d1d1d1111d11d111d111d1d111d1111111111111111111111111111111111111111111111111111111111111111111111111111
1ddd1ddd1111111111111d1d1d1d1ddd11d11d111d111d1d111d1111111111111111111111111111111111111111111111111111111111111111111111111111
111111111111111111111d1d1d1d111d11d11d111d111d1d111d1111111111111111111111111111111111111111111111111111111111111111111111111111
111111111111111111111d1d11dd1dd11ddd11dd11d11ddd11d11111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
111111111eee1ee11ee1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
111111111e111e1e1e1e111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
111111111ee11e1e1e1e111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
111111111e111e1e1e1e111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
111111111eee1e1e1eee111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111d111d1ddd1dd11ddd1ddd111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
1111111111d111d11d1d1d1d11d11ddd111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
1111111111d111d11ddd1d1d11d11d1d111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
1111111111d111d11d1d1d1d11d11d1d111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
111111111d111d111d1d1d1d1ddd1d1d111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
111111111eee1eee11111666166116661666166616611666166611111eee1e1e1eee1ee111111111111111111111111111111111111111111111111111111111
1111111111e11e11111111611616116111611616161611611666111111e11e1e1e111e1e11111111111111111111111111111111111111111111111111111111
1111111111e11ee1111111611616116111611666161611611616111111e11eee1ee11e1e11111111111111111111111111111111111111111111111111111111
1111111111e11e11111111611616116111611616161611611616111111e11e1e1e111e1e11111111111111111111111111111111111111111111111111111111
111111111eee1e11111116661616166611611616161616661616111111e11e1e1eee1e1e11111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
1111111111111eee1eee1111116616661666161611661666166611661666166611171ccc11111eee1e1e1eee1ee1111111111111111111111111111111111111
11111111111111e11e11111116111616166616161616161116111611161111611171111c111111e11e1e1e111e1e111111111111111111111111111111111111
11111111111111e11ee11111161116661616166616161661166116661661116117111ccc111111e11eee1ee11e1e111111111111111111111111111111111111
11111111111111e11e111111161116161616111616161611161111161611116111711c11111111e11e1e1e111e1e111111111111111111111111111111111111
1111111111111eee1e111111116616161616166616611611161116611666116111171ccc111111e11e1e1eee1e1e111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111166166616661616116616661666116616661666111111111cc1111111111111111111111111111111111111111111111111111111111111
111111111111111116111616166616161616161116111611161111611171177711c1111111111111111111111111111111111111111111111111111111111111
111111111111111116111666161616661616166116611666166111611777111111c1111111111111111111111111111111111111111111111111111111111111
111111111111111116111616161611161616161116111116161111611171177711c1111111111111111111111111111111111111111111111111111111111111
11111111111111111166161616161666166116111611166116661161111111111ccc111111111111111111171111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111177111111111111111111111111111111111111111
1111111111111eee1ee11ee111111111111111111111111111111111111111111111111111111111111111177711111111111111111111111111111111111111
1111111111111e111e1e1e1e11111111111111111111111111111111111111111111111111111111111111177771111111111111111111111111111111111111
1111111111111ee11e1e1e1e11111111111111111111111111111111111111111111111111111111111111177111111111111111111111111111111111111111
1111111111111e111e1e1e1e11111111111111111111111111111111111111111111111111111111111111111711111111111111111111111111111111111111
1111111111111eee1e1e1eee11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
1111111111111eee1eee11111166166616661616116616661666116616661666111111111ccc11111eee1e1e1eee1ee111111111111111111111111111111111
11111111111111e11e1111111611161616661616161616111611161116111161177717771c1c111111e11e1e1e111e1e11111111111111111111111111111111
11111111111111e11ee111111611166616161666161616611661166616611161111111111c1c111111e11eee1ee11e1e11111111111111111111111111111111
11111111111111e11e1111111611161616161116161616111611111616111161177717771c1c111111e11e1e1e111e1e11111111111111111111111111111111
1111111111111eee1e1111111166161616161666166116111611166116661161111111111ccc111111e11e1e1eee1e1e11111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
1111111111111111116616661666161611661666166611661666166611111ccc1111111111111111111111111111111111111111111111111111111111111111
1111111111111111161116161666161616161611161116111611116117771c1c1111111111111111111111111111111111111111111111111111111111111111
1111111111111111161116661616116116161661166116661661116111111c1c1111111111111111111111111111111111111111111111111111111111111111
1111111111111111161116161616161616161611161111161611116117771c1c1111111111111111111111111111111111111111111111111111111111111111
1111111111111111116616161616161616611611161116611666116111111ccc1111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
1111111111111111116616661666161611661666166611661666166611111ccc1111111111111111111111111111111111111111111111111111111111111111
1111111111111111161116161666161616161611161116111611116117771c1c1111111111111111111111111111111111111111111111111111111111111111
1111111111111111161116661616166616161661166116661661116111111c1c1111111111111111111111111111111111111111111111111111111111111111
1111111111111111161116161616111616161611161111161611116117771c1c1111111111111111111111111111111111111111111111111111111111111111
1111111111111111116616161616166616611611161116611666116111111ccc1111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111666166116661666166616611666166611111ccc1ccc1c1111cc1ccc11111111111111111111111111111111111111111111111111111111
11111111111111111161161611611161161616161161166617771c111c1c1c111c111c1111111111111111111111111111111111111111111111111111111111
11111111111111111161161611611161166616161161161611111cc11ccc1c111ccc1cc111111111111111111111111111111111111111111111111111111111
11111111111111111161161611611161161616161161161617771c111c1c1c11111c1c1111111111111111111111111111111111111111111111111111111111
11111111111111111666161616661161161616161666161611111c111c1c1ccc1cc11ccc11111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
1111111111111111116616661166166616661666166611111c1c1c111ccc1c1c1ccc1c111c1c1111111111111111111111111111111111111111111111111111
1111111111111111161116661611116116161161161117771c1c1c111c111c1c1c111c111c1c1111111111111111111111111111111111111111111111111111
11111111111111111611161616661161166611611661111111111c111cc11c1c1cc11c1111111111111111111111111111111111111111111111111111111111
11111111111111111616161611161161161611611611177711111c111c111ccc1c111c1111111111111111111111111111111111111111111111111111111111
11111111111111111666161616611161161611611666111111111ccc1ccc11c11ccc1ccc11111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
1111111111111eee1ee11ee111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
1111111111111e111e1e1e1e11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
1111111111111ee11e1e1e1e11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
1111111111111e111e1e1e1e11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
1111111111111eee1e1e1eee11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
111111111eee1ee11ee1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
111111111e111e1e1e1e111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
111111111ee11e1e1e1e111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
111111111e111e1e1e1e111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
111111111eee1e1e1eee111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111eee1ee11ee11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111e111e1e1e1e1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111ee11e1e1e1e1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111e111e1e1e1e1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
82888222822882228888822882228882822282228282888888888888888888888888888888888888888882228222822282228882822282288222822288866688
82888828828282888888882882828828828282828282888888888888888888888888888888888888888888828282828288828828828288288282888288888888
82888828828282288888882882228828822282228222888888888888888888888888888888888888888888828282828288828828822288288222822288822288
82888828828282888888882888828828828282828882888888888888888888888888888888888888888888828282828288828828828288288882828888888888
82228222828282228888822288828288822282228882888888888888888888888888888888888888888888828222822288828288822282228882822288822288
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888

__sfx__
06020000320502c0502805025050220501f0501d0501b05019050180501505014050120500f0500d0500c05009050080500605005050040500205002050020500205002050020400104001030010300002000020
26040000000540005402054040540605407054090540a0540b0540d0540e05410054110541305414054150541605418054190541a0541b0541c0541e0541e0541f05420054210542305424054250542605427054
2f0800001d5452c53532525325152a50534505395053050533505375053b5053c5053e5053f505295052e5053150533505385053a5053d5053e5053a5053c5053d5053e505005050050500505005050050500505
2f0800001e5452a5353152533515345553b5053c5053e5053e5053c5053b5053c5053e5053f505295052e5053150533505385053a5053d5053e5053a5053c5053d5053e505005050050500505005050050500505
2f0800001e5452a535315253351535555355053c5053e5053e5053c5053b5053c5053e5053f505295052e5053150533505385053a5053d5053e5053a5053c5053d5053e505005050050500505005050050500505
2f0800001e5452a535315253351536555375553c5053e5053e5053c5053b5053c5053e5053f505295052e5053150533505385053a5053d5053e5053a5053c5053d5053e505005050050500505005050050500505
2e0800001d5452c535325253451535555365553655536555365553655536555365553655536545365353652536515375053650536505365053650536505365053650536505365053650536505365053650536505
791a0000185351b53527535185351b53526535185051b505185351b53527535185351b53526535145051b505145351b53527535145351b53526535165051b505165351b5352b535165351b535295350000000000
601a00003012130121301213012130121301213012130121301213012130121301213212132121321213212133121331213312133121331213312133121331213712137121371213712137121371213712137121
601a00003012130121301213012130121301213012130121301213012130121301212e1212e1212e1212e1212c1212c1212c1212c1212c1212c1212c1212c1213212132121321213212132121321213212132121
7c1a000037735370352b005270052b00527005180052b005370053700537735370353500535735350353000530735300352c005270052e005270051a0052e005270051a0053a7353a03535735000050000500005
011a00000c035070050c0050c0350c0050c0050c0350c0350c0050c0050c0350c0050c0050c0350c0050c0050803508005080050803508005080050a0350a0350a0050a0050a0350a0050a0050a0350a0350a035
791a0000245352753533535245352753532535185051b505245352753533535245352753532535145051b505205352753533535205352753532535165051b5052253527535375352253527535355350000000000
b51a00002413424135241042713427135271043313433135331043310432134321353210432134321353210437134371353710437104371043710437104371043710437104351343513535104351343513535104
cd1a0000241342413524106271342713527106331343313533106331063213432135321063213432135321063013430135301063010630106301063010630106301063010630134301352e1062e1342e1352e106
7c1a000037735370352b005270052b00527005180052b005370053700537735370353500535735350353000533735330352c005270052e005270051a0052e005270051a005337353303530735300550000500005
781a0000245352753533535245352753532535185051b505245352753533535245352753532535145051b505205352753533535205352753532535165051b5052253527535325352250527505305350000000000
03070000061500e100061500615005150001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100
1a0300001005014050190501e05022050180501c05021050250502a050240002a0002f000340003800036000320002d00029000230001e0001900000000000000000000000000000000000000000000000000000
200900002c55527555205551c5552e55529555265551b555305552d5552b555285552b5052b5052b5052b5052b5052b5052b5052b505005050050500505005050050500505005050050500505005050050500505
00020000065500e550215500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000300002455000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
08110000160521f00215052190020d0520d0520d0520d0521a0021a0021a0021a0020000221002000020000200002000020000200002000020000200002000020000200002000020000200002000020000200002
091000003505535005340050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005
0f1000003b0553b0553b0553b05500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005
000d0000387502d750247501c750147500d7500875005750037500275001750007500075000700217001970012700077000770000700007000070000700007000070000700007000070000700007000070000700
0f030000167521b75221752277522975223752297522d752327522d702327021f7021670223702207021c7022070224702257021a7021b7021c7021e7021e7021f70220702217022370224702257022670227702
0e050000110501105021000110501105011050110001a000130002d000320001f0001600023000200001c0002000024000250001a0001b0001c0001e0001e0001f00020000210002300024000250002600027000
5e0200000c05110051140511b05121051280510e051160511e051270512e05133051130511a051210512805130051390513e05121051280512c05130051360513a0513d0513f0510000100001000010000100001
080c0000270521e0522e0522e0021c0021f0022000224002280022700224002220021e0021d0021a00217002150021400213002110020f0020e0020d0020a0020a00208002070020700207002060020400200002
__music__
00 07484a44
00 07494a44
01 07480a44
00 07490f44
00 07480a0b
00 07490f0b
00 470c4a4b
00 47104a4b
00 0c0d4a0b
00 0c0e4f0b
00 0c0d4a0b
02 0c0e4f0b

