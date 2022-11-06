package;

#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.ui.FlxButton;
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
import lime.app.Application;
import Achievements;
import editors.MasterEditorMenu;
import flixel.input.keyboard.FlxKey;
import flixel.util.FlxTimer;
import flixel.ui.FlxSpriteButton;
import openfl.Lib;
import flixel.util.FlxSave;

using StringTools;

class SongSelectionState extends MusicBeatState
{
	public static var psychEngineVersion:String = '0.5'; //This is also used for Discord RPC
	public static var curSelected:Int = 0;
	public static var curSelected2:Int = 0;
	var realcurselected = 0;
	var realdiff = -1;
	var buttonSelected:Int = 0;

	var menuItems:FlxTypedGroup<FlxSprite>;
	var textItems:FlxTypedGroup<FlxSprite>;
	private var camGame:FlxCamera;
	private var camAchievement:FlxCamera;

	public static var finishedFunnyMove:Bool = false;

	var menuInfomation:FlxText;
	
	var optionShit:Array<String> = [
	    'error'
	];
	
	var buttonsItems:FlxTypedGroup<FlxSprite>;
	
	var buttons:Array<String> = ['story', 'amogus', 'extras'];

	var camFollow:FlxObject;
	var debugKeys:Array<FlxKey>;

	var codeMenu:FlxSpriteButton;

	var bg:FlxSprite;
	
	var lastbutton = 'story'; // main menu code copy so I can save time heheheha
	var lastbuttonnumber = 0;
	
	var scoreText:FlxText;
	var ratingText:FlxText;
	var diffText:FlxText;
	var lerpScore:Int = 0;
	var lerpRating:Float = 0;
	var intendedScore:Int = 0;
	var intendedRating:Float = 0;
	
	var curDifficulty:Int = 2;
	private static var lastDifficultyName:String = '';
	 
	public static var curstate = 1;

	var changingstate = false;

    var exit:FlxButton;
    
    var topbar:FlxSprite;
    
    var starFG:FlxSprite;
	var starBG:FlxSprite;

    public function new(thestatelol:Int = 0)
    {
		if(thestatelol != 0) curstate = thestatelol;
		buttonSelected = curstate - 1;
		switch(curstate) {
			case 1:
				optionShit = [
					'skeld',
                    'lights',
                    'visor',
                    'custom',
                    'corrupted',
                    'trapped',
					'mira-hq',
					'ria-roll',
					'escape',
					'report',
					'dark-electrical',
					'no-escape'
				];
			case 2:
				optionShit = [
					'telesussy',
					'lord',
					'express'
				];
			case 3:
				optionShit = [
					'phantasm',
					'monovisor',
					'distraught',
					'ugh',
					'fried-eggs',
					'mong-balls',
					'madness',
					'cone'
				];
				var save:FlxSave = new FlxSave();
				save.bind('avfnf', 'ninjamuffin99');
		}
		if(curstate == 1) {
			realcurselected = curSelected;
			realdiff = curDifficulty;
		}

        super();
    }

	override function create()
	{
		Paths.clearStoredMemory();
		Paths.clearUnusedMemory();
		
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In Freeplay", null);
		Lib.application.window.title = "Novisor Funkin - Freeplay";
		#end
		
		FlxG.mouse.visible = true;

		WeekData.setDirectoryFromWeek();
		debugKeys = ClientPrefs.copyKey(ClientPrefs.keyBinds.get('debug_1'));

		camGame = new FlxCamera();
		camAchievement = new FlxCamera();
		camAchievement.bgColor.alpha = 0;

		FlxG.cameras.reset(camGame);
		FlxG.cameras.add(camAchievement);
		FlxCamera.defaultCameras = [camGame];

		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		persistentUpdate = persistentDraw = true;

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

        topbar = new FlxSprite(0, -1.9).loadGraphic(Paths.image('info_menu/topbar'));
		add(topbar);

        exit = new FlxButton(26.35, 13.55, null, function()
            {
                MusicBeatState.switchState(new MainMenuState());
                FlxG.sound.play(Paths.sound('cancelMenu'));
            });
        exit.loadGraphic(Paths.image('info_menu/exit'));
        add(exit);

		camFollow = new FlxObject(0, 0, 1, 1);
		add(camFollow);

		// magenta.scrollFactor.set();

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		textItems = new FlxTypedGroup<FlxSprite>();
		add(textItems);

		var addstuff = '';

		switch(curstate) {
			case 2:
				addstuff = 'extras/';
			case 3:
				addstuff = 'extras/';
		}

		for(i in 0...optionShit.length) // main menu code copy so I can save time heheheha
		{
			var character:FlxSprite = new FlxSprite(700, 90);
			character.loadGraphic('assets/images/mainmenu/freeplay/' + addstuff + 'freeplay_' + optionShit[i] + '.png');
			character.ID = i;
			menuItems.add(character);
			character.scrollFactor.set();
			character.antialiasing = ClientPrefs.globalAntialiasing;
			character.updateHitbox();
			character.screenCenter();
			character.y += 15;
			character.x += i * 200;
			var name:FlxSprite = new FlxSprite(700, 90);
			name.loadGraphic('assets/images/mainmenu/freeplay/' + addstuff + 'text_' + optionShit[i] + '.png');
			name.scale.set(0.45, 0.45);
			name.ID = i;
			textItems.add(name);
			name.scrollFactor.set();
			name.antialiasing = ClientPrefs.globalAntialiasing;
			name.updateHitbox();
			name.screenCenter();
			name.y = character.y - name.height - 10;
			name.x = character.x;
		}
		
		buttonsItems = new FlxTypedGroup<FlxSprite>();
		add(buttonsItems);
		
		for (i in 0...buttons.length)
		{
			var buttonstuff:FlxSprite = new FlxSprite(710, 10);
			buttonstuff.frames = Paths.getSparrowAtlas('mainmenu/freeplay/Section_Buttons');
			buttonstuff.animation.addByPrefix('idle', buttons[i] + 'Idle', 24, true);
			buttonstuff.animation.addByPrefix('hover', buttons[i] + 'Hover', 24, true);
			buttonstuff.animation.play('idle');
			buttonstuff.scale.set(0.18, 0.18);
			buttonstuff.ID = i;
			buttonsItems.add(buttonstuff);
			buttonstuff.scrollFactor.set();
			buttonstuff.antialiasing = ClientPrefs.globalAntialiasing;
			buttonstuff.updateHitbox();
			buttonstuff.x += i * 200;
			//fixed yo stupid code
		}

		menuInfomation = new FlxText(110, 680, 1000, "Press SPACE to listen to the Song", 28);
		menuInfomation.setFormat("VCR OSD Mono", 28, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		menuInfomation.scrollFactor.set(0, 0);
		menuInfomation.borderSize = 2;
		add(menuInfomation);
		menuInfomation.screenCenter(X);

		if(ClientPrefs.languageChoose == 'Spanish')
		{
			menuInfomation.text = "Presiona ESPACIO para escuchar la Canción";
		}
		if(ClientPrefs.languageChoose == 'French')
		{
			menuInfomation.text = "Appuyez sur ESPACE pour écouter la chanson";
		}
		if(ClientPrefs.languageChoose == 'Portuguese')
		{
			menuInfomation.text = "Pressione SPACE para ouvir a música";
		}
		if(ClientPrefs.languageChoose == 'German')
		{
			menuInfomation.text = "Drücken Sie die Leertaste, um den Song anzuhören";
		}
		if(ClientPrefs.languageChoose == 'Russian')
		{
			menuInfomation.text = "Нажмите ПРОБЕЛ, чтобы прослушать песню";
			menuInfomation.setFormat("VCR OSD Mono [RUS by Daymarius]", 28, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		}
		
		scoreText = new FlxText(FlxG.width * 0.7, 5, 0, "", 42);
		scoreText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER);
		scoreText.y += 580;
		scoreText.x -= 850;

		ratingText = new FlxText(FlxG.width * 0.7, 5, 0, "", 42);
		ratingText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER);
		ratingText.y += 620;
		ratingText.x -= 850;

		if(ClientPrefs.languageChoose == 'Russian')
		{
			scoreText.setFormat(Paths.font("vcr-russian.ttf"), 32, FlxColor.WHITE, CENTER);
			ratingText.setFormat(Paths.font("vcr-russian.ttf"), 32, FlxColor.WHITE, CENTER);
		}

		
		diffText = new FlxText(FlxG.width * 0.7, 5, 0, "", 42);
		diffText.setFormat(Paths.font("vcr.ttf"), 42, FlxColor.WHITE, CENTER);
		diffText.y += 580;
		diffText.x -= 730;

		// NG.core.calls.event.logEvent('swag').send();

		changeItem();

		add(scoreText);
		add(ratingText);
		
		if(lastDifficultyName == '')
		{
			lastDifficultyName = CoolUtil.defaultDifficulty;
		}
		
		curDifficulty = Math.round(Math.max(0, CoolUtil.defaultDifficulties.indexOf(lastDifficultyName)));
		if(curstate == 1) {
			realdiff = curDifficulty;
		}
		
		changeDiff();

		bg.screenCenter();

		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.x = ((spr.ID - realcurselected) * 400) + (FlxG.height * 0.65);
		});

		super.create();
	}

	var selectedSomethin:Bool = false;
	var instPlaying:Int = -1;

	
	var canClick:Bool = true;
	var usingMouse:Bool = false;

	override function update(elapsed:Float)
	{
		var ctrl = FlxG.keys.justPressed.CONTROL;
		var space = FlxG.keys.justPressed.SPACE;
		
		Conductor.songPosition = FlxG.sound.music.time;
		
		lerpScore = Math.floor(FlxMath.lerp(lerpScore, intendedScore, CoolUtil.boundTo(elapsed * 24, 0, 1)));
		lerpRating = FlxMath.lerp(lerpRating, intendedRating, CoolUtil.boundTo(elapsed * 12, 0, 1));

		if (Math.abs(lerpScore - intendedScore) <= 10)
			lerpScore = intendedScore;
		if (Math.abs(lerpRating - intendedRating) <= 0.01)
			lerpRating = intendedRating;
			
		var ratingSplit:Array<String> = Std.string(Highscore.floorDecimal(lerpRating * 100, 2)).split('.');
		if(ratingSplit.length < 2) { //No decimals, add an empty space
			ratingSplit.push('');
		}
		
		while(ratingSplit[1].length < 2) { //Less than 2 decimals in it, add decimals then
			ratingSplit[1] += '0';
		}

		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		scoreText.text = 'Score: ' + lerpScore;
		ratingText.text = 'Rating: [' + ratingSplit.join('.') + '%]';

		if(ClientPrefs.languageChoose == 'Spanish')
		{
			scoreText.text = 'Puntaje: ' + lerpScore;
			ratingText.text = 'Clasificación: [' + ratingSplit.join('.') + '%]';
		}
		if(ClientPrefs.languageChoose == 'French')
		{
			scoreText.text = 'Score: ' + lerpScore;
			ratingText.text = 'Évaluation: [' + ratingSplit.join('.') + '%]';
		}
		if(ClientPrefs.languageChoose == 'Portuguese')
		{
			scoreText.text = 'Pontuação: ' + lerpScore;
			ratingText.text = 'Avaliação: [' + ratingSplit.join('.') + '%]';
		}
		if(ClientPrefs.languageChoose == 'German')
		{
			scoreText.text = 'Punktzahl: ' + lerpScore;
			ratingText.text = 'Bewertung: [' + ratingSplit.join('.') + '%]';
		}
		if(ClientPrefs.languageChoose == 'Russian')
		{
			scoreText.text = 'Счет: ' + lerpScore;
			ratingText.text = 'Рейтинг: [' + ratingSplit.join('.') + '%]';
		}

		if (!selectedSomethin && !changingstate)
		{
			if(ctrl) {
				persistentUpdate = false;
				openSubState(new GameplayChangersSubstate());
			}

			buttonsItems.forEach(function(spr:FlxSprite)
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
							var daChoice:String = buttons[curSelected];
							
							switch (daChoice)
							{
								
								case 'story':
				                    MusicBeatState.switchState(new SongSelectionState(1));
								case 'amogus':
									MusicBeatState.switchState(new SongSelectionState(2));
								case 'extras':
									MusicBeatState.switchState(new SongSelectionState(3));
							}
						}
					}
		
					starFG.y -= 0.03;
					starBG.y -= 0.01;
			
					spr.updateHitbox();
				});

			menuItems.forEach(function(spr:FlxSprite) {
				spr.x = FlxMath.lerp(spr.x, ((spr.ID - realcurselected) * 400) + (FlxG.height * 0.65), CoolUtil.boundTo(elapsed * 9.6, 0, 1));
				for(text in textItems) {
					if(text.ID == spr.ID) {
						text.x = spr.x;
					}
				}
			});

			if (controls.UI_LEFT_P)
				changeItem(-1);
			if (controls.UI_RIGHT_P)
				changeItem(1);

			if (controls.BACK) {
				selectedSomethin = true;
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new MainMenuState());
			}

			if(space) {
				if(instPlaying != realcurselected)
				{
					#if PRELOAD_ALL
					FlxG.sound.playMusic(Paths.inst(optionShit[realcurselected]), 0);
					#end
					
					PlayState.SONG = Song.loadFromJson(optionShit[realcurselected], optionShit[realcurselected]);
					Conductor.changeBPM((PlayState.SONG.bpm));
				}
			} else if (controls.ACCEPT) {

				menuItems.forEach(function(spr:FlxSprite)
				{
					textItems.forEach(function(textspr:FlxSprite)
					{
						{
							switch (optionShit[realcurselected])
							{
								default:
								PlayState.storyDifficulty = realdiff;
								PlayState.SONG = Song.loadFromJson(optionShit[realcurselected], optionShit[realcurselected]); 
								PlayState.isStoryMode = false;
								PlayState.storyWeek = 1;
								LoadingState.loadAndSwitchState(new PlayState());
							}
						}
					});
				});
			}
		}

		super.update(elapsed);
	}

	function changeItem(huh:Int = 0)
	{
		if(huh != 0) FlxG.sound.play(Paths.sound('scrollMenu'));

		realcurselected += huh;

		if (realcurselected >= menuItems.length)
			realcurselected = 0;
		if (realcurselected < 0)
			realcurselected = menuItems.length - 1;

		if(curstate == 1) {
			curSelected = realcurselected;
		} else {
			curSelected2 = realcurselected;
		}
		#if !switch
		intendedScore = Highscore.getScore(optionShit[realcurselected], realdiff);
		intendedRating = Highscore.getRating(optionShit[realcurselected], realdiff);
		#end
		if (finishedFunnyMove)
			{
				curSelected += huh;
		
				if (curSelected >= buttonsItems.length)
					curSelected = 0;
				if (curSelected < 0)
					curSelected = buttonsItems.length - 1;
			}
	
		buttonsItems.forEach(function(spr:FlxSprite)
			{
				spr.animation.play('idle');
		
				if (spr.ID == curSelected && finishedFunnyMove)
				{
					spr.animation.play('hover');				
				}
				spr.updateHitbox();
			});

			menuItems.forEach(function(spr:FlxSprite)
				{
					spr.updateHitbox();
					spr.alpha = 0.6;
					if (spr.ID == realcurselected)
					{
						spr.alpha = 1;
						var add:Float = 0;
						if(menuItems.length > 4) {
							add = menuItems.length * 8;
						}
						camFollow.setPosition(spr.getGraphicMidpoint().x, spr.getGraphicMidpoint().y - add);
						spr.centerOffsets();
					}
				});
		
		CoolUtil.difficulties = CoolUtil.defaultDifficulties.copy();
		
		curDifficulty = Math.round(Math.max(0, CoolUtil.defaultDifficulties.indexOf(CoolUtil.defaultDifficulty)));
		if(curstate == 1) {
			realdiff = curDifficulty;
		}
		var newPos:Int = CoolUtil.difficulties.indexOf(lastDifficultyName);
		//trace('Pos of ' + lastDifficultyName + ' is ' + newPos);
		if(newPos > -1)
		{
			realdiff = newPos;
		}
	}
	
	function changeDiff(change:Int = 0)
	{
		curDifficulty += change;

		if (curDifficulty < 1)
			curDifficulty = CoolUtil.difficulties.length-1;
		if (curDifficulty >= CoolUtil.difficulties.length)
			curDifficulty = 1;

		lastDifficultyName = CoolUtil.difficulties[curDifficulty];

		#if !switch
		intendedScore = Highscore.getScore(optionShit[realcurselected], curDifficulty);
		intendedRating = Highscore.getRating(optionShit[realcurselected], curDifficulty);
		#end

		PlayState.storyDifficulty = curDifficulty;
		if(curstate == 1) {
			diffText.text = '^\n' + CoolUtil.difficultyString() + '\nv';
		}
		realdiff = curDifficulty;
	}
}