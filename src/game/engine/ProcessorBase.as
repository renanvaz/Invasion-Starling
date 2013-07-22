package game.engine {

	import starling.display.Sprite;

	public interface ProcessorBase {

		function process():void;
		function reset():void;
		function add(sprite:Sprite):void;
		function remove(sprite:Sprite):void;
		//function bind(name:String, fn:Function):void {};
		//function trigger(name:String, params = null):void {};

	}

}
