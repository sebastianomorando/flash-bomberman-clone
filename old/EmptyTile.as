package  
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import net.atraxgames.topdown.Tile;
	/**
	 * ...
	 * @author Sebastiano Morando
	 */
	public class EmptyTile extends Tile
	{
		
		public function EmptyTile() 
		{
			var canvas:BitmapData = new BitmapData(32,32);
			var image:Bitmap = new Bitmap(canvas);
			
			canvas.copyPixels((new Asset.tileset_class).bitmapData, new Rectangle(0, 0, 32, 32), new Point(0, 0));
			
			addChild(image);
		}
		
	}

}