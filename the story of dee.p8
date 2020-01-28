pico-8 cartridge // http://www.pico-8.com
version 18
__lua__

function _init()
  scene='menu'
  t=0

  dee = {} --table for player
  dee.x = 15
  dee.y = 64
  dee.sprite = 16
  dee.w = 2
  dee.h = 2
  dee.step = 0
  dee.tmr = 1

  choose = {} --lil arrow to make descisions
  choose.x = 11
  choose.y = 102
  choose.sprite = 15

  spark = {} --table for growth
  spark.sprite = 5

  door = {}
  door.sprite = 22
  door.w = 2
  door.h = 2
  door.x = 100
  door.y = 64
  door.step = 0

  stanley = {} --ai information
 	stanley.res = 1
  stanley.dialogue = {'hey, who the fuck are you?', 'i care. i asked for a reason.', 'do you want to keep walking?', 'walk, in that case.', 'walk, in that case.', 'what do you think?', 'that hurts.', 'what did you expect? this is only life.'}
  dee.dialogue = {'who cares?', 'fuck off.', 'yeah, i guess.', 'a door?', 'a door?', 'what a snore.', 'sorry.', 'i guess. now what?'}
  dee.dialogue2 = {'you tell me...', 'how sweet.', 'this isnt real, anyway.', 'press z to interact', 'press z to interact', 'this is the same shit wtf..', 'i do not care.', 'i might just stop playing'}

  stars={}
  star_cols={1,13,6,7,1,13}
  warp_factor=3

  for i=1,#star_cols do
    for j=1,10 do
      local s={
        x=rnd(128),
        y=rnd(128),
        z=i,
        c=star_cols[i]}
      add(stars,s)
        end
      end

--levels
lvl = {}
lvl.value = 1
lvl.sx = {0, 17}

end

function draw_unit(unit)
  spr(unit.sprite, unit.x, unit.y, unit.w, unit.h, unit.flip)
end

function draw_choose()
if stanley.res!=4 and stanley.res!=5 then
  print('>', 14, choose.y, 0)
end
end

function stan_talk()
    print(stanley.dialogue[stanley.res], 9, 18, 7)
end

function dee_talk()
    print(dee.dialogue[stanley.res], 20, 102, 0)
    print(dee.dialogue2[stanley.res], 20, 110, 0)
end

function new_level()
  lvl.value+=1 end
  cls()
  for s in all(stars) do
  pset(s.x,s.y,s.c)
  end
  map(lvl.sx[lvl.value], 0, 0, 0)
  end

function dee_walk()
  if (btn(0) and dee.x > 0) dee.x -= 1
		if (btn(0)) dee.flip=true
  if (btn(1) and dee.x < 112) dee.x += 1
  if (btn(1)) dee.flip=false
end

function dee_choose()
  if (btnp(2)) then choose.y = 102 end
  if (btnp(3)) then choose.y = 110 end
end

function decide()
  if ((btnp(5)) and (choose.y<103)) stanley.res+=0.5
 	if ((btnp(5)) and (choose.y>103)) stanley.res+=1
end

function dee_animate()
  dee.tmr = dee.tmr+1
	if dee.tmr>=90 then
		dee.sprite = 18
	end
	if dee.tmr >= 120 then
		dee.sprite = 20
	end
	if dee.tmr >= 150 then
		dee.sprite = 18
	end
	if dee.tmr >= 180 then
	 dee.sprite = 16
		dee.tmr = 0
	end
end

function create_door()
  if stanley.res==5 or stanley.res==6 then
  		 draw_unit(door) end
  if dee.y-door.y==0 then
    if btnp(4) then
 				if(door.step%3==0) door.sprite+=2
			  if(door.sprite>29) door.sprite=28
    		if btnp(4) and door.sprite==28 then
          transition()
        end
   	end
  end
end

function _update()
  t+=0.1
  if scene=="menu" then
        update_menu()
    end
  dee_animate()
  new_level()
  dee_choose()
  decide()
  stan_talk()
  dee_talk()
  dee_walk()
  create_door()
  for s in all(stars) do
   s.y+=s.z*warp_factor/10
   if s.y>128 then
    s.y=0
    s.x=rnd(128)
   end
   end
end

