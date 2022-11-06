package;

import Controls.Control;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.addons.transition.FlxTransitionableState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.util.FlxTimer;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.FlxCamera;
import flixel.util.FlxStringUtil;
import flixel.effects.FlxFlicker;

class NovisorPauseSubState extends MusicBeatSubstate
{
    var pauseStuffs:FlxTypedGroup<FlxSprite>;
    var pauseOptions:Array<String> = [
	'resume',
    'restart',
    'exit',
    'x'
    ];

    public static var curSelected:Int = 0;

    var pauseMusic:FlxSound;

    var bg2:FlxSprite;

    var levelInfo:FlxText;

    var menuItems:Array<String> = [];

    public static var finishedFunnyMove:Bool = false;

    public function new(x:Float, y:Float)
    {
        super();

        FlxG.mouse.visible = true;

        menuItems = pauseOptions;

        FlxG.sound.play(Paths.sound('scrollMenu'));

        pauseMusic = new FlxSound().loadEmbedded(Paths.music('breakfast'), true, true);
		pauseMusic.volume = 0;
		pauseMusic.play(false, FlxG.random.int(0, Std.int(pauseMusic.length / 2)));

        trace("HOLY FUCK, the pause is here!");

        FlxG.sound.list.add(pauseMusic);

        var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.alpha = 0.5;
        bg.setGraphicSize(2000, 2000);
		bg.scrollFactor.set();
		add(bg);

        bg2 = new FlxSprite(317, 18.75).loadGraphic(Paths.image('pause_stuff/background'));
        bg.scrollFactor.set();
        add(bg2);

        pauseStuffs = new FlxTypedGroup<FlxSprite>();
		add(pauseStuffs);

        for (i in 0...pauseOptions.length)
		{
			var offset:Float = 108 - (Math.max(pauseOptions.length, 4) - 4) * 80;
            var pauseStuff:FlxSprite = new FlxSprite(0, (i * 140)  + offset);
	        pauseStuff.frames = Paths.getSparrowAtlas('pause_stuff/buttons');
			pauseStuff.animation.addByPrefix('idle', pauseOptions[i] + '_idle', 24, true);
			pauseStuff.animation.addByPrefix('hover', pauseOptions[i] + '_selected', 24, true);
			pauseStuff.animation.play('idle');
			pauseStuff.ID = i;
			pauseStuff.antialiasing = true;
			pauseStuff.updateHitbox();
			pauseStuff.screenCenter(X);
			pauseStuff.scrollFactor.set();
			switch(i) {
				case 0:
					pauseStuff.setPosition(472.85, 238.75);
				case 1:
					pauseStuff.setPosition(472.85, 346.75);
				case 2:
					pauseStuff.setPosition(472.85, 458.55);
				case 3:
			        pauseStuff.setPosition(234.7, 31.25);
			}
			pauseStuffs.add(pauseStuff);
		}

        levelInfo = new FlxText(20, 15, 0, "", 32);
		levelInfo.text += "Song: " + PlayState.SONG.song;
		levelInfo.scrollFactor.set();
		levelInfo.setFormat(Paths.font("amogus.ttf"), 32);
		levelInfo.updateHitbox();
		add(levelInfo);

        cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];
    }

    var selectedSomethin:Bool = false;

	var canClick:Bool = true;
	var usingMouse:Bool = false;

    override function update(elapsed:Float)
    {
        if (pauseMusic.volume < 0.5)
			pauseMusic.volume += 0.01 * elapsed;

		super.update(elapsed);

        pauseStuffs.forEach(function(spr:FlxSprite)
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
        
                spr.updateHitbox();
            });
    }

    override function destroy()
    {
        pauseMusic.destroy();
    
        super.destroy();
    }

    function selectSomething()
    {
        selectedSomethin = true;
		canClick = false;

        pauseStuffs.forEach(function(spr:FlxSprite)
            {
                if (curSelected == spr.ID)
                {
                    var daSelected:String = pauseOptions[curSelected];
        
                    switch (daSelected)
                    {
						case 'resume':
                            close();
                        case 'restart':
                            restartSong();
                        case 'exit':
                            PlayState.deathCounter = 0;
                            PlayState.seenCutscene = false;
                            WeekData.loadTheFirstEnabledMod();
                            if(PlayState.isStoryMode) {
								MusicBeatState.switchState(new StoryMenuState());
                            } else {
                                MusicBeatState.switchState(new SongSelectionState());
                            }
                            PlayState.cancelMusicFadeTween();
                            FlxG.sound.playMusic(Paths.music('freakyMenu'));
                            PlayState.changedDifficulty = false;
                            PlayState.chartingMode = false;
                        case 'x':
                            close();
                    }
				}
            });
    }

    public static function restartSong(noTrans:Bool = false)
    {
                PlayState.instance.paused = true; // For lua
                FlxG.sound.music.volume = 0;
                PlayState.instance.vocals.volume = 0;
        
                if(noTrans)
                {
                    FlxTransitionableState.skipNextTransOut = true;
                    FlxG.resetState();
                }
                else
                {
                    MusicBeatState.resetState();
                }
    }

            function changeItem(huh:Int = 0)
    {
                    if (finishedFunnyMove)
                    {
                        curSelected += huh;
                
                        if (curSelected >= pauseStuffs.length)
                            curSelected = 0;
                        if (curSelected < 0)
                            curSelected = pauseStuffs.length - 1;
                    }
                    pauseStuffs.forEach(function(spr:FlxSprite)
                    {
                        spr.animation.play('idle');
                
                        if (spr.ID == curSelected && finishedFunnyMove)
                        {
                            spr.animation.play('hover');			
                        }
                        spr.updateHitbox();
                    });
    }

}