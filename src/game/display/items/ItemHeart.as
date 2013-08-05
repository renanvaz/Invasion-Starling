package game.display.items {
	
	import game.engine.AssetManager;
	import game.engine.Engine;
	
	import starling.core.Starling;
	import starling.display.Image;
	
	public class ItemHeart extends ItemBase {
		private var data:Object;
		
		public function ItemHeart() {
			this.view = Image.fromBitmap(AssetManager.get.items.heart.texture, false, Starling.contentScaleFactor);
			this.view.pivotX = 77/4;
			this.view.pivotY = 77/4;
			this.addChild(this.view);
		}
		
		override public function collect():void {
			Engine.life++;
		}
	}
}