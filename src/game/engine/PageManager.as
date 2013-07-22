package game.engine {

	import starling.animation.Transitions;
	import starling.core.Starling;
	import starling.display.Sprite;

	public class PageManager {
		public static var main:Sprite;
		public static var current:String = null;
		private static var _pages:Object = {};

		public static function add(name:String, page:Sprite):void {
			page.visible = false;

			PageManager._pages[name] = page;
			PageManager.main.addChild(page);
		}

		public static function get(name:String){
			return PageManager._pages[name];
		}

		public static function goTo(name:String, direction:String = 'left'){
			var nextPage = PageManager.get(name);

			nextPage.visible = true;
			nextPage.reset();

			if(PageManager.current){
				var currentPage = PageManager.get(current);

				if(direction === 'left'){
					nextPage.x = PageManager.main.stage.stageWidth;

					Starling.juggler.tween(currentPage, 1.2, {
						transition: Transitions.EASE_OUT,
						onComplete: function():void { currentPage.visible = false; },
						x: -currentPage.width
					});
					Starling.juggler.tween(nextPage, 1.2, {
						transition: Transitions.EASE_OUT,
						x: 0
					});
				}else if(direction === 'right'){
					nextPage.x = -nextPage.width;

					Starling.juggler.tween(currentPage, 1.2, {
						transition: Transitions.EASE_OUT,
						onComplete: function():void { currentPage.visible = false; },
						x: PageManager.main.stage.stageWidth
					});
					Starling.juggler.tween(nextPage, 1.2, {
						transition: Transitions.EASE_OUT,
						x: 0
					});
				}
			}else{
				nextPage.x = nextPage.y = 0;
			}

			PageManager.current = name;
		}

	}

}