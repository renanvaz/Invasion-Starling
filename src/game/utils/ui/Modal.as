package game.utils.ui {
    import com.greensock.TweenNano;

    import starling.core.Starling;
    import starling.display.DisplayObject;
    import starling.display.DisplayObjectContainer;
    import starling.display.Quad;
    import starling.display.Sprite;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;

    import game.utils.Extend;

    public class Modal extends Sprite {

		public static var defaults:Object = {
			alpha:          .5,
			color:          0x000000,
			clickToClose:   true
		};

		private var root:DisplayObjectContainer;
		private var overlay:Quad;
		private var content:DisplayObject;

		public function Modal(root:DisplayObjectContainer = null):void {
			super();

			this.root = root ? root : Starling.current.stage;
			this.root.addChild(this);
			this.visible = false;
		}


        public function show(content:DisplayObject, config:Object = null):void {
			var self:Modal = this;
            config = Extend.get({}, Modal.defaults, config);

            while(this.numChildren > 0){ this.removeChildAt(0); }
			this.parent.setChildIndex(this, this.parent.numChildren - 1);

            this.overlay = new Quad(this.root.width, this.root.height, config.color);
			this.overlay.alpha = config.alpha;

			this.content = content;
			this.content.x = this.root.width / 2 - this.content.width / 2;
			this.content.y = this.root.height / 2 - this.content.height / 2;

			addChild(this.overlay);
			addChild(this.content);

            this.alpha = 0;
            this.visible = true;
            TweenNano.to(this, .6, {alpha: 1});

            if(config.clickToClose){
				this.overlay.addEventListener(TouchEvent.TOUCH, function(e):void{
					var touch = e.getTouch(e.currentTarget);

					if(touch){
						if(touch.phase == TouchPhase.BEGAN){
							self.hide();
						}
					}
				});
            }
        }

        public function hide():void {
			var self:Modal = this;
            TweenNano.to(this, .6, {alpha: 0, onComplete: function(){ self.visible = false; }});
        }
    }
}
