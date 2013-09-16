package game.pages {

	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.ImageLoader;
	import feathers.controls.List;
	import feathers.controls.ScrollContainer;
	import feathers.core.PopUpManager;
	import feathers.data.ListCollection;
	import feathers.events.FeathersEventType;
	
	import game.engine.PageManager;
	import game.utils.ui.Loading;
	
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	public class PageStart extends PageBase {

        [Embed(source='/../assets/textures/2x/start.png')]
        public static const bmBg:Class;

		[Embed(source='/../assets/textures/2x/popup.png')]
		public static const popupBg:Class;

		public var bg:Image;
		public var header;
		public var container;
		public var list;

		public function PageStart() {
			super();

			/*this.bg = Image.fromBitmap(new bmBg, false, Starling.contentScaleFactor);

			addChild(this.bg);

			this.addEventListener(TouchEvent.TOUCH, function(e):void{
				var self = e.currentTarget;
				var touch = e.getTouch(self);

				if(touch){
					if(touch.phase == TouchPhase.BEGAN){
						PageManager.goTo('todo');
					}
				}
			});*/
		}


		override protected function initialize():void {
			var m:Loading = new Loading(this);
			
			header = new Header();
			header.title = "RANKING";
			
			var backButton:Button = new Button();
			backButton.label = "Back";
			backButton.addEventListener(Event.TRIGGERED, function(){
				FB.login();
			});

			header.leftItems = new <DisplayObject>[backButton];
			this.addChild(header);

			list = new List();
			list.itemRendererProperties.labelField = "name";
			list.isSelectable = false;

			Global.data.bind('ranking', function(data):void {
				m.hide();
				var lc:ListCollection = new ListCollection(data);
				list.dataProvider = lc;
			});
			
			this.addChild(list);
			
			m.show();
			
		}

		override protected function draw():void {
			header.width =  Global.stage.stageWidth;

			list.width = Global.stage.stageWidth;
			list.height = Global.stage.stageHeight - header.height;
			list.y = header.height;
			list.itemRendererProperties.horizontalAlign = Button.HORIZONTAL_ALIGN_LEFT;
			list.itemRendererProperties.verticalAlign = Button.VERTICAL_ALIGN_MIDDLE;
			list.itemRendererProperties.iconPosition = Button.ICON_POSITION_TOP;
			list.itemRendererProperties.gap = 10;
		}
	}
}

