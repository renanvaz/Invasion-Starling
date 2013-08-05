package game.display.items {
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	import game.engine.Engine;
	
	import starling.core.Starling;
	import starling.display.Image;

	public class ItemAD extends ItemBase {
		private var data:Object;
		
		public function ItemAD(d:Object) {
			var self:ItemAD = this;
			this.data = d;
			
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(e:Event):void {
				var bm:Bitmap = loader.content as Bitmap;
				
				self.view = Image.fromBitmap(bm, false, Starling.contentScaleFactor);
				self.view.pivotX = self.view.pivotY = 38/2;
				self.addChild(self.view);
			});
			
			var fileRequest:URLRequest = new URLRequest(this.data.image);
			loader.load(fileRequest);
		}
		
		override public function collect():void {
			Engine.addScore(this.data.points, this.parent.x, this.parent.y);
		}
	}
}