package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	/**
	 * ...
	 * @author Sebastiano Morando
	 */
	public class Explosion extends Entity
	{
		[Embed(source = '../img/flames.png')] private const FLAMES:Class;
		public var flames:Spritemap = new Spritemap(FLAMES, 32, 32,anim_end);
		
		public function Explosion(side:String = "center") 
		{
			flames.add("center", [0, 1, 2, 3], 6);
			flames.add("left", [12, 13, 14, 15], 6);
			flames.add("right", [16, 17, 18, 19], 6);
			flames.add("top", [24, 25, 26, 27], 6);
			flames.add("bottom", [28, 29, 30, 31], 6);
			graphic = flames;
			flames.play(side);
			
			type = "explosion";
			setHitbox(32, 32);
			layer = 1;
			
		}
		
		private function anim_end():void 
		{
			BWorld.instance.remove(this);
			
		}
		
		
		
	}

}