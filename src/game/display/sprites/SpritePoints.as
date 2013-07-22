package game.display.sprites {

	import starling.animation.Transitions;
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	public class SpritePoints extends Sprite {
		private var txt:TextField;
		private var txtShadow:TextField;

		public function SpritePoints(p:Number, x:Number, y:Number) {
			var self:SpritePoints = this;
			this.x = Math.round(x);
			this.y = Math.round(y);
			this.pivotX = 60;
			this.pivotY = 35;
			this.touchable = false;

			this.txtShadow = new TextField(120, 50, p.toString(), 'Mini Pixel-7', 13 * 2.5, 0x0);
			this.txtShadow.hAlign = HAlign.CENTER;
			this.txtShadow.vAlign = VAlign.CENTER;
			this.txtShadow.x = 1 / Starling.contentScaleFactor;
			this.txtShadow.y = 1 / Starling.contentScaleFactor;
			this.addChild(this.txtShadow);

			this.txt = new TextField(120, 50, p.toString(), 'Mini Pixel-7', 13 * 2.5, 0xFFFFFF);
			this.txt.hAlign = HAlign.CENTER;
			this.txt.vAlign = VAlign.CENTER;
			this.txt.x = 0;
			this.txt.y = 0;
			this.addChild(this.txt);

			Starling.juggler.tween(this, .6, {
				transition: Transitions.EASE_OUT,
				onComplete: function():void { self.removeFromParent(true) },
				y: Math.round(y - 25)
			});
		}

		public function set text (v:String):void {
			this.txtShadow.text = v;
			this.txt.text = v;
		}

	}

}