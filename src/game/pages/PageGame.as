package game.pages {

	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import game.display.sprites.SpriteBase;
	import game.display.sprites.SpriteCloud;
	import game.display.sprites.SpriteEte;
	import game.display.sprites.SpriteHeart;
	import game.engine.AssetManager;
	import game.engine.Engine;
	import game.engine.PageManager;
	import game.engine.SoundManager;
	
	import starling.animation.Transitions;
	import starling.core.Starling;
	import starling.display.BlendMode;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	/*
	Estatitsicas
	Contador de tempo
	itens
	*/

	public class PageGame extends PageBase {
		public var _sprites:Vector.<SpriteBase> = new Vector.<SpriteBase>();

		public var count:int 				= 0;
		public var maxFrames:int			= 0;

		public var fxDanger:Image;
		public var bg:Image;
		public var containerClouds:Sprite;
		public var containerSprites:Sprite;
		public var header:Sprite;
		public var containerLife:Sprite;
		public var txtScore:TextField;

		public function PageGame() {
			super();

			this.bg 				= Image.fromBitmap(AssetManager.get.pages.game.bg.texture, false, Starling.contentScaleFactor);
			this.fxDanger 			= Image.fromBitmap(AssetManager.get.pages.game.danger.texture, false, Starling.contentScaleFactor);
			this.fxDanger.blendMode = BlendMode.MULTIPLY;
			this.fxDanger.touchable = false;
			this.containerClouds 	= new Sprite;
			this.containerSprites 	= new Sprite;
			this.header 			= new Sprite;
			this.containerLife 		= new Sprite;

			for(var i:int = 0; i < 10; i++){
				SpriteEte.getTexture(Math.random() * 0xFFFFFF);
			}

			// Setup header
			this.header.addChild(new Quad(320, 25, 0x000000));

			this.txtScore = new TextField(85, 25, 'SCORE: 99999', 'Mini Pixel-7', 13, 0xFFFFFF);
			this.txtScore.hAlign = HAlign.LEFT;
			this.txtScore.vAlign = VAlign.CENTER;
			this.txtScore.x = 7;
			this.txtScore.y = .5;
			//this.txtScore.border = true;
			this.header.addChild(this.txtScore);

			this.containerLife.x = Starling.current.stage.stageWidth - 1;
			this.containerLife.y = 6;
			this.header.addChild(this.containerLife);
			//

			containerSprites.y = this.header.height;

			addChild(this.bg);
			addChild(this.containerClouds);
			addChild(this.containerSprites);
			addChild(this.fxDanger);
			addChild(this.header);

			Engine.bind(Engine.events.LIFE, this.lifeChange);
			Engine.bind(Engine.events.MAX_LIFE, this.maxLifeChange);
			Engine.bind(Engine.events.PROCESS, this.process);
			Engine.bind(Engine.events.GAME_OVER, this.gameOver);
			Engine.bind(Engine.events.SCORE, this.score);
			Engine.bind(Engine.events.RESET, this.reset);
		}
		
		override public function reset():void {
			var sprite:SpriteCloud;
			for each(sprite in this._sprites){
				sprite.dispose();
				this.remove(sprite);
			}
			
			this._sprites 				= new Vector.<SpriteBase>();
			this.fxDanger.visible 		= false;
		}
		
		
		override public function onShow():void {
			Global.stage.instance.frameRate = 30;
			Engine.reset();
			
			SoundManager.loop('bg');
			SoundManager.volume('bg', .5);
		}
		
		override public function onHide():void {
			Global.stage.instance.frameRate = 60;
			SoundManager.stop('bg');
		}

		public function score(params):void {
			this.txtScore.text = 'SCORE: ' + params.toString();
		}

		public function gameOver():void {
			Engine.paused = true;
			var sprite;

			for each(sprite in Engine.sprites){
				sprite.remove();
			}

			//this.screenGameOver.visible = true;
			var user:Object = Global.data.get('user');
			var date:int = new Date().getTime();
			
			if(user){
				user.score.best = Math.max(user.score.best, Engine.score);
				user.score.offline.push({score: Engine.score, date: date});
				Global.data.set('user', user);
			}else{
				Global.data.set('user', {score: {best: Engine.score, offline: [{score: Engine.score, date: date}]}});	
				PageManager.goTo('connect');
			}
		}

		public function lifeChange(oldLife:int):void {
			if(oldLife > Engine.life){
			 	this.fxDanger.alpha = 1;
				this.fxDanger.visible = true;
				Starling.juggler.tween(this.fxDanger, .4, {
					transition: Transitions.LINEAR,
					onComplete: function():void { fxDanger.visible = false; },
					alpha: 0
				});
				SoundManager.play('damage');
			}

		 	for(var i:int = 0; i < Engine.maxLife; i++){
				SpriteHeart(this.containerLife.getChildAt(i)).active = i < Engine.life;
			}
		}

		public function maxLifeChange(oldMaxLife:int):void {
			var h:SpriteHeart;

			while(this.containerLife.numChildren){
				this.containerLife.removeChildAt(0);
			}

		 	for(var i:int = 1; i <= Engine.maxLife; i++){
		 		h = new SpriteHeart;
		 		h.x = -i * (h.width + 3);
				this.containerLife.addChild(h);
			}

			lifeChange(Engine.life);
		}

		public function process():void {
			var sprite:SpriteCloud;
			for each(sprite in this._sprites){
				sprite.x += sprite.acceleration.x;

				if(sprite.x > this.stage.stageWidth){
					this.remove(sprite);
				}
			}

			if(++this.count%this.maxFrames == 0){
				var c:SpriteCloud = new SpriteCloud;
				c.acceleration.x = Math.random() * 2 + .5;
				c.scaleX = c.scaleY = Math.random() * .4 + .6;
				c.alpha = Math.random() * .5 + .5;
				c.x = Math.round(-c.width);
				c.y = Math.round(Math.random() * (this.stage.stageHeight * .5));
				this.add(c);

				this.count = 0;
				this.maxFrames = Math.round(Math.random() * (Global.stage.frameRate * 5));
			}
		}

		public function add(sprite:Sprite):void {
			this._sprites.push(sprite);
			this.containerClouds.addChild(sprite);
		}

		public function remove(sprite:Sprite):void {
			this._sprites = this._sprites.filter(function(item){
				return item !== sprite;
			});

			sprite.removeFromParent(true);
			this.containerClouds.removeChild(sprite);
		}

	}

}
