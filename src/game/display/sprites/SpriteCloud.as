package game.display.sprites {
	import game.engine.AssetManager;

	import starling.core.Starling;
	import starling.display.Image;

	public class SpriteCloud extends SpriteBase {

		public function SpriteCloud() {
			this.view = Image.fromBitmap(AssetManager.get.cloud.texture, false, Starling.contentScaleFactor)
			this.addChild(this.view);
		}
	}

}