package  
{
	import flash.display.Sprite;
	import net.atraxgames.topdown.Tile
	import net.atraxgames.Utils;
	/**
	 * ...
	 * @author Sebastiano Morando
	 */
	public class World extends Sprite
	{
		
		public var layer0:Array = new Array();
		public var p_height:int = 32;
		public var p_width:int = 32;
		
		public function World():void 
		{
			/* Riempio il level 0 */
			for (var ix:int = 0; ix < p_width; ix++)
			{
				layer0[ix] = new Array();
				for (var iy:int = 0; iy < p_height; iy++) {
					setTile(ix, iy,Utils.nRand(0,1));
					addChild(layer0[ix][iy]);
					layer0[ix][iy].x = Tile.tileWidth*ix;
					layer0[ix][iy].y = Tile.tileHeight*iy;
				}
			}
		}
		
		public function setTile(_px:int, _py:int,_type:int):void 
		{
			switch (_type) 
			{
				case 0:
						layer0[_px][_py] = new EmptyTile();
				break;
			case 1:
				layer0[_px][_py] = new WallTile();
				break;
				default:
			}
			
		}
	}

}