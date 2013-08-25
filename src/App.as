package {
	import air.net.URLMonitor;

    import feathers.themes.MetalWorksMobileTheme;

    import flash.events.StatusEvent;
    import flash.media.Sound;
    import flash.net.URLRequest;

    import game.engine.AssetManager;
    import game.engine.Engine;
    import game.engine.PageManager;
    import game.pages.*;
    import game.utils.EventSimple;

	import starling.display.Sprite;
	import starling.events.Event;

	public class App extends Sprite {

        private static var _event:EventSimple      = new EventSimple;
        public static var events:Object            = {
            ONLINE:     1,
            OFFLINE:    2
        };

		public function App() {
			this.addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}

		private function onAdded():void {
            new MetalWorksMobileTheme(); // Setup feathers theme
            AssetManager.setup();

			setupPages();
            setupInternetVerification();
            setupEngine();
		}

        private function setupPages():void {
            PageManager.main = this;
            PageManager.add('start', new PageStart);
            PageManager.add('todo', new PageToDo);
            PageManager.add('ranking', new PageRanking);
            PageManager.add('rankingFB', new PageRankingFB);
            PageManager.add('home', new PageHome);
            PageManager.add('game', new PageGame);

            PageManager.goTo('start');
        }

        private function setupInternetVerification():void {
            var monitor:URLMonitor = new URLMonitor(new URLRequest(Global.config.WS));
            monitor.addEventListener(StatusEvent.STATUS, function (e:StatusEvent):void {
                Global.internet.active = monitor.available;
                if (monitor.available) {
                    App.trigger(App.events.ONLINE);
                } else {
                    App.trigger(App.events.OFFILINE);
                }
            });
            monitor.start();

            App.bind(App.events.ONLINE, function():void {
                Ad.getData();
            });
        }

        private function setupEngine():void {
            Engine.main = PageManager.get('game');
            this.addEventListener(Event.ENTER_FRAME, onStep);
        }

        // Event handler
        private function onStep(e:Event):void {
            Engine.process();
        }

        // Statics functions
        public static function bind(name:String, fn:Function):void{
            App._event.bind(name, fn);
        };

        public static function trigger(name:String, params = null):void{
            App._event.trigger(name, params);
        };
	}
}
