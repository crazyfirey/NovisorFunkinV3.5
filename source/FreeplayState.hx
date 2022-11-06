package;

#if desktop
import Discord.DiscordClient;
#end
import editors.ChartingState;
import flixel.addons.display.FlxBackdrop;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.tweens.FlxEase;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.transition.FlxTransitionableState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.app.Application;
import flixel.tweens.FlxTween;
import lime.utils.Assets;
import flixel.system.FlxSound;
import openfl.utils.Assets as OpenFlAssets;
import WeekData;
#if MODS_ALLOWED
import sys.FileSystem;
#end

using StringTools;

class FreeplayState extends MusicBeatState
{
	var songs:Array<SongMetadata> = [];

	var selector:FlxText;
	private static var curSelected:Int = 0;
	var curDifficulty:Int = -1;
	private static var lastDifficultyName:String = '';

	var scoreBG:FlxSprite;
	var scoreText:FlxText;
	var diffText:FlxText;
	var lerpScore:Int = 0;
	var lerpRating:Float = 0;
	var intendedScore:Int = 0;
	var intendedRating:Float = 0;

	private var grpSongs:FlxTypedGroup<SongFont>;
	private var curPlaying:Bool = false;

	private var iconArray:Array<HealthIcon> = [];

	var png:FlxSprite;
	var bg:FlxSprite;
	var starFG:FlxBackdrop;
	var starBG:FlxBackdrop;
	var intendedColor:Int;
	var colorTween:FlxTween;

	var comm:FlxSprite;
	var bg2:FlxSprite;
	var bush:FlxSprite;
	var yard:FlxSprite;
	var bushe1:FlxSprite;
	var bushe2:FlxSprite;
	var mira:FlxSprite;
	var vaultbg:FlxSprite;
	var vaultruby:FlxSprite;
	var vaultglow:FlxSprite;
	var vaultitem:FlxSprite;
	var void:FlxSprite;
	var amogusbg:FlxSprite;
	var amogusclouds:FlxSprite;
	var amogusmg:FlxSprite;
	var amogusmg2:FlxSprite;
	var amogusground:FlxSprite;