function _draw()
 cls()
 for s in all(stars) do
 pset(s.x,s.y,s.c)
	end
 new_level()
 decide()
 stan_talk()
 dee_talk()
 dee_animate()
 dee_choose()
 draw_choose()
 create_door()
 draw_unit(dee)
 print(stanley.res, 32, 32, 7)
 print(lvl.value, 40, 40, 7)
 if scene=="menu" then
      draw_menu()
 end
end

function update_menu()
    if btn(0) and btn(1) then
        scene="game"
    end
end

function draw_menu()
    cls()
    for s in all(stars) do
			 pset(s.x,s.y,s.c)
				end
				spr(192, 38, 38, 7, 2)
				spr(199, 44, 52, 5, 2)
				spr(16, 55, 76, 2, 2)
    print("x to choose", 42, 10, 7)
    print("use arrow keys to move", 18, 18, 7)
    print("press <- and ->", 33, 100, 13)
    print("at the same time to start", 16, 108, 13)
end

function transition()
  cls()
  rectfill(0,0,128,128,1)
      for i=0,8 do
        for j=0,8 do
        local x = i*16
        local osc1 = sin(t+i*0.1)
        local osc2 = sin(t/4+j*0.03)
        local y = j*16 + osc1*10
        circfill(x, y, osc2*15, 13)
        end
      new_level() end
end


__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
66666666666666666666666666666666000000000000000044444444444444444444444444444fff44444444ffffffff44444fffffffffff0000000000000000
6666666666666666666666666666666666666666666666664444444444444444444444444444400f444444440000000f444440000000000f0000000000000000
66666666666666666666666666666666666666666666666644fffff44fffff4444ffff44ffff400f4ff4fff40000000f4f4f40000000000f0000000000000000
66666666666666666666666666666666666666666666666644fffff44fffff4444ffff44ffff400f4ff4fff40000000f4f4f40000000000f0000000000000000
66666666666666666666666666666666666666666666666644fffff44fffff4444ffff44ffff400f4ff4fff40000000f4f4f40000000000f0000000000000000
6dddddddddd666666ddddddddddd66666dddddddddd6666644fffff44fffff4444ffff44ffff400f4ff4fff40000000f4f4f40000000000f0000000000000000
6dddddddddd666666ddddddddddd66666dddddddddd6666644fffff44fffff4444ffff44ffff400f4ff4fff40000000f4f4f40000000000f0000000000000000
6dddd7777dd677776dddd1111ddd11116dddd1111dd6111144fffff44fffff4444ffff44ffff400f4ff4fff40000000f4f4f40000000000f0000000000000000
6dddd7777dd677776dddd1111ddd11116dddd1111dd6111144fffff44ffff99444ffff44ff99400f4ff4f9940000000f4f4940000000000f0000000000000000
6dddd7777dd677776dddd7777ddd77776dddd1111dd6111144fffff44ffff99444ffff44ff99400f4ff4f9940000000f4f4940000000000f0000000000000000
6dddddddddd666666ddddddddddd66666dddddddddd6666644fffff44fffff4444ffff44ffff400f4ff4fff40000000f4f4f40000000000f0000000000000000
6dddddddddd666666ddddddddddd66666dddddddddd6666644fffff44fffff4444ffff44ffff400f4ff4fff40000000f4f4f40000000000f0000000000000000
6ddddddd111116666ddddddd111116666ddddddd111116664444444444444444444444444444400f444444440000000f444440000000000f0000000000000000
6dddddddddd666666ddddddddddd66666dddddddddd6666644fffff44fffff4444ffff44ffff400f4ff4fff40000000f4f4f40000000000f0000000000000000
6dddddddddd666666ddddddddddd66666dddddddddd6666644fffff44fffff4444ffff44ffff400f4ff4fff40000000f4f4f40000000000f0000000000000000
66666666666666666666666666666666666666666666666644444444444444444444444444444fff44444444ffffffff44444fffffffffff0000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
77777777777777777777777711171717171711111717171717777777777777777777777777777777777777777777777777777777000000000000000000000000
777777777777777777777d7717777777777777717777777777777777777777777777777777777777777777777777777777777677000000000000000000000000
77777777777777777777d1d717777777777777717777777717777777667777777777777777777777777777777777777777776167000000000000000000000000
77777777dddd7777d777d1d7777777777777777177777777777777777667677777777777777777777777776d6666777767776167000000000000000000000000
777777771111d77d1ddd11dd177777777777777177777777177777777766677777777777777777667777666d1111677616661166000000000000000000000000
77777777ddd11dd11111111177777777777777777777777777777777777666666677767777777666666666dd6661166111111111000000000000000000000000
7777777766dd1111dd111dd117777777777777717777777717777777776d66666666667777766666d66ddddddd66111166111661000000000000000000000000
77777777666d1ddd6d11d66d77777777777777777777777777777777766ddddddd6666666666666dddddddddddd61666d6116dd6000000000000000000000000
000000006dd111d66d1d666d177777777777777177777777777777716dddddddddddddd6666dddddddddddd0d661116dd616ddd6000000000000000000000000
00000000dd1111ddd11d66d177777777777777777777777777777777ddd000000ddddd000ddddddd000dd000661111666116dd61000000000000000000000000
0000000011ddd1111111d6d117777777777777717777777777777771000000000000000000000000000000001166611111116d61000000000000000000000000
00000000dd66d111d1111d11777777777777777777777777777777770000000000000000000000000000000066dd611161111611000000000000000000000000
000000006666d11ddd1d11111777777777777771777777777777777100000000000000000000000000000000dddd611666161111000000000000000000000000
000000006666d11d66ddddd11777777777777771777777777777777700000000000000000000000000000000dddd6116dd666661000000000000000000000000
00000000666dd11dd6666dd11777777777777771777777777777777100000000000000000000000000000000ddd661166dddd661000000000000000000000000
00000000666d1111d6666d111111171717171111171717177777777700000000000000000000000000000000ddd611116dddd611000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
06666666000000000000000006666000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
06666666000000000000000066006600000000000000000000000000000000000000000006666000000000000000000000000000000000000000000000000000
00006006000000000000000660000000600000000000000000000000000000000066000066006660000000000000000000000000000000000000000000000000
00066066000000000000000660000006600000000000000000000000000000000600000600000060000000000000000000000000000000000000000000000000
00066066666000666000000066600066660066600066606006600000000000000600000606000066000000000000000000000000000000000000000000000000
00060066006006006000000006660066600600660660066006000000006660006600000006000066006660000660000000000000000000000000000000000000
00060060006060066000000000066006006600060660060006000000066006066600000066000066066066066006000000000000000000000000000000000000
00660060066066600000006000006066006000060600060006000000660006006000000066000060660066060066000000000000000000000000000000000000
00660660060066006000006000066060006000660600060066000000660006006000000066000660666600066660000000000000000000000000000000000000
00600600060066066000006660660060006606600600660666000000660006066000000060000660660006066006000000000000000000000000000000000000
00600600060006660000000066600066000666006600066060000000660066060000000060006600660060066066000000000000000000000000000000000000
00000000000000000000000000000000000000000000600060000000066660060000000066660000066600006660000000000000000000000000000000000000
00000000000000000000000000000000000000000000066600000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
4749484948494748494849494849494a004749484948494748494849494849494a004a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5759585958595758595859595859595a005759585958595758595859595859595a005a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
ffffffffffffffffffffffffffffffff00ffffffffffffffffffffffffffffffff00ff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
ffffffffffffffffffffffffffffffff00ffffffffffffffffffffffffffffffff00ff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
ffffffffffffffffffffffffffffffff00ffffffffffffffffffffffffffffffff00ff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
ffffffff01ffffffffffffffffffffff00ffffffff01ffffffffffffffffffffff00ff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
ffffffff01ffffffffffffffffffffff00ffffffff01ffffffffffffffffffffff00ff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
ffffffff01ffffffffffffffffffffff00ffffffff01ffffffffffffffffffffff00ff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
ffffffff01ffffffffffffffffffffff00ffffffff01ffffffffffffffffffffff00ff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
ffffffffffffffffffffffffffffffff00ffffffffffffffffffffffffffffffff00ff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
41414141414141414141414141414141004b4c4b4c4b4c4b4c4b4c4b4c4b4c4b4c004c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
52525152525152525152525152515152005b5c5b5b5b5c5b5c5b5c5b5c5b5b5b5c005c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
51434545454545454545454545454452005b43454545454545454545454545445b005b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
52464040404040404040404040405652005b46404040404040404040404040565b005b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
51535555555555555555555555555452005b53555555555555555555555555545b005b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
52515251525251515251515251525152005b5b5b5b5c5c5c5c5c5c5c5b5b5b5c5c005c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
