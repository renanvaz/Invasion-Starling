package game.engine {
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	
	/*
	SoundManager.add('test', new testSound as Sound);
	SoundManager.add('test2', new test2Sound as Sound);
	SoundManager.loop('test', 3);
	SoundManager.volume('test', .3);
	SoundManager.play('test2');
	*/
	public class SoundManager {
		private static var cache:Object = {};

		public function SoundManager(){}

		public static function add(name:String, sound:Sound):void {
			var channel:SoundChannel = new SoundChannel;
			var transform:SoundTransform = new SoundTransform();

			SoundManager.cache[name] = {
				sound: sound,
				channel: channel,
				transform: transform
			}
		}

		public static function remove(name:String):void {
			SoundManager.stop(name);
			delete SoundManager.cache[name];
		}

		public static function play(name:String):void {
			SoundManager.cache[name].channel = SoundManager.cache[name].sound.play();
			SoundManager.volume(name, SoundManager.cache[name].transform.volume);
		}

		public static function stop(name:String):void {
			SoundManager.cache[name].channel.stop();
		}

		public static function loop(name:String, repeat:int = 0 /* 0 =  infinity */):void {
			var count:int = 0;
			SoundManager.stop(name);
			SoundManager.play(name);

			function onSoundChannelSoundComplete(e:Event):void {
				if(repeat != 0 && ++count == repeat){
					// Trigger complete
				}else{
					SoundManager.cache[name].channel.removeEventListener(Event.SOUND_COMPLETE, onSoundChannelSoundComplete);
					SoundManager.play(name);
					SoundManager.cache[name].channel.addEventListener(Event.SOUND_COMPLETE, onSoundChannelSoundComplete);

					// Trigger loop
				}
			}

			SoundManager.cache[name].channel.addEventListener(Event.SOUND_COMPLETE, onSoundChannelSoundComplete);
		}

		public static function volume(name:String, volume:Number):void {
			SoundManager.cache[name].transform.volume = volume;
			SoundManager.cache[name].channel.soundTransform = SoundManager.cache[name].transform;
		}

		public static function get(name:String):Object {
			return SoundManager.cache[name];
		}
	}
}