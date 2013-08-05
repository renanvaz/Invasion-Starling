package game.display.sprites {
	import game.engine.Engine;
	import game.engine.SoundManager;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Quad;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	public class SpriteItem extends SpriteBase {
		private var _mode:String;

		public var bubble:SpriteBubble;
		public var item;

		public const PHYSICS:Object = {
			fall: {
				velocity: {x: 1, y: 3.5},
				acceleration: {x: 0, y: .25}
			},
			bubble: {
				velocity: {x: 1, y: 1},
				acceleration: {x: 0, y: 0}
			}
		};

		public function SpriteItem(item) {
			this.direction 		= Math.random() > .5 ? 1 : -1;
			this.scaleX 		*= this.direction;

			this.item 			= item;
			this.item.scaleX 	*= this.direction;
			this.addChild(this.item);
			
			this.hit 			= new Quad(100, 100, 0x0);
			this.hit.pivotX 	= 50;
			this.hit.pivotY 	= 50;
			this.hit.alpha 		= 0;
			this.addChild(this.hit);
			
			this.mode 			= 'bubble';

			this.hit.addEventListener(TouchEvent.TOUCH, function(e){
				var self:SpriteItem 	= e.currentTarget.parent;
				var touch:Object 		= e.getTouch(self);

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
			SoundManager.play('item');
			var s:SpriteStars = new SpriteStars(this.x, this.y);
			this.parent.addChild(s);
			this.item.collect();
			this.remove();
		}

		override public function lose():void {
			this.item.lose();
			Engine.remove(this);
		}

		override public function remove():void {
			Engine.remove(this);
		}

		public function set mode(v):void {
			var intensity:Number = .5;
			var rand_x:Number = Math.random();
			var rand_y:Number = Math.random();
			var sWidth:Number = Engine.main.stage.stageWidth;
			var sHeight:Number = Engine.main.stage.stageHeight;
			
			intensity = intensity + (Math.random() * intensity);
			
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
					this.hit.width = 77;
					this.hit.height = 77;
					
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
