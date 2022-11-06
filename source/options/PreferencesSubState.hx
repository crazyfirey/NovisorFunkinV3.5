package options;

#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import flixel.FlxSubState;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxSave;
import haxe.Json;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.input.keyboard.FlxKey;
import flixel.graphics.FlxGraphic;
import Controls;

using StringTools;

class Preferences extends BaseOptionsMenu
{
    public function new()
    {
        title = 'Preferences Settings';
		rpcTitle = 'Preferences Settings Menu'; //for Discord Rich Presence

        
        var option:Option = new Option('Downscroll', //Name
            'If checked, notes go Down instead of Up, simple enough.', //Description
            'downScroll', //Save data variable name
            'bool', //Variable type
            false); //Default value
        addOption(option);

        var option:Option = new Option('Middlescroll',
            'If checked, your notes get centered.',
            'middleScroll',
            'bool',
            false);
        addOption(option);

        var option:Option = new Option('Opponent Notes',
            'If unchecked, opponent notes get hidden.',
            'opponentStrums',
            'bool',
            true);
        addOption(option);var option:Option = new Option('Hide HUD',
            'If checked, hides most HUD elements.',
            'hideHud',
            'bool',
            false);
        addOption(option);

        var option:Option = new Option('Hide Icons',
            "If checked, it's gonna hide the icons and the health bar.",
            'hideicon',
            'bool',
            false);
        addOption(option);

        var option:Option = new Option('Hide HUD',
            'If checked, hides most HUD elements.',
            'hideHud',
            'bool',
            false);
        addOption(option);

        var option:Option = new Option('Hide Icons',
            "If checked, it's gonna hide the icons and the health bar.",
            'hideicon',
            'bool',
            false);
        addOption(option);

        var option:Option = new Option('Choose Language:',
            "What is your personal language?",
            'languageChoose',
            'string',
            'English',
            ['English', 'Spanish', 'French', 'Portuguese', 'German', 'Russian']);
        addOption(option);

        var option:Option = new Option('Rating Offset',
            'Changes how late/early you have to hit for a "Sick!"\nHigher values mean you have to hit later.',
            'ratingOffset',
            'int',
            0);
        option.displayFormat = '%vms';
        option.scrollSpeed = 20;
        option.minValue = -30;
        option.maxValue = 30;
        addOption(option);

        var option:Option = new Option('Shaders', //Name
            'Add your Description here.', //Description
            'shaders', //Save data variable name
            'bool', //Variable type
            false); //Default value
        addOption(option);

        #if !html5 //Apparently other framerates isn't correctly supported on Browser? Probably it has some V-Sync shit enabled by default, idk
        var option:Option = new Option('Framerate',
            "Pretty self explanatory, isn't it?",
            'framerate',
            'int',
            60);
        addOption(option);

        option.minValue = 60;
        option.maxValue = 240;
        option.displayFormat = '%v FPS';
        option.onChange = onChangeFramerate;
        #end

        var option:Option = new Option('Flashing Lights',
			"Uncheck this if you're sensitive to flashing lights!",
			'flashing',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option('Camera Zooms',
			"If unchecked, the camera won't zoom in on a beat hit.",
			'camZooms',
			'bool',
			true);
		addOption(option);

        #if !mobile
		var option:Option = new Option('FPS Counter',
			'If unchecked, hides FPS Counter.',
			'showFPS',
			'bool',
			true);
		addOption(option);
		option.onChange = onChangeFPSCounter;
		#end
    }

    #if !mobile
	function onChangeFPSCounter()
	{
		if(Main.fpsVar != null)
			Main.fpsVar.visible = ClientPrefs.showFPS;
	}
	#end

    function onChangeAntiAliasing()
        {
            for (sprite in members)
            {
                var sprite:Dynamic = sprite; //Make it check for FlxSprite instead of FlxBasic
                var sprite:FlxSprite = sprite; //Don't judge me ok
                if(sprite != null && (sprite is FlxSprite) && !(sprite is FlxText)) {
                    sprite.antialiasing = ClientPrefs.globalAntialiasing;
                }
            }
        }
    
        function onChangeFramerate()
        {
            if(ClientPrefs.framerate > FlxG.drawFramerate)
            {
                FlxG.updateFramerate = ClientPrefs.framerate;
                FlxG.drawFramerate = ClientPrefs.framerate;
            }
            else
            {
                FlxG.drawFramerate = ClientPrefs.framerate;
                FlxG.updateFramerate = ClientPrefs.framerate;
            }
        }
}