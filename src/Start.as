package 
{
    import flash.desktop.NativeApplication;
    import flash.display.Bitmap;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.filesystem.File;
    import flash.geom.Rectangle;
    import flash.system.Capabilities;
    
    import starling.core.Starling;
    import starling.events.Event;
    import starling.utils.HAlign;
    import starling.utils.RectangleUtil;
    import starling.utils.ScaleMode;
    import starling.utils.VAlign;
	
	import air.net.URLMonitor;
	import flash.net.URLRequest;
	import flash.events.StatusEvent;
    
    [SWF(width="320", height="480", frameRate="30", backgroundColor="#000000")]
    public class Start extends Sprite
    {
        [Embed(source="assets/textures/1x/startup.png")]
        private static var Background:Class;
        
        [Embed(source="assets/textures/2x/startup.png")]
        private static var BackgroundHD:Class;
        
        private var mStarling:Starling;
        
        public function Start()
        {
			
			var monitor:URLMonitor = new URLMonitor(new URLRequest('http://www.google.com'));
			monitor.addEventListener(StatusEvent.STATUS, function (e:StatusEvent):void {
				Global.internetStatus = monitor.available;
				if (monitor.available) {
					trace("Internet is available");
				} else {
					trace("No internet connection available");
				}
			});
			monitor.start();
			
            var stageWidth:int  = 320;
            var stageHeight:int = 480;
            var iOS:Boolean = Capabilities.manufacturer.indexOf("iOS") != -1;
            
            Starling.multitouchEnabled = true;  // useful on mobile devices
            Starling.handleLostContext = !iOS;  // not necessary on iOS. Saves a lot of memory!
            
            var viewPort:Rectangle = RectangleUtil.fit(
                new Rectangle(0, 0, stageWidth, stageHeight), 
                new Rectangle(0, 0, stage.fullScreenWidth, stage.fullScreenHeight), 
                ScaleMode.SHOW_ALL, iOS);
            
            var scaleFactor:int = viewPort.width < 480 ? 1 : 2;
            
            var background:Bitmap = scaleFactor == 1 ? new Background() : new BackgroundHD();
            Background = BackgroundHD = null;
            
            background.x = viewPort.x;
            background.y = viewPort.y;
            background.width  = viewPort.width;
            background.height = viewPort.height;
            background.smoothing = true;
            addChild(background);
            
			Starling.multitouchEnabled = false;
            mStarling = new Starling(Main, stage, viewPort);
            mStarling.stage.stageWidth  = stageWidth;
            mStarling.stage.stageHeight = stageHeight;
            mStarling.simulateMultitouch  = false;
            mStarling.enableErrorChecking = true;
			mStarling.antiAliasing = 0;

            mStarling.addEventListener(starling.events.Event.ROOT_CREATED, function():void
            {
                removeChild(background);
                
                var main:Main = mStarling.root as Main;
                main.start();
				
				mStarling.showStatsAt(HAlign.RIGHT, VAlign.BOTTOM);
                mStarling.start();
            });
            
            NativeApplication.nativeApplication.addEventListener(
                flash.events.Event.ACTIVATE, function (e:*):void { mStarling.start(); });
            
            NativeApplication.nativeApplication.addEventListener(
                flash.events.Event.DEACTIVATE, function (e:*):void { mStarling.stop(); });
        }
        
    }
}