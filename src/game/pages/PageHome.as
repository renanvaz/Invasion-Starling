package game.pages {
	import game.engine.PageManager;
	import game.engine.Engine;

	import starling.core.Starling;
	import starling.display.Image;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	public class PageHome extends PageBase {

		[Embed(source='/../assets/textures/2x/home.png')]
		public static const bmBg:Class;

		public var bg:Image;

		public function PageHome() {
			super();

			this.bg = Image.fromBitmap(new bmBg, false, Starling.contentScaleFactor);

			addChild(this.bg);

			this.addEventListener(TouchEvent.TOUCH, function(e):void{
				var self = e.currentTarget;
				var touch = e.getTouch(self);

				if(touch){
					if(touch.phase == TouchPhase.BEGAN){
						
						
						Engine.paused = false;
						PageManager.goTo('game');
					}
				}
			});
		}
	}

}