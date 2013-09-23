package game.utils {
    import game.utils.EventSimple;
	
	import flash.data.EncryptedLocalStore;
	import flash.utils.ByteArray;

    public class DataObservable {
        private var _event:EventSimple       = new EventSimple;
		private var _data:Object             = {}
		private var _persistName:String      = null;
		
		public function DataObservable(p:String = null):void {
			this._persistName = p; 
			if(this._persistName){
				var storedValue:ByteArray = EncryptedLocalStore.getItem(this._persistName);
				if(storedValue){
					this._data = JSON.parse(storedValue.readUTFBytes(storedValue.length));
				}
			}
		}; 

        public function get(name:String):* {
            return this._data[name];
        };

        public function set(name:String, val:Object = null):void {
            this._data[name] = val;
			if(this._persistName){
				var str:String = JSON.stringify(this._data);
				var bytes:ByteArray = new ByteArray();
				bytes.writeUTFBytes(str);
				EncryptedLocalStore.setItem(this._persistName, bytes);
			}
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
