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

using StringTools;

// week trio, dia
class HexDialogueBox extends FlxSpriteGroup
{
	// static inline final I = '[i]';

	public var box:FlxSprite;

    var background:FlxSprite;
	var curBg:String = '';

	// var bgMusic;
	// var curMus:String = '';

	var curCharacter:String = '';

	var dialogue:Alphabet;
	var dialogueList:Array<String> = [];

	// SECOND DIALOGUE FOR THE PIXEL SHIT INSTEAD???
	var swagDialogue:FlxTypeText;

	// var dropText:FlxText;

	public var finishThing:Void->Void;

    var nametagHE:FlxSprite;
    var nametagmyst:FlxSprite;
    var nametagBf:FlxSprite;
    var nametagGf:FlxSprite;
	// var portraitRightNobody:FlxSprite;

	var handSelect:FlxSprite;
	var bgFade:FlxSprite;
    var black:FlxSprite;

	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>)
	{
		super();

		// bgMusic = FlxG.sound.playMusic(Paths.music('silence'));
		// bgMusic.fadeIn(3, 0, 0.7);

        switch (PlayState.SONG.song.toLowerCase())
		{
			case 'dunk':
				FlxG.sound.playMusic(Paths.music('givinALittle'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.6);
		}

        black = new FlxSprite(-500,-500).makeGraphic(9000,9000,FlxColor.BLACK);
		black.scrollFactor.set();
        add(black);

		box = new FlxSprite(90, 438);
		box.frames = Paths.getSparrowAtlas('mods/starlight/cutscene/starlight', 'shared');
		box.animation.addByPrefix('normalOpen', 'open', 24, false);
		box.animation.addByPrefix('normal', 'normal', 24, false);
		// box.frames = Paths.getSparrowAtlas('speech_bubble_talking', 'shared');
		// box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
		// box.animation.addByPrefix('normal', 'speech bubble normal', 24, false);
		
        // box.y = FlxG.height * 0.64;

        this.dialogueList = dialogueList;

		background = new FlxSprite(0,0).loadGraphic(Paths.image('mods/starlight/cutscene/1'));
		background.antialiasing = true;		// this line probably isn't necessary though...
		background.setGraphicSize(Std.int(background.width * 0.67));
		background.screenCenter();
		background.visible = true;
		add(background);

		nametagHE = new FlxSprite(120, 325).loadGraphic(Paths.image('hex/hex_nametag'));	
		nametagHE.updateHitbox();
		nametagHE.scrollFactor.set();
		add(nametagHE);
		nametagHE.visible = false;

		nametagmyst = new FlxSprite(120, 325).loadGraphic(Paths.image('hex/question_nametag'));	
		nametagmyst.updateHitbox();
		nametagmyst.scrollFactor.set();
		add(nametagmyst);
		nametagmyst.visible = false;

		nametagBf = new FlxSprite(840, 325).loadGraphic(Paths.image('hex/bf_nametag'));
		nametagBf.updateHitbox();
		nametagBf.scrollFactor.set();
		add(nametagBf);//120, 325
		nametagBf.visible = false;

		nametagGf = new FlxSprite(840, 325).loadGraphic(Paths.image('mods/starlight/cutscene/gf_nametag'));	
		nametagGf.updateHitbox();
		nametagGf.scrollFactor.set();
		add(nametagGf);
		nametagGf.visible = false;
				
		box.animation.play('normalOpen');
		box.updateHitbox();
		add(box);
			
		handSelect = new FlxSprite(FlxG.width * 0.88, FlxG.height * 0.9).loadGraphic(Paths.image('weeb/pixelUI/hand_textbox'));
		add(handSelect);

		/*dropText = new FlxText(242, 502, Std.int(FlxG.width * 0.6), "", 32);
		dropText.font = 'Candara';
		dropText.bold = true;
		dropText.color = 0xFFD89494;
		add(dropText);*/

		swagDialogue = new FlxTypeText(240, 497, Std.int(FlxG.width * 0.6), "", 44);
		swagDialogue.font = 'Candara';
		swagDialogue.bold = true;
		swagDialogue.color = 0xFF3F2021;
		swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
		add(swagDialogue);

		dialogue = new Alphabet(0, 80, "", false, true);

        nametagHE.visible = false;
        nametagmyst.visible = false;
        nametagBf.visible = false;
        nametagGf.visible = false;

		// dropText.y -= 15;
		// swagDialogue.y -= 15;
	}

	var dialogueOpened:Bool = false;
	var dialogueStarted:Bool = false;

	override function update(elapsed:Float)
	{
		// dropText.text = swagDialogue.text;

		if (box.animation.curAnim != null)
		{
			if (box.animation.curAnim.name == 'normalOpen' && box.animation.curAnim.finished)
			{
				box.animation.play('normal');
				dialogueOpened = true;
			}
		}

		if (dialogueOpened && !dialogueStarted)
		{
			startDialogue();
			dialogueStarted = true;
		}

		#if mobile
		var justTouched:Bool = false;

		for (touch in FlxG.touches.list)
		{
			justTouched = false;
			
			if (touch.justReleased){
				justTouched = true;
			}
		}
		#end

		if (curCharacter == 'BGCHANGE' && dialogueStarted == true)
		{
			dialogueList.remove(dialogueList[0]);
			startDialogue();
		}

		/*if (cutEl == true && dialogueStarted == true)
		{
			dialogueList.remove(dialogueList[0]);
			startDialogue();
		}*/
		
		if (FlxG.keys.justPressed.ANY #if mobile || justTouched #end && dialogueStarted == true)
		{
			remove(dialogue);
				
			FlxG.sound.play(Paths.sound('clickText'), 0.8);

			if (dialogueList[1] == null && dialogueList[0] != null)
			{
				if (!isEnding)
				{
					isEnding = true;

					FlxG.sound.music.fadeOut(2.2, 0);

					new FlxTimer().start(0.2, function(tmr:FlxTimer)
					{
						box.alpha -= 1 / 5;
						background.alpha -= 1 / 5;
						black.alpha -= 1 / 5;
        				nametagHE.visible = false;
        				nametagmyst.visible = false;
        				nametagBf.visible = false;
        				nametagGf.visible = false;
						swagDialogue.alpha -= 1 / 5;
						// dropText.alpha = swagDialogue.alpha;
					}, 5);

					new FlxTimer().start(1.2, function(tmr:FlxTimer)
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

	var isEnding:Bool = false;

	// var cutEl = false;

	function startDialogue():Void
	{
		cleanDialog();
		
		// background = loadGraphic(Paths.image('maginage/cutscene/$curBg'));

		// var theDialog:Alphabet = new Alphabet(0, 70, dialogueList[0], false, true);
		// dialogue = theDialog;
		// add(theDialog);

		// swagDialogue.text = ;
		swagDialogue.resetText(dialogueList[0]);
		swagDialogue.start(0.04, true);

		if (!box.visible)
		{
			box.visible = true;
		}

		switch (curCharacter)
		{
            case 'hex':
				nametagHE.visible = false;
                nametagmyst.visible = false;
                nametagBf.visible = false;
                nametagGf.visible = false;
				if (!nametagHE.visible)
				{
					nametagHE.visible = true;
					nametagHE.animation.play('enter');
					nametagHE.setGraphicSize(Std.int(nametagHE.width * 0.8));
				}
            case 'myst':
                nametagHE.visible = false;
                nametagBf.visible = false;
                nametagGf.visible = false;
				nametagCarol.visible = false;
				if (!nametagmyst.visible)
				{
					nametagmyst.visible = true;
					nametagmyst.animation.play('enter');
					nametagmyst.setGraphicSize(Std.int(nametagmyst.width * 0.8));
				}
			case 'bf':
                nametagHE.visible = false;
                nametagmyst.visible = false;
                nametagGf.visible = false;
				if (!nametagBf.visible)
				{
					nametagBf.visible = true;
					nametagBf.animation.play('enter');
                    nametagBf.setGraphicSize(Std.int(nametagBf.width * 0.8));
				}
            case 'gf':
                nametagHE.visible = false;
                nametagmyst.visible = false;
                nametagBf.visible = false;
				if (!nametagGf.visible)
				{
					nametagGf.visible = true;
					nametagGf.animation.play('enter');
					nametagGf.setGraphicSize(Std.int(nametagGf.width * 0.8));
				}
			case 'na'://NO NAMETAG
				nametagTac.visible = false;
                nametagHE.visible = false;
                nametagmyst.visible = false;
				nametagBf.visible = false;
                nametagGf.visible = false;
				nametagCarol.visible = false;
			case 'nb'://NOBODY LOL
				box.visible = false;
				nametagTac.visible = false;
                nametagHE.visible = false;
                nametagmyst.visible = false;
				nametagBf.visible = false;
                nametagGf.visible = false;
				nametagCarol.visible = false;
			case 'BGCHANGE':			// leads to maginage/cutscene/BLANK.png
				remove(background);
				background.loadGraphic(Paths.image('mods/starlight/cutscene/$curBg'));
				background.setGraphicSize(FlxG.width);
				background.screenCenter();
				add(background);
			/*
			case 'BGAnim':
				remove(background);
				background.frames = Paths.getSparrowAtlas('$curBg');
				animation.addByPrefix('animatedCutscene', '$curBg', 24, false);
				add(background);

				background.animation.play('animatedCutscene');
			
			case 'BGMUSIC':			// leads to shared/music/BLANK.ogg
				cutEl = true;
				bgMusic.fadeOut(3, 0, 0.7);
				bgMusic.stop();
				if (!bgMusic.play())
				{
					bgMusic.play(Paths.music('$curMus'));
					bgMusic.fadeIn(3, 0, 0.7);
				}
			case 'BGMpause':
				cutEl = true;
				bgMusic.fadeOut(3, 0, 0.7);
				bgMusic.pause();
			case 'BGMplay':
				cutEl = true;
				bgMusic.resume();
				bgMusic.fadeIn(3, 0, 0.7);

			case 'SOUND':
					FlxG.sound.play(Paths.sound('$curSnd'));
			*/
		}
	}
	
	// var splitData:Array<String>;

	function cleanDialog():Void
	{
		var splitData:Array<String> = dialogueList[0].split(":");
		curCharacter = splitData[1];
		dialogueList[0] = dialogueList[0].substr(splitData[1].length + 2).trim();
		
		curBg = dialogueList[0];
	}
}
