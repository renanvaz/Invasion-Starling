package game.display.sprites {
	import game.engine.AssetManager;

	import starling.animation.Transitions;
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class SpriteStars extends SpriteBase {

		public static var atlas:TextureAtlas;

		public function SpriteStars(x:int, y:int) {
			var self:SpriteStars = this;

			this.x = x;
			this.y = y;

			if(SpriteStars.atlas == null){
				var texture:Texture = Texture.fromBitmap(AssetManager.get.stars.texture, false, false, Starling.contentScaleFactor);
				var xml:XML = XML(AssetManager.get.stars.atlas);
				SpriteStars.atlas = new TextureAtlas(texture, xml);
			}

			this.view = new MovieClip(SpriteStars.atlas.getTextures('stars'), 30);
			this.view.pivotX = this.view.width / 2;
			this.view.pivotY = this.view.height;

			Starling.juggler.tween(this.view, this.view.numFrames / this.view.fps, {
				transition: Transitions.LINEAR,
				onComplete: function():void { self.removeFromParent(true); },
				currentFrame: this.view.numFrames - 1
			});

			this.addChild(this.view);
		}
	}

}

