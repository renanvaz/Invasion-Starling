package game.display.items
{
	import starling.display.Sprite;
	
	public class ItemBase extends Sprite {
		public var view;
		
		public function ItemBase () {
			
		}
		
		public function collect():void {  } // Action for collect this item, ex: Score, Life...
		public function lose():void {  } // Action for lose this item, ex: Subtract score, Subtract Life...
	}
}
