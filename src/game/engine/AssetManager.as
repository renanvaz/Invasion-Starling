package game.engine {
	import flash.media.Sound;

	import game.sounds.SoundManager;

	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureSmoothing;

	public class AssetManager 	{
		// Items
		[Embed(source="/../assets/textures/2x/sprites/itemHeart.png")]
		public static const ItemHeartTexture:Class;

		// Heart
		[Embed(source="/../assets/textures/2x/sprites/heart.xml", mimeType="application/octet-stream")]
		public static const HeartAtlasXml:Class;

		[Embed(source="/../assets/textures/2x/sprites/heart.png")]
		public static const HeartTexture:Class;

		// Starts
		[Embed(source="/../assets/textures/2x/sprites/stars.xml", mimeType="application/octet-stream")]
		public static const StarsAtlasXml:Class;

		[Embed(source="/../assets/textures/2x/sprites/stars.png")]
		public static const StarsTexture:Class;

		// Bubble
		[Embed(source="/../assets/textures/2x/sprites/bubble.xml", mimeType="application/octet-stream")]
		public static const BubbleAtlasXml:Class;

		[Embed(source="/../assets/textures/2x/sprites/bubble.png")]
		public static const BubbleTexture:Class;

		// ETE
		[Embed(source="/../assets/textures/2x/sprites/ete.xml", mimeType="application/octet-stream")]
		public static const EteAtlasXml:Class;

		[Embed(source="/../assets/textures/2x/sprites/ete.png")]
		public static const EteBodyTexture:Class;

		[Embed(source="/../assets/textures/2x/sprites/ete-wing1.png")]
		public static const EteWing1Texture:Class;

		[Embed(source="/../assets/textures/2x/sprites/ete-wing2.png")]
		public static const EteWing2Texture:Class;

		[Embed(source="/../assets/textures/2x/sprites/ete-elements.png")]
		public static const EteElementsTexture:Class;

		// Cloud
		[Embed(source='/../assets/textures/2x/cloud.png')]
		public static const CloudTexture:Class;

		// Pages
		[Embed(source='/../assets/textures/2x/pages/page-game/danger.png')]
		public static const PageGameDangerTexture:Class;

		[Embed(source='/../assets/textures/2x/pages/page-game/bg.png')]
		public static const PageGameBgTexture:Class;

		// Fonts
		[Embed(source="/../assets/fonts/MP7.fnt", mimeType="application/octet-stream")]
		private static const MP7Font:Class;

		[Embed(source = "/../assets/fonts/MP7_0.png")]
		public static const MP7Texture:Class;

		// Sounds
		[Embed(source='/../assets/audio/bubble.mp3')]
		private static const BubbleSound:Class;

		[Embed(source='/../assets/audio/bg.mp3')]
		private static const BgSound:Class;

		[Embed(source='/../assets/audio/explode.mp3')]
		private static const ExplodeSound:Class;

		[Embed(source='/../assets/audio/damage.mp3')]
		private static const DamageSound:Class;

		[Embed(source='/../assets/audio/item.mp3')]
		private static const ItemSound:Class;

		public static const get:Object = {
			heart: {
				texture: new HeartTexture,
				atlas: new HeartAtlasXml
			},
			stars: {
				texture: new StarsTexture,
				atlas: new StarsAtlasXml
			},
			bubble: {
				texture: new BubbleTexture,
				atlas: new BubbleAtlasXml
			},
			ete: {
				texture: {
					body: new EteBodyTexture,
					wing1: new EteWing1Texture,
					wing2: new EteWing2Texture,
					elements: new EteElementsTexture
				},
				atlas: new EteAtlasXml
			},
			cloud: {
				texture: new CloudTexture
			},
			pages: {
				game: {
					danger: {texture: new PageGameDangerTexture},
					bg: {texture: new PageGameBgTexture}
				}
			},
			items: {
				heart: {texture: new ItemHeartTexture}
			}
		}


		public static function setup():void
		{
			var texture:Texture = Texture.fromBitmap(new MP7Texture());
			var xml:XML = XML(new MP7Font());
			var font:BitmapFont = new BitmapFont(texture, xml);
			font.smoothing = TextureSmoothing.NONE;
			TextField.registerBitmapFont(font);

			SoundManager.add('bubble-explode', new BubbleSound as Sound);
			SoundManager.add('bg', new BgSound as Sound);
			SoundManager.add('ete-explode', new ExplodeSound as Sound);
			SoundManager.add('damage', new DamageSound as Sound);
			SoundManager.add('item', new ItemSound as Sound);
		}
	}
}
