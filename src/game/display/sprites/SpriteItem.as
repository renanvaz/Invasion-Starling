package game.display.sprites {
	import game.engine.SoundManager;

	import starling.core.Starling;
	import starling.display.Image;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import game.engine.Engine;

	public class SpriteItem extends SpriteBase {
		private var _mode:String;

		public var bubble:SpriteBubble;
		public var item;

		public var SCORE:Object = {
			bubble: 20,
			fall: 0,
		}

		public const PHYSICS:Object = {
			fall: {
				velocity: {x: .5, y: 3.5},
				acceleration: {x: .05, y: .1}
			},
			bubble: {
				velocity: {x: 1, y: 1},
				acceleration: {x: 0, y: 0}
			}
		}

		public function SpriteItem(item, score:int = 50) {
			this.SCORE.fall 	= score;
			this.direction 		= Math.random() > .5 ? 1 : -1;
			this.scaleX 		*= this.direction;

			this.item 			= item;
			this.item.scaleX 	*= this.direction;
			this.addChild(this.item);
			this.mode 			= 'bubble';

			this.hit.addEventListener(TouchEvent.TOUCH, function(){
				var self:SpriteEte 	= e.currentTarget.parent;
				var touch:Object 	= e.getTouch(self);

				if(touch){
					if(touch.phase == TouchPhase.BEGAN){
						self.touch();
					}
				}
			});
		}

		override public function touch():void {
			if(this.mode === 'bubble'){
				this.mode = 'fall';
			} else {
				this.collect();
			}
		}

		override public function collect():void {
			this.score(this.SCORE.collect[this.mode]);
			this.remove();
		}

		override public function lose():void {
			Engine.life--;
			Engine.remove(this);
		}

		override public function remove():void {
			SoundManager.play('item');

			var s:SpriteStars = new SpriteStars(this.x, this.y);
			this.parent.addChild(s);

			Engine.remove(this);
		}

		public function set mode(v):void {
			var intensity_x:Number = Math.random();
			var intensity_y:Number = Math.random();
			var rand_x:Number = Math.random();
			var rand_y:Number = Math.random();
			var sWidth:Number = Starling.current.stage.stageWidth;
			var sHeight:Number = Starling.current.stage.stageHeight;

			switch(v) {
				case 'bubble':
					intensity_x = intensity_x * .4 + .8;
					intensity_y = intensity_x * .6 + .7;

					this.bubble = new SpriteBubble;
					this.bubble.scaleX *= this.direction;
					this.addChild(this.bubble);
					if(this.direction === -1){
						this.x = (rand_x * (sWidth/2 - this.width)) + this.width/2 + sWidth/2;
					}else{
						this.x = (rand_x * (sWidth/2 - this.width)) + this.width/2;
					}
					this.y = -this.height/2;
				break;
				case 'fall':
					intensity_x = intensity_x * .4 + .8;
					intensity_y = intensity_x + .5;

					if(this.bubble) {
						this.bubble.collect();
						this.bubble = null;
					} else {
						if(this.direction === -1){
							this.x = (rand_x * (sWidth/2 - this.width)) + this.width/2 + sWidth/2;
						}else{
							this.x = (rand_x * (sWidth/2 - this.width)) + this.width/2;
						}
						this.y = -this.height/2;
					}
				break;
			}

			this.velocity.x = (this.PHYSICS[v].velocity.x * intensity_x) * this.direction;
			this.velocity.y = this.PHYSICS[v].velocity.y * intensity_y;

			this.acceleration.x = (this.PHYSICS[v].acceleration.x * intensity_x) * this.direction;
			this.acceleration.y = this.PHYSICS[v].acceleration.y * intensity_y;

			this._mode = v;
		}

		public function get mode():String {
			return this._mode;
		}
	}

}
