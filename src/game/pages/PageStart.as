package game.pages {

	import com.greensock.TweenNano;
	
	import game.engine.PageManager;
	import game.utils.ui.Alert;
	import game.utils.ui.Text;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	public class PageStart extends PageBase {

        [Embed(source='/../assets/textures/2x/start.png')]
		private static const bmBg:Class;

		private var bg:Image;
		private var txtStart:Text;
		

		public function PageStart() {
			super();
			
			var a:Alert = new Alert(this);
			
			
			this.bg = Image.fromBitmap(new bmBg, false, Starling.contentScaleFactor);
			this.txtStart = new Text(Global.stage.stageWidth, 20, 'TAP TO START', Text.sizeBase);
			this.txtStart.y = Global.stage.stageHeight - 20 - (50/Global.starling.contentScaleFactor);
			
			addChild(this.bg);
			addChild(this.txtStart);
			
			this.addEventListener(TouchEvent.TOUCH, function(e):void{
				var self = e.currentTarget;
				var touch = e.getTouch(self);
				
				if(touch){
					if(touch.phase == TouchPhase.BEGAN){
						a.show("teste");
						/*var user:Object = Global.data.get('user');
						if(user){
							if(user.id){
								PageManager.goTo('home');
							}else{
								PageManager.goTo('connect');
							}
						}else{
							PageManager.goTo('todo');
						}*/
					}
				}
			});
		}
		
		private function animate():void {
			TweenNano.to(txtStart, .5, {
				delay: 1,
				alpha: 0, 
				onComplete: function():void {
					TweenNano.to(txtStart, .5, {
						alpha: 1, 
						onComplete: animate
					});
				}
			});
		}


		override protected function initialize():void {
			
		}

		override protected function draw():void {

		}
		
		override public function onShow():void {
			animate();
		}
		
		override public function onHide():void {
			TweenNano.killTweensOf(txtStart);
		}
	}
}

