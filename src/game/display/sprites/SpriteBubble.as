package game.display.sprites {
	import game.engine.AssetManager;
	import game.engine.Engine;
	import game.engine.SoundManager;

	import starling.animation.Transitions;
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class SpriteBubble extends SpriteBase {
	
		public static var atlas:TextureAtlas;
		
		public const SCORE:Object = {
			collect: 20
		};

		public function SpriteBubble(type:String = 'bubble', x:Number = 0, y:Number = 0) {
			var self:SpriteBubble = this;

			this.x = x;
			this.y = y;

			if(SpriteBubble.atlas == null){
				var texture:Texture = Texture.fromBitmap(AssetManager.get.bubble.texture, false, false, Starling.contentScaleFactor);
				var xml:XML = XML(AssetManager.get.bubble.atlas);
				SpriteBubble.atlas = new TextureAtlas(texture, xml);
			}

			this.view = new MovieClip(SpriteBubble.atlas.getTextures(type), 30);
			this.view.pivotX = 45;
			this.view.pivotY = 45;

			if(type == 'explode'){
				SoundManager.play('bubble-explode');

				Starling.juggler.tween(this.view, this.view.numFrames / this.view.fps, {
					transition: Transitions.LINEAR,
					onComplete: function():void { self.removeFromParent(true); },
					currentFrame: this.view.numFrames - 1
				});
			}else{
				Starling.juggler.add(this.view);
			}

			this.addChild(this.view);
		}

		override public function collect():void {
			Engine.addScore(this.SCORE.collect, this.parent.x, this.parent.y);

			this.remove();
		}

		override public function remove():void {
			var b:SpriteBubble = new SpriteBubble('explode', this.parent.x, this.parent.y);
			this.parent.parent.addChild(b);

			this.removeFromParent(true);
		}
	}

}

