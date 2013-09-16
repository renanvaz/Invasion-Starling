package {
    
    import flash.events.LocationChangeEvent;
    import flash.geom.Rectangle;
    import flash.media.StageWebView;
    import flash.net.URLVariables;
    
    import feathers.controls.Button;
    import feathers.controls.Header;
    
    import game.utils.DataObservable;
    import game.utils.EventSimple;
    import game.utils.Extend;
    import game.utils.Request;
    import game.utils.ui.Alert;
    
    import starling.events.Event;


    public class FB {
        private static var _event:EventSimple       = new EventSimple;

        public static var config:Object             = {
            APP_ID: '477432402315105',
			ACCESS_TOKEN: null
        };

        public static function login():void {	
			var a:Alert = new Alert(Global.starling.stage);
			
            var webView:StageWebView = new StageWebView();
            webView.viewPort = new Rectangle(0, 0, Global.viewPort.width, Global.viewPort.height);
            webView.stage =  Global.stage.instance;
			webView.addEventListener(LocationChangeEvent.LOCATION_CHANGE, function(){ 
				if(webView.location.indexOf(Global.config.WS + 'fb') === 0){
					var params:Array = webView.location.split('#');
					var urlVariables:URLVariables = new URLVariables(params[1]);
					
					webView.stage = null;
					webView.dispose();
					
					if(urlVariables.access_token){
						trace(urlVariables.access_token);
						FB.config.ACCESS_TOKEN = urlVariables.access_token;
						a.show('Success');
						FB.api('me', {}, function(res){ trace(res.name); });
					}else{
						a.show('Noooo');
					}
				}
			});
            webView.loadURL('https://www.facebook.com/dialog/oauth?response_type=token&client_id='+FB.config.APP_ID+'&redirect_uri='+encodeURIComponent(Global.config.WS + 'fb'));
        }
		
		public static function api(method:String, params:Object, callback:Function):void {
			params = Extend.get({access_token: FB.config.ACCESS_TOKEN}, params);
			Request.call('https://graph.facebook.com/' + method, params, function(res:String){ trace(res); callback(JSON.parse(res)); });
		}

        public static var data:DataObservable       = new DataObservable;

        // Event handler
        public static function bind(name:String, fn:Function):void{
            FB._event.bind(name, fn);
        };

        public static function trigger(name:String, params = null):void{
            FB._event.trigger(name, params);
        };
    }
}
