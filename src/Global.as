package {
	import flash.geom.Rectangle;
	import flash.system.Capabilities;

    import game.utils.DataObservable;
	import game.utils.EventSimple;

	import starling.core.Starling;

	public class Global {
		private static var _event:EventSimple 		= new EventSimple;

		public static var stage:Object;
        public static var viewPort:Rectangle;
        public static var starling:Starling;
		public static var theme:Object;

        public static var device:Object             = {
            iOS: Capabilities.manufacturer.indexOf("iOS") != -1
        };

        public static var internet:Object           = {
            active: false
        };

		public static var config:Object             = {
            WS: 'http://198.211.108.145/invasion/ws/default/'
            // WS: 'http://127.0.0.1/rvaz/labs/Invasion-Starling/server/ws/default/'
        };

		public static var data:DataObservable       = new DataObservable;

		// Event handler
		public static function bind(name:String, fn:Function):void{
			Global._event.bind(name, fn);
		};

		public static function trigger(name:String, params = null):void{
			Global._event.trigger(name, params);
		};
	}
}
