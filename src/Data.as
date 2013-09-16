package {
    import game.utils.EventSimple;

    public class Data {
        private static var _event:EventSimple       = new EventSimple;
        private static var _data:Object             = {}


        public static function get(name:String){
            return Data._data[name];
        };

        public static function set(name:String, val:Object = null){
            Data._data[name] = val;
            Data.trigger(name, val);
        };

        // Event handler
        public static function bind(name:String, fn:Function):void{
            Data._event.bind(name, fn);
        };

        public static function trigger(name:String, params = null):void{
            Data._event.trigger(name, params);
        };
    }
}
