package game.pages {
	import game.engine.PageManager;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	public class PageToDo extends PageBase {

		[Embed(source='/../assets/textures/2x/todo.png')]
		public static const bmBg:Class;

		public var bg:Image;

		public function PageToDo() {
			super();

			this.bg = Image.fromBitmap(new bmBg, false, Starling.contentScaleFactor);

			addChild(this.bg);

			this.addEventListener(TouchEvent.TOUCH, function(e):void{
				var self = e.currentTarget;
				var touch = e.getTouch(self);

				if(touch){
					if(touch.phase == TouchPhase.BEGAN){
						Global.data.set('todo', true);
						PageManager.goTo('game');
					}
				}
			});
		}
	}

}