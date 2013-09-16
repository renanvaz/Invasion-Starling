package game.utils {
    import game.utils.EventSimple;

    public class DataObservable {
        private var _event:EventSimple       = new EventSimple;
        private var _data:Object             = {}

        public function get(name:String) {
            return this._data[name];
        };

        public function set(name:String, val:Object = null):void {
            this._data[name] = val;
            this.trigger(name, val);
        };

        // Event handler
        public function bind(name:String, fn:Function):void {
            this._event.bind(name, fn);
        };

        public function trigger(name:String, params = null):void {
            this._event.trigger(name, params);
        };
    }
}
