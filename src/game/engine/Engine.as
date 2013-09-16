package game.engine {

	import game.display.items.ItemAD;
	import game.display.items.ItemHeart;
	import game.display.sprites.SpriteBase;
	import game.display.sprites.SpriteEte;
	import game.display.sprites.SpriteItem;
	import game.display.sprites.SpritePoints;
	import game.utils.EventSimple;

	public class Engine {
		public static var count:int 					= 0;
        public static var sprites:Vector.<SpriteBase>   = new Vector.<SpriteBase>();
		public static var main;
        public static var maxFrames:int                 = 0;

		private static var _event:EventSimple 			= new EventSimple;
		private static var _life:int 					= 0;
        private static var _maxLife:int                 = 0;
        private static var _paused:Boolean              = true;
        private static var _score:int                   = 0;

		public static var events:Object = {
			ADD: 		0,
			REMOVE: 	1,
			PAUSE:		2,
			SCORE: 		3,
			PROCESS: 	4,
			LIFE:		5,
			MAX_LIFE:	6,
			GAME_OVER:	7,
			RESET:		8
		};

		public static var TimelineIndex:int = 0;
		public static var Timeline:Array =
		[
			{
				length: 20, // Seconds
				enemys: {
					interval: {
						min: 3,
						max: 4
					},
					timer: {
						create: 1,
						interval: 9
					},
					intensity: .7
				},
				ads: {
					create: 1 // Número de itens que poderão cair neste intervalo
				},
				items: {
					create: 1 // Número de itens que poderão cair neste intervalo
				}
			},
			{
				length: 40,
				enemys: {
					interval: {
						min: 1,
						max: 3
					},
					timer: {
						create: 2,
						interval: 9
					},
					intensity: 1
				},
				ads: {
					create: 2
				},
				items: {
					create: 2
				}
			},
			{
				length: 45,
				enemys: {
					interval: {
						min: 1,
						max: 3
					},
					timer: {
						create: 2,
						interval: 5
					},
					intensity: 1.5
				},
				ads: {
					create: 4
				},
				items: {
					create: 2
				}
			}
		]

		public static var currentTimeline:Object;

		public static function getTimeline(s:Number):Object {
			var count:int = 0;

			for(var i:int = 0, l:int = Engine.Timeline.length - 1;  i < l; i++){
				if(s <= count + (Engine.Timeline[i].length) && s > count){
					return Engine.Timeline[i];
				}

				count += Engine.Timeline[i].length;
			}

			return Engine.Timeline[i];
		}

		public static function process():void {
			if(!Engine.paused){
				var sprite:SpriteBase, i:int;

				Engine.count++;
				Engine.currentTimeline = Engine.getTimeline(Math.floor(Engine.count/Global.stage.frameRate));

				if(!Engine.currentTimeline.ads.max){
					Engine.currentTimeline.ads.max = [];

					for(i = 0; i < Engine.currentTimeline.ads.create; i++){
						Engine.currentTimeline.ads.max[i] = Engine.count + (Math.round(Math.random() * (Engine.currentTimeline.length - 1)) * Global.stage.frameRate);
					}
				}

				if(!Engine.currentTimeline.items.max){
					Engine.currentTimeline.items.max = [];

					for(i = 0; i < Engine.currentTimeline.items.create; i++){
						Engine.currentTimeline.items.max[i] = Engine.count + (Math.round(Math.random() * (Engine.currentTimeline.length - 1)) * Global.stage.frameRate);
					}
				}

				for each(sprite in Engine.sprites){
					sprite.velocity.x += sprite.acceleration.x;
					sprite.velocity.y += sprite.acceleration.y;

					sprite.x += sprite.velocity.x;
					sprite.y += sprite.velocity.y;

					if(
						sprite.y > Engine.main.stage.stageHeight + sprite.height
						|| (sprite.direction === -1 && sprite.x < (-sprite.width))
						|| (sprite.direction === 1 && sprite.x > (Engine.main.stage.stageWidth + sprite.width))
					 ){
					 	sprite.lose();
					}
				}

				if(Engine.count%maxFrames == 0){
					Engine.add(new SpriteEte());

					var max:Number = Engine.currentTimeline.enemys.interval.max;
					var min:Number = Engine.currentTimeline.enemys.interval.min;
					maxFrames = Engine.count + ((min + Math.round(Math.random() * (max - min))) * Global.stage.frameRate);
				}

				if(Engine.count%(Engine.currentTimeline.enemys.timer.interval * Global.stage.frameRate) == 0){
					for(i = 0; i < Engine.currentTimeline.enemys.timer.create; i++){
						Engine.add(new SpriteEte());
					}
				}

				if(Global.data.get('ad')){
					for(i = 0; i < Engine.currentTimeline.ads.create; i++){
						if(Engine.count == Engine.currentTimeline.ads.max[i]){
							Engine.add(new SpriteItem(new ItemAD(Global.data.get('ad')[Math.round(Math.random() * (Global.data.get('ad').length - 1))])));
						}
					}
				}

				for(i = 0; i < Engine.currentTimeline.items.create; i++){
					if(Engine.count == Engine.currentTimeline.items.max[i]){
						Engine.add(new SpriteItem(new ItemHeart));
					}
				}

				Engine.trigger(Engine.events.PROCESS);
			}
		}

		public static function reset():void {
			Engine.count		= 0;
            Engine.life         = 3;
			Engine.maxFrames	= 3 * Global.stage.frameRate;
            Engine.maxLife      = 5;
			Engine.paused 		= false;
            Engine.sprites      = new Vector.<SpriteBase>();
            Engine.score        = 0;

            Engine.trigger(Engine.events.RESET);

		}

		public static function add(sprite:SpriteBase):void {
			Engine.sprites.push(sprite);
			Engine.main.containerSprites.addChild(sprite);
			Engine.trigger(Engine.events.ADD, sprite);
		}

		public static function remove(sprite:SpriteBase):void {
			Engine.sprites = Engine.sprites.filter(function(item){
				return item !== sprite;
			});

			sprite.removeFromParent(true);
			Engine.trigger(Engine.events.REMOVE, sprite);
		}

		public static function addScore(s:int = 0, x:Number = 0, y:Number = 0):void {
			var p:SpritePoints = new SpritePoints(s, x, y);
			Engine.main.addChild(p);

			Engine.score += s;
		}

		public static function get maxLife():int {
			return Engine._maxLife;
		}

		public static function set maxLife(v:int):void {
			var params:Object = Engine._maxLife;
			Engine._maxLife = v;
			Engine.trigger(Engine.events.MAX_LIFE, params);
		}

		public static function get life():int {
			return Engine._life;
		}

		public static function set life(v:int):void {
			var params:int = Engine._life;
			Engine._life = v;
			Engine.trigger(Engine.events.LIFE, params);

			if(v === 0){
				Engine.trigger(Engine.events.GAME_OVER);
			}
		}

		public static function get paused():Boolean {
			return Engine._paused;
		}

		public static function set paused(v:Boolean):void {
			Engine._paused = v;
			Engine.trigger(Engine.events.PAUSE, v);
		}

		public static function get time():int {
			return Math.round(Engine.count/60);
		}

		public static function get score():int {
			return Engine._score;
		}

		public static function set score(v:int):void {
			Engine._score = v;
			Engine.trigger(Engine.events.SCORE, Engine._score);
		}

		public static function bind(name:String, fn:Function):void{
			Engine._event.bind(name, fn);
		};

		public static function trigger(name:String, params = null):void{
			Engine._event.trigger(name, params);
		};

	}

}
