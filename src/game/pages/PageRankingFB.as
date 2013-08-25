package game.pages {

	import starling.core.Starling;
	import starling.display.Image;

	public class PageRankingFB extends PageBase {

		[Embed(source='/../assets/textures/2x/ranking-fb.png')]
		public static const bmBg:Class;

		public var bg:Image;

		public function PageRankingFB() {
			super();

			this.bg = Image.fromBitmap(new bmBg, false, Starling.contentScaleFactor);

			addChild(this.bg);
		}
	}

}
