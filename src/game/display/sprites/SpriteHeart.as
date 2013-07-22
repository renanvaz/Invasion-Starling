package game.display.sprites {
	import game.engine.AssetManager;

	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class SpriteHeart extends Sprite {
		public static var atlas:TextureAtlas;
		public var view:Image;
		private var _active:Boolean;

		public function SpriteHeart(active:Boolean = true) {
			if(!SpriteHeart.atlas){
				var texture:Texture = Texture.fromBitmap(AssetManager.get.heart.texture, false, false, Starling.contentScaleFactor);
				var xml:XML = XML(AssetManager.get.heart.atlas);
				SpriteHeart.atlas = new TextureAtlas(texture, xml);
			}

			this.active = active;
		}

		public function set active (v:Boolean):void {
			this._active = v;

			this.removeChild(this.view);
			if(v){
				this.view = new Image(SpriteHeart.atlas.getTexture('heart'));
				this.addChild(this.view);
			}else{
				this.view = new Image(SpriteHeart.atlas.getTexture('inactive'));
				this.addChild(this.view);
			}
		}
	}

}