package game.pages {

    import feathers.core.FeathersControl;

    public class PageBase extends FeathersControl {

        public function PageBase() {
			this.width = Global.stage.stageWidth;
			this.height = Global.stage.stageHeight;
		}
		
		public function reset():void {}
		public function onShow():void {}
		public function onHide():void {}
    }
}