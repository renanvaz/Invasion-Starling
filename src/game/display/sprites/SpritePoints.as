package game.display.sprites {

	import game.utils.ui.Text;
	
	import starling.animation.Transitions;
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	public class SpritePoints extends Sprite {
		private var txt:Text;

		public function SpritePoints(p:Number, x:Number, y:Number) {
			var self:SpritePoints = this;
			this.x = Math.round(x);
			this.y = Math.round(y);
			this.pivotX = 60;
			this.pivotY = 35;
			this.touchable = false;
			
			this.txt = new Text(120, 50, p.toString(), 13 * 2.5);

			this.addChild(this.txt);

			Starling.juggler.tween(this, .6, {
				transition: Transitions.EASE_OUT,
				onComplete: function():void { self.removeFromParent(true) },
				y: Math.round(y - 25)
			});
		}

		public function set text (v:String):void {
			this.txt.text = v;
		}

	}

}