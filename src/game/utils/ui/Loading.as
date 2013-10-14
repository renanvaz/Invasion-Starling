package game.utils.ui {
	import flash.geom.Rectangle;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;

	import feathers.controls.Button;
	import feathers.display.Scale9Image;
	import feathers.textures.Scale9Textures;

	import game.utils.Extend;

	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

    public class Loading {
        [Embed(source="/../assets/skin/images/metalworks/background-popup-skin.png")]
        protected static const alertBmp:Class;

        [Embed(source="/../assets/textures/2x/sprites/loader.png")]
        protected static const loaderBmp:Class;

        [Embed(source="/../assets/textures/2x/sprites/loader.xml", mimeType="application/octet-stream")]
        protected static const loaderAtlas:Class;

		private var box:Scale9Image;
		private var loading:MovieClip;
        private var modal:Modal;
        private var container:Sprite;
		private static var atlas:TextureAtlas;

        public static var defaults:Object = {};

		public function Loading(root:DisplayObjectContainer = null):void {
			var self:Loading = this;
			var texture:Texture = Texture.fromBitmap(new alertBmp, false, false, Global.starling.contentScaleFactor);
			var textures:Scale9Textures = new Scale9Textures(texture, new Rectangle(5/2, 5/2, 22/2, 22/2));

			this.modal = new Modal(root);

			this.container = new Sprite;

			this.box = new Scale9Image(textures);

            texture = Texture.fromBitmap(new loaderBmp, false, false, Global.starling.contentScaleFactor);
            var xml:XML = XML(new loaderAtlas);
            Loading.atlas = new TextureAtlas(texture, xml);

            this.loading = new MovieClip(Loading.atlas.getTextures('loading'), 24);

            this.container.addChild(this.box);
            this.container.addChild(this.loading);
		}

        public function show(config:Object = null):void {
            var self:Loading = this;
            config = Extend.get({}, Loading.defaults, config);

			this.box.width = 84;
			this.box.height = 84;
			
			this.loading.x = (this.box.width - this.loading.width) / 2;
			this.loading.y = (this.box.height - this.loading.height) / 2;
			
			Global.starling.juggler.add(this.loading);
			
			this.modal.show(this.container, {clickToClose: false});
        }

        public function hide():void {
			Global.starling.juggler.remove(this.loading);
			
            this.modal.hide();
        }
    }
}
