package game.display.sprites {

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.ColorTransform;
	import flash.utils.Dictionary;

	import game.engine.AssetManager;
	import game.engine.Engine;
	import game.engine.SoundManager;

	import starling.animation.Transitions;
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Quad;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class SpriteEte extends SpriteBase {

		public static var textures:Dictionary		= new Dictionary;
		public static var colors:Array				= [];

		public var color:Number;

		private var bubble:SpriteBubble;
		private var atlas:TextureAtlas;
		private var _mode:String;


		public const SCORE:Object = {
			collect: {
				fall: 50,
				airplane: 70
			}
		};

		public const PHYSICS:Object = {
			fall: {
				velocity: {x: 1, y: 3.5},
				acceleration: {x: 0, y: .25}
			},
			bubble: {
				velocity: {x: 1, y: 1},
				acceleration: {x: 0, y: 0}
			},
			airplane: {
				velocity: {x: 2, y: 3},
				acceleration: {x: .3, y: 0}
			}
		};

		public function SpriteEte(type:String = null, color:Number = 0) {
			this.direction 	= Math.random() > .5 ? 1 : -1;
			this.scaleX 	*= this.direction;

			if (!type) {
				var rand_mode:Number = Math.random();
				type = rand_mode > .6 ? 'airplane': (rand_mode > .3 ? 'bubble': 'fall');
			}

			if (!color) {
				color = Number('0x'+(Math.random() * (255 * 255 * 255)).toString(16));
			}

			this.hit 			= new Quad(100, 100, 0x0);
			this.hit.pivotX 	= 50;
			this.hit.pivotY 	= 50;
			this.hit.alpha 		= 0;
			this.addChild(this.hit);

			this.mode = type;
			this.color = color;

			this.hit.addEventListener(TouchEvent.TOUCH, function(e):void {
				var self:SpriteEte 	= e.currentTarget.parent;
				var touch:Object 	= e.getTouch(self);

				if(touch){
					if(touch.phase == TouchPhase.BEGAN){
						self.touch();
					}
				}
			});
			
			trace(Global.stage.stageWidth, Global.viewPort.width);
		}

		override public function touch():void {
			if(this.mode === 'bubble'){
				this.mode = 'fall';
			} else {
				this.collect();
			}
		}

		override public function collect():void {
			SoundManager.play('ete-explode');
			Engine.addScore(this.SCORE.collect[this.mode], this.x, this.y);
			this.remove();
		}

		override public function lose():void {
			Engine.life--;
			Engine.remove(this);
		}

		override public function remove():void {
			if(this.bubble) {
				this.bubble.remove();
			}

			var ex:MovieClip = new MovieClip(this.atlas.getTextures('explode'), 60);
			ex.pivotX = 70;
			ex.pivotY = 41;
			ex.x = this.x;
			ex.y = this.y;

			Starling.juggler.tween(ex, ex.numFrames / ex.fps, {
				transition: Transitions.LINEAR,
				onComplete: function():void { ex.removeFromParent(true); },
				currentFrame: ex.numFrames - 1
			});

			this.parent.addChild(ex);

			Engine.remove(this);
		}

		public static function getTexture(color:uint = 0x990099):TextureAtlas {
			if(!SpriteEte.textures[color]){
				var bmData:BitmapData 	= new BitmapData(AssetManager.get.ete.texture.body.width, AssetManager.get.ete.texture.body.height, true, 0x00000000)
					, spriteBody:Bitmap	= new Bitmap(AssetManager.get.ete.texture.body.bitmapData.clone())
					, bm:Bitmap
					, colorRGB:Object 	= {
						r: ((color & 0xFF0000) >> 16),
						g: ((color & 0x00FF00) >> 8),
						b: ((color & 0x0000FF))
					};

				spriteBody.bitmapData.draw(AssetManager.get.ete.texture.body.bitmapData, null, new ColorTransform(colorRGB.r / 255, colorRGB.g / 255, colorRGB.b / 255));

				bmData.draw(AssetManager.get.ete.texture.wing2.bitmapData);
				bmData.draw(spriteBody.bitmapData);
				bmData.draw(AssetManager.get.ete.texture.wing1.bitmapData);
				bmData.draw(AssetManager.get.ete.texture.elements.bitmapData);

				bm = new Bitmap(bmData);

				var texture:Texture = Texture.fromBitmap(bm, false, false, Starling.contentScaleFactor);
				var xml:XML = XML(AssetManager.get.ete.atlas);
				var atlas:TextureAtlas = new TextureAtlas(texture, xml);

				SpriteEte.textures[color] = atlas;
				SpriteEte.colors.push(color);
			}

			return SpriteEte.textures[color];
		}

		public function set mode(v):void {
			var intensity:Number = .5;
			var rand_x:Number = Math.random();
			var rand_y:Number = Math.random();
			var sWidth:Number = Global.stage.stageWidth;
			var sHeight:Number = Global.stage.stageHeight;

			intensity = intensity + (Math.random() * intensity);

			if(this.atlas == null){
				this.atlas = SpriteEte.textures[SpriteEte.colors[Math.round(Math.random() * (SpriteEte.colors.length - 1))]];
			}

			if(this.view){
				this.view.removeFromParent();
			}

			this.view = new MovieClip(this.atlas.getTextures(v), 60);
			this.view.pivotX = 69;
			this.view.pivotY = 41;

			Starling.juggler.add(this.view);
			this.addChild(this.view);

			switch(v) {
				case 'bubble':
					this.hit.width = 70;
					this.hit.height = 77;

					this.bubble = new SpriteBubble;
					this.bubble.scaleX *= this.direction;
					this.addChild(this.bubble);

					if(Math.random() > .5){
						if(this.direction === -1){
							this.x = (rand_x * (sWidth/2 - this.hit.width)) + this.hit.width/2 + sWidth/2;
						}else{
							this.x = (rand_x * (sWidth/2 - this.hit.width)) + this.hit.width/2;
						}
						this.y = -this.height/2;
					}else{
						if(this.direction === -1) {
							this.x = sWidth + this.hit.width/2;
						} else {
							this.x = -this.hit.width/2;
						}

						this.y = Math.random() * (sHeight * .2);
					}
				break;
				case 'fall':
					this.hit.width = 50;
					this.hit.height = 56;

					if(this.bubble) {
						this.bubble.collect();
						this.bubble = null;
					} else {
						if(this.direction === -1){
							this.x = (rand_x * (sWidth/2 - this.hit.width)) + this.hit.width/2 + sWidth/2;
						}else{
							this.x = (rand_x * (sWidth/2 - this.hit.width)) + this.hit.width/2;
						}
						this.y = -this.hit.height/2;
					}
				break;
				case 'airplane':
					this.hit.width = 50;
					this.hit.height = 56;

					if(this.direction === -1) {
						this.x = sWidth + this.hit.width/2 + 50;
					} else {
						this.x = -this.hit.width/2 - 50;
					}

					this.y = Math.random() * (sHeight * .5);
				break;
			}

			this.hit.width += 10; //border gap
			this.hit.height += 10;
			this.addChild(this.hit); //adjust depth

			this.velocity.x = ((this.PHYSICS[v].velocity.x * intensity) * this.direction) * Engine.currentTimeline.enemys.intensity;
			this.velocity.y = (this.PHYSICS[v].velocity.y * intensity) * Engine.currentTimeline.enemys.intensity;

			this.acceleration.x = ((this.PHYSICS[v].acceleration.x * intensity) * this.direction) * Engine.currentTimeline.enemys.intensity;
			this.acceleration.y = (this.PHYSICS[v].acceleration.y * intensity) * Engine.currentTimeline.enemys.intensity;

			this._mode = v;
		}

		public function get mode():String {
			return this._mode;
		}

	}

}
