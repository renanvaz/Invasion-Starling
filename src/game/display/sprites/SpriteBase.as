package game.display.sprites {

	import flash.geom.Point;
	
	import game.engine.Engine;
	
	import starling.display.Quad;
	import starling.display.Sprite;

	public class SpriteBase extends Sprite {
		public var direction:int 		= 1;
		public var acceleration:Point	= new Point;
		public var velocity:Point		= new Point;
		public var hit:Quad				= null;
		public var view:*               = null;

		public function SpriteBase() {

		}

		public function collect():void { this.remove(); } 		// Action for collect this item, ex: Score and Remove
		public function lose():void { this.remove(); } 			// Action for lose this item, ex: Damage and Remove
		public function remove():void { Engine.remove(this); } 	// Animation for remove item from screen
		public function touch():void {} 						// Event handler for touch in this item
	}

}
