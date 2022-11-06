package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxMath;
import flixel.util.FlxTimer;
import flixel.system.FlxSound;
import flash.media.Sound;

using StringTools;

class NovisorFunction extends MusicBeatState
{
	public var LanSelect:Bool = false;
    public var ModFinished:Bool = false;
}

public static function SongSelecting() {
		Dialouge = PlayState.LanSelect.Dialouge();
}