package  
{
	import flash.display.Sprite;
	import flash.sampler.NewObjectSample;
	import net.atraxgames.topdown.*;
	/**
	 * ...
	 * @author Sebastiano Morando
	 */
	public class PlayState extends Sprite
	{
		
		public var player:Player = new Player(new Asset.sprite_sheet_class, 32, 64);
		
		public var level:World = new World();
		
		public function PlayState() 
		{
			addChild(level);
			addChild(player);
			
		}
		
	}

}