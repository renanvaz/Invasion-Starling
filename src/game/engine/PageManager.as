package game.engine {

	import com.greensock.TweenNano;
	import com.greensock.easing.Expo;
	
	import game.pages.PageBase;
	
	import starling.animation.Transitions;
	import starling.core.Starling;
	import starling.display.Sprite;

	public class PageManager {
		public static var main:Sprite;
		public static var current:String = null;
		private static var _pages:Object = {};
		private static var inTransition:Boolean = false;

		public static function add(name:String, page:Sprite):void {
			page.visible = false;

			PageManager._pages[name] = page;
			PageManager.main.addChild(page);
		}

		public static function get(name:String):PageBase {
			return PageManager._pages[name];
		}

		public static function goTo(name:String, direction:String = 'left'):void {
			if(!PageManager.inTransition){
				trace('Go to page: ' + name);
				PageManager.inTransition = true;
				
				var nextPage:Object = PageManager.get(name);
	
				nextPage.visible = true;
				nextPage.onShow();
	
				if(PageManager.current){
					var currentPage:PageBase = PageManager.get(current);
					currentPage.onHide();
	
					if(direction === 'left'){
						nextPage.x = PageManager.main.stage.stageWidth;
						
						/*
						Starling.juggler.tween(currentPage, 1.2, {
							transition: Transitions.EASE_OUT,
							onComplete: function():void { currentPage.visible = false; },
							x: -currentPage.width
						});
						Starling.juggler.tween(nextPage, 1.2, {
							transition: Transitions.EASE_OUT,
							x: 0
						});
						*/
						
						TweenNano.to(currentPage, 1.2, {x: -PageManager.main.stage.stageWidth, onComplete: function():void { currentPage.visible = false; PageManager.inTransition = false; }, ease: Expo.easeInOut});
						TweenNano.to(nextPage, 1.2, {x: 0, ease: Expo.easeInOut});
						
					}else if(direction === 'right'){
						nextPage.x = -nextPage.width;
	
						/*
						Starling.juggler.tween(currentPage, 1.2, {
							transition: Transitions.EASE_OUT,
							onComplete: function():void { currentPage.visible = false; },
							x: PageManager.main.stage.stageWidth
						});
						Starling.juggler.tween(nextPage, 1.2, {
							transition: Transitions.EASE_OUT,
							x: 0
						});
						*/
						
						TweenNano.to(currentPage, 1.2, {x: PageManager.main.stage.stageWidth, onComplete: function():void { currentPage.visible = false; PageManager.inTransition = false; }, ease: Expo.easeInOut});
						TweenNano.to(nextPage, 1.2, {x: 0, ease: Expo.easeInOut});
					}
				}else{
					nextPage.x = nextPage.y = 0;
					PageManager.inTransition = false;
				}
	
				PageManager.current = name;
			}
		}

	}

}