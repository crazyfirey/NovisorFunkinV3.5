package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxKeyManager;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;

using StringTools;

class DialogueBox extends FlxSpriteGroup
{
	var box:FlxSprite;

	var curCharacter:String = '';

	var dialogue:Alphabet;
	var dialogueList:Array<String> = [];

	// SECOND DIALOGUE FOR THE PIXEL SHIT INSTEAD???
	var swagDialogue:FlxTypeText;

	var dropText:FlxText;

	public var finishThing:Void->Void;
	public var nextDialogueThing:Void->Void = null;
	public var skipDialogueThing:Void->Void = null;

    var prevSide:Bool;
	var curSide:Bool;
	var emotion:String = '';

	var leftTween:FlxTween;
	var rightTween:FlxTween;

    var rightState:String = 'normal';
	var leftState:String = 'normal';

	var portraitLeft:FlxSprite;
	var portraitRight:FlxSprite;

	var handSelect:FlxSprite;
	var bgFade:FlxSprite;

	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>)
	{
		super();

		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				FlxG.sound.playMusic(Paths.music('Lunchbox'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'thorns':
				FlxG.sound.playMusic(Paths.music('LunchboxScary'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
		}

		bgFade = new FlxSprite(-200, -200).makeGraphic(Std.int(FlxG.width * 1.3), Std.int(FlxG.height * 1.3), 0xFFB3DFd8);
		bgFade.scrollFactor.set();
		bgFade.alpha = 0;
		add(bgFade);

		new FlxTimer().start(0.83, function(tmr:FlxTimer)
		{
			bgFade.alpha += (1 / 5) * 0.7;
			if (bgFade.alpha > 0.7)
				bgFade.alpha = 0.7;
		}, 5);

		box = new FlxSprite(39, 339).loadGraphic(Paths.image('dialogue/diabox', 'shared'));
		
		var hasDialog = false;
		hasDialog = true;

		this.dialogueList = dialogueList;
		
		if (!hasDialog)
			return;
		
		portraitLeft = new FlxSprite(0, 50);
		portraitLeft.frames = Paths.getSparrowAtlas('dialogue/LeftCharacters', 'shared');

        portraitLeft.animation.addByPrefix('p-normal-talking', 'Player Normal', 24, true);
		portraitLeft.animation.addByPrefix('p-excited-talking', 'Player Excited', 24, true);
		portraitLeft.animation.addByPrefix('p-confused-talking', 'Player Confused', 24, true);
	    portraitLeft.animation.addByPrefix('p-scared-talking', 'Player Shocked', 24, true);
		portraitLeft.animation.addByPrefix('p-pissed-talking', 'Player Pissed', 24, true);

		portraitLeft.animation.addByPrefix('v-normal-talking', 'Veteran Normal', 24, true);
		portraitLeft.animation.addByPrefix('v-excited-talking', 'Veteran Excited', 24, true);
		portraitLeft.animation.addByPrefix('v-confused-talking', 'Veteran Confused', 24, true);
	    portraitLeft.animation.addByPrefix('v-scared-talking', 'Veteran Shocked', 24, true);
		portraitLeft.animation.addByPrefix('v-pissed-talking', 'Veteran Pissed', 24, true);

		portraitLeft.animation.addByPrefix('pav-normal-talking', 'PlayerandVeteran Normal', 24, true);
		portraitLeft.animation.addByPrefix('pav-excited-talking', 'PlayerandVeteran Excited', 24, true);
		portraitLeft.animation.addByPrefix('pav-confused-talking', 'PlayerandVeteran Confused', 24, true);
	    portraitLeft.animation.addByPrefix('pav-scared-talking', 'PlayerandVeteran Shocked', 24, true);
		portraitLeft.animation.addByPrefix('pav-pissed-talking', 'PlayerandVeteran Pissed', 24, true);

		portraitLeft.animation.addByPrefix('a-normal-talking', 'Aiden Normal', 24, true);
		portraitLeft.animation.addByPrefix('a-excited-talking', 'Aiden Excited', 24, true);
		portraitLeft.animation.addByPrefix('a-confused-talking', 'Aiden Confused', 24, true);
	    portraitLeft.animation.addByPrefix('a-scared-talking', 'Aiden Shocked', 24, true);
		portraitLeft.animation.addByPrefix('a-pissed-talking', 'Aiden Pissed', 24, true);
		
		portraitLeft.animation.addByPrefix('d-normal-talking', 'Duncan Normal', 24, true);
		portraitLeft.animation.addByPrefix('d-excited-talking', 'Duncan Excited', 24, true);
		portraitLeft.animation.addByPrefix('d-confused-talking', 'Duncan Confused', 24, true);
	    portraitLeft.animation.addByPrefix('d-scared-talking', 'Duncan Shocked', 24, true);
		portraitLeft.animation.addByPrefix('d-pissed-talking', 'Duncan Pissed', 24, true);

		portraitLeft.animation.addByPrefix('r-normal-talking', 'Ria Normal', 24, true);
		portraitLeft.animation.addByPrefix('r-excited-talking', 'Ria Excited', 24, true);
		portraitLeft.animation.addByPrefix('r-confused-talking', 'Ria Confused', 24, true);

		portraitLeft.animation.addByPrefix('e-normal-talking', 'MrEgg Normal', 24, true);
		portraitLeft.animation.addByPrefix('e-excited-talking', 'MrEgg Excited', 24, true);
	    portraitLeft.animation.addByPrefix('e-scared-talking', 'MrEgg Shocked', 24, true);
		portraitLeft.animation.addByPrefix('e-pissed-talking', 'MrEgg Pissed', 24, true);

		portraitLeft.animation.addByPrefix('g-normal-talking', 'Gentleman Normal', 24, true);
		portraitLeft.animation.addByPrefix('g-excited-talking', 'Gentleman Excited', 24, true);
		portraitLeft.animation.addByPrefix('g-pissed-talking', 'Gentleman Pissed', 24, true);

		portraitLeft.animation.addByIndices('p-normal', 'Player Normal', [5], "", 24, true);
		portraitLeft.animation.addByIndices('p-excited', 'Player Excited', [5], "", 24, true);
		portraitLeft.animation.addByIndices('p-confused', 'Player Confused', [5], "", 24, true);
	    portraitLeft.animation.addByIndices('p-scared', 'Player Shocked', [5], "", 24, true);
		portraitLeft.animation.addByIndices('p-pissed', 'Player Pissed', [5], "", 24, true);

		portraitLeft.animation.addByIndices('v-normal', 'Veteran Normal', [5], "", 24, true);
		portraitLeft.animation.addByIndices('v-excited', 'Veteran Excited', [5], "", 24, true);
		portraitLeft.animation.addByIndices('v-confused', 'Veteran Confused', [5], "", 24, true);
	    portraitLeft.animation.addByIndices('v-scared', 'Veteran Shocked', [5], "", 24, true);
		portraitLeft.animation.addByIndices('v-pissed', 'Veteran Pissed', [5], "", 24, true);

		portraitLeft.animation.addByIndices('pav-normal', 'PlayerandVeteran Normal', [5], "", 24, true);
		portraitLeft.animation.addByIndices('pav-excited', 'PlayerandVeteran Excited', [5], "", 24, true);
		portraitLeft.animation.addByIndices('pav-confused', 'PlayerandVeteran Confused', [5], "", 24, true);
	    portraitLeft.animation.addByIndices('pav-scared', 'PlayerandVeteran Shocked', [1], "", 24, true);
		portraitLeft.animation.addByIndices('pav-pissed', 'PlayerandVeteran Pissed', [5], "", 24, true);

		portraitLeft.animation.addByIndices('a-normal', 'Aiden Normal', [3], "", 24, true);
		portraitLeft.animation.addByIndices('a-excited', 'Aiden Excited', [3], "", 24, true);
		portraitLeft.animation.addByIndices('a-confused', 'Aiden Confused', [3], "", 24, true);
	    portraitLeft.animation.addByIndices('a-scared', 'Aiden Shocked', [3], "", 24, true);
		portraitLeft.animation.addByIndices('a-pissed', 'Aiden Pissed', [3], "", 24, true);

		portraitLeft.animation.addByIndices('d-normal', 'Duncan Normal', [1], "", 24, true);
		portraitLeft.animation.addByIndices('d-excited', 'Duncan Excited', [1], "", 24, true);
		portraitLeft.animation.addByIndices('d-confused', 'Duncan Confused', [1], "", 24, true);
	    portraitLeft.animation.addByIndices('d-scared', 'Duncan Shocked', [1], "", 24, true);
		portraitLeft.animation.addByIndices('d-pissed', 'Duncan Pissed', [1], "", 24, true);

		portraitLeft.animation.addByIndices('r-normal', 'Ria Normal', [3], "", 24, true);
		portraitLeft.animation.addByIndices('r-excited', 'Ria Excited', [3], "", 24, true);
		portraitLeft.animation.addByIndices('r-confused', 'Ria Confused', [3], "", 24, true);

		portraitLeft.animation.addByIndices('e-normal', 'MrEgg Normal', [1], "", 24, true);
		portraitLeft.animation.addByIndices('e-excited', 'MrEgg Excited', [1], "", 24, true);
	    portraitLeft.animation.addByIndices('e-scared', 'MrEgg Shocked', [1], "", 24, true);
		portraitLeft.animation.addByIndices('e-pissed', 'MrEgg Pissed', [1], "", 24, true);

		portraitLeft.animation.addByIndices('g-normal', 'Gentleman Normal', [1], "", 24, true);
		portraitLeft.animation.addByIndices('g-excited', 'Gentleman Excited', [1], "", 24, true);
		portraitLeft.animation.addByIndices('g-pissed', 'Gentleman Pissed', [1], "", 24, true);

		portraitLeft.animation.play('normal');
		add(portraitLeft);
		portraitLeft.alpha = 0;

		portraitRight = new FlxSprite(200, 50);
		portraitRight.frames = Paths.getSparrowAtlas('dialogue/RightCharacters', 'shared');

        portraitRight.animation.addByPrefix('b-normal-talking', 'Boyfriend Normal', 24, true);
		portraitRight.animation.addByPrefix('b-excited-talking', 'Boyfriend Excited', 24, true);
	    portraitRight.animation.addByPrefix('b-confused-talking', 'Boyfriend Confused', 24, true);
	    portraitRight.animation.addByPrefix('b-scared-talking', 'Boyfriend Shocked', 24, true);
		portraitRight.animation.addByPrefix('b-pissed-talking', 'Boyfriend Pissed', 24, true);

		portraitRight.animation.addByPrefix('pr-normal-talking', 'PlayerRight Normal', 24, true);
		portraitRight.animation.addByPrefix('pr-excited-talking', 'PlayerRight Excited', 24, true);
	    portraitRight.animation.addByPrefix('pr-confused-talking', 'PlayerRight Confuse', 24, true);
	    portraitRight.animation.addByPrefix('pr-scared-talking', 'PlayerRight Shocked', 24, true);
		portraitRight.animation.addByPrefix('pr-pissed-talking', 'PlayerRight Pissed', 24, true);

		portraitRight.animation.addByPrefix('dr-normal-talking', 'DuncanRight Normal', 24, true);
		portraitRight.animation.addByPrefix('dr-excited-talking', 'DuncanRight Excited', 24, true);
	    portraitRight.animation.addByPrefix('dr-confused-talking', 'DuncanRight Confuse', 24, true);
	    portraitRight.animation.addByPrefix('dr-scared-talking', 'DuncanRight Shocked', 24, true);
		portraitRight.animation.addByPrefix('dr-pissed-talking', 'DuncanRight Pissed', 24, true);

	    portraitRight.animation.addByPrefix('pab-normal-talking', 'PlayerandBF Normal', 24, true);

        portraitRight.animation.addByIndices('b-normal', 'Boyfriend Normal', [5], "", 24, true);
		portraitRight.animation.addByIndices('b-excited', 'Boyfriend Excited', [5], "", 24, true);
	    portraitRight.animation.addByIndices('b-confused', 'Boyfriend Confused', [5], "", 24, true);
	    portraitRight.animation.addByIndices('b-scared', 'Boyfriend Shocked', [5], "", 24, true);
		portraitRight.animation.addByIndices('b-pissed', 'Boyfriend Pissed', [5], "", 24, true);

		portraitRight.animation.addByIndices('pr-normal', 'PlayerRight Normal', [5], "", 24, true);
		portraitRight.animation.addByIndices('pr-excited', 'PlayerRight Excited', [5], "", 24, true);
	    portraitRight.animation.addByIndices('pr-confused', 'PlayerRight Confuse', [5], "", 24, true);
	    portraitRight.animation.addByIndices('pr-scared', 'PlayerRight Shocked', [5], "", 24, true);
		portraitRight.animation.addByIndices('pr-pissed', 'PlayerRight Pissed', [5], "", 24, true);

	    portraitRight.animation.addByIndices('pab-normal', 'PlayerandBF Normal', [5], "", 24, true);

		portraitRight.animation.addByIndices('dr-normal', 'DuncanRight Normal', [1], "", 24, true);
		portraitRight.animation.addByIndices('dr-excited', 'DuncanRight Excited', [1], "", 24, true);
	    portraitRight.animation.addByIndices('dr-confused', 'DuncanRight Confuse', [1], "", 24, true);
	    portraitRight.animation.addByIndices('dr-scared', 'DuncanRight Shocked', [1], "", 24, true);
		portraitRight.animation.addByIndices('dr-pissed', 'DuncanRight Pissed', [1], "", 24, true);
		
		portraitRight.animation.play('normal');
		add(portraitRight);
		portraitRight.alpha = 0;

		box.screenCenter(X);
		add(box);

		handSelect = new FlxSprite(1042, 590).loadGraphic(Paths.image('weeb/pixelUI/hand_textbox'));
		handSelect.setGraphicSize(Std.int(handSelect.width * PlayState.daPixelZoom * 0.9));
		handSelect.updateHitbox();
		handSelect.visible = false;

		if(talkingRight) {
			leftTween = FlxTween.tween(portraitLeft, {x: 50 + 30, alpha: 1}, 0.3, {ease: FlxEase.quadOut});
			rightTween = FlxTween.tween(portraitRight, {x: 770 + 30, alpha: 0}, 0.3, {ease: FlxEase.quadOut});
		}
		else {
			leftTween = FlxTween.tween(portraitLeft, {x: 50 + 30, alpha: 1}, 0.3, {ease: FlxEase.quadOut});
			rightTween = FlxTween.tween(portraitRight, {x: 770 + 30, alpha: 0}, 0.3, {ease: FlxEase.quadOut});
		}

		dropText = new FlxText(100, 400, 1100, "", 40);
		dropText.font = 'Arial';
		dropText.color = FlxColor.WHITE;
		add(dropText);

		swagDialogue = new FlxTypeText(100, 400, 1100, "", 40);
		swagDialogue.font = 'Arial';
		swagDialogue.color = FlxColor.WHITE;
		swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
		add(swagDialogue);

		dialogue = new Alphabet(0, 80, "", false, true);
		// dialogue.x = 90;
		// add(dialogue);
	}

	var dialogueOpened:Bool = false;
	var dialogueStarted:Bool = false;
	var dialogueEnded:Bool = false;

		override function update(elapsed:Float)
	{
		if (!dialogueStarted)
		{
			startDialogue();
			dialogueStarted = true;
		}

		if (PlayerSettings.player1.controls.ACCEPT && dialogueStarted == true)
		{			
			FlxG.sound.play(Paths.sound('clickText'), 0.8);

			if (dialogueList[1] == null && dialogueList[0] != null)
			{
				if (!isEnding)
				{
					isEnding = true;

					FlxTween.tween(portraitRight, {alpha: 0}, 0.5);
					FlxTween.tween(portraitLeft, {alpha: 0}, 0.5);
					FlxTween.tween(box, {alpha: 0}, 0.5);
					FlxTween.tween(swagDialogue, {alpha: 0}, 0.5);
					FlxTween.tween(bgFade, {alpha: 0}, 0.5);

					new FlxTimer().start(0.7, function(tmr:FlxTimer)
					{
						finishThing();
						kill();
					});
				}
			}
			else
			{
				dialogueList.remove(dialogueList[0]);
				startDialogue();
			}
		}
		
		super.update(elapsed);
	}

	function endAnimation():Void {
		portraitRight.animation.play(curCharacter + "-" + emotion);
		portraitLeft.animation.play(curCharacter + "-" + emotion);
	}

	var isEnding:Bool = false;

	function startDialogue():Void
	{
		cleanDialog();

		// swagDialogue.text = ;
		swagDialogue.resetText(dialogueList[0]);
		swagDialogue.start(0.04, true, false, null);
		swagDialogue.completeCallback = endAnimation;
	}

	function cleanDialog():Void
	{
		var splitName:Array<String> = dialogueList[0].split(":");
		emotion = splitName[2];
		curCharacter = splitName[1];
		switch(curCharacter) {
			case 'b':
				portraitRight.animation.play(curCharacter + "-" + emotion + "-talking");
			    prevSide = curSide;
				curSide = true;
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('dialogue/bf', 'shared'), 0.6)];
			case 'p':
				portraitLeft.animation.play(curCharacter + "-" + emotion + "-talking");
			    prevSide = curSide;
				curSide = false;
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('dialogue/player', 'shared'), 0.6)];
			case 'v':
				portraitLeft.animation.play(curCharacter + "-" + emotion + "-talking");
			    prevSide = curSide;
				curSide = false;
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('dialogue/veteran', 'shared'), 0.6)];
			case 'pr':
				portraitRight.animation.play(curCharacter + "-" + emotion + "-talking");
			    prevSide = curSide;
				curSide = true;
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('dialogue/player', 'shared'), 0.6)];
			case 'pab':
				portraitRight.animation.play(curCharacter + "-" + emotion + "-talking");
			    prevSide = curSide;
				curSide = true;
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('dialogue/playerandbf', 'shared'), 0.6)];
			case 'pav':
				portraitLeft.animation.play(curCharacter + "-" + emotion + "-talking");
			    prevSide = curSide;
				curSide = false;
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('dialogue/playerandveteran', 'shared'), 0.6)];
			case 'a':
				portraitLeft.animation.play(curCharacter + "-" + emotion + "-talking");
			    prevSide = curSide;
				curSide = false;
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('dialogue/aiden', 'shared'), 0.6)];
			case 'd':
				portraitLeft.animation.play(curCharacter + "-" + emotion + "-talking");
			    prevSide = curSide;
				curSide = false;
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('dialogue/duncan', 'shared'), 0.6)];
			case 'dr':
				portraitRight.animation.play(curCharacter + "-" + emotion + "-talking");
			    prevSide = curSide;
				curSide = true;
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('dialogue/duncan', 'shared'), 0.6)];
			case 'r':
				portraitLeft.animation.play(curCharacter + "-" + emotion + "-talking");
			    prevSide = curSide;
				curSide = false;
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('dialogue/ria', 'shared'), 0.6)];
			case 'e':
				portraitLeft.animation.play(curCharacter + "-" + emotion + "-talking");
			    prevSide = curSide;
				curSide = false;
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('dialogue/mregg', 'shared'), 0.6)];
			case 'g':
				portraitLeft.animation.play(curCharacter + "-" + emotion + "-talking");
			    prevSide = curSide;
				curSide = false;
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('dialogue/gentleman', 'shared'), 0.6)];
		}

		if(curSide) {
			if(curSide != prevSide) {
				portraitRight.x = 770 + 30;
				portraitRight.alpha = 0;
				if(leftTween != null) {
					leftTween.cancel();
				}
				if(rightTween != null) {
					rightTween.cancel();
				}
				rightTween = FlxTween.tween(portraitRight, {x: 770 - 30, alpha: 1}, 0.3, {ease: FlxEase.quadOut});
				leftTween = FlxTween.tween(portraitLeft, {x: 50 - 30, alpha: 0}, 0.3, {ease: FlxEase.quadOut});
			}
		}
		else {
			if(curSide != prevSide) {
				portraitLeft.x = 50 - 30;
				portraitLeft.alpha = 0;
				if(leftTween != null) {
					leftTween.cancel();
				}
				if(rightTween != null) {
					rightTween.cancel();
				}
				leftTween = FlxTween.tween(portraitLeft, {x: 50 + 30, alpha: 1}, 0.3, {ease: FlxEase.quadOut});
				rightTween = FlxTween.tween(portraitRight, {x: 770 + 30, alpha: 0}, 0.3, {ease: FlxEase.quadOut});
			}
		}

		dialogueList[0] = dialogueList[0].substr(splitName[1].length + 3 + splitName[2].length).trim();
	}
}
