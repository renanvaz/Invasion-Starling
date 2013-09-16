package game.utils.ui {
	import flash.geom.Rectangle;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;

	import feathers.controls.Button;
	import feathers.display.Scale9Image;
	import feathers.textures.Scale9Textures;

	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

    import game.utils.Extend;

    public class Alert {
        [Embed(source="/../assets/skin/images/metalworks/background-popup-skin.png")]
        protected static const alertBmp:Class;

        private var to:uint;
		private var btClose:Button;
		private var btOk:Button;
		private var txt:TextField;
		private var box:Scale9Image;
        private var modal:Modal;
		private var container:Sprite;

        public static var defaults:Object = {
            time: 0,
            btOkLabel: 'OK'
        };

		public function Alert(root:DisplayObjectContainer = null):void {
			var self:Alert = this;
			var texture:Texture = Texture.fromBitmap(new alertBmp, false, false, Global.starling.contentScaleFactor);
			var textures:Scale9Textures = new Scale9Textures(texture, new Rectangle(5/2, 5/2, 22/2, 22/2));

			this.modal = new Modal(root);

			this.container = new Sprite;

			this.box = new Scale9Image(textures);

			this.btClose = new Button;
			this.btClose.label = 'X';

			this.btOk = new Button;

			this.txt = new TextField(1, 1, '', 'Mini Pixel-7', 13, 0xFFFFFF);
			this.txt.hAlign = HAlign.CENTER;
			this.txt.vAlign = VAlign.CENTER;

			this.container.addChild(this.box);
			this.container.addChild(this.txt);
			this.container.addChild(this.btClose);
			this.container.addChild(this.btOk);

			this.btClose.addEventListener(Event.TRIGGERED, function(){
				self.hide();
			});


			this.btOk.addEventListener(Event.TRIGGERED, function(){
				self.hide();
			});

			root.addChild(this.container);
		}

        public function show(msg:String, config:Object = null):void {
            var self:Alert = this;
            config = Extend.get({}, Alert.defaults, config);
			var padding:int = 10;

			if(config.time != 0){
	            this.to = setTimeout(function():void { self.hide(); }, config.time);
			}

			this.box.width = 230;
			this.box.height = 230;

			this.txt.width = this.box.width;
			this.txt.height = this.box.height;
			this.txt.text = msg;

			this.btClose.x = this.container.width - this.btClose.width - padding;
			this.btClose.y = padding;

            this.btOk.label = config.btOkLabel;
			this.btOk.width = this.box.width - (2 * padding);
			this.btOk.x = (this.container.width - this.btOk.width) / 2;
			this.btOk.y = this.box.height - this.btOk.height - padding;

			this.modal.show(this.container);
        }

        public function hide():void {
            clearTimeout(this.to);

            this.modal.hide();
        }
    }
}
