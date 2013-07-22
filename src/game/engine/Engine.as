package game.engine {

	import game.display.sprites.SpriteBase;
	import game.display.sprites.SpriteEte;
	import game.utils.EventSimple;
	
	import starling.display.Sprite;

	public class Engine {
		public static var sprites:Vector.<SpriteBase> 	= new Vector.<SpriteBase>();
		public static var count:int 					= 0;
		public static var maxFrames:int 				= 2 * 30;
		public static var main;

		public static var _paused:Boolean 				= true;
		public static var _score:int 					= 0;
		public static var _event:EventSimple 			= new EventSimple;
		public static var _maxLife:int 					= 0;
		public static var _life:int 					= 0;
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

		public static var Timeline:Array = 
		[
			{
				limit: 20,
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
					length: 1 // Número de itens que poderão cair neste intervalo
				},
				items: {
					length: 1 // Número de itens que poderão cair neste intervalo
				}
			},
			{
				limit: 60,
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
					length: 2
				},
				items: {
					length: 2
				}
			}
		]

		public static var currentTimeline:Object;

		public static function getTimeline(s:Number):Object {
			var _oldLimit:int = 0;

			for(var i:int = 0, l:int = Engine.Timeline.length - 1;  i < l; i++){
				if(s < Engine.Timeline[i].limit && s > Number(_oldLimit)){
					return Engine.Timeline[i];
				}

				_oldLimit = Engine.Timeline[i].limit;
			}

			return Engine.Timeline[i];
		}

		public static function process():void {
			if(!Engine.paused){
				Engine.currentTimeline = Engine.getTimeline(Math.floor(Engine.count/30));

				var sprite:SpriteBase;
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
						Engine.remove(sprite);
						Engine.life--;
					}
				}

				if(++Engine.count%maxFrames == 0){
					Engine.add(new SpriteEte());

					var max:Number = Engine.currentTimeline.enemys.interval.max;
					var min:Number = Engine.currentTimeline.enemys.interval.min;
					maxFrames = Engine.count + ((min + Math.round(Math.random() * (max - min))) * 30);
				}
				
				if(Engine.count%(Engine.currentTimeline.enemys.timer.interval * 30) == 0){
					for(var i:int = 0; i < Engine.currentTimeline.enemys.timer.create; i++){
						Engine.add(new SpriteEte());
					}
				}

				Engine.trigger(Engine.events.PROCESS);
			}
		}

		public static function reset():void {
			Engine.maxLife 		= 5;
			Engine.life 		= 3;
			Engine.sprites 		= new Vector.<SpriteBase>();
			Engine.count		= 0;
			Engine.score		= 0;
			Engine.maxFrames	= 3 * 30;

			Engine.trigger(Engine.events.RESET);

			Engine.paused 		= false;
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
