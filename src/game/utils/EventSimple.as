package game.utils {

	public class EventSimple {
		public var events:Object;

		public function EventSimple(){
			this.events = {};
		}

		public function bind (name, fn):void{
			if(!this.events[name]){
				this.events[name] = [fn];
			}else{
				this.events[name].push(fn);
			}
		};

		public function trigger(name:String, params = null):void{
			if(this.events[name])
			for(var i:int = 0; i < this.events[name].length; i++){
				if(params != null){
					this.events[name][i](params);
				}else{
					this.events[name][i]();
				}
			}
		};

	}

}
