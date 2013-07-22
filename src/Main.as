package 
{  
	import flash.media.Sound;
	
	import game.engine.AssetManager;
	import game.engine.Engine;
	import game.engine.PageManager;
	import game.pages.PageGame;
	import game.pages.PageHome;
	import game.pages.PageRanking;
	import game.pages.PageRankingFB;
	import game.pages.PageStart;
	import game.pages.PageToDo;
	
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Main extends Sprite
	{
		public function Main()
		{
			
		}
		
		public function start():void
		{			
			AssetManager.setup();
			
			/*
			SoundManager.add('test', new testSound as Sound);
			SoundManager.add('test2', new test2Sound as Sound);
			SoundManager.loop('test', 3);
			SoundManager.volume('test', .3);
			SoundManager.play('test2');
			*/
			
			PageManager.main = this;
			PageManager.add('start', new PageStart);
			PageManager.add('todo', new PageToDo);
			PageManager.add('ranking', new PageRanking);
			PageManager.add('rankingFB', new PageRankingFB);
			PageManager.add('home', new PageHome);
			PageManager.add('game', new PageGame);
			
			Engine.main = PageManager.get('game');
			
			PageManager.goTo('game');
			
			//Engine.add(new Item(Image.fromBitmap(new AssetManager.AdTexture, false, Starling.contentScaleFactor), 120));
			
			this.addEventListener(Event.ENTER_FRAME, function(e:Event):void { Engine.process(); });
		}
	}
}