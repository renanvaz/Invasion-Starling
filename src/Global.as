package
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public class Global
	{	
		public static var FPS:int 					= 0;
		public static var internetStatus:Boolean 	= false;
		public static var WS:String 				= 'http://198.211.108.145/invasion/ws/';
		public static var adData:Array 				= [];		
		
		
		public static function getAdData():void {
			if(Global.internetStatus){
				var loader:URLLoader = new URLLoader();
				var request:URLRequest = new URLRequest();
				request.url = Global.WS;
				loader.addEventListener(Event.COMPLETE, function(e:Event):void {
					var res:Object = JSON.parse(URLLoader(e.target).data);
					
					if(res.status){
						Global.adData = res.data;
					}
				});
				loader.load(request);
			}
		}
	}
}