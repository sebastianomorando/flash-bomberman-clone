package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author Sebastiano Morando
	 */
	public class Wall extends Entity
	{
		[Embed(source = '../img/wall.png')] private const WALL:Class;
		public var wall:Spritemap = new Spritemap(WALL, 32, 32,anim_end);
		
		public function Wall() 
		{
			wall.add("stand", [0]);
			wall.add("burn", [1, 2, 3, 4, 5], 6);
			graphic = wall;
			wall.play("stand");
			
			setHitbox(32, 32);
			type = "solid";
			layer = 2;
		}
		
		override public function update():void
		{
			if (collide("explosion", x, y)) wall.play("burn");
		}
		
		private function anim_end():void 
		{
			BWorld.instance.remove(this);
		}
		
	}

}