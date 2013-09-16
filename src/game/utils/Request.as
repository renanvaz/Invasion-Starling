package game.utils {

	public class Request {
		import flash.net.URLLoader;
		import flash.net.URLRequestMethod;
		import flash.net.URLLoaderDataFormat;
		import flash.net.URLVariables;
		import flash.net.URLRequest;

		import flash.errors.IOError;
		import flash.events.SecurityErrorEvent;
		import flash.events.IOErrorEvent;
		import flash.events.Event;

		public function Request() {
			// constructor code
		}

		public static function call(_url, _data, _fn, _method:String = 'GET'):void {
			var requestVars:URLVariables = new URLVariables();

			for (var i:* in _data){
				requestVars[i] = _data[i];
			}

			var request:URLRequest = new URLRequest(_url);
			request.method = URLRequestMethod[_method];
			request.data = requestVars;

			var loader:URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			loader.addEventListener(Event.COMPLETE, function(e:Event):void {
				trace('Request Complete');
				_fn (e.target.data);
			});
			loader.addEventListener(IOErrorEvent.IO_ERROR, function(e:*):void {
				trace('Request IO_ERROR');
				_fn (false);
			});
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, function(e:*):void {
				trace('Request SECURITY_ERROR');
				_fn (false);
			});

			loader.load(request);
			trace('Send Request', request.url, request.data, request.method);
		}
		
	}
}
