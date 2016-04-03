package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author Sebastiano Morando
	 */
	public class Bomb extends Entity
	{
		
		[Embed(source = '../img/bombs1.png')] private const BOMB:Class;
		public var bomb:Spritemap = new Spritemap(BOMB, 32, 32, anim_end);
		
		private var counter:int = 0;
		
		public function Bomb() 
		{
			bomb.add("normal", [0, 1, 2], 6, true);
			graphic = bomb;
			bomb.play("normal");
			
			layer = 1;
			
			type = "bomb";
			setHitbox(32, 32);
		}
		
		override public function update():void
		{
			if (!collide("player", x, y))
				type = "solid";
		}
		
		private function anim_end():void 
		{
			counter++;
			if (counter > 4) explode();
		}
		
		public function explode():void 
		{
			var explosion:Explosion = new Explosion("center");
			explosion.x = x;
			explosion.y = y;
			BWorld.instance.add(explosion);
			
			if (!Ground.instance.collidePoint(0, 0, x-32, y)) {
				var explosion:Explosion = new Explosion("left");
				explosion.x = x - 32;
				explosion.y = y;
				BWorld.instance.add(explosion);
			}
			
			if (!Ground.instance.collidePoint(0, 0, x+32, y)) {
				var explosion:Explosion = new Explosion("right");
				explosion.x = x + 32;
				explosion.y = y;
				BWorld.instance.add(explosion);
			}
			
			if (!Ground.instance.collidePoint(0, 0, x, y-32)) {
				var explosion:Explosion = new Explosion("top");
				explosion.x = x;
				explosion.y = y-32;
				BWorld.instance.add(explosion);
			}
			
			if (!Ground.instance.collidePoint(0, 0, x, y+32)) {
				var explosion:Explosion = new Explosion("bottom");
				explosion.x = x;
				explosion.y = y+32;
				BWorld.instance.add(explosion);
			}
			
			
			
			
			BWorld.instance.remove(this);
		}
		
	}

}