	override function create()
	{
		Paths.clearStoredMemory();
		//Paths.clearUnusedMemory();
		
		persistentUpdate = true;
		PlayState.isStoryMode = false;
		WeekData.reloadWeekFiles(false);

		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("Freeplay Menu", null);
		#end

		Application.current.window.title = 'Novisor Funkin - Freeplay';

		for (i in 0...WeekData.weeksList.length) {
			if(weekIsLocked(WeekData.weeksList[i])) continue;

			var leWeek:WeekData = WeekData.weeksLoaded.get(WeekData.weeksList[i]);
			var leSongs:Array<String> = [];
			var leChars:Array<String> = [];

			for (j in 0...leWeek.songs.length)
			{
				leSongs.push(leWeek.songs[j][0]);
				leChars.push(leWeek.songs[j][1]);
			}

			WeekData.setDirectoryFromWeek(leWeek);
			for (song in leWeek.songs)
			{
				var colors:Array<Int> = song[2];
				if(colors == null || colors.length < 3)
				{
					colors = [146, 113, 253];
				}
				addSong(song[0], i, song[1], FlxColor.fromRGB(colors[0], colors[1], colors[2]));
			}
		}
		WeekData.loadTheFirstEnabledMod();

		/*		//KIND OF BROKEN NOW AND ALSO PRETTY USELESS//

		var initSonglist = CoolUtil.coolTextFile(Paths.txt('freeplaySonglist'));
		for (i in 0...initSonglist.length)
		{
			if(initSonglist[i] != null && initSonglist[i].length > 0) {
				var songArray:Array<String> = initSonglist[i].split(":");
				addSong(songArray[0], 0, songArray[1], Std.parseInt(songArray[2]));
			}
		}*/

		png = new FlxSprite().loadGraphic(Paths.image('spacep'));
		png.antialiasing = ClientPrefs.globalAntialiasing;
		png.screenCenter();
		
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

		vaultbg = new FlxSprite(-114, 995.9).loadGraphic(Paths.image('stages/vault_bg'));
		add(vaultbg);

		vaultitem = new FlxSprite(583, 1560.85).loadGraphic(Paths.image('stages/vault_items'));
		add(vaultitem);

		vaultruby = new FlxSprite(282.9, 1122.7).loadGraphic(Paths.image('stages/vault_ruby'));
		add(vaultruby);

		vaultglow = new FlxSprite(148, 1611).loadGraphic(Paths.image('stages/vault_glow'));
		add(vaultglow);

		void = new FlxSprite(-303, 761).loadGraphic(Paths.image('corrupted/corrupted', 'shared'));
		add(void);

		amogusbg = new FlxSprite(-448.7, 757.6).loadGraphic(Paths.image('amogus/bg'));
		add(amogusbg);

		amogusclouds = new FlxSprite(-321.2, 954).loadGraphic(Paths.image('amogus/clouds'));
		add(amogusclouds);

		amogusmg = new FlxSprite(-585.35, 1194).loadGraphic(Paths.image('amogus/mg'));
		add(amogusmg);

		amogusmg2 = new FlxSprite(-515.6, 1186).loadGraphic(Paths.image('amogus/mg2'));
		add(amogusmg2);

		amogusground = new FlxSprite(-637.15, 1615).loadGraphic(Paths.image('amogus/ground'));
		add(amogusground);

		var gradient:FlxSprite = new FlxSprite(-100).loadGraphic(Paths.image('menuGr'));
		gradient.scrollFactor.x = 0;
		gradient.scrollFactor.y = 0.10;
		gradient.setGraphicSize(Std.int(gradient.width * 1.1));
		gradient.updateHitbox();
		gradient.screenCenter();
		add(gradient);

		grpSongs = new FlxTypedGroup<SongFont>();
		add(grpSongs);

		for (i in 0...songs.length)
		{
			var songText:SongFont = new SongFont(0, (70 * i) + 30, songs[i].songName, true);
			songText.setFormat(Paths.font("amogus.ttf"), 90, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
			songText.antialiasing = true;
			songText.isMenuItem = true;
			songText.targetY = i;
			grpSongs.add(songText);

			Paths.currentModDirectory = songs[i].folder;
			var icon:HealthIcon = new HealthIcon(songs[i].songCharacter);
			icon.sprTracker = songText;

			// using a FlxGroup is too much fuss!
			iconArray.push(icon);
			add(icon);

			// songText.x += 40;
			// DONT PUT X IN THE FIRST PARAMETER OF new ALPHABET() !!
			// songText.screenCenter(X);
		}
		WeekData.setDirectoryFromWeek();

		scoreText = new FlxText(FlxG.width * 0.7, 5, 0, "", 32);
		scoreText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, RIGHT);

		var logo:FlxSprite = new FlxSprite(908, 480).loadGraphic(Paths.image('small_logo'));
		logo.alpha = 0.6;
	    add(logo);

		scoreBG = new FlxSprite(scoreText.x - 6, 0).makeGraphic(1, 66, 0xFF000000);
		scoreBG.alpha = 0.6;

		diffText = new FlxText(scoreText.x, scoreText.y + 36, 0, "", 24);
		diffText.font = scoreText.font;

		add(scoreText);

		if(curSelected >= songs.length) curSelected = 0;
		png.color = songs[curSelected].color;
		intendedColor = png.color;

		if(lastDifficultyName == '')
		{
			lastDifficultyName = CoolUtil.defaultDifficulty;
		}
		curDifficulty = Math.round(Math.max(0, CoolUtil.defaultDifficulties.indexOf(lastDifficultyName)));
		
		changeSelection();
		changeDiff();

		var swag:Alphabet = new Alphabet(1, 0, "swag");

		// JUST DOIN THIS SHIT FOR TESTING!!!
		/* 
			var md:String = Markdown.markdownToHtml(Assets.getText('CHANGELOG.md'));

			var texFel:TextField = new TextField();
			texFel.width = FlxG.width;
			texFel.height = FlxG.height;
			// texFel.
			texFel.htmlText = md;

			FlxG.stage.addChild(texFel);

			// scoreText.textField.htmlText = md;

			trace(md);
		 */

		var textBG:FlxSprite = new FlxSprite(0, FlxG.height - 26).makeGraphic(FlxG.width, 26, 0xFF000000);
		textBG.alpha = 0.6;
		add(textBG);

		#if PRELOAD_ALL
		var leText:String = "Press SPACE to listen to the Song / Press CTRL to open the Gameplay Changers Menu / Press RESET to Reset your Score and Accuracy.";
		var size:Int = 16;
		#else
		var leText:String = "Press CTRL to open the Gameplay Changers Menu / Press RESET to Reset your Score and Accuracy.";
		var size:Int = 18;
		#end
		var text:FlxText = new FlxText(textBG.x, textBG.y + 4, FlxG.width, leText, size);
		text.setFormat(Paths.font("vcr.ttf"), size, FlxColor.WHITE, RIGHT);
		text.scrollFactor.set();
		add(text);
		super.create();
	}

	override function closeSubState() {
		changeSelection(0, false);
		persistentUpdate = true;
		super.closeSubState();
	}

	public function addSong(songName:String, weekNum:Int, songCharacter:String, color:Int)
	{
		songs.push(new SongMetadata(songName, weekNum, songCharacter, color));
	}

	function weekIsLocked(name:String):Bool {
		var leWeek:WeekData = WeekData.weeksLoaded.get(name);
		return (!leWeek.startUnlocked && leWeek.weekBefore.length > 0 && (!StoryMenuState.weekCompleted.exists(leWeek.weekBefore) || !StoryMenuState.weekCompleted.get(leWeek.weekBefore)));
	}

	/*public function addWeek(songs:Array<String>, weekNum:Int, weekColor:Int, ?songCharacters:Array<String>)
	{
		if (songCharacters == null)
			songCharacters = ['bf'];

		var num:Int = 0;
		for (song in songs)
		{
			addSong(song, weekNum, songCharacters[num]);
			this.songs[this.songs.length-1].color = weekColor;

			if (songCharacters.length != 1)
				num++;
		}
	}*/

	var instPlaying:Int = -1;
	public static var vocals:FlxSound = null;
	var holdTime:Float = 0;
	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.7)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

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

		scoreText.text = 'Personal Score: ' + lerpScore;
		positionHighscore();

		var upP = controls.UI_UP_P;
		var downP = controls.UI_DOWN_P;
		var accepted = controls.ACCEPT;
		var space = FlxG.keys.justPressed.SPACE;
		var ctrl = FlxG.keys.justPressed.CONTROL;

		var shiftMult:Int = 1;
		if(FlxG.keys.pressed.SHIFT) shiftMult = 3;

		if(songs.length > 1)
		{
			if (upP)
			{
				changeSelection(-shiftMult);
				holdTime = 0;
			}
			if (downP)
			{
				changeSelection(shiftMult);
				holdTime = 0;
			}

			if(controls.UI_DOWN || controls.UI_UP)
			{
				var checkLastHold:Int = Math.floor((holdTime - 0.5) * 10);
				holdTime += elapsed;
				var checkNewHold:Int = Math.floor((holdTime - 0.5) * 10);

				if(holdTime > 0.5 && checkNewHold - checkLastHold > 0)
				{
					changeSelection((checkNewHold - checkLastHold) * (controls.UI_UP ? -shiftMult : shiftMult));
					changeDiff();
				}
			}

			if(FlxG.mouse.wheel != 0)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
				changeSelection(-shiftMult * FlxG.mouse.wheel, false);
			}
		}

		if (controls.UI_LEFT_P)
			changeDiff(-1);
		else if (controls.UI_RIGHT_P)
			changeDiff(1);
		else if (upP || downP) changeDiff();

		if (controls.BACK)
		{
			persistentUpdate = false;
			if(colorTween != null) {
				colorTween.cancel();
			}
			FlxG.sound.play(Paths.sound('cancelMenu'));
			MusicBeatState.switchState(new MainMenuState());
		}

		if(ctrl)
		{
			persistentUpdate = false;
			openSubState(new GameplayChangersSubstate());
		}
		else if(space)
		{
			if(instPlaying != curSelected)
			{
				#if PRELOAD_ALL
				destroyFreeplayVocals();
				FlxG.sound.music.volume = 0;
				Paths.currentModDirectory = songs[curSelected].folder;
				var poop:String = Highscore.formatSong(songs[curSelected].songName.toLowerCase(), curDifficulty);
				PlayState.SONG = Song.loadFromJson(poop, songs[curSelected].songName.toLowerCase());
				if (PlayState.SONG.needsVoices)
					vocals = new FlxSound().loadEmbedded(Paths.voices(PlayState.SONG.song));
				else
					vocals = new FlxSound();

				FlxG.sound.list.add(vocals);
				FlxG.sound.playMusic(Paths.inst(PlayState.SONG.song), 0.7);
				vocals.play();
				vocals.persist = true;
				vocals.looped = true;
				vocals.volume = 0.7;
				instPlaying = curSelected;
				#end
			}
		}

		else if (accepted)
		{
			persistentUpdate = false;
			var songLowercase:String = Paths.formatToSongPath(songs[curSelected].songName);
			var poop:String = Highscore.formatSong(songLowercase, curDifficulty);
			/*#if MODS_ALLOWED
			if(!sys.FileSystem.exists(Paths.modsJson(songLowercase + '/' + poop)) && !sys.FileSystem.exists(Paths.json(songLowercase + '/' + poop))) {
			#else
			if(!OpenFlAssets.exists(Paths.json(songLowercase + '/' + poop))) {
			#end
				poop = songLowercase;
				curDifficulty = 1;
				trace('Couldnt find file');
			}*/
			trace(poop);

			PlayState.SONG = Song.loadFromJson(poop, songLowercase);
			PlayState.isStoryMode = false;
			PlayState.storyDifficulty = curDifficulty;

			trace('CURRENT WEEK: ' + WeekData.getWeekFileName());
			if(colorTween != null) {
				colorTween.cancel();
			}
			
			if (FlxG.keys.pressed.SHIFT){
				LoadingState.loadAndSwitchState(new ChartingState());
			}else{
				LoadingState.loadAndSwitchState(new PlayState());
			}

			FlxG.sound.music.volume = 0;
					
			destroyFreeplayVocals();
		}
		else if(controls.RESET)
		{
			persistentUpdate = false;
			openSubState(new ResetScoreSubState(songs[curSelected].songName, curDifficulty, songs[curSelected].songCharacter));
			FlxG.sound.play(Paths.sound('scrollMenu'));
		}
		super.update(elapsed);
	}

	public static function destroyFreeplayVocals() {
		if(vocals != null) {
			vocals.stop();
			vocals.destroy();
		}
		vocals = null;
	}

	function changeDiff(change:Int = 0)
	{
		curDifficulty += change;

		if (curDifficulty < 0)
			curDifficulty = CoolUtil.difficulties.length-1;
		if (curDifficulty >= CoolUtil.difficulties.length)
			curDifficulty = 0;

		lastDifficultyName = CoolUtil.difficulties[curDifficulty];

		#if !switch
		intendedScore = Highscore.getScore(songs[curSelected].songName, curDifficulty);
		intendedRating = Highscore.getRating(songs[curSelected].songName, curDifficulty);
		#end

		PlayState.storyDifficulty = curDifficulty;
		diffText.text = '< ' + CoolUtil.difficultyString() + ' >';
		positionHighscore();
	}

	var commTween:FlxTween;
	var bg2Tween:FlxTween;
	var bushTween:FlxTween;
	var yardTween:FlxTween;
	var bushe1Tween:FlxTween;
	var bushe2Tween:FlxTween;
	var miraTween:FlxTween;
	var voidTween:FlxTween;

	function cancelTweens()
	{
		commTween.cancel();
		bg2Tween.cancel();
		bushTween.cancel();
		yardTween.cancel();
		bushe1Tween.cancel();
		bushe2Tween.cancel();
		miraTween.cancel();
        voidTween.cancel();
	}

	function changeSelection(change:Int = 0, playSound:Bool = true)
	{
		if(playSound) FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

		curSelected += change;

		if (curSelected < 0)
			curSelected = songs.length - 1;
		if (curSelected >= songs.length)
			curSelected = 0;
			
		var newColor:Int = songs[curSelected].color;
		if(newColor != intendedColor) {
			if(colorTween != null) {
				colorTween.cancel();
			}
			intendedColor = newColor;
			colorTween = FlxTween.color(png, 1, png.color, intendedColor, {
				onComplete: function(twn:FlxTween) {
					colorTween = null;
				}
			});
		}

		// selector.y = (70 * curSelected) + 30;

		#if !switch
		intendedScore = Highscore.getScore(songs[curSelected].songName, curDifficulty);
		intendedRating = Highscore.getRating(songs[curSelected].songName, curDifficulty);
		#end

		var bullShit:Int = 0;

		for (i in 0...iconArray.length)
		{
			iconArray[i].alpha = 0.6;
		}

		iconArray[curSelected].alpha = 1;

		for (item in grpSongs.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			// item.setGraphicSize(Std.int(item.width * 0.8));

			if (item.targetY == 0)
			{
				item.alpha = 1;
				// item.setGraphicSize(Std.int(item.width));
			}
		}
		
		Paths.currentModDirectory = songs[curSelected].folder;
		PlayState.storyWeek = songs[curSelected].week;

		CoolUtil.difficulties = CoolUtil.defaultDifficulties.copy();
		var diffStr:String = WeekData.getCurrentWeek().difficulties;
		if(diffStr != null) diffStr = diffStr.trim(); //Fuck you HTML5

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

		switch(songs[curSelected].week)
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
				voidTween = FlxTween.tween(void,{y: 761}, 0.8 ,{ease: FlxEase.expoIn});
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
				voidTween = FlxTween.tween(void,{y: 761}, 0.8 ,{ease: FlxEase.expoIn});
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
				voidTween = FlxTween.tween(void,{y: 761}, 0.8 ,{ease: FlxEase.expoIn});
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
				voidTween = FlxTween.tween(void,{y: -337}, 0.8 ,{ease: FlxEase.expoOut});
			}
		}
	}

	private function positionHighscore() {
		scoreText.x = FlxG.width - scoreText.width - 6;

		scoreBG.scale.x = FlxG.width - scoreText.x + 6;
		scoreBG.x = FlxG.width - (scoreBG.scale.x / 2);
		diffText.x = Std.int(scoreBG.x + (scoreBG.width / 2));
		diffText.x -= diffText.width / 2;
	}
}

class SongMetadata
{
	public var songName:String = "";
	public var week:Int = 0;
	public var songCharacter:String = "";
	public var color:Int = -7179779;
	public var folder:String = "";

	public function new(song:String, week:Int, songCharacter:String, color:Int)
	{
		this.songName = song;
		this.week = week;
		this.songCharacter = songCharacter;
		this.color = color;
		this.folder = Paths.currentModDirectory;
		if(this.folder == null) this.folder = '';
	}
}