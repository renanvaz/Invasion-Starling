package game.pages {
	import feathers.controls.Button;
	
	import game.engine.Engine;
	import game.engine.PageManager;
	import game.utils.ui.Loading;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	public class PageConnect extends PageBase {

		[Embed(source='/../assets/textures/2x/home.png')]
		public static const bmBg:Class;

		public var bg:Image;

		public function PageConnect() {
			super();

			this.bg = Image.fromBitmap(new bmBg, false, Starling.contentScaleFactor);

			var loading:Loading = new Loading(this);
			var button:Button = new Button();
			button.label = "Connect";
			button.addEventListener(Event.TRIGGERED, function():void {
				FB.login(function(status:Boolean):void {
					if(status){
						loading.show();
						FB.api('/me', {}, function(res:Object):void {
							var user:Object = Global.data.get('user'); //"user" was generated at the end of the first match of the user to record the score
							Global.data.set('user', {id: res.id, name: res.name, score: user.score});
							loading.hide();	
							PageManager.goTo('home');
						});
					}else{
						
					}
				});
			});
			
			addChild(this.bg);
			addChild(button);
		}
	}

}