package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxMath;
import flixel.util.FlxTimer;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.util.FlxColor;

using StringTools;

class SongFontMiddle extends FlxText
{
	public var forceX:Float = Math.NEGATIVE_INFINITY;
	public var targetY:Float = 0;
	public var yMult:Float = 0;
	public var xAdd:Float = 25;
	public var yAdd:Float = 0;
    var groupX:Float = 90;
	var groupY:Float = 0.48;
	public var isMenuItem:Bool = false;

	override function update(elapsed:Float)
	{
		if (isMenuItem)
		{
			var scaledY = FlxMath.remapToRange(targetY, 0, 1, 0, 1.3);
	
			screenCenter(X);
	
			var lerpVal:Float = CoolUtil.boundTo(elapsed * 9.6, 0, 1);
			y = FlxMath.lerp(y, (scaledY * yMult) + (FlxG.height * 0.48) + yAdd, lerpVal);
		}
	
		super.update(elapsed);
	}
}