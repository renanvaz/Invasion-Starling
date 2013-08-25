package {
	import flash.geom.Rectangle;
    import starling.core.Starling;
	import flash.system.Capabilities;

	public class Global {
        public static var stage:Object;
        public static var viewPort:Rectangle;
		public static var starling:Starling;

        public static var device:Object           = {
            iOS: Capabilities.manufacturer.indexOf("iOS") != -1
        };

		public static var internet:Object           = {
            active: false
        };

		public static var config:Object             = {
            WS: 'http://198.211.108.145/invasion/ws/'
        };

	}
}
