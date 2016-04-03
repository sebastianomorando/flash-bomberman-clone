package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.FP;
	import net.flashpunk.masks.Grid;
	/**
	 * ...
	 * @author Sebastiano Morando
	 */
	public class Ground extends Entity
	{
		[Embed(source = '../img/tiles01.png')] private const TILESHEET:Class;
		
		public var tileMap:Tilemap = new Tilemap(TILESHEET, 640, 480, 32, 32);
		public var grid:Grid;
		
		public static var instance:Ground;
		
		public function Ground() 
		{
			instance = this;
			graphic = tileMap;
			type = "solid";
			mask = grid = new Grid(640, 480, 32, 32);
			
			for (var i:int = 0; i < 20; i++){
				for (var j:int = 0; j < 15; j++) {
					var temp_tile:int = ((i + 1) % 2) * ((j + 1) % 2);
					if (i == 0) temp_tile = 1;
					if (j == 0) temp_tile = 1;
					if (i == 19) temp_tile = 1;
					if (j == 14) temp_tile = 1;
					tileMap.setTile(i, j, temp_tile*2);
					if (temp_tile == 1) grid.setTile(i, j, true); 
					else {
						grid.setTile(i, j, false);
					
						if ((i > 2 || j > 2) && FP.rand(4) == 0) {
							var wall:Wall = new Wall();
							wall.x = i * 32;
							wall.y = j * 32;
							BWorld.instance.add(wall);
						} else {
							if ((i > 2 || j > 2) && FP.rand(24) == 0) {
								var enemy:Enemy_red = new Enemy_red();
								enemy.x = i * 32;
								enemy.y = (j * 32)-16;
								BWorld.instance.add(enemy);
							}
						}
					}
				}
			}
			
			
			layer = 3;
		}
		
		public function init():void 
		{
			
		}
		
	}

}