package;

#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.addons.transition.FlxTransitionableState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import lime.app.Application;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.net.curl.CURLCode;
import flixel.graphics.FlxGraphic;
import WeekData;

using StringTools;

class StoryMenuState extends MusicBeatState
{
	public static var weekCompleted:Map<String, Bool> = new Map<String, Bool>();

	var scoreText:FlxText;

	private static var lastDifficultyName:String = '';
	var curDifficulty:Int = 1;

	var txtWeekTitle:FlxText;
	var bgSprite:FlxSprite;

	private static var curWeek:Int = 0;

	var txtTracklist:FlxText;

	var grpWeekText:FlxTypedGroup<MenuItem>;
	var grpWeekCharacters:FlxTypedGroup<MenuCharacter>;

	var grpLocks:FlxTypedGroup<FlxSprite>;

	var difficultySelectors:FlxGroup;
	var sprDifficulty:FlxSprite;
	var leftArrow:FlxSprite;
	var rightArrow:FlxSprite;

	var titlebar:FlxSprite;

	var comm:FlxSprite;
	var bg2:FlxSprite;
	var bush:FlxSprite;
	var yard:FlxSprite;
	var bushe1:FlxSprite;
	var bushe2:FlxSprite;
	var mira:FlxSprite;
	var amogusbg:FlxSprite;
	var amogusclouds:FlxSprite;
	var amogusmg:FlxSprite;
	var amogusmg2:FlxSprite;
	var amogusground:FlxSprite;

	var loadedWeeks:Array<WeekData> = [];

	override function create()
	{
		Paths.clearStoredMemory();
		Paths.clearUnusedMemory();

		PlayState.isStoryMode = true;
		WeekData.reloadWeekFiles(true);
		if(curWeek >= WeekData.weeksList.length) curWeek = 0;

		Application.current.window.title = 'Novisor Funkin - Story Menu';

		comm = new FlxSprite(-39, 804.5).loadGraphic(Paths.image('stages/week1'));
		add(comm);

		bg2 = new FlxSprite(-253, 781.95).loadGraphic(Paths.image('stages/week2bg'));
		add(bg2);

		bush = new FlxSprite(150, 849.7).loadGraphic(Paths.image('stages/week2bush'));
		add(bush);

		yard = new FlxSprite(-1298, 781.95).loadGraphic(Paths.image('stages/week2yard'));
		add(yard);

		bushe1 = new FlxSprite(922, 781.95).loadGraphic(Paths.image('stages/week2bush2'));
		add(bushe1);
		
		bushe2 = new FlxSprite(-121, 726.55).loadGraphic(Paths.image('stages/week2bush1'));
		add(bushe2);

		mira = new FlxSprite(-430.55, 748.15).loadGraphic(Paths.image('stages/week3'));
		add(mira);
		
		amogusbg = new FlxSprite(-448.7, 757.6).loadGraphic(Paths.image('amogus/bg', 'shared'));
		add(amogusbg);

		amogusclouds = new FlxSprite(-321.2, 954).loadGraphic(Paths.image('amogus/clouds', 'shared'));
		add(amogusclouds);

		amogusmg = new FlxSprite(-585.35, 1194).loadGraphic(Paths.image('amogus/mg', 'shared'));
		add(amogusmg);

		amogusmg2 = new FlxSprite(-515.6, 1186).loadGraphic(Paths.image('amogus/mg2', 'shared'));
		add(amogusmg2);

		amogusground = new FlxSprite(-637.15, 1615).loadGraphic(Paths.image('amogus/ground', 'shared'));
		add(amogusground);

		var gradient:FlxSprite = new FlxSprite(-100).loadGraphic(Paths.image('menuGr'));
		gradient.scrollFactor.x = 0;
		gradient.scrollFactor.y = 0.10;
		gradient.setGraphicSize(Std.int(gradient.width * 1.1));
		gradient.updateHitbox();
		gradient.screenCenter();
		add(gradient);

		titlebar = new FlxSprite(-181.6, -20).loadGraphic(Paths.image('titlebar'));
		add(titlebar);

		persistentUpdate = persistentDraw = true;

		scoreText = new FlxText(10, 10, 0, "SCORE: 49324858", 36);
		scoreText.setFormat("VCR OSD Mono", 32);

		txtWeekTitle = new FlxText(FlxG.width * 0.7, 10, 0, "", 32);
		txtWeekTitle.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, RIGHT);
		txtWeekTitle.alpha = 0.7;

		var rankText:FlxText = new FlxText(0, 10);
		rankText.text = 'RANK: GREAT';
		rankText.setFormat(Paths.font("phant.ttf"), 32);
		rankText.size = scoreText.size;
		rankText.screenCenter(X);

		var ui_tex = Paths.getSparrowAtlas('campaign_menu_UI_assets');
		var bgYellow:FlxSprite = new FlxSprite(0, 56).makeGraphic(FlxG.width, 386, 0xFFF9CF51);
		bgSprite = new FlxSprite(0, 56);
		bgSprite.antialiasing = ClientPrefs.globalAntialiasing;

		grpWeekText = new FlxTypedGroup<MenuItem>();
		add(grpWeekText);

		var blackBarThingie:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, 56, FlxColor.BLACK);

		grpWeekCharacters = new FlxTypedGroup<MenuCharacter>();

		grpLocks = new FlxTypedGroup<FlxSprite>();
		add(grpLocks);

		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		var num:Int = 0;
		for (i in 0...WeekData.weeksList.length)
		{
			var weekFile:WeekData = WeekData.weeksLoaded.get(WeekData.weeksList[i]);
			var isLocked:Bool = weekIsLocked(WeekData.weeksList[i]);
			if(!isLocked || !weekFile.hiddenUntilUnlocked)
			{
				loadedWeeks.push(weekFile);
				WeekData.setDirectoryFromWeek(weekFile);
				var weekThing:MenuItem = new MenuItem(0, bgSprite.y + 396, WeekData.weeksList[i]);
				weekThing.y += ((weekThing.height + 20) * num);
				weekThing.targetY = num;
				grpWeekText.add(weekThing);

				weekThing.screenCenter(X);
				weekThing.x += 350;
				weekThing.antialiasing = ClientPrefs.globalAntialiasing;
				// weekThing.updateHitbox();

				// Needs an offset thingie
				if (isLocked)
				{
					var lock:FlxSprite = new FlxSprite(weekThing.width + 10 + weekThing.x);
					lock.frames = ui_tex;
					lock.animation.addByPrefix('lock', 'lock');
					lock.animation.play('lock');
					lock.ID = i;
					lock.antialiasing = ClientPrefs.globalAntialiasing;
					grpLocks.add(lock);
				}
				num++;
			}
		}

		WeekData.setDirectoryFromWeek(loadedWeeks[0]);
		var charArray:Array<String> = loadedWeeks[0].weekCharacters;
		for (char in 0...3)
		{
			var weekCharacterThing:MenuCharacter = new MenuCharacter((FlxG.width * 0.25) * (1 + char) - 150, charArray[char]);
			weekCharacterThing.y += 70;
			grpWeekCharacters.add(weekCharacterThing);
		}

		difficultySelectors = new FlxGroup();
		add(difficultySelectors);

		leftArrow = new FlxSprite(-350 + grpWeekText.members[0].width + 10, grpWeekText.members[0].y + 90);
		leftArrow.frames = ui_tex;
		leftArrow.animation.addByPrefix('idle', "arrow left");
		leftArrow.animation.addByPrefix('press', "arrow push left");
		leftArrow.animation.play('idle');
		leftArrow.antialiasing = ClientPrefs.globalAntialiasing;

		CoolUtil.difficulties = CoolUtil.defaultDifficulties.copy();
		if(lastDifficultyName == '')
		{
			lastDifficultyName = CoolUtil.defaultDifficulty;
		}
		curDifficulty = Math.round(Math.max(0, CoolUtil.defaultDifficulties.indexOf(lastDifficultyName)));
		
		sprDifficulty = new FlxSprite(0, leftArrow.y);
		sprDifficulty.antialiasing = ClientPrefs.globalAntialiasing;

		rightArrow = new FlxSprite(leftArrow.x + 376, leftArrow.y);
		rightArrow.frames = ui_tex;
		rightArrow.animation.addByPrefix('idle', 'arrow right');
		rightArrow.animation.addByPrefix('press', "arrow push right", 24, false);
		rightArrow.animation.play('idle');
		rightArrow.antialiasing = ClientPrefs.globalAntialiasing;

		var tracksSprite:FlxSprite = new FlxSprite(FlxG.width * 0.07, 100).loadGraphic(Paths.image('Menu_Tracks'));
		tracksSprite.antialiasing = ClientPrefs.globalAntialiasing;
		tracksSprite.color = 0xFFFF0000;
		add(tracksSprite);

		txtTracklist = new FlxText(FlxG.width * 0.05, tracksSprite.y + 60, 0, "", 32);
		txtTracklist.alignment = CENTER;
		txtTracklist.font = rankText.font;
		txtTracklist.borderSize = 1.25;
		txtTracklist.color = 0xFFFF0000;
		add(txtTracklist);
		// add(rankText);
		add(scoreText);
		add(txtWeekTitle);

		add(sprDifficulty);

		var inputTxt:FlxText = new FlxText(268, 67, 1000, "", 25);
		inputTxt.setFormat(Paths.font("vcr.ttf"), 25, FlxColor.RED, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		inputTxt.text = "Up/Down - Change Weeks\nLeft/Right - Changing Mechanics Mode\n(Normal = Without Mechanics | Mechanics = With Mechanics)";
		add(inputTxt);

		if(ClientPrefs.languageChoose == 'Spanish')
		{
			inputTxt.text = "Arriba/abajo - Cambiar semanas\nIzquierda/Derecha - Cambiar el modo de mecánica\n(Normal = Sin Mecánica | Mecánica = Con Mecánica)";
		}
		if(ClientPrefs.languageChoose == 'French')
		{
			inputTxt.text = "Haut/Bas - Changer les semaines\nGauche/Droite - Modification du mode Mécanique\n(Normal = Sans Mécanique | Mécanique = Avec Mécanique)";
		}
		if(ClientPrefs.languageChoose == 'Portuguese')
		{
			inputTxt.text = "Para cima/para baixo - Alterar semanas\nEsquerda/Direita - Mudando o Modo de Mecânica\n(Normal = Sem Mecânica | Mecânica = Com Mecânica)";
		}
		if(ClientPrefs.languageChoose == 'German')
		{
			inputTxt.text = "Auf/Ab - Wochen ändern\nLinks/Rechts - Ändern des Mechanikmodus\n(Normal = ohne Mechanik | Mechanik = mit Mechanik)";
		}
		if(ClientPrefs.languageChoose == 'Russian')
		{
			inputTxt.text = "Вверх/Вниз - Изменить недели\nВлево/вправо — изменение режима механики\n(Обычный = Без механики | Механика = С механикой)";
			inputTxt.setFormat(Paths.font("vcr-russian.ttf"), 25, FlxColor.RED, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		}

		changeWeek();
		changeDifficulty();

		super.create();
	}

	override function closeSubState() {
		persistentUpdate = true;
		changeWeek();
		super.closeSubState();
	}

	override function update(elapsed:Float)
	{
		// scoreText.setFormat('VCR OSD Mono', 32);
		lerpScore = Math.floor(FlxMath.lerp(lerpScore, intendedScore, CoolUtil.boundTo(elapsed * 30, 0, 1)));
		if(Math.abs(intendedScore - lerpScore) < 10) lerpScore = intendedScore;

		scoreText.text = "WEEK SCORE:" + lerpScore;

		if(ClientPrefs.languageChoose == 'Spanish')
		{
			scoreText.text = "PUNTAJE DE LA SEMANA:" + lerpScore;
		}
		if(ClientPrefs.languageChoose == 'French')
		{
			scoreText.text = "SCORE DE LA SEMAINE:" + lerpScore;
		}
		if(ClientPrefs.languageChoose == 'Portuguese')
		{
			scoreText.text = "PONTUAÇÃO DA SEMANA:" + lerpScore;
		}
		if(ClientPrefs.languageChoose == 'German')
		{
			scoreText.text = "WOCHEN-ERGEBNIS:" + lerpScore;
		}

		// FlxG.watch.addQuick('font', scoreText.font);

		if (!movedBack && !selectedWeek)
		{
			var upP = controls.UI_UP_P;
			var downP = controls.UI_DOWN_P;
			if (upP)
			{
				changeWeek(-1);
				FlxG.sound.play(Paths.sound('scrollMenu'));
			}

			if (downP)
			{
				changeWeek(1);
				FlxG.sound.play(Paths.sound('scrollMenu'));
			}

			if(FlxG.mouse.wheel != 0)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
				changeWeek(-FlxG.mouse.wheel);
			}

			if (controls.UI_RIGHT)
				rightArrow.animation.play('press')
			else
				rightArrow.animation.play('idle');

			if (controls.UI_LEFT)
				leftArrow.animation.play('press');
			else
				leftArrow.animation.play('idle');

			if (controls.UI_RIGHT_P)
				changeDifficulty(1);
			else if (controls.UI_LEFT_P)
				changeDifficulty(-1);
			else if (upP || downP)
				changeDifficulty();

			if(FlxG.keys.justPressed.CONTROL)
			{
                persistentUpdate = false;
				openSubState(new GameplayChangersSubstate());
			}
			else if(controls.RESET)
			{
				persistentUpdate = false;
				openSubState(new ResetScoreSubState('', curDifficulty, '', curWeek));
				//FlxG.sound.play(Paths.sound('scrollMenu'));
			}
			else if (controls.ACCEPT)
			{
				selectWeek();
			}
		}

		if (controls.BACK && !movedBack && !selectedWeek)
		{
			FlxG.sound.play(Paths.sound('cancelMenu'));
			movedBack = true;
			MusicBeatState.switchState(new MainMenuState());
		}

		super.update(elapsed);

		grpLocks.forEach(function(lock:FlxSprite)
		{
			lock.y = grpWeekText.members[lock.ID].y;
			lock.visible = (lock.y > FlxG.height / 2);
		});
	}

	var movedBack:Bool = false;
	var selectedWeek:Bool = false;
	var stopspamming:Bool = false;

	var commTween:FlxTween;
	var bg2Tween:FlxTween;
	var bushTween:FlxTween;
	var yardTween:FlxTween;
	var bushe1Tween:FlxTween;
	var bushe2Tween:FlxTween;
	var miraTween:FlxTween;
	var amogusbgTween:FlxTween;
	var amogusbg2Tween:FlxTween;
	var amogusmgTween:FlxTween;
	var amogusmg2Tween:FlxTween;
	var amogusgroundTween:FlxTween;

	function cancelTweens()
	{
		commTween.cancel();
		bg2Tween.cancel();
		bushTween.cancel();
		yardTween.cancel();
		bushe1Tween.cancel();
		bushe2Tween.cancel();
		miraTween.cancel();
		amogusbgTween.cancel();
		amogusbg2Tween.cancel();
		amogusmgTween.cancel();
		amogusmg2Tween.cancel();
		amogusgroundTween.cancel();
	}

	function selectWeek()
	{
		if (!weekIsLocked(loadedWeeks[curWeek].fileName))
		{
			if (stopspamming == false)
			{
				FlxG.sound.play(Paths.sound('confirmMenu'));

				grpWeekText.members[curWeek].startFlashing();

				var bf:MenuCharacter = grpWeekCharacters.members[1];
				if(bf.character != '' && bf.hasConfirmAnimation) grpWeekCharacters.members[1].animation.play('confirm');
				stopspamming = true;
			}

			// We can't use Dynamic Array .copy() because that crashes HTML5, here's a workaround.
			var songArray:Array<String> = [];
			var leWeek:Array<Dynamic> = loadedWeeks[curWeek].songs;
			for (i in 0...leWeek.length) {
				songArray.push(leWeek[i][0]);
			}

			// Nevermind that's stupid lmao
			PlayState.storyPlaylist = songArray;
			PlayState.isStoryMode = true;
			selectedWeek = true;

			var diffic = CoolUtil.getDifficultyFilePath(curDifficulty);
			if(diffic == null) diffic = '';

			PlayState.storyDifficulty = curDifficulty;

			PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + diffic, PlayState.storyPlaylist[0].toLowerCase());
			PlayState.campaignScore = 0;
			PlayState.campaignMisses = 0;
			new FlxTimer().start(1, function(tmr:FlxTimer)
			{
				LoadingState.loadAndSwitchState(new PlayState(), true);
				FreeplayState.destroyFreeplayVocals();
			});
		} else {
			FlxG.sound.play(Paths.sound('cancelMenu'));
		}
	}

	var tweenDifficulty:FlxTween;
	function changeDifficulty(change:Int = 0):Void
	{
		curDifficulty += change;

		if (curDifficulty < 0)
			curDifficulty = CoolUtil.difficulties.length-1;
		if (curDifficulty >= CoolUtil.difficulties.length)
			curDifficulty = 0;

		WeekData.setDirectoryFromWeek(loadedWeeks[curWeek]);

		var diff:String = CoolUtil.difficulties[curDifficulty];
		var newImage:FlxGraphic = Paths.image('menudifficulties/' + Paths.formatToSongPath(diff));
		//trace(Paths.currentModDirectory + ', menudifficulties/' + Paths.formatToSongPath(diff));

		if(sprDifficulty.graphic != newImage)
		{
			sprDifficulty.loadGraphic(newImage);
			sprDifficulty.x = leftArrow.x + 60;
			sprDifficulty.x += (308 - sprDifficulty.width) / 3;
			sprDifficulty.alpha = 0;
			sprDifficulty.y = leftArrow.y - 15;

			if(tweenDifficulty != null) tweenDifficulty.cancel();
			tweenDifficulty = FlxTween.tween(sprDifficulty, {y: leftArrow.y + 15, alpha: 1}, 0.07, {onComplete: function(twn:FlxTween)
			{
				tweenDifficulty = null;
			}});
		}
		lastDifficultyName = diff;

		#if !switch
		intendedScore = Highscore.getWeekScore(loadedWeeks[curWeek].fileName, curDifficulty);
		#end
	}

	var lerpScore:Int = 0;
	var intendedScore:Int = 0;

	function changeWeek(change:Int = 0):Void
	{
		curWeek += change;

		if (curWeek >= loadedWeeks.length)
			curWeek = 0;
		if (curWeek < 0)
			curWeek = loadedWeeks.length - 1;

		var leWeek:WeekData = loadedWeeks[curWeek];
		WeekData.setDirectoryFromWeek(leWeek);

		var leName:String = leWeek.storyName;
		txtWeekTitle.text = leName.toUpperCase();
		txtWeekTitle.x = FlxG.width - (txtWeekTitle.width + 10);

		var bullShit:Int = 0;

		var unlocked:Bool = !weekIsLocked(leWeek.fileName);
		for (item in grpWeekText.members)
		{
			item.targetY = bullShit - curWeek;
			if (item.targetY == Std.int(0) && unlocked)
				item.alpha = 1;
			else
				item.alpha = 0.6;
			bullShit++;
		}

		bgSprite.visible = true;
		var assetName:String = leWeek.weekBackground;
		if(assetName == null || assetName.length < 1) {
			bgSprite.visible = false;
		} else {
			bgSprite.loadGraphic(Paths.image('menubackgrounds/menu_' + assetName));
		}
		PlayState.storyWeek = curWeek;

		CoolUtil.difficulties = CoolUtil.defaultDifficulties.copy();
		var diffStr:String = WeekData.getCurrentWeek().difficulties;
		if(diffStr != null) diffStr = diffStr.trim(); //Fuck you HTML5
		difficultySelectors.visible = unlocked;

		if(diffStr != null && diffStr.length > 0)
		{
			var diffs:Array<String> = diffStr.split(',');
			var i:Int = diffs.length - 1;
			while (i > 0)
			{
				if(diffs[i] != null)
				{
					diffs[i] = diffs[i].trim();
					if(diffs[i].length < 1) diffs.remove(diffs[i]);
				}
				--i;
			}

			if(diffs.length > 0 && diffs[0].length > 0)
			{
				CoolUtil.difficulties = diffs;
			}
		}
		
		if(CoolUtil.difficulties.contains(CoolUtil.defaultDifficulty))
		{
			curDifficulty = Math.round(Math.max(0, CoolUtil.defaultDifficulties.indexOf(CoolUtil.defaultDifficulty)));
		}
		else
		{
			curDifficulty = 0;
		}

		var newPos:Int = CoolUtil.difficulties.indexOf(lastDifficultyName);
		//trace('Pos of ' + lastDifficultyName + ' is ' + newPos);
		if(newPos > -1)
		{
			curDifficulty = newPos;
		}
		updateText();

		for (i in 0...grpWeekText.members.length)
		{
			if(i > curWeek) {
				FlxTween.tween(grpWeekText.members[i], {alpha: 0.3}, 0.1, {ease: FlxEase.expoOut});
			}
			else if(i == curWeek) {
				FlxTween.tween(grpWeekText.members[i], {alpha: 1}, 0.1, {ease: FlxEase.expoOut});
			}
			else if(i < curWeek) {
				FlxTween.tween(grpWeekText.members[i], {alpha: 0}, 0.1, {ease: FlxEase.expoOut});
			}
		}

		switch(curWeek)
		{
			case 0:
			{
				if(commTween != null)
				{
					cancelTweens();
				}
				commTween = FlxTween.tween(comm,{y: -94}, 0.5 ,{ease: FlxEase.expoOut});
				bg2Tween = FlxTween.tween(bg2,{y: 781.95}, 0.6 ,{ease: FlxEase.expoIn});
				bushTween = FlxTween.tween(bush,{y: 849.7}, 1 ,{ease: FlxEase.expoIn});
				yardTween = FlxTween.tween(yard,{y: 781.95}, 0.8 ,{ease: FlxEase.expoIn});
				bushe1Tween = FlxTween.tween(bushe1,{y: 781.95}, 0.8 ,{ease: FlxEase.expoIn});
				bushe2Tween = FlxTween.tween(bushe2,{y: 726.55}, 0.8 ,{ease: FlxEase.expoIn});
				miraTween = FlxTween.tween(mira,{y: 748.15}, 0.6 ,{ease: FlxEase.expoIn});
				amogusbgTween = FlxTween.tween(amogusbg,{y: 786}, 0.6 ,{ease: FlxEase.expoIn});
				amogusbg2Tween = FlxTween.tween(amogusclouds,{y: 983}, 0.6 ,{ease: FlxEase.expoIn});
				amogusmgTween = FlxTween.tween(amogusmg,{y: 1215}, 0.6 ,{ease: FlxEase.expoIn});
				amogusmg2Tween = FlxTween.tween(amogusmg2,{y: 1215}, 0.6 ,{ease: FlxEase.expoIn});
				amogusgroundTween = FlxTween.tween(amogusground,{y: 1644}, 0.6 ,{ease: FlxEase.expoIn});
			}
			case 1:
			{
				if(commTween != null)
				{
					cancelTweens();
				}
				commTween = FlxTween.tween(comm,{y: 804.5}, 0.5 ,{ease: FlxEase.expoIn});
				bg2Tween = FlxTween.tween(bg2,{y: -220.9}, 0.6 ,{ease: FlxEase.expoOut});
				bushTween = FlxTween.tween(bush,{y: -46.9}, 1 ,{ease: FlxEase.expoOut});
				yardTween = FlxTween.tween(yard,{y: 37.1}, 0.8 ,{ease: FlxEase.expoOut});
				bushe1Tween = FlxTween.tween(bushe1,{y: 378.1}, 0.8 ,{ease: FlxEase.expoOut});
				bushe2Tween = FlxTween.tween(bushe2,{y: 263.1}, 0.8 ,{ease: FlxEase.expoOut});
				miraTween = FlxTween.tween(mira,{y: 748.15}, 0.6 ,{ease: FlxEase.expoIn});
				amogusbgTween = FlxTween.tween(amogusbg,{y: 786}, 0.6 ,{ease: FlxEase.expoIn});
				amogusbg2Tween = FlxTween.tween(amogusclouds,{y: 983}, 0.6 ,{ease: FlxEase.expoIn});
				amogusmgTween = FlxTween.tween(amogusmg,{y: 1215}, 0.6 ,{ease: FlxEase.expoIn});
				amogusmg2Tween = FlxTween.tween(amogusmg2,{y: 1215}, 0.6 ,{ease: FlxEase.expoIn});
				amogusgroundTween = FlxTween.tween(amogusground,{y: 1644}, 0.6 ,{ease: FlxEase.expoIn});
			}
		    case 2:
			{
				if(commTween != null)
				{
					cancelTweens();
				}
				commTween = FlxTween.tween(comm,{y: 804.5}, 0.5 ,{ease: FlxEase.expoIn});
				bg2Tween = FlxTween.tween(bg2,{y: 781.95}, 0.6 ,{ease: FlxEase.expoIn});
				bushTween = FlxTween.tween(bush,{y: 849.7}, 1 ,{ease: FlxEase.expoIn});
				yardTween = FlxTween.tween(yard,{y: 781.95}, 0.8 ,{ease: FlxEase.expoIn});
				bushe1Tween = FlxTween.tween(bushe1,{y: 781.95}, 0.8 ,{ease: FlxEase.expoIn});
				bushe2Tween = FlxTween.tween(bushe2,{y: 726.55}, 0.8 ,{ease: FlxEase.expoIn});
				miraTween = FlxTween.tween(mira,{y: -9.6}, 0.6 ,{ease: FlxEase.expoOut});
				amogusbgTween = FlxTween.tween(amogusbg,{y: 786}, 0.6 ,{ease: FlxEase.expoIn});
				amogusbg2Tween = FlxTween.tween(amogusclouds,{y: 983}, 0.6 ,{ease: FlxEase.expoIn});
				amogusmgTween = FlxTween.tween(amogusmg,{y: 1215}, 0.6 ,{ease: FlxEase.expoIn});
				amogusmg2Tween = FlxTween.tween(amogusmg2,{y: 1215}, 0.6 ,{ease: FlxEase.expoIn});
				amogusgroundTween = FlxTween.tween(amogusground,{y: 1644}, 0.6 ,{ease: FlxEase.expoIn});
			}
			case 3:
			{
				if(commTween != null)
				{
					cancelTweens();
				}
				commTween = FlxTween.tween(comm,{y: 804.5}, 0.5 ,{ease: FlxEase.expoIn});
				bg2Tween = FlxTween.tween(bg2,{y: 781.95}, 0.6 ,{ease: FlxEase.expoIn});
				bushTween = FlxTween.tween(bush,{y: 849.7}, 1 ,{ease: FlxEase.expoIn});
				yardTween = FlxTween.tween(yard,{y: 781.95}, 0.8 ,{ease: FlxEase.expoIn});
				bushe1Tween = FlxTween.tween(bushe1,{y: 781.95}, 0.8 ,{ease: FlxEase.expoIn});
				bushe2Tween = FlxTween.tween(bushe2,{y: 726.55}, 0.8 ,{ease: FlxEase.expoIn});
				miraTween = FlxTween.tween(mira,{y: 748.15}, 0.6 ,{ease: FlxEase.expoIn});
				amogusbgTween = FlxTween.tween(amogusbg,{y: -258}, 0.6 ,{ease: FlxEase.expoOut});
				amogusbg2Tween = FlxTween.tween(amogusclouds,{y: -205}, 0.6 ,{ease: FlxEase.expoOut});
				amogusmgTween = FlxTween.tween(amogusmg,{y: 121}, 0.6 ,{ease: FlxEase.expoOut});
				amogusmg2Tween = FlxTween.tween(amogusmg2,{y: 123}, 0.6 ,{ease: FlxEase.expoOut});
				amogusgroundTween = FlxTween.tween(amogusground,{y: 521}, 0.6 ,{ease: FlxEase.expoOut});
			}
		}
	}

	function weekIsLocked(name:String):Bool {
		var leWeek:WeekData = WeekData.weeksLoaded.get(name);
		return (!leWeek.startUnlocked && leWeek.weekBefore.length > 0 && (!weekCompleted.exists(leWeek.weekBefore) || !weekCompleted.get(leWeek.weekBefore)));
	}

	function updateText()
	{
		var weekArray:Array<String> = loadedWeeks[curWeek].weekCharacters;
		for (i in 0...grpWeekCharacters.length) {
			grpWeekCharacters.members[i].changeCharacter(weekArray[i]);
		}

		var leWeek:WeekData = loadedWeeks[curWeek];
		var stringThing:Array<String> = [];
		for (i in 0...leWeek.songs.length) {
			stringThing.push(leWeek.songs[i][0]);
		}

		txtTracklist.text = '';
		for (i in 0...stringThing.length)
		{
			txtTracklist.text += stringThing[i] + '\n';
		}

		txtTracklist.text = txtTracklist.text.toUpperCase();

		txtTracklist.screenCenter(X);
		txtTracklist.x -= FlxG.width * 0.35;

		#if !switch
		intendedScore = Highscore.getWeekScore(loadedWeeks[curWeek].fileName, curDifficulty);
		#end
	}
}