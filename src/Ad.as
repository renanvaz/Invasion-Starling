package
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public class Ad
	{
        public static var data:Array = [];

        public static function getData():void {
            if(Global.internet.active){
                var loader:URLLoader    = new URLLoader();
                var request:URLRequest  = new URLRequest();
                request.url             = Global.config.WS;
                loader.addEventListener(Event.COMPLETE, function(e:Event):void {
                    var res:Object = JSON.parse(URLLoader(e.target).data);

                    if(res.status){
                        Ad.data = res.data;
                    }
                });
                loader.load(request);
            }
        }

	}
}
