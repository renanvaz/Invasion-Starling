package game.utils.ui {
    import com.greensock.TweenNano;

    import starling.display.Sprite;
    import starling.text.TextField;
    import starling.utils.HAlign;
    import starling.utils.VAlign;

    public class Text extends Sprite {

		private var txtShadow:TextField;
        private var txt:TextField;
        public static var sizeBase:int = 13;

		public function Text(w:Number, h:Number, text:String, size:Number, color:uint = 0xFFFFFF, colorShadow:uint = 0x000000):void {
			super();

			this.txtShadow = new TextField(w, h, text, 'Mini Pixel-7', size, colorShadow);
            this.txtShadow.hAlign = HAlign.CENTER;
            this.txtShadow.vAlign = VAlign.CENTER;
            this.txtShadow.x = 1 / Global.starling.contentScaleFactor;
            this.txtShadow.y = 1 / Global.starling.contentScaleFactor;
            this.addChild(this.txtShadow);

            this.txt = new TextField(w, h, text, 'Mini Pixel-7', size, color);
            this.txt.hAlign = HAlign.CENTER;
            this.txt.vAlign = VAlign.CENTER;
            this.txt.x = 0;
            this.txt.y = 0;
            this.addChild(this.txt);
		}

        public function set text(t:String):void {
            this.txtShadow.text = t;
            this.txt.text = t;
        }

        public function get text():String {
            return this.txt.text;
        }
    }
}
