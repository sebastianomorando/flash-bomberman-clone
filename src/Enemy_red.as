package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	/**
	 * ...
	 * @author Sebastiano Morando
	 */
	public class Enemy_red extends Entity
	{
		[Embed(source = '../img/enemy1.png')] private const ENEMY:Class;
		
		public var enemy:Spritemap = new Spritemap(ENEMY, 32, 48);
		
		private var vx:Number = 0;
		private var vy:Number = 0;
		
		public function Enemy_red() 
		{
			enemy.add("left", [0, 1, 2, 3], 6);
			enemy.add("down", [4, 5, 6, 7], 6);
			enemy.add("up", [8, 9, 10, 11], 6);
			
			graphic = enemy;
			enemy.play("left");
			setHitbox(32, 32, 0, -16);
			vx = -1;
			
			type = "enemy";
		}
		
		override public function update():void
		{
			
			if (vx != 0) {
				enemy.play("left");
				
				if (!collide("solid", x + vx, y)) 
					x += vx;
				else 
					vx = -1 * vx;
					
				if (collide("enemy", x + vx, y)) 
					vx = -1 * vx;
					
				if (collide("bomb", x + vx, y)) 
					vx = -1 * vx;
					
				if (collide("solid", x + 2, y) && collide("solid", x - 2, y)) { vx = 0; vy = -1; }
				
				if (vx > 0) enemy.flipped = true; else enemy.flipped = false;
			}
				
			
			if (vy != 0) {
				if (!collide("solid", x, y+vy)) 
					y += vy;
				else 
					vy = -1 * vy;
					
				if (collide("enemy", x + vx, y)) 
					vy = -1 * vy;
					
				if (collide("bomb", x + vx, y)) 
					vy = -1 * vy;
					
				if (collide("solid", x, y + 2) && collide("solid", x, y + 2)) { vx = -1; vy = 0; }
				
				if (vy > 0) enemy.play("down"); else enemy.play("up");
			}
				
			if (collide("explosion", x, y)) BWorld.instance.remove(this);
			
		}
		
	}

}