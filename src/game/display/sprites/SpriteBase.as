package game.display.sprites {

	import flash.geom.Point;

	import starling.display.DisplayObject;
	import starling.display.Quad;
	import starling.display.Sprite;

	public class SpriteBase extends Sprite {
		public var direction:int 		= 1;
		public var acceleration:Point	= new Point;
		public var velocity:Point		= new Point;
		public var view;
		public var hit:Quad				= null;

		public function SpriteBase() {

		}
	}

}
