package  
{
	import net.flashpunk.World;
	/**
	 * ...
	 * @author Sebastiano Morando
	 */
	public class BWorld extends World
	{
		public static var instance:BWorld;
		
		
		public function BWorld() 
		{
			instance = this;
			add(new Ground());
			add(new Player());
		}
		
		public function restart():void 
		{
			removeAll();
			add(new Ground());
			add(new Player());
			
		}
		
	}

}