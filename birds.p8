pico-8 cartridge // http://www.pico-8.com
version 18
__lua__
in_progress = 0
start_end_game = 1
game_over = 2

left=0 right=1 up=2 down=3
valid_moves = {left,right,up,down}

function _init()
 player = {}
 player.x = flr(rnd(120))
 player.y = flr(rnd(114)+8)
 player.startsprite = 0
 player.endsprite = 1
 player.sprite = 0
 player.speed = 2
 player.stuck = 0

 enemy = {}
 enemy.x = flr(rnd(120))
 enemy.y = flr(rnd(114)+8)
 enemy.startsprite = 4
 enemy.endsprite = 5
 enemy.sprite = 4
 enemy.speed = 1
 enemy.stuck = 0

 state = in_progress
 score = 0
end

function move(unit)
 unit.sprite += 1
 if unit.sprite > unit.endsprite then
  unit.sprite = unit.startsprite
 end
end

function draw_unit(unit) spr(unit.sprite, unit.x, unit.y) end
function get_map_cell(unit) return mget(flr((unit.x+4)/8), flr((unit.y-4)/8)) end

function hit_house(unit) return get_map_cell(unit) == 16 end

function move_unit(unit, direction)
 unit.moving = false
 
 if hit_house(unit) then
  unit.stuck += 1
  if unit.stuck > 4 then
   unit.stuck = 0
  else
   return 
  end
 end
 
 if not unit.moving then
  unit.sprite = unit.startsprite
 else
  move(unit)
 end
end

function move_player()
  if (btn(0) and player.x > 0) player.x-=1
  if (btn(1) and player.x < 120) player.x+= 1
  if (btn(2) and player.y > 8) player.y -= 1
  if (btn(3) and player.y < 120) player.y+= 1
end

function move_enemy()
 if enemy.x > player.x then
  move_unit(enemy, left)
 end
 if enemy.x < player.x then
  move_unit(enemy, right)
 end
 if enemy.y > player.y then
  move_unit(enemy, up)
 end
 if enemy.y < player.y then
  move_unit(enemy, down)
 end
 enemy.speed += 0.0005
end

function distance(p0, p1)
 dx=p0.x-p1.x dy=p0.y-p1.y
 return sqrt(dx*dx+dy*dy)
end

function check_game_over()
 if 
  distance(enemy,player) < 7 
  and state != game_over 
   then
    state = start_end_game
 end
end

function _update()
 move_player()
 move_enemy()
 check_game_over()
end

function _draw()
 cls()
 if state == in_progress then
  map(0,0,0,8,16,15)
  draw_unit(player)
  draw_unit(enemy)
  score += 1
  print("score: "..score)
 elseif state == start_end_game then
  sfx(0)
  state = game_over
 elseif state == game_over then
  print("\135 game over \135")
  print("your final score was: "..score)
  print("press action to try again")
  if btn(4) then 
   _init() 
  end
 end
end
__gfx__
99008880990888002222222222222222990011109901110022aaaa22000000000000000000000000000000000000000000000000000000000000000000000000
98808e889880ee88222222222222222291101c119110cc112aaaaaa2000000000000000000000000000000000000000000000000000000000000000000000000
08888ee808888e88222222222222222201111cc101111c11aaaaaaaa000000000000000000000000000000000000000000000000000000000000000000000000
008888088088880022777722222222220011110110111100aaaaaaaa000000000000000000000000000000000000000000000000000000000000000000000000
888888008e8888002777777222222222111111001c111100aaaaaaaa000000000000000000000000000000000000000000000000000000000000000000000000
8ee888888ee8888877777777222222221cc111111cc11111aaaaaaaa000000000000000000000000000000000000000000000000000000000000000000000000
88e0088008800880222222222222222211c00110011001102aaaaaa2000000000000000000000000000000000000000000000000000000000000000000000000
08880800088008002222222222222222011101000110010022aaaa22000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0203020302030203020302030203030200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0203030303030303030303030303030200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0203030303030303030203030306030200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0203020303030203030303020303030200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0203030303030303030303030303030200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0203030302030203030303030203030200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0203030303030303030303030303030200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0203020303030303030302030303030200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0203030303030203030303030303030200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0203030303030303030302020303030200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0203030303030303030303030303030200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0203030203030303020303030303030200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0203030303030303030303030303030200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0203030203020302030203020302030200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
