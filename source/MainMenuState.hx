package;

import flixel.util.FlxTimer;
import flixel.addons.display.FlxBackdrop;
#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import Achievements;
import lime.app.Application;
import editors.MasterEditorMenu;

using StringTools;

class MainMenuState extends MusicBeatState
{
	public static var psychEngineVersion:String = '0.6.2'; //This is also used for Discord RPC
	public static var curSelected:Int = 0;

	var menuItems:FlxTypedGroup<FlxSprite>;
	private var camGame:FlxCamera;
	
	var optionShit:Array<String> = [
	'Story', 
	'Freeplay', 
	'Options', 
	'Credits', 
	'Twitter',
	'Info'
    ];

	var magenta:FlxSprite;
	public static var finishedFunnyMove:Bool = false;
	public static var FreeplayUnlocked:Bool = false;

	var starFG:FlxBackdrop;
	var starBG:FlxBackdrop;
	var vignette:FlxSprite;
	var logo2:FlxSprite;
	var logo:FlxSprite;

	override function create()
	{
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("Main Menu", null);
		#end

		camGame = new FlxCamera();
		FlxG.cameras.reset(camGame);
		FlxCamera.defaultCameras = [camGame];

		persistentUpdate = persistentDraw = true;

		FlxG.mouse.visible = true;

		var bg:FlxSprite = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.scrollFactor.set();
		add(bg);

		starFG = new FlxBackdrop(Paths.image('menu_assets/starFG'), 1, 1, true, true);
		starFG.updateHitbox();
		starFG.antialiasing = true;
		starFG.scrollFactor.set();
		add(starFG);

		starBG = new FlxBackdrop(Paths.image('menu_assets/starBG'), 1, 1, true, true);
		starBG.updateHitbox();
		starBG.antialiasing = true;
		starBG.scrollFactor.set();
		add(starBG);

		var visorx:FlxSprite = new FlxSprite(1066.9, 527.05).loadGraphic(Paths.image('menu_assets/visorx'));
		visorx.updateHitbox();
		visorx.antialiasing = true;
		add(visorx);

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		logo = new FlxSprite(680, 100);
		logo.frames = Paths.getSparrowAtlas('logoBumpin');
		logo.animation.addByPrefix('idle', 'logo bumpin', 24, true);
		logo.setGraphicSize(Std.int(logo.width * 0.70));
		logo.updateHitbox();
		add(logo);

		for (i in 0...optionShit.length)
		{
			var offset:Float = 108 - (Math.max(optionShit.length, 4) - 4) * 80;
			var menuItem:FlxSprite = new FlxSprite(0, (i * 140)  + offset);
	        menuItem.frames = Paths.getSparrowAtlas('menu_assets/menu_assets');
			menuItem.animation.addByPrefix('idle', optionShit[i] + 'Idle', 24, true);
			menuItem.animation.addByPrefix('hover', optionShit[i] + 'Hover', 24, true);
			menuItem.animation.play('idle');
			menuItem.ID = i;
			menuItem.antialiasing = true;
			menuItem.updateHitbox();
			menuItem.scrollFactor.set();
			switch(i) {
				case 0:
					menuItem.setPosition(29.9, 41.75);
				case 1:
					menuItem.setPosition(29.9, 222.7);
				case 2:
					menuItem.setPosition(29.9, 402);
				case 3:
					menuItem.setPosition(369.3, 127.55);
				case 4:
			        menuItem.setPosition(369.3, 336.75);
				case 5:
			        menuItem.setPosition(1202.3, 9.2);
			}
			menuItems.add(menuItem);
		}

		Application.current.window.title = 'Novisor Funkin - Main Menu';

	    var versionShit:FlxText = new FlxText(12, FlxG.height - 44, 0, "Novisor Funkin' v3.5", 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);
		var versionShit:FlxText = new FlxText(12, FlxG.height - 24, 0, "Psych Engine 0.6.2", 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);

		// NG.core.calls.event.logEvent('swag').send();

		changeItem();

		super.create();
	}

	var selectedSomethin:Bool = false;

	var canClick:Bool = true;
	var usingMouse:Bool = false;

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		if (!selectedSomethin)
		{

			if (controls.BACK)
				{
					selectedSomethin = true;
					FlxG.sound.play(Paths.sound('cancelMenu'));
					MusicBeatState.switchState(new TitleState());
				}
			
			menuItems.forEach(function(spr:FlxSprite)
				{
					
					if(usingMouse)
					{
						if(!FlxG.mouse.overlaps(spr))
							spr.animation.play('idle');
					}
			
					if (FlxG.mouse.overlaps(spr))
					{

						if(canClick)
						{
							curSelected = spr.ID;
							usingMouse = true;
							spr.animation.play('hover');
						}
							
						if(FlxG.mouse.pressed && canClick)
						{
							selectSomething();
						}
					}
		
					starFG.x -= 0.03;
					starBG.x -= 0.01;
			
					spr.updateHitbox();
				});
		}

		super.update(elapsed);

		/*menuItems.forEach(function(spr:FlxSprite)
		{
		//	spr.screenCenter(X);
		});*/
	}

	function selectSomething()
		{
				if (optionShit[curSelected] == 'Twitter')
				{
					CoolUtil.browserLoad('https://twitter.com/NovisorDev');
				}
				else
				selectedSomethin = true;
				FlxG.sound.play(Paths.sound('confirmMenu'));
				
				canClick = false;

				menuItems.forEach(function(spr:FlxSprite)
				{
					if (curSelected != spr.ID)
					{
						FlxTween.tween(spr, {alpha: 0}, 0.4, {
							ease: FlxEase.quadOut,
							onComplete: function(twn:FlxTween)
							{
								spr.kill();
							}
							});
					} else {
						
						FlxFlicker.flicker(spr, 1, 0.06, false, false, function(flick:FlxFlicker)
						{
						    new FlxTimer().start(1, function(tmr:FlxTimer)
							{
								goToState();
							});
						});
					}
				});
				}

	function goToState()
	{
		var daChoice:String = optionShit[curSelected];

		switch (daChoice)
		{
			case 'Story':
				MusicBeatState.switchState(new StoryMenuState());
			case 'Freeplay':
			    MusicBeatState.switchState(new SongSelectionState());
			case 'Options':
				MusicBeatState.switchState(new options.OptionsState());
			case 'Credits':
				MusicBeatState.switchState(new CreditsState());
			case 'Info':
				MusicBeatState.switchState(new InfoMenu());
		}
	}

	function changeItem(huh:Int = 0)
	{
		if (finishedFunnyMove)
		{
			curSelected += huh;
	
			if (curSelected >= menuItems.length)
				curSelected = 0;
			if (curSelected < 0)
				curSelected = menuItems.length - 1;
		}
		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.animation.play('idle');
	
			if (spr.ID == curSelected && finishedFunnyMove)
			{
				spr.animation.play('hover');				
			}
			spr.updateHitbox();
		});
	}

	override function beatHit()
	{
		logo.animation.play('idle', true);
	}
}