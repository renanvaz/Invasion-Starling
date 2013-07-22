package game.pages {

	import starling.core.Starling;
	import starling.display.Image;

	public class PageRanking extends PageBase {

		[Embed(source='/assets/textures/2x/ranking.png')]
		public static const bmBg:Class;

		public var bg:Image;

		public function PageRanking() {
			super();

			this.bg = Image.fromBitmap(new bmBg, false, Starling.contentScaleFactor);

			addChild(this.bg);
		}
	}

}