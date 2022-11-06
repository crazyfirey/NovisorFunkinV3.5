package;

import flixel.ui.FlxButton;
import flixel.system.FlxSound;
import flixel.tweens.FlxEase;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import lime.app.Application;
import flixel.addons.transition.FlxTransitionableState;
#if sys
import sys.io.File;
import sys.FileSystem;
import flash.media.Sound;
#end
#if desktop
import Discord.DiscordClient;
#end

using StringTools;

class InfoMenu extends MusicBeatState
{
    var arrow:FlxButton;
    var arrow2:FlxButton;
    var unarrow:FlxSprite;
    var unarrow2:FlxSprite;
    
    var twitter:FlxButton;
    var gamebanana:FlxButton;
    var gamejolt:FlxButton;
    
    var exit:FlxButton;
    
    var changtext:FlxSprite;
    var pagtext:FlxSprite;
    var changelog:FlxSprite;
    
    var topbar:FlxSprite;
    
    var starFG:FlxSprite;
	var starBG:FlxSprite;

    override public function create():Void
    {
        FlxG.mouse.visible = true;
        
        var bg:FlxSprite = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.scrollFactor.set();
		add(bg);

        starFG = new FlxSprite(50, 77).loadGraphic(Paths.image('info_menu/starFG'));
		starFG.updateHitbox();
		starFG.antialiasing = true;
		starFG.scrollFactor.set();
		add(starFG);

		starBG = new FlxSprite(47, 77).loadGraphic(Paths.image('info_menu/starBG'));
		starBG.updateHitbox();
		starBG.antialiasing = true;
		starBG.scrollFactor.set();
		add(starBG);

        FlxTween.tween(starFG, {x: -1383}, 300);
        FlxTween.tween(starBG, {x: -1670}, 300);

        topbar = new FlxSprite(0, -1.9).loadGraphic(Paths.image('info_menu/topbar'));
		add(topbar);

        exit = new FlxButton(26.35, 13.55, null, function()
            {
                MusicBeatState.switchState(new MainMenuState());
                FlxG.sound.play(Paths.sound('cancelMenu'));
            });
        exit.loadGraphic(Paths.image('info_menu/exit'));
        add(exit);

        changtext = new FlxSprite(207.8, 0).loadGraphic(Paths.image('info_menu/changelogtext'));
		add(changtext);
        
        changelog = new FlxSprite(22.15, 130.95).loadGraphic(Paths.image('info_menu/changelog'));
		add(changelog);

        pagtext = new FlxSprite(1670.9, 0).loadGraphic(Paths.image('info_menu/pagestext'));
		add(pagtext);

        twitter = new FlxButton(1371.5, 153.3, null, function()
            {
                CoolUtil.browserLoad('https://twitter.com/NovisorDev');
            });
        twitter.loadGraphic(Paths.image('info_menu/twitter'));
        add(twitter);

        gamebanana = new FlxButton(1371.5, 327, null, function()
            {
                CoolUtil.browserLoad('https://gamebanana.com/mods/334516');
            });
        gamebanana.loadGraphic(Paths.image('info_menu/gamebanana'));
        add(gamebanana);

        gamejolt = new FlxButton(1371.5, 496.1, null, function()
            {
                CoolUtil.browserLoad('https://gamejolt.com/games/runawayfromnovisor/662077');
            });
        gamejolt.loadGraphic(Paths.image('info_menu/gamejolt'));
        add(gamejolt);

        arrow = new FlxButton(1165.7, 534.6, null, function()
            {
                arrow.alpha = 0;
                arrow2.alpha = 1;
                unarrow.alpha = 1;
                unarrow2.alpha = 0;
                FlxTween.tween(changtext, {x: 1407.95}, 1.5, {ease: FlxEase.expoInOut});
                FlxTween.tween(pagtext, {x: 445.35}, 1.5, {ease: FlxEase.expoInOut});
                FlxTween.tween(changelog, {x: -1231.2}, 1.5, {ease: FlxEase.expoInOut});
        
                FlxTween.tween(twitter, {x: 286.05}, 1.5, {ease: FlxEase.expoInOut});
                FlxTween.tween(gamebanana, {x: 286.05}, 1.5, {ease: FlxEase.expoInOut});
                FlxTween.tween(gamejolt, {x: 286.05}, 1.5, {ease: FlxEase.expoInOut});
            });
        arrow.loadGraphic(Paths.image('info_menu/arrow'));
        add(arrow);

        arrow2 = new FlxButton(1047.4, 534.6, null, function()
            {
                arrow.alpha = 1;
                arrow2.alpha = 0;
                unarrow.alpha = 0;
                unarrow2.alpha = 1;
                FlxTween.tween(changtext, {x: 207.8}, 1.5, {ease: FlxEase.expoInOut});
                FlxTween.tween(pagtext, {x: 1670.9}, 1.5, {ease: FlxEase.expoInOut});
                FlxTween.tween(changelog, {x: 22.15}, 1.5, {ease: FlxEase.expoInOut});
            
                FlxTween.tween(twitter, {x: 1371.5}, 1.5, {ease: FlxEase.expoInOut});
                FlxTween.tween(gamebanana, {x: 1371.5}, 1.5, {ease: FlxEase.expoInOut});
                FlxTween.tween(gamejolt, {x: 1371.5}, 1.5, {ease: FlxEase.expoInOut});
            });
        arrow2.loadGraphic(Paths.image('info_menu/arrow'));
        arrow2.flipX = true;
        arrow2.alpha = 0;
        add(arrow2);

        unarrow = new FlxSprite(1165.7, 534.6).loadGraphic(Paths.image('info_menu/unarrow'));
        unarrow.alpha = 0;
        add(unarrow);

        unarrow2 = new FlxSprite(1047.4, 534.6).loadGraphic(Paths.image('info_menu/unarrow'));
        unarrow2.flipX = true;
        add(unarrow2);

        #if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("Info Menu", null);
		#end

        Application.current.window.title = 'Novisor Funkin - Info Menu';

        super.create();
    }
}