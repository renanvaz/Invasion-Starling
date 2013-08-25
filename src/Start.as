package {
    import flash.desktop.NativeApplication;
    import flash.display.Bitmap;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.geom.Rectangle;

    import starling.core.Starling;
    import starling.events.Event;
    import starling.utils.HAlign;
    import starling.utils.RectangleUtil;
    import starling.utils.ScaleMode;
    import starling.utils.VAlign;

    [SWF(width="320", height="480", frameRate="30", backgroundColor="#000000")]
    public class Start extends Sprite {

        // Bitmaps for splash screen
        [Embed(source="/../assets/textures/1x/startup.png")]
        private static var Background:Class;

        [Embed(source="/../assets/textures/2x/startup.png")]
        private static var BackgroundHD:Class;

        private var splash:Bitmap;

        public function Start() {
            super();

            var viewPort:Rectangle = RectangleUtil.fit(
                new Rectangle(0, 0, this.stage.stageWidth, this.stage.stageHeight),
                new Rectangle(0, 0, this.stage.fullScreenWidth, this.stage.fullScreenHeight),
                ScaleMode.SHOW_ALL, Global.device.iOS
			);

			Global.stage    = {
				stageWidth: this.stage.stageWidth,
				stageHeight: this.stage.stageHeight,
				frameRate: this.stage.frameRate
			};

            Global.viewPort = viewPort;

            showSplashScreen();
            setupStarling();
        }

        public function showSplashScreen():void {
            var scaleFactor:int = Global.viewPort.width < 480 ? 1 : 2;
            splash              = scaleFactor == 1 ? new Background() : new BackgroundHD();
            Background          = BackgroundHD = null;

            addChild(splash);
        }

        public function setupStarling():void {
            Starling.handleLostContext          = !Global.device.iOS;  // not necessary on iOS. Saves a lot of memory!
            Starling.multitouchEnabled          = false;

            Global.starling                     = new Starling(App, stage, Global.viewPort);
			Global.starling.stage.stageWidth  	= this.stage.stageWidth;
			Global.starling.stage.stageHeight 	= this.stage.stageHeight;
            Global.starling.simulateMultitouch  = false;
            Global.starling.enableErrorChecking = false;
            Global.starling.antiAliasing        = 0;
            Global.starling.showStatsAt(HAlign.RIGHT, VAlign.BOTTOM);
			
            Global.starling.addEventListener(starling.events.Event.ROOT_CREATED, function():void
            {
                removeChild(splash);
                splash = null;

                Global.starling.start();

                NativeApplication.nativeApplication.addEventListener(flash.events.Event.ACTIVATE, function (e:*):void { Global.starling.start(); });
                NativeApplication.nativeApplication.addEventListener(flash.events.Event.DEACTIVATE, function (e:*):void { Global.starling.stop(); });
            });
        }

    }
}
