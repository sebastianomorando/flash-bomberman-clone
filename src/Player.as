package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.FP;
	import flash.utils.*;
	/**
	 * ...
	 * @author Sebastiano Morando
	 */
	public class Player extends Entity
	{
		[Embed(source = '../img/bomberman.png')] private const BOMBERMAN:Class;
		
		public var bomberman:Spritemap = new Spritemap(BOMBERMAN, 32, 64, anim_end);
		
		private var vx:Number = 0;
		private var vy:Number = 0;
		
		private var colX:Number;
		private var colY:Number;
		
		private var _t:uint;
		
		public function Player() 
		{
			bomberman.add("stand_right", [0], 0, true);
			bomberman.add("stand_left", [11], 0, true);
			bomberman.add("stand_up", [3], 0, true);
			bomberman.add("stand_down", [6], 0, true);
			
			bomberman.add("walk_right", [2, 1, 0], 6, true);
			bomberman.add("walk_left", [9, 10, 11], 6, true);
			bomberman.add("walk_up", [3, 4, 5], 6, true);
			bomberman.add("walk_down", [6, 7, 8], 6, true);
			
			bomberman.add("die", [0, 3, 6, 9, 0, 3, 6], 6, true);
			
			graphic = bomberman;
			bomberman.play("stand_right");
			
			setHitbox(24, 24, -4, -36);
			
			layer = 0;
			x = 32;
			
			type = "player";
			
			//bomberman.tintMode = 1.0;
			//bomberman.color = 0xFFFFFF;
			
		}
		
		override public function update():void 
		{
			if (bomberman.currentAnim != "die") alive(); 
		}
		
		private function alive():void
		{
			vx = 0; vy = 0;
			if (Input.check(Key.LEFT)) { vy = 0; vx = -2;  bomberman.play("walk_left"); }
			if (Input.check(Key.RIGHT)) { vy = 0; vx = 2; bomberman.play("walk_right"); }
			if (Input.check(Key.UP)) { vx = 0; vy = -2; bomberman.play("walk_up"); }
			if (Input.check(Key.DOWN)) { vx = 0; vy = 2;  bomberman.play("walk_down"); }
			if (Input.released(Key.Z) && !collide("bomb",x,y)) {
				var bomb:Bomb = new Bomb();
				bomb.x = Math.round(x/32)*32;
				bomb.y = Math.round((y-originY)/32)*32;
				BWorld.instance.add(bomb); 
				
				}
			if (vx == 0 && vy == 0) { 
				if (bomberman.currentAnim == "walk_right") bomberman.play("stand_right");
				if (bomberman.currentAnim == "walk_left") bomberman.play("stand_left");
				if (bomberman.currentAnim == "walk_up") bomberman.play("stand_up");
				if (bomberman.currentAnim == "walk_down") bomberman.play("stand_down");
			}
			if (!collide("solid", x + vx, y)) 
				x += vx;
			else {
				var dy:int = 0;
				var right_top:Boolean = Ground.instance.collidePoint(0, 0, right+vx, top);
				var right_bottom:Boolean = Ground.instance.collidePoint(0, 0, right+vx, bottom);
				if (right_top) dy = +2;
				if (right_bottom) dy = -2;
				if (right_top && right_bottom) dy = 0;
				if (!collide("solid",x, y+dy)) y += dy;
				dy = 0;
				var left_top:Boolean = Ground.instance.collidePoint(0, 0, left+vx, top);
				var left_bottom:Boolean = Ground.instance.collidePoint(0, 0, left+vx, bottom);
				if (left_top) dy = +2;
				if (left_bottom) dy = -2;
				if (left_top && left_bottom) dy = 0;
				if (!collide("solid",x, y+dy)) y += dy;
			}
				
			if (!collide("solid", x, y + vy)) 
				y += vy;
			else {
				var dx:int = 0;
				var top_left:Boolean = Ground.instance.collidePoint(0, 0, left, top+vy);
				var top_right:Boolean = Ground.instance.collidePoint(0, 0, right, top + vy);
				if (top_left) dx = +2;
				if (top_right) dx = -2;
				if (top_left && top_right) dx = 0;
				if (!collide("solid",x+dx, y)) x += dx;
				dx = 0;
				var left_bottom:Boolean = Ground.instance.collidePoint(0, 0, left, bottom+vy);
				var right_bottom:Boolean = Ground.instance.collidePoint(0, 0, right, bottom + vy);
				if (left_bottom) dx = +2;
				if (right_bottom) dx = -2;
				if (left_bottom && right_bottom) dx = 0;
				if (!collide("solid",x+dx, y)) x += dx;
			}
				
			/*if (collide("solid",x,y)) 
			FP.console.log("collide");*/
			
			if (collide("enemy", x, y)) { bomberman.play("die"); }
			if (collide("explosion", x, y)) {bomberman.play("die");}
			
		}
		
		private function anim_end():void 
		{
			if (bomberman.currentAnim == "die") BWorld.instance.restart();
		}
		
	}

}