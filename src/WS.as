package
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public class WS
	{
        public static var data:Array = [];

        public static function call(params:Object):void {
            if(Global.internet.active){
                var loader:URLLoader    = new URLLoader();
                var request:URLRequest  = new URLRequest();
                request.url             = Global.config.WS + params.method;
                loader.addEventListener(Event.COMPLETE, function(e:Event):void {
                    var res:Object = JSON.parse(URLLoader(e.target).data);

                    if(res.status){
                        params.callback(res.data);
                    }else{
                        params.callback(false);
                    }
                });
                loader.load(request);
            } else {
                params.callback(false);
            }
        }

	}
}
