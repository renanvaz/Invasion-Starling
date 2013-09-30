package game.pages {

	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.List;
	import feathers.data.ListCollection;
	
	import game.utils.ui.Loading;
	
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.events.Event;

	public class PageRanking extends PageBase {

		[Embed(source='/../assets/textures/2x/ranking.png')]
		public static const bmBg:Class;

		public var bg:Image;
		public var header:Header;
		public var list:List;

		public function PageRanking() {
			super();
		}
		
		override protected function initialize():void {
			var m:Loading = new Loading(this);
			
			header = new Header();
			header.title = "RANKING";
			
			var backButton:Button = new Button();
			backButton.label = "Back";
			backButton.addEventListener(Event.TRIGGERED, function(){
				
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