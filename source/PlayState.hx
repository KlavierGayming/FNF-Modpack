package;

import flixel.input.keyboard.FlxKey;
import haxe.Exception;
import openfl.geom.Matrix;
import openfl.display.BitmapData;
import openfl.utils.AssetType;
import lime.graphics.Image;
import flixel.graphics.FlxGraphic;
import openfl.utils.AssetManifest;
import openfl.utils.AssetLibrary;
import flixel.system.FlxAssets;
import NoteSplash;
import lime.app.Application;
import lime.media.AudioContext;
import lime.media.AudioManager;
import openfl.Lib;
import Section.SwagSection;
import Song.SwagSong;
import WiggleEffect.WiggleEffectType;
import flixel.FlxBasic;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxSubState;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.effects.FlxTrail;
import flixel.addons.effects.FlxTrailArea;
import flixel.addons.effects.chainable.FlxEffectSprite;
import flixel.addons.effects.chainable.FlxWaveEffect;
import flixel.addons.transition.FlxTransitionableState;
import flixel.graphics.atlas.FlxAtlas;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxBar;
import flixel.util.FlxCollision;
import flixel.util.FlxColor;
import flixel.util.FlxSort;
import flixel.util.FlxStringUtil;
import flixel.util.FlxTimer;
import haxe.Json;
import lime.utils.Assets;
import openfl.display.BlendMode;
import openfl.display.StageQuality;
import openfl.filters.ShaderFilter;

#if windows
import Discord.DiscordClient;
#end
#if windows
import Sys;
import sys.FileSystem;
#end

import ui.Mobilecontrols;

using StringTools;

class PlayState extends MusicBeatState
{
	public static var instance:PlayState = null;

	public static var curStage:String = '';
	public static var SONG:SwagSong;
	public static var isStoryMode:Bool = false;
	public static var isMod:Bool = false;
	public static var storyWeek:Int = 0;
	public static var storyPlaylist:Array<String> = [];
	public static var storyDifficulty:Int = 1;
	public static var weekSong:Int = 0;
	public static var shits:Int = 0;
	public static var bads:Int = 0;
	public static var goods:Int = 0;
	public static var sicks:Int = 0;

	public static var songPosBG:FlxSprite;
	public static var songPosBar:FlxBar;
	var grpNoteSplashes:FlxTypedGroup<NoteSplash>;
	var noteSplashOp:Bool = FlxG.save.data.noteSplash;
	private var SplashNote:NoteSplash;
	var hitsound:FlxSound;

	var tankmanRun:FlxTypedGroup<TankmenBG>;
		//tankbop shit
		var tankBop1:FlxSprite;
		var tankBop2:FlxSprite;
		var tankBop3:FlxSprite;
		var tankBop4:FlxSprite;
		var tankBop5:FlxSprite;
		var tankBop6:FlxSprite;
		//end of tankbop
		var tankWatchtower:FlxSprite;

	public static var rep:Replay;
	public static var loadRep:Bool = false;

	public static var noteBools:Array<Bool> = [false, false, false, false];

	var halloweenLevel:Bool = false;

	var songLength:Float = 0;
	var kadeEngineWatermark:FlxText;
	
	#if windows
	// Discord RPC variables
	var storyDifficultyText:String = "";
	var iconRPC:String = "";
	var detailsText:String = "";
	var detailsPausedText:String = "";
	#end

	private var vocals:FlxSound;

	public static var dad:Character;
	public static var gf:Character;
	public static var boyfriend:Boyfriend;
	public static var pc:Character;
	var max:Character;
	var cj:FlxSprite;
	var abel:Character;
	var normalStage:FlxTypedGroup<FlxSprite>;
	var headlights:FlxSprite;
	var frontbop:FlxSprite;

	public var notes:FlxTypedGroup<Note>;
	private var unspawnNotes:Array<Note> = [];

	public var strumLine:FlxSprite;
	private var curSection:Int = 0;

	private var camFollow:FlxObject;

	var daSong:String = "";

	private static var prevCamFollow:FlxObject;

	public static var strumLineNotes:FlxTypedGroup<FlxSprite> = null;
	public static var playerStrums:FlxTypedGroup<FlxSprite> = null;
	public static var cpuStrums:FlxTypedGroup<FlxSprite> = null;

	private var camZooming:Bool = false;
	private var curSong:String = "";

	private var gfSpeed:Int = 1;
	public var health:Float = 1; //making public because sethealth doesnt work without it
	private var combo:Int = 0;
	public static var misses:Int = 0;
	private var accuracy:Float = 0.00;
	private var accuracyDefault:Float = 0.00;
	private var totalNotesHit:Float = 0;
	private var totalNotesHitDefault:Float = 0;
	private var totalPlayed:Int = 0;
	private var ss:Bool = false;
	var shakeCam:Bool = false;

	var camPos:FlxPoint;


	private var healthBarBG:FlxSprite;
	private var healthBar:FlxBar;
	private var songPositionBar:Float = 0;
	
	private var generatedMusic:Bool = false;
	private var startingSong:Bool = false;

	public var iconP1:HealthIcon; //making these public again because i may be stupid
	public var iconP2:HealthIcon; //what could go wrong?
	public var camHUD:FlxCamera;
	private var camGame:FlxCamera;


	var IsNoteSpinning:Bool = false;
	var SpinAmount:Float = 0;
	var windowX:Float = Lib.application.window.x;
	var windowY:Float = Lib.application.window.y;

	public static var offsetTesting:Bool = false;

	var notesHitArray:Array<Date> = [];
	var currentFrames:Int = 0;

	public var dialogue:Array<String> = ['dad:blah blah blah', 'bf:coolswag'];

	var halloweenBG:FlxSprite;
	var isHalloween:Bool = false;

	var phillyCityLights:FlxTypedGroup<FlxSprite>;
	var theEntireFuckingStage:FlxTypedGroup<FlxSprite>;
	var phillyTrain:FlxSprite;
	var trainSound:FlxSound;

	var limo:FlxSprite;
	var grpLimoDancers:FlxTypedGroup<BackgroundDancer>;
	var fastCar:FlxSprite;
	var songName:FlxText;
	var upperBoppers:FlxSprite;
	var bottomBoppers:FlxSprite;
	var santa:FlxSprite;
	var daBob:FlxSprite;
	var mordecai:FlxSprite;
	var mini:FlxSprite;
	var uBg:FlxSprite;
	var wBg2:FlxSprite;

	var fc:Bool = true;

	var bgGirls:BackgroundGirls;
	var wiggleShit:WiggleEffect = new WiggleEffect();

	var talking:Bool = true;
	var songScore:Int = 0;
	var songScoreDef:Int = 0;
	var scoreTxt:FlxText;
	var replayTxt:FlxText;

	public static var campaignScore:Int = 0;

	var defaultCamZoom:Float = 1.05;

	public static var daPixelZoom:Float = 6;

	public static var theFunne:Bool = true;
	var funneEffect:FlxSprite;
	var inCutscene:Bool = false;
	public static var repPresses:Int = 0;
	public static var repReleases:Int = 0;
	var wBg:FlxSprite;
	var nwBg:FlxSprite;
	var wstageFront:FlxSprite;

	public static var timeCurrently:Float = 0;
	public static var timeCurrentlyR:Float = 0;
	
	// Will fire once to prevent debug spam messages and broken animations
	private var triggeredAlready:Bool = false;
	
	// Will decide if she's even allowed to headbang at all depending on the song
	private var allowedToHeadbang:Bool = false;
	// Per song additive offset
	public static var songOffset:Float = 0;
	// BotPlay text
	private var botPlayState:FlxText;
	// Replay shit
	private var saveNotes:Array<Float> = [];

	private var executeModchart = false;
	
	var littleGuys:FlxSprite;
	var curTime:Int = 0;

	// API stuff
	
	public function addObject(object:FlxBasic) { add(object); }
	public function removeObject(object:FlxBasic) { remove(object); }

	var mcontrols:Mobilecontrols;

	var picoStep:Ps;
	var tankStep:Ts;
	override public function create()
	{
		instance = this;
		daSong = SONG.song.toLowerCase();
		if (FlxG.save.data.botplay)
			FlxG.autoPause = false;
		else
			FlxG.autoPause = true;
		if (FlxG.save.data.hitsound != 'none')
			hitsound = new FlxSound().loadEmbedded(Paths.sound('hitsounds/' + FlxG.save.data.hitsound + '_hit'));
		else
			hitsound = new FlxSound();
		
		if (FlxG.save.data.fpsCap > 290)
			(cast (Lib.current.getChildAt(0), Main)).setFPSCap(800);
		
		if (FlxG.sound.music != null)
			FlxG.sound.music.stop();

		

		sicks = 0;
		bads = 0;
		shits = 0;
		goods = 0;

		misses = 0;

		repPresses = 0;
		repReleases = 0;

		// pre lowercasing the song name (create)
		var songLowercase = StringTools.replace(PlayState.SONG.song, " ", "-").toLowerCase();
			switch (songLowercase) {
				case 'dad-battle': songLowercase = 'dadbattle';
				case 'philly-nice': songLowercase = 'philly';
			}
		
		#if windows
		executeModchart = FileSystem.exists(Paths.lua(songLowercase  + "/modchart"));
		#end
		#if !cpp
		executeModchart = false; // FORCE disable for non cpp targets
		#end

		trace('Mod chart: ' + executeModchart + " - " + Paths.lua(songLowercase + "/modchart"));

		#if windows
		// Making difficulty text for Discord Rich Presence.
		switch (storyDifficulty)
		{
			case 0:
				storyDifficultyText = "Easy";
			case 1:
				storyDifficultyText = "Normal";
			case 2:
				storyDifficultyText = "Hard";
		}

		iconRPC = SONG.player2;

		// To avoid having duplicate images in Discord assets
		switch (iconRPC)
		{
			case 'senpai-angry':
				iconRPC = 'senpai';
			case 'monster-christmas':
				iconRPC = 'monster';
			case 'mom-car':
				iconRPC = 'mom';
		}

		// String that contains the mode defined here so it isn't necessary to call changePresence for each mode
		if (isStoryMode)
		{
			detailsText = "Story Mode: Week " + storyWeek;
		}
		else
		{
			detailsText = "Freeplay";
		}

		// String for when the game is paused
		detailsPausedText = "Paused - " + detailsText;

		// Updating Discord Rich Presence.
		DiscordClient.changePresence(detailsText + " " + SONG.song + " (" + storyDifficultyText + ") " + Ratings.GenerateLetterRank(accuracy), "\nAcc: " + HelperFunctions.truncateFloat(accuracy, 2) + "% | Score: " + songScore + " | Misses: " + misses  , iconRPC);
		#end


		// var gameCam:FlxCamera = FlxG.camera;
		camGame = new FlxCamera();
		camHUD = new FlxCamera();
		camHUD.bgColor.alpha = 0;

		FlxG.cameras.reset(camGame);
		FlxG.cameras.add(camHUD);

		FlxCamera.defaultCameras = [camGame];

		persistentUpdate = true;
		persistentDraw = true;
		grpNoteSplashes = new FlxTypedGroup<NoteSplash>();
		var sploosh = new NoteSplash(100, 100, 0);
		sploosh.alpha = 0.6;
		grpNoteSplashes.add(sploosh);

		if (SONG == null)
			SONG = Song.loadFromJson('tutorial');

		Conductor.mapBPMChanges(SONG);
		Conductor.changeBPM(SONG.bpm);

		trace('INFORMATION ABOUT WHAT U PLAYIN WIT:\nFRAMES: ' + Conductor.safeFrames + '\nZONE: ' + Conductor.safeZoneOffset + '\nTS: ' + Conductor.timeScale + '\nBotPlay : ' + FlxG.save.data.botplay);
	
		//dialogue shit
		switch (songLowercase)
		{
			case 'tutorial':
				dialogue = ["Hey you're pretty cute.", 'Use the arrow keys to keep up \nwith me singing.'];
			case 'bopeebo':
				dialogue = [
					'HEY!',
					"You think you can just sing\nwith my daughter like that?",
					"If you want to date her...",
					"You're going to have to go \nthrough ME first!"
				];
			case 'fresh':
				dialogue = ["Not too shabby boy.", ""];
			case 'dadbattle':
				dialogue = [
					"gah you think you're hot stuff?",
					"If you can beat me here...",
					"Only then I will even CONSIDER letting you\ndate my daughter!"
				];
			case 'senpai':
				dialogue = CoolUtil.coolTextFile(Paths.txt('senpai/senpaiDialogue'));
			case 'roses':
				dialogue = CoolUtil.coolTextFile(Paths.txt('roses/rosesDialogue'));
			case 'thorns':
				dialogue = CoolUtil.coolTextFile(Paths.txt('thorns/thornsDialogue'));
			case 'headache' | 'nerves' | 'release' | 'fading':
				dialogue = CoolUtil.coolTextFile(Paths.txt(daSong + "/" + daSong + "Dialogue"));
		}

		switch(SONG.stage)
		{
			case 'limbo': 
				{
					defaultCamZoom = 1.11;

				var bg:FlxSprite = new FlxSprite(-100).loadGraphic(Paths.image('mods/king/limbo/sky', 'shared'));
				bg.scrollFactor.set(0.1, 0.1);
				add(bg);

				var city:FlxSprite = new FlxSprite(-10).loadGraphic(Paths.image('mods/king/limbo/rockBG', 'shared'));
				city.scrollFactor.set(0.3, 0);
				city.setGraphicSize(Std.int(city.width * 0.85));
				city.updateHitbox();
				add(city);

				var streetBehind:FlxSprite = new FlxSprite(-40, 50).loadGraphic(Paths.image('mods/king/limbo/rockBETWEEN','shared'));
				add(streetBehind);

				var street:FlxSprite = new FlxSprite(-230, streetBehind.y).loadGraphic(Paths.image('mods/king/limbo/rockPLAYER','shared'));
				add(street);
		}
		case 'hell': 
				{
				defaultCamZoom = 1.11;

				var bg:FlxSprite = new FlxSprite(-100);
				bg.frames = Paths.getSparrowAtlas('mods/king/hell/hellsky', 'shared');
				bg.animation.addByPrefix("bgAnim", "hell", 8, true);
				bg.animation.play("bgAnim", true, false, -1);
				bg.scrollFactor.set(0.1, 0.1);
				add(bg);

				var city:FlxSprite = new FlxSprite(-10).loadGraphic(Paths.image('mods/king/hell/rockBG', 'shared'));
				city.scrollFactor.set(0.3, 0);
				city.setGraphicSize(Std.int(city.width * 0.85));
				city.updateHitbox();
				add(city);

				var streetBehind:FlxSprite = new FlxSprite(-40, 50).loadGraphic(Paths.image('mods/king/hell/rockBETWEEN','shared'));
				add(streetBehind);

				var street:FlxSprite = new FlxSprite(-230, streetBehind.y).loadGraphic(Paths.image('mods/king/hell/rockPLAYER','shared'));
				add(street);
				
		}
			case 'halloween': 
			{
				curStage = 'spooky';
				halloweenLevel = true;

				var hallowTex = Paths.getSparrowAtlas('halloween_bg','week2');

				halloweenBG = new FlxSprite(-200, -100);
				halloweenBG.frames = hallowTex;
				halloweenBG.animation.addByPrefix('idle', 'halloweem bg0');
				halloweenBG.animation.addByPrefix('lightning', 'halloweem bg lightning strike', 24, false);
				halloweenBG.animation.play('idle');
				halloweenBG.antialiasing = true;
				add(halloweenBG);

				isHalloween = true;
			}
			case 'philly': 
					{
					curStage = 'philly';

					var bg:FlxSprite = new FlxSprite(-100).loadGraphic(Paths.image('philly/sky', 'week3'));
					bg.scrollFactor.set(0.1, 0.1);
					add(bg);

					var city:FlxSprite = new FlxSprite(-10).loadGraphic(Paths.image('philly/city', 'week3'));
					city.scrollFactor.set(0.3, 0.3);
					city.setGraphicSize(Std.int(city.width * 0.85));
					city.updateHitbox();
					add(city);

					phillyCityLights = new FlxTypedGroup<FlxSprite>();
					if(FlxG.save.data.distractions){
						add(phillyCityLights);
					}

					for (i in 0...5)
					{
							var light:FlxSprite = new FlxSprite(city.x).loadGraphic(Paths.image('philly/win' + i, 'week3'));
							light.scrollFactor.set(0.3, 0.3);
							light.visible = false;
							light.setGraphicSize(Std.int(light.width * 0.85));
							light.updateHitbox();
							light.antialiasing = true;
							phillyCityLights.add(light);
					}

					var streetBehind:FlxSprite = new FlxSprite(-40, 50).loadGraphic(Paths.image('philly/behindTrain','week3'));
					add(streetBehind);

					phillyTrain = new FlxSprite(2000, 360).loadGraphic(Paths.image('philly/train','week3'));
					if(FlxG.save.data.distractions){
						add(phillyTrain);
					}

					trainSound = new FlxSound().loadEmbedded(Paths.sound('train_passes','week3'));
					FlxG.sound.list.add(trainSound);

					// var cityLights:FlxSprite = new FlxSprite().loadGraphic(AssetPaths.win0.png);

					var street:FlxSprite = new FlxSprite(-40, streetBehind.y).loadGraphic(Paths.image('philly/street','week3'));
					add(street);
			}
			case 'limo':
			{
					curStage = 'limo';
					defaultCamZoom = 0.90;

					var skyBG:FlxSprite = new FlxSprite(-120, -50).loadGraphic(Paths.image('limo/limoSunset','week4'));
					skyBG.scrollFactor.set(0.1, 0.1);
					add(skyBG);

					var bgLimo:FlxSprite = new FlxSprite(-200, 480);
					bgLimo.frames = Paths.getSparrowAtlas('limo/bgLimo','week4');
					bgLimo.animation.addByPrefix('drive', "background limo pink", 24);
					bgLimo.animation.play('drive');
					bgLimo.scrollFactor.set(0.4, 0.4);
					add(bgLimo);
					if(FlxG.save.data.distractions){
						grpLimoDancers = new FlxTypedGroup<BackgroundDancer>();
						add(grpLimoDancers);
	
						for (i in 0...5)
						{
								var dancer:BackgroundDancer = new BackgroundDancer((370 * i) + 130, bgLimo.y - 400);
								dancer.scrollFactor.set(0.4, 0.4);
								grpLimoDancers.add(dancer);
						}
					}

					var overlayShit:FlxSprite = new FlxSprite(-500, -600).loadGraphic(Paths.image('limo/limoOverlay','week4'));
					overlayShit.alpha = 0.5;
					// add(overlayShit);

					// var shaderBullshit = new BlendModeEffect(new OverlayShader(), FlxColor.RED);

					// FlxG.camera.setFilters([new ShaderFilter(cast shaderBullshit.shader)]);

					// overlayShit.shader = shaderBullshit;

					var limoTex = Paths.getSparrowAtlas('limo/limoDrive','week4');

					limo = new FlxSprite(-120, 550);
					limo.frames = limoTex;
					limo.animation.addByPrefix('drive', "Limo stage", 24);
					limo.animation.play('drive');
					limo.antialiasing = true;

					fastCar = new FlxSprite(-300, 160).loadGraphic(Paths.image('limo/fastCarLol','week4'));
					// add(limo);
			}
			case 'mall':
			{
					curStage = 'mall';

					defaultCamZoom = 0.80;

					var bg:FlxSprite = new FlxSprite(-1000, -500).loadGraphic(Paths.image('christmas/bgWalls','week5'));
					bg.antialiasing = true;
					bg.scrollFactor.set(0.2, 0.2);
					bg.active = false;
					bg.setGraphicSize(Std.int(bg.width * 0.8));
					bg.updateHitbox();
					add(bg);

					upperBoppers = new FlxSprite(-240, -90);
					upperBoppers.frames = Paths.getSparrowAtlas('christmas/upperBop','week5');
					upperBoppers.animation.addByPrefix('bop', "Upper Crowd Bob", 24, false);
					upperBoppers.antialiasing = true;
					upperBoppers.scrollFactor.set(0.33, 0.33);
					upperBoppers.setGraphicSize(Std.int(upperBoppers.width * 0.85));
					upperBoppers.updateHitbox();
					if(FlxG.save.data.distractions){
						add(upperBoppers);
					}


					var bgEscalator:FlxSprite = new FlxSprite(-1100, -600).loadGraphic(Paths.image('christmas/bgEscalator','week5'));
					bgEscalator.antialiasing = true;
					bgEscalator.scrollFactor.set(0.3, 0.3);
					bgEscalator.active = false;
					bgEscalator.setGraphicSize(Std.int(bgEscalator.width * 0.9));
					bgEscalator.updateHitbox();
					add(bgEscalator);

					var tree:FlxSprite = new FlxSprite(370, -250).loadGraphic(Paths.image('christmas/christmasTree','week5'));
					tree.antialiasing = true;
					tree.scrollFactor.set(0.40, 0.40);
					add(tree);

					bottomBoppers = new FlxSprite(-300, 140);
					bottomBoppers.frames = Paths.getSparrowAtlas('christmas/bottomBop','week5');
					bottomBoppers.animation.addByPrefix('bop', 'Bottom Level Boppers', 24, false);
					bottomBoppers.antialiasing = true;
					bottomBoppers.scrollFactor.set(0.9, 0.9);
					bottomBoppers.setGraphicSize(Std.int(bottomBoppers.width * 1));
					bottomBoppers.updateHitbox();
					if(FlxG.save.data.distractions){
						add(bottomBoppers);
					}


					var fgSnow:FlxSprite = new FlxSprite(-600, 700).loadGraphic(Paths.image('christmas/fgSnow','week5'));
					fgSnow.active = false;
					fgSnow.antialiasing = true;
					add(fgSnow);

					santa = new FlxSprite(-840, 150);
					santa.frames = Paths.getSparrowAtlas('christmas/santa','week5');
					santa.animation.addByPrefix('idle', 'santa idle in fear', 24, false);
					santa.antialiasing = true;
					if(FlxG.save.data.distractions){
						add(santa);
					}
			}
			case 'mallEvil':
			{
					curStage = 'mallEvil';
					var bg:FlxSprite = new FlxSprite(-400, -500).loadGraphic(Paths.image('christmas/evilBG','week5'));
					bg.antialiasing = true;
					bg.scrollFactor.set(0.2, 0.2);
					bg.active = false;
					bg.setGraphicSize(Std.int(bg.width * 0.8));
					bg.updateHitbox();
					add(bg);

					var evilTree:FlxSprite = new FlxSprite(300, -300).loadGraphic(Paths.image('christmas/evilTree','week5'));
					evilTree.antialiasing = true;
					evilTree.scrollFactor.set(0.2, 0.2);
					add(evilTree);

					var evilSnow:FlxSprite = new FlxSprite(-200, 700).loadGraphic(Paths.image("christmas/evilSnow",'week5'));
						evilSnow.antialiasing = true;
					add(evilSnow);
					}
			case 'school':
			{
					curStage = 'school';

					// defaultCamZoom = 0.9;

					var bgSky = new FlxSprite().loadGraphic(Paths.image('weeb/weebSky','week6'));
					bgSky.scrollFactor.set(0.1, 0.1);
					add(bgSky);

					var repositionShit = -200;

					var bgSchool:FlxSprite = new FlxSprite(repositionShit, 0).loadGraphic(Paths.image('weeb/weebSchool','week6'));
					bgSchool.scrollFactor.set(0.6, 0.90);
					add(bgSchool);

					var bgStreet:FlxSprite = new FlxSprite(repositionShit).loadGraphic(Paths.image('weeb/weebStreet','week6'));
					bgStreet.scrollFactor.set(0.95, 0.95);
					add(bgStreet);

					var fgTrees:FlxSprite = new FlxSprite(repositionShit + 170, 130).loadGraphic(Paths.image('weeb/weebTreesBack','week6'));
					fgTrees.scrollFactor.set(0.9, 0.9);
					add(fgTrees);

					var bgTrees:FlxSprite = new FlxSprite(repositionShit - 380, -800);
					var treetex = Paths.getPackerAtlas('weeb/weebTrees','week6');
					bgTrees.frames = treetex;
					bgTrees.animation.add('treeLoop', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18], 12);
					bgTrees.animation.play('treeLoop');
					bgTrees.scrollFactor.set(0.85, 0.85);
					add(bgTrees);

					var treeLeaves:FlxSprite = new FlxSprite(repositionShit, -40);
					treeLeaves.frames = Paths.getSparrowAtlas('weeb/petals','week6');
					treeLeaves.animation.addByPrefix('leaves', 'PETALS ALL', 24, true);
					treeLeaves.animation.play('leaves');
					treeLeaves.scrollFactor.set(0.85, 0.85);
					add(treeLeaves);

					var widShit = Std.int(bgSky.width * 6);

					bgSky.setGraphicSize(widShit);
					bgSchool.setGraphicSize(widShit);
					bgStreet.setGraphicSize(widShit);
					bgTrees.setGraphicSize(Std.int(widShit * 1.4));
					fgTrees.setGraphicSize(Std.int(widShit * 0.8));
					treeLeaves.setGraphicSize(widShit);

					fgTrees.updateHitbox();
					bgSky.updateHitbox();
					bgSchool.updateHitbox();
					bgStreet.updateHitbox();
					bgTrees.updateHitbox();
					treeLeaves.updateHitbox();

					bgGirls = new BackgroundGirls(-100, 190);
					bgGirls.scrollFactor.set(0.9, 0.9);

					if (songLowercase == 'roses')
						{
							if(FlxG.save.data.distractions){
								bgGirls.getScared();
							}
						}

					bgGirls.setGraphicSize(Std.int(bgGirls.width * daPixelZoom));
					bgGirls.updateHitbox();
					if(FlxG.save.data.distractions){
						add(bgGirls);
					}
			}
			case 'schoolEvil':
			{
					curStage = 'schoolEvil';

					var waveEffectBG = new FlxWaveEffect(FlxWaveMode.ALL, 2, -1, 3, 2);
					var waveEffectFG = new FlxWaveEffect(FlxWaveMode.ALL, 2, -1, 5, 2);

					var posX = 400; // umm what-
					var posY = 200;

					var bg:FlxSprite = new FlxSprite(posX, posY);
					bg.frames = Paths.getSparrowAtlas('weeb/animatedEvilSchool','week6');
					bg.animation.addByPrefix('idle', 'background 2', 24);
					bg.animation.play('idle');
					bg.scrollFactor.set(0.8, 0.9);
					bg.scale.set(6, 6);
					add(bg);

					/* 
							var bg:FlxSprite = new FlxSprite(posX, posY).loadGraphic(Paths.image('weeb/evilSchoolBG'));
							bg.scale.set(6, 6);
							// bg.setGraphicSize(Std.int(bg.width * 6));
							// bg.updateHitbox();
							add(bg);
							var fg:FlxSprite = new FlxSprite(posX, posY).loadGraphic(Paths.image('weeb/evilSchoolFG'));
							fg.scale.set(6, 6);
							// fg.setGraphicSize(Std.int(fg.width * 6));
							// fg.updateHitbox();
							add(fg);
							wiggleShit.effectType = WiggleEffectType.DREAMY;
							wiggleShit.waveAmplitude = 0.01;
							wiggleShit.waveFrequency = 60;
							wiggleShit.waveSpeed = 0.8;
						*/

					// bg.shader = wiggleShit.shader;
					// fg.shader = wiggleShit.shader;

					/* 
								var waveSprite = new FlxEffectSprite(bg, [waveEffectBG]);
								var waveSpriteFG = new FlxEffectSprite(fg, [waveEffectFG]);
								// Using scale since setGraphicSize() doesnt work???
								waveSprite.scale.set(6, 6);
								waveSpriteFG.scale.set(6, 6);
								waveSprite.setPosition(posX, posY);
								waveSpriteFG.setPosition(posX, posY);
								waveSprite.scrollFactor.set(0.7, 0.8);
								waveSpriteFG.scrollFactor.set(0.9, 0.8);
								// waveSprite.setGraphicSize(Std.int(waveSprite.width * 6));
								// waveSprite.updateHitbox();
								// waveSpriteFG.setGraphicSize(Std.int(fg.width * 6));
								// waveSpriteFG.updateHitbox();
								add(waveSprite);
								add(waveSpriteFG);
						*/
			}
			case 'sabotage':
				{
					defaultCamZoom = 0.9;
					curStage = 'sabotage';
					var bg:FlxSprite = new FlxSprite(-200, -300).loadGraphic(Paths.image('mods/sus/polusSky','shared'));
					bg.setGraphicSize(Std.int(bg.width * 1.5));
					bg.antialiasing = true;
					bg.scrollFactor.set(0.5, 0.5);
					bg.active = false;
					add(bg);


					var rocks:FlxSprite = new FlxSprite(-800, -300).loadGraphic(Paths.image('mods/sus/polusrocks','shared'));
					rocks.setGraphicSize(Std.int(rocks.width * 1.5));
					rocks.updateHitbox();
					rocks.antialiasing = true;
					rocks.scrollFactor.set(0.6, 0.6);
					rocks.active = false;
					add(rocks);

				
					var rocks:FlxSprite = new FlxSprite(-450, -200).loadGraphic(Paths.image('mods/sus/polusWarehouse','shared'));
					rocks.setGraphicSize(Std.int(rocks.width * 1.5));
					rocks.updateHitbox();
					rocks.antialiasing = true;
					rocks.scrollFactor.set(0.9, 0.9);
					rocks.active = false;
					add(rocks);
					
					var rocks:FlxSprite = new FlxSprite(-1000, 0).loadGraphic(Paths.image('mods/sus/polusHills','shared'));
					rocks.setGraphicSize(Std.int(rocks.width * 1.5));
					rocks.updateHitbox();
					rocks.antialiasing = true;
					rocks.scrollFactor.set(0.9, 0.9);
					rocks.active = false;
					add(rocks);

					var stageFront:FlxSprite = new FlxSprite(-400, 450).loadGraphic(Paths.image('mods/sus/polusGround','shared'));
					stageFront.setGraphicSize(Std.int(stageFront.width * 1.5));
					stageFront.updateHitbox();
					stageFront.antialiasing = true;
					stageFront.scrollFactor.set(1, 1);
					stageFront.active = false;
					add(stageFront);


					var stageCurtains:FlxSprite = new FlxSprite(-500, -300).loadGraphic(Paths.image('mods/sus/stagecurtains','shared'));
					stageCurtains.setGraphicSize(Std.int(stageCurtains.width * 0.9));
					stageCurtains.updateHitbox();
					stageCurtains.antialiasing = true;
					stageCurtains.scrollFactor.set(1.3, 1.3);
					stageCurtains.active = false;


				}
			case 'meltdown':
				{
					defaultCamZoom = 0.9;
					curStage = 'meltdown';
					var bg:FlxSprite = new FlxSprite(-200, -300).loadGraphic(Paths.image('mods/sus/polusSky','shared'));
					bg.setGraphicSize(Std.int(bg.width * 1.5));
					bg.antialiasing = true;
					bg.scrollFactor.set(0.5, 0.5);
					bg.active = false;
					add(bg);


					var rocks:FlxSprite = new FlxSprite(-800, -300).loadGraphic(Paths.image('mods/sus/polusrocks','shared'));
					rocks.setGraphicSize(Std.int(rocks.width * 1.5));
					rocks.updateHitbox();
					rocks.antialiasing = true;
					rocks.scrollFactor.set(0.6, 0.6);
					rocks.active = false;
					add(rocks);

				
					var rocks:FlxSprite = new FlxSprite(-450, -200).loadGraphic(Paths.image('mods/sus/polusWarehouse','shared'));
					rocks.setGraphicSize(Std.int(rocks.width * 1.5));
					rocks.updateHitbox();
					rocks.antialiasing = true;
					rocks.scrollFactor.set(0.9, 0.9);
					rocks.active = false;
					add(rocks);
					
					var rocks:FlxSprite = new FlxSprite(-1000, 0).loadGraphic(Paths.image('mods/sus/polusHills','shared'));
					rocks.setGraphicSize(Std.int(rocks.width * 1.5));
					rocks.updateHitbox();
					rocks.antialiasing = true;
					rocks.scrollFactor.set(0.9, 0.9);
					rocks.active = false;
					add(rocks);

					var crowd:FlxSprite = new FlxSprite(0, 150).loadGraphic(Paths.image('mods/sus/crowd','shared'));
					crowd.setGraphicSize(Std.int(crowd.width * 1.5));
					crowd.updateHitbox();
					crowd.antialiasing = true;
					crowd.scrollFactor.set(0.9, 0.9);
					crowd.active = false;
					add(crowd);

					var stageFront:FlxSprite = new FlxSprite(-400, 450).loadGraphic(Paths.image('mods/sus/polusGround','shared'));
					stageFront.setGraphicSize(Std.int(stageFront.width * 1.5));
					stageFront.updateHitbox();
					stageFront.antialiasing = true;
					stageFront.scrollFactor.set(1, 1);
					stageFront.active = false;
					add(stageFront);


					var stageCurtains:FlxSprite = new FlxSprite(-500, -300).loadGraphic(Paths.image('mods/sus/stagecurtains','shared'));
					stageCurtains.setGraphicSize(Std.int(stageCurtains.width * 0.9));
					stageCurtains.updateHitbox();
					stageCurtains.antialiasing = true;
					stageCurtains.scrollFactor.set(1.3, 1.3);
					stageCurtains.active = false;
				}
			case 'stage':
				{
						defaultCamZoom = 0.9;
						curStage = 'stage';
						var bg:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('stageback'));
						bg.antialiasing = true;
						bg.scrollFactor.set(0.9, 0.9);
						bg.active = false;
						add(bg);
	
						var stageFront:FlxSprite = new FlxSprite(-650, 600).loadGraphic(Paths.image('stagefront'));
						stageFront.setGraphicSize(Std.int(stageFront.width * 1.1));
						stageFront.updateHitbox();
						stageFront.antialiasing = true;
						stageFront.scrollFactor.set(0.9, 0.9);
						stageFront.active = false;
						add(stageFront);
	
						var stageCurtains:FlxSprite = new FlxSprite(-500, -300).loadGraphic(Paths.image('stagecurtains'));
						stageCurtains.setGraphicSize(Std.int(stageCurtains.width * 0.9));
						stageCurtains.updateHitbox();
						stageCurtains.antialiasing = true;
						stageCurtains.scrollFactor.set(1.3, 1.3);
						stageCurtains.active = false;
	
						add(stageCurtains);
				}
				case 'day':
					{
							defaultCamZoom = 0.9;
							curStage = 'day';
							var bg1:FlxSprite = new FlxSprite(-970, -580).loadGraphic(Paths.image('mods/bobnbosip/day/BG1', 'shared'));
							bg1.antialiasing = true;
							bg1.scale.set(0.8, 0.8);
							bg1.scrollFactor.set(0.3, 0.3);
							bg1.active = false;
							add(bg1);
	
							var bg2:FlxSprite = new FlxSprite(-1240, -650).loadGraphic(Paths.image('mods/bobnbosip/day/BG2', 'shared'));
							bg2.antialiasing = true;
							bg2.scale.set(0.5, 0.5);
							bg2.scrollFactor.set(0.6, 0.6);
							bg2.active = false;
							add(bg2);
	
							mini = new FlxSprite(849, 189);
							mini.frames = Paths.getSparrowAtlas('mods/bobnbosip/day/mini','shared');
							mini.animation.addByPrefix('idle', 'mini', 24, false);
							mini.animation.play('idle');
							mini.scale.set(0.4, 0.4);
							mini.scrollFactor.set(0.6, 0.6);
							add(mini);
	
							mordecai = new FlxSprite(130, 160);
							mordecai.frames = Paths.getSparrowAtlas('mods/bobnbosip/day/bluskystv','shared');
							mordecai.animation.addByIndices('walk1', 'bluskystv', [29, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13] , '', 24, false);
							mordecai.animation.addByIndices('walk2', 'bluskystv', [14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28] , '', 24, false);
							mordecai.animation.play('walk1');
							mordecai.scale.set(0.4, 0.4);
							mordecai.scrollFactor.set(0.6, 0.6);
							add(mordecai);
	
							var bg3:FlxSprite = new FlxSprite(-630, -330).loadGraphic(Paths.image('mods/bobnbosip/day/BG3', 'shared'));
							bg3.antialiasing = true;
							bg3.scale.set(0.8, 0.8);
							bg3.active = false;
							add(bg3);
	
							
							
					}
				case 'sunset':
					{
						defaultCamZoom = 0.9;
						curStage = 'sunset';
						var bg1:FlxSprite = new FlxSprite(-970, -580).loadGraphic(Paths.image('mods/bobnbosip/sunset/BG1', 'shared'));
						bg1.antialiasing = true;
						bg1.scale.set(0.8, 0.8);
						bg1.scrollFactor.set(0.3, 0.3);
						bg1.active = false;
						add(bg1);
	
						var bg2:FlxSprite = new FlxSprite(-1240, -680).loadGraphic(Paths.image('mods/bobnbosip/sunset/BG2', 'shared'));
						bg2.antialiasing = true;
						bg2.scale.set(0.5, 0.5);
						bg2.scrollFactor.set(0.6, 0.6);
						bg2.active = false;
						add(bg2);
	
						mini = new FlxSprite(817, 190);
						mini.frames = Paths.getSparrowAtlas('mods/bobnbosip/sunset/femboy and edgy jigglypuff','shared');
						mini.animation.addByPrefix('idle', 'femboy', 24, false);
						mini.animation.play('idle');
						mini.scale.set(0.5, 0.5);
						mini.scrollFactor.set(0.6, 0.6);
						add(mini);
	
						mordecai = new FlxSprite(141, 103);
						mordecai.frames = Paths.getSparrowAtlas('mods/bobnbosip/sunset/jacob','shared');
						mordecai.animation.addByPrefix('idle', 'jacob', 24, false);
						mordecai.animation.play('idle');
						mordecai.scale.set(0.5, 0.5);
						mordecai.scrollFactor.set(0.6, 0.6);
						add(mordecai);
	
						var bg3:FlxSprite = new FlxSprite(-630, -330).loadGraphic(Paths.image('mods/bobnbosip/sunset/BG3', 'shared'));
						bg3.antialiasing = true;
						bg3.scale.set(0.8, 0.8);
						bg3.active = false;
						add(bg3);
							
					}
				case 'night':
					{
						defaultCamZoom = 0.9;
						curStage = 'night';
						theEntireFuckingStage = new FlxTypedGroup<FlxSprite>();
						add(theEntireFuckingStage);
	
						var bg1:FlxSprite = new FlxSprite(-970, -580).loadGraphic(Paths.image('mods/bobnbosip/night/BG1', 'shared'));
						bg1.antialiasing = true;
						bg1.scale.set(0.8, 0.8);
						bg1.scrollFactor.set(0.3, 0.3);
						bg1.active = false;
						theEntireFuckingStage.add(bg1);
	
						var bg2:FlxSprite = new FlxSprite(-1240, -650).loadGraphic(Paths.image('mods/bobnbosip/night/BG2', 'shared'));
						bg2.antialiasing = true;
						bg2.scale.set(0.5, 0.5);
						bg2.scrollFactor.set(0.6, 0.6);
						bg2.active = false;
						theEntireFuckingStage.add(bg2);
	
						mini = new FlxSprite(818, 189);
						mini.frames = Paths.getSparrowAtlas('mods/bobnbosip/night/bobsip','shared');
						mini.animation.addByPrefix('idle', 'bobsip', 24, false);
						mini.animation.play('idle');
						mini.scale.set(0.5, 0.5);
						mini.scrollFactor.set(0.6, 0.6);
						add(mini);
	
						var bg3:FlxSprite = new FlxSprite(-630, -330).loadGraphic(Paths.image('mods/bobnbosip/night/BG3', 'shared'));
						bg3.antialiasing = true;
						bg3.scale.set(0.8, 0.8);
						bg3.active = false;
						theEntireFuckingStage.add(bg3);
	
						var bg4:FlxSprite = new FlxSprite(-1390, -740).loadGraphic(Paths.image('mods/bobnbosip/night/BG4', 'shared'));
						bg4.antialiasing = true;
						bg4.scale.set(0.6, 0.6);
						bg4.active = false;
						theEntireFuckingStage.add(bg4);
	
						var bg5:FlxSprite = new FlxSprite(-34, 90);
						bg5.antialiasing = true;
						bg5.scale.set(1.4, 1.4);
						bg5.frames = Paths.getSparrowAtlas('mods/bobnbosip/night/pixelthing', 'shared');
						bg5.animation.addByPrefix('idle', 'pixelthing', 24);
						bg5.animation.play('idle');
						add(bg5);
	
						pc = new Character(115, 166, 'pc');
						pc.debugMode = true;
						pc.antialiasing = true;
						add(pc);
	
						
					}
			default:
			{
				switch (SONG.song.toLowerCase())
				{
					default:
					{
				    	defaultCamZoom = 0.9;
						curStage = 'stage';
						var bg:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('stageback'));
						bg.antialiasing = true;
						bg.scrollFactor.set(0.9, 0.9);
						bg.active = false;
						add(bg);

						var stageFront:FlxSprite = new FlxSprite(-650, 600).loadGraphic(Paths.image('stagefront'));
						stageFront.setGraphicSize(Std.int(stageFront.width * 1.1));
						stageFront.updateHitbox();
						stageFront.antialiasing = true;
						stageFront.scrollFactor.set(0.9, 0.9);
						stageFront.active = false;
						add(stageFront);

						var stageCurtains:FlxSprite = new FlxSprite(-500, -300).loadGraphic(Paths.image('stagecurtains'));
						stageCurtains.setGraphicSize(Std.int(stageCurtains.width * 0.9));
						stageCurtains.updateHitbox();
						stageCurtains.antialiasing = true;
						stageCurtains.scrollFactor.set(1.3, 1.3);
						stageCurtains.active = false;

						add(stageCurtains);
					}
					case 'wocky':
					{
						defaultCamZoom = 0.9;
						curStage = 'arcade';
						var bg:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('mods/kapi/stageback','shared'));
						bg.antialiasing = true;
						bg.scrollFactor.set(0.9, 0.9);
						bg.active = false;
						add(bg);

						var stageFront:FlxSprite = new FlxSprite(-650, 600).loadGraphic(Paths.image('mods/kapi/stagefront','shared'));
						stageFront.setGraphicSize(Std.int(stageFront.width * 1.1));
						stageFront.updateHitbox();
						stageFront.antialiasing = true;
						stageFront.scrollFactor.set(0.9, 0.9);
						stageFront.active = false;
						add(stageFront);
					}
					case 'nyaw':
						{
								curStage = 'arcadeclosed';
			
								defaultCamZoom = 0.9;
								var bg:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('mods/kapi/closed'));
								bg.antialiasing = true;
								bg.scrollFactor.set(0.9, 0.9);
								bg.active = false;
								add(bg);
			
								bottomBoppers = new FlxSprite(-600, -200);
										 bottomBoppers.frames = Paths.getSparrowAtlas('mods/kapi/bgFreaks');
										  bottomBoppers.animation.addByPrefix('bop', 'Bottom Level Boppers', 24, false);
										  bottomBoppers.antialiasing = true;
											  bottomBoppers.scrollFactor.set(0.92, 0.92);
									 bottomBoppers.setGraphicSize(Std.int(bottomBoppers.width * 1));
										  bottomBoppers.updateHitbox();
											  add(bottomBoppers);
			
								var stageFront:FlxSprite = new FlxSprite(-650, 600).loadGraphic(Paths.image('mods/kapi/stagefront'));
								stageFront.setGraphicSize(Std.int(stageFront.width * 1.1));
								stageFront.updateHitbox();
								stageFront.antialiasing = true;
								stageFront.scrollFactor.set(0.9, 0.9);
								stageFront.active = false;
								add(stageFront);
			
								phillyCityLights = new FlxTypedGroup<FlxSprite>();
								add(phillyCityLights);
			
								for (i in 0...4)
								{
										var light:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('mods/kapi/win' + i));
										light.scrollFactor.set(0.9, 0.9);
										light.visible = false;
										light.updateHitbox();
										light.antialiasing = true;
										phillyCityLights.add(light);
								
								}
								// var cityLights:FlxSprite = new FlxSprite().loadGraphic(AssetPaths.win0.png);
			
							upperBoppers = new FlxSprite(-600, -200);
									  upperBoppers.frames = Paths.getSparrowAtlas('mods/kapi/upperBop');
									  upperBoppers.animation.addByPrefix('bop', "Upper Crowd Bob", 24, false);
									  upperBoppers.antialiasing = true;
									  upperBoppers.scrollFactor.set(1.05, 1.05);
									  upperBoppers.setGraphicSize(Std.int(upperBoppers.width * 1));
									  upperBoppers.updateHitbox();
									  add(upperBoppers);
							 
							
						}
						case 'hairball':
						{
			
								defaultCamZoom = 0.9;
								curStage = 'arcadesunset';
								var bg:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('mods/kapi/sunset'));
								bg.antialiasing = true;
								bg.scrollFactor.set(0.9, 0.9);
								bg.active = false;
								add(bg);
			
								var stageFront:FlxSprite = new FlxSprite(-650, 600).loadGraphic(Paths.image('mods/kapi/stagefront'));
								stageFront.setGraphicSize(Std.int(stageFront.width * 1.1));
								stageFront.updateHitbox();
								stageFront.antialiasing = true;
								stageFront.scrollFactor.set(0.9, 0.9);
								stageFront.active = false;
								add(stageFront);
			
								phillyCityLights = new FlxTypedGroup<FlxSprite>();
								add(phillyCityLights);
			
								for (i in 0...4)
								{
										var light:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('mods/kapi/win' + i));
										light.scrollFactor.set(0.9, 0.9);
										light.visible = false;
										light.updateHitbox();
										light.antialiasing = true;
										phillyCityLights.add(light);
								
								}
								// var cityLights:FlxSprite = new FlxSprite().loadGraphic(AssetPaths.win0.png);
			
								upperBoppers = new FlxSprite(-600, -200);
								upperBoppers.frames = Paths.getSparrowAtlas('mods/kapi/upperBop');
									  upperBoppers.animation.addByPrefix('bop', "Upper Crowd Bob", 24, false);
									  upperBoppers.antialiasing = true;
									  upperBoppers.scrollFactor.set(1.05, 1.05);
									  upperBoppers.setGraphicSize(Std.int(upperBoppers.width * 1));
									  upperBoppers.updateHitbox();
									  add(upperBoppers);
								 
								littleGuys = new FlxSprite(25, 200);
										 littleGuys.frames = Paths.getSparrowAtlas('mods/kapi/littleguys');
										  littleGuys.animation.addByPrefix('bop', 'Bottom Level Boppers', 24, false);
										  littleGuys.antialiasing = true;
											 littleGuys.scrollFactor.set(0.9, 0.9);
								 littleGuys.setGraphicSize(Std.int(littleGuys.width * 1));
										 littleGuys.updateHitbox();
											  add(littleGuys);
							
						}
						case 'beathoven':
							{
									defaultCamZoom = 0.9;
									curStage = 'arcade2';
									var bg:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('mods/kapi/stageback','shared'));
									bg.antialiasing = true;
									bg.scrollFactor.set(0.9, 0.9);
									bg.active = false;
									add(bg);
				
									var stageFront:FlxSprite = new FlxSprite(-650, 600).loadGraphic(Paths.image('mods/kapi/stagefront','shared'));
									stageFront.setGraphicSize(Std.int(stageFront.width * 1.1));
									stageFront.updateHitbox();
									stageFront.antialiasing = true;
									stageFront.scrollFactor.set(0.9, 0.9);
									stageFront.active = false;
									add(stageFront);
									
									phillyCityLights = new FlxTypedGroup<FlxSprite>();
									add(phillyCityLights);
				
									for (i in 0...4)
									{
											var light:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('mods/kapi/win' + i));
											light.scrollFactor.set(0.9, 0.9);
											light.visible = false;
											light.updateHitbox();
											light.antialiasing = true;
											phillyCityLights.add(light);
									
									}
									// var cityLights:FlxSprite = new FlxSprite().loadGraphic(AssetPaths.win0.png);
				
									littleGuys = new FlxSprite(25, 200);
											 littleGuys.frames = Paths.getSparrowAtlas('mods/kapi/littleguys');
											  littleGuys.animation.addByPrefix('bop', 'Bottom Level Boppers', 24, false);
											  littleGuys.antialiasing = true;
												 littleGuys.scrollFactor.set(0.9, 0.9);
									 littleGuys.setGraphicSize(Std.int(littleGuys.width * 1));
											 littleGuys.updateHitbox();
												 add(littleGuys);
				
							}
						case 'headache' | 'nerves':
							{
								defaultCamZoom = 0.9;
								curStage = 'garAlley';
	  
								var bg:FlxSprite = new FlxSprite(-500, -170).loadGraphic(Paths.image('mods/gar/garStagebg'));
								bg.antialiasing = true;
								bg.scrollFactor.set(0.7, 0.7);
								bg.active = false;
								add(bg);
	  
								var bgAlley:FlxSprite = new FlxSprite(-500, -200).loadGraphic(Paths.image('mods/gar/garStage'));
								bgAlley.antialiasing = true;
								bgAlley.scrollFactor.set(0.9, 0.9);
								bgAlley.active = false;
								add(bgAlley);
							}
						case 'release':
							{
								defaultCamZoom = 0.9;
								curStage = 'garAlleyDead';
	  
								var bg:FlxSprite = new FlxSprite(-500, -170).loadGraphic(Paths.image('mods/gar/garStagebgAlt'));
								bg.antialiasing = true;
								bg.scrollFactor.set(0.7, 0.7);
								bg.active = false;
								add(bg);
	  
								var smoker:FlxSprite = new FlxSprite(0, -290);
								smoker.frames = Paths.getSparrowAtlas('mods/gar/garSmoke');
								smoker.setGraphicSize(Std.int(smoker.width * 1.7));
								smoker.alpha = 0.3;
								smoker.animation.addByPrefix('garsmoke', "smokey", 13); // TOTALLY NOT FAMILIAR
								smoker.animation.play('garsmoke');
								smoker.scrollFactor.set(0.7, 0.7);
								add(smoker);
	  
								var bgAlley:FlxSprite = new FlxSprite(-500, -200).loadGraphic(Paths.image('mods/gar/garStagealt'));
								bgAlley.antialiasing = true;
								bgAlley.scrollFactor.set(0.9, 0.9);
								bgAlley.active = false;
								add(bgAlley);
	  
								var corpse:FlxSprite = new FlxSprite(-230, 540).loadGraphic(Paths.image('mods/gar/gardead'));
								corpse.antialiasing = true;
								corpse.scrollFactor.set(0.9, 0.9);
								corpse.active = false;
								add(corpse);
							}
						case 'fading':
							{
								defaultCamZoom = 0.9;
								curStage = 'garAlleyDip';
	  
								var bg:FlxSprite = new FlxSprite(-500, -170).loadGraphic(Paths.image('mods/gar/garStagebgRise'));
								bg.antialiasing = true;
								bg.scrollFactor.set(0.7, 0.7);
								bg.active = false;
								add(bg);
	  
								var bgAlley:FlxSprite = new FlxSprite(-500, -200).loadGraphic(Paths.image('mods/gar/garStageRise'));
								bgAlley.antialiasing = true;
								bgAlley.scrollFactor.set(0.9, 0.9);
								bgAlley.active = false;
								add(bgAlley);
	  
								var corpse:FlxSprite = new FlxSprite(-230, 540).loadGraphic(Paths.image('mods/gar/gardead'));
								corpse.antialiasing = true;
								corpse.scrollFactor.set(0.9, 0.9);
								corpse.active = false;
								add(corpse);
							}
								case 'sussus-moogus':
								{
									defaultCamZoom = 0.9;
									curStage = 'sussy';
									var bg:FlxSprite = new FlxSprite(-200, -300).loadGraphic(Paths.image('mods/sus/polusSky','shared'));
									bg.setGraphicSize(Std.int(bg.width * 1.5));
									bg.antialiasing = true;
									bg.scrollFactor.set(0.5, 0.5);
									bg.active = false;
									add(bg);
				
				
									var rocks:FlxSprite = new FlxSprite(-800, -300).loadGraphic(Paths.image('mods/sus/polusrocks','shared'));
									rocks.setGraphicSize(Std.int(rocks.width * 1.5));
									rocks.updateHitbox();
									rocks.antialiasing = true;
									rocks.scrollFactor.set(0.6, 0.6);
									rocks.active = false;
									add(rocks);
				
								
									var rocks:FlxSprite = new FlxSprite(-450, -200).loadGraphic(Paths.image('mods/sus/polusWarehouse','shared'));
									rocks.setGraphicSize(Std.int(rocks.width * 1.5));
									rocks.updateHitbox();
									rocks.antialiasing = true;
									rocks.scrollFactor.set(0.9, 0.9);
									rocks.active = false;
									add(rocks);
									
									var rocks:FlxSprite = new FlxSprite(-1000, 0).loadGraphic(Paths.image('mods/sus/polusHills','shared'));
									rocks.setGraphicSize(Std.int(rocks.width * 1.5));
									rocks.updateHitbox();
									rocks.antialiasing = true;
									rocks.scrollFactor.set(0.9, 0.9);
									rocks.active = false;
									add(rocks);
				
									var stageFront:FlxSprite = new FlxSprite(-400, 450).loadGraphic(Paths.image('mods/sus/polusGround','shared'));
									stageFront.setGraphicSize(Std.int(stageFront.width * 1.5));
									stageFront.updateHitbox();
									stageFront.antialiasing = true;
									stageFront.scrollFactor.set(1, 1);
									stageFront.active = false;
									add(stageFront);
				
				
									var stageCurtains:FlxSprite = new FlxSprite(-500, -300).loadGraphic(Paths.image('mods/sus/stagecurtains','shared'));
									stageCurtains.setGraphicSize(Std.int(stageCurtains.width * 0.9));
									stageCurtains.updateHitbox();
									stageCurtains.antialiasing = true;
									stageCurtains.scrollFactor.set(1.3, 1.3);
									stageCurtains.active = false;
								}
								case 'good enough' | 'lover' | 'tug of war': 
									{
									curStage = 'philly';
				
									var bg:FlxSprite = new FlxSprite(-100).loadGraphic(Paths.image('mods/annie/philly/sky', 'shared'));
									bg.scrollFactor.set(0.1, 0.1);
									add(bg);
				
									var city:FlxSprite = new FlxSprite(-10).loadGraphic(Paths.image('mods/annie/philly/city', 'shared'));
									city.scrollFactor.set(0.3, 0.3);
									city.setGraphicSize(Std.int(city.width * 0.85));
									city.updateHitbox();
									add(city);
				
									phillyCityLights = new FlxTypedGroup<FlxSprite>();
									if(FlxG.save.data.distractions){
										add(phillyCityLights);
									}
				
									for (i in 0...5)
									{
											var light:FlxSprite = new FlxSprite(city.x).loadGraphic(Paths.image('mods/annie/philly/win' + i, 'shared'));
											light.scrollFactor.set(0.3, 0.3);
											light.visible = false;
											light.setGraphicSize(Std.int(light.width * 0.85));
											light.updateHitbox();
											light.antialiasing = true;
											phillyCityLights.add(light);
									}
				
									var streetBehind:FlxSprite = new FlxSprite(-40, 50).loadGraphic(Paths.image('mods/annie/philly/behindTrain','shared'));
									add(streetBehind);
				
									phillyTrain = new FlxSprite(2000, 360).loadGraphic(Paths.image('mods/annie/philly/train','shared'));
									if(FlxG.save.data.distractions){
										add(phillyTrain);
									}
				
									trainSound = new FlxSound().loadEmbedded(Paths.sound('train_passes2','shared'));
									FlxG.sound.list.add(trainSound);
				
									// var cityLights:FlxSprite = new FlxSprite().loadGraphic(AssetPaths.win0.png);
				
									var street:FlxSprite = new FlxSprite(-40, streetBehind.y).loadGraphic(Paths.image('mods/annie/philly/street','shared'));
									add(street);
							}
							case 'animal':
								{
										curStage = 'mallEvil';
										var bg:FlxSprite = new FlxSprite(-400, -500).loadGraphic(Paths.image('mods/annie/christmas/evilBG','shared'));
										bg.antialiasing = true;
										bg.scrollFactor.set(0.2, 0.2);
										bg.active = false;
										bg.setGraphicSize(Std.int(bg.width * 0.8));
										bg.updateHitbox();
										add(bg);
					
										var evilTree:FlxSprite = new FlxSprite(300, -300).loadGraphic(Paths.image('mods/annie/christmas/evilTree','shared'));
										evilTree.antialiasing = true;
										evilTree.scrollFactor.set(0.2, 0.2);
										add(evilTree);
					
										var evilSnow:FlxSprite = new FlxSprite(-200, 700).loadGraphic(Paths.image("mods/annie/christmas/evilSnow",'shared'));
											evilSnow.antialiasing = true;
										add(evilSnow);
								}
								case 'onslaught' :
									{
										defaultCamZoom = 0.9;
										curStage = 'slaught';
										var bg:FlxSprite = new FlxSprite(-100).loadGraphic(Paths.image('mods/bob/scary_sky'));
										bg.updateHitbox();
										bg.active = false;
										bg.antialiasing = true;
										bg.scrollFactor.set(0.1, 0.1);
										add(bg);
										/*var glitchEffect = new FlxGlitchEffect(8,10,0.4,FlxGlitchDirection.HORIZONTAL);
										var glitchSprite = new FlxEffectSprite(bg, [glitchEffect]);
										add(glitchSprite);*/
										
										var ground:FlxSprite = new FlxSprite(-537, -158).loadGraphic(Paths.image('mods/bob/GlitchedGround'));
										ground.updateHitbox();
										ground.active = false;
										ground.antialiasing = true;
										add(ground);
										
									}
									case 'trouble' :
										{
											defaultCamZoom = 0.9;
											curStage = 'trouble';
											var bg:FlxSprite = new FlxSprite(-100,10).loadGraphic(Paths.image('mods/bob/nothappy_sky'));
											bg.updateHitbox();
											bg.scale.x = 1.2;
											bg.scale.y = 1.2;
											bg.active = false;
											bg.antialiasing = true;
											bg.scrollFactor.set(0.1, 0.1);
											add(bg);
											/*var glitchEffect = new FlxGlitchEffect(8,10,0.4,FlxGlitchDirection.HORIZONTAL);
											var glitchSprite = new FlxEffectSprite(bg, [glitchEffect]);
											add(glitchSprite);*/
											
											var ground:FlxSprite = new FlxSprite(-537, -250).loadGraphic(Paths.image('mods/bob/nothappy_ground'));
											ground.updateHitbox();
											ground.active = false;
											ground.antialiasing = true;
											add(ground);
						
											var deadron:FlxSprite = new FlxSprite(-700, 600).loadGraphic(Paths.image('mods/bob/GoodHeDied'));
											deadron.updateHitbox();
											deadron.active = false;
											deadron.scale.x = 0.8;
											deadron.scale.y = 0.8;
											deadron.antialiasing = true;
											add(deadron);
											
										}
									case 'ron' | 'little-man' | 'ron bside':
										{
										defaultCamZoom = 0.9;
										curStage = 'ron';
										var bg:FlxSprite = new FlxSprite(-100,10).loadGraphic(Paths.image('mods/bob/happyRon_sky'));
										bg.updateHitbox();
										bg.scale.x = 1.2;
										bg.scale.y = 1.2;
										bg.active = false;
										bg.antialiasing = true;
										bg.scrollFactor.set(0.1, 0.1);
										add(bg);
										/*var glitchEffect = new FlxGlitchEffect(8,10,0.4,FlxGlitchDirection.HORIZONTAL);
										var glitchSprite = new FlxEffectSprite(bg, [glitchEffect]);
										add(glitchSprite);*/
										
										var ground:FlxSprite = new FlxSprite(-537, -250).loadGraphic(Paths.image('mods/bob/happyRon_ground'));
										ground.updateHitbox();
										ground.active = false;
										ground.antialiasing = true;
										add(ground);
											
										}
										case 'sunshine' :
											{
												var bg:FlxSprite = new FlxSprite(-100).loadGraphic(Paths.image('mods/bob/happysky'));
												bg.updateHitbox();
												bg.active = false;
												bg.antialiasing = true;
												bg.scrollFactor.set(0.1, 0.1);
												add(bg);
												
												var ground:FlxSprite = new FlxSprite(-537, -158).loadGraphic(Paths.image('mods/bob/happyground'));
												ground.updateHitbox();
												ground.active = false;
												ground.antialiasing = true;
												add(ground);
											}
											
											case 'withered' :
											{
												var bg:FlxSprite = new FlxSprite( -100).loadGraphic(Paths.image('mods/bob/slightlyannyoed_sky'));
												bg.updateHitbox();
												bg.active = false;
												bg.antialiasing = true;
												bg.scrollFactor.set(0.1, 0.1);
												add(bg);
												
												var ground:FlxSprite = new FlxSprite(-537, -158).loadGraphic(Paths.image('mods/bob/slightlyannyoed_ground'));
												ground.updateHitbox();
												ground.active = false;
												ground.antialiasing = true;
												add(ground);
											}
											
											//phlox is a little baby
											case 'run' | 'run-remix-because-its-cool' :
											{
												curStage = 'hellstage';
													var bg:FlxSprite = new FlxSprite( -100).loadGraphic(Paths.image('mods/bob/hell'));
												bg.updateHitbox();
												bg.active = false;
												bg.antialiasing = true;
												bg.scrollFactor.set(0.1, 0.1);
												add(bg);
												
												var thingidk:FlxSprite = new FlxSprite( -271).loadGraphic(Paths.image('mods/bob/middlething'));
												thingidk.updateHitbox();
												thingidk.active = false;
												thingidk.antialiasing = true;
												thingidk.scrollFactor.set(0.3, 0.3);
												add(thingidk);
												
												var dead:FlxSprite = new FlxSprite( -60, 50).loadGraphic(Paths.image('mods/bob/theydead'));
												dead.updateHitbox();
												dead.active = false;
												dead.antialiasing = true;
												dead.scrollFactor.set(0.8, 0.8);
												add(dead);
								
												var ground:FlxSprite = new FlxSprite(-537, -158).loadGraphic(Paths.image('mods/bob/ground'));
												ground.updateHitbox();
												ground.active = false;
												ground.antialiasing = true;
												add(ground);												
											}
											case 'megalo strike back':
											{
												curStage = 'chara';
												defaultCamZoom = 0.8;
												var bg:FlxSprite = new FlxSprite(-420, 150).loadGraphic(Paths.image('mods/chara/chara-bg'));
												bg.antialiasing = true;
												bg.scrollFactor.set();
												bg.active = false;
												bg.setGraphicSize(Std.int(bg.width * 1.5));
												add(bg);
											}
											case 'remorse':
											{
												curStage = 'ass';
												defaultCamZoom = 0.9;
												uBg = new FlxSprite(-500, -400);
												uBg.frames = Paths.getSparrowAtlas('mods/updike/mainBG');
												uBg.animation.addByPrefix('bg', 'bg', 0, false);
												uBg.animation.addByPrefix('edgy', 'bg edgy', 0, false);
												uBg.animation.play('bg');
												add(uBg);
											}
											case 'lo-fight' | 'overhead':
											{
												curStage = 'wity';
												defaultCamZoom = 0.9;
												var wBg:FlxSprite = new FlxSprite(-500, -300);
												var whittyFront:FlxSprite = new FlxSprite(-650, 600).loadGraphic(Paths.image('mods/whitty/whittyFront'));
												whittyFront.setGraphicSize(Std.int(whittyFront.width * 1.1));
												whittyFront.updateHitbox();
												whittyFront.antialiasing = true;
												whittyFront.scrollFactor.set(0.9, 0.9);
												whittyFront.active = false;
												wBg.loadGraphic(Paths.image('mods/whitty/whittyBack'));
												wBg.antialiasing = true;
												wBg.scrollFactor.set(0.9, 0.9);
												wBg.active = false;
												add(wBg);
												add(whittyFront);
											}
											case 'ballistic' | 'ballistic-old':
											{
												curStage = 'wityangy';
												defaultCamZoom = 0.9;
												wBg2 = new FlxSprite(-600, -200);
												wBg2.frames = Paths.getSparrowAtlas('mods/whitty/BallisticBackground');
												wBg2.animation.addByPrefix('start', 'Background Whitty Start', 24, false);
												wBg2.animation.addByPrefix('gaming', 'Backgrounds Whitty Startup', 24, true);
												var whittyFront:FlxSprite = new FlxSprite(-650, 600).loadGraphic(Paths.image('mods/whitty/whittyFront'));
												whittyFront.setGraphicSize(Std.int(whittyFront.width * 1.1));
												whittyFront.updateHitbox();
												whittyFront.antialiasing = true;
												whittyFront.scrollFactor.set(0.9, 0.9);
												whittyFront.active = false;
												add(wBg2);
												add(whittyFront);
												wBg2.animation.play('gaming', true);
											}
											case 'line art' | 'sketched out':
												{
														defaultCamZoom = 0.80;
														curStage = 'paper';
														var bg:FlxSprite = new FlxSprite(-995, -478).loadGraphic(Paths.image('mods/sketchy/notebookPage'));
														bg.antialiasing = true;
														bg.scrollFactor.set(0.895, 0.895);
														bg.active = false;
														add(bg);
									
														var stageCurtains:FlxSprite = new FlxSprite(-955, -378).loadGraphic(Paths.image('mods/sketchy/PencilErase'));
														stageCurtains.setGraphicSize(Std.int(stageCurtains.width * 0.9));
														stageCurtains.updateHitbox();
														stageCurtains.antialiasing = true;
														stageCurtains.scrollFactor.set(0.95, 0.95);
														stageCurtains.active = false;
									
														add(stageCurtains);
												}
												case 'rip and tear':
												{		
														defaultCamZoom = 0.75;
														curStage = 'DestroyedPaper';
														var bg:FlxSprite = new FlxSprite(-230, -95);
														bg.frames = Paths.getSparrowAtlas('mods/sketchy/destroyedpaperjig');
														bg.animation.addByPrefix('idle', 'DestroyedPaper', 24);
														bg.setGraphicSize(Std.int(bg.width * 0.5));
														bg.animation.play('idle');
														bg.scrollFactor.set(0.8, 1.0);
														bg.scale.set(2.3, 2.3);
														bg.antialiasing = true;
														add(bg);
									
														var rips:FlxSprite = new FlxSprite(-230, -95);
														rips.frames = Paths.getSparrowAtlas('mods/sketchy/PaperRips');
														rips.animation.addByPrefix('idle', 'Ripping Graphic', 24);
														rips.setGraphicSize(Std.int(rips.width * 0.5));
														rips.animation.play('idle');
														rips.scrollFactor.set(1.0, 1.0);
														rips.scale.set(2.0, 2.0);
														rips.antialiasing = true;
														add(rips);
												}
												case 'ugh' | 'guns' | 'stress': 
												{
														curStage = 'tankStage';
														defaultCamZoom = 0.9;
														var sky:FlxSprite = new FlxSprite(-400,-400).loadGraphic(Paths.image('tankSky'));
														sky.scrollFactor.set(0, 0);
														sky.antialiasing = true;
														sky.setGraphicSize(Std.int(sky.width * 1.5));
														add(sky);
														picoStep = Json.parse(openfl.utils.Assets.getText(Paths.json('stress/picospeaker')));
														tankStep = Json.parse(openfl.utils.Assets.getText(Paths.json('stress/tankSpawn')));
										
														var clouds:FlxSprite = new FlxSprite(FlxG.random.int(-700, -100), FlxG.random.int(-20, 20)).loadGraphic(Paths.image('tankClouds'));
														clouds.scrollFactor.set(0.1, 0.1);
														clouds.velocity.x = FlxG.random.float(5, 15);
														clouds.antialiasing = true;
														clouds.updateHitbox();
														add(clouds);
										
														var mountains:FlxSprite = new FlxSprite(-300,-20).loadGraphic(Paths.image('tankMountains'));
														mountains.scrollFactor.set(0.2, 0.2);
														mountains.setGraphicSize(Std.int(1.2 * mountains.width));
														mountains.updateHitbox();
														mountains.antialiasing = true;
														add(mountains);
										
														var buildings:FlxSprite = new FlxSprite(-200,0).loadGraphic(Paths.image('tankBuildings'));
														buildings.scrollFactor.set(0.3, 0.3);
														buildings.setGraphicSize(Std.int(buildings.width * 1.1));
														buildings.updateHitbox();
														buildings.antialiasing = true;
														add(buildings);
										
														var ruins:FlxSprite = new FlxSprite(-200,0).loadGraphic(Paths.image('tankRuins'));
														ruins.scrollFactor.set(0.35, 0.35);
														ruins.setGraphicSize(Std.int(ruins.width * 1.1));
														ruins.updateHitbox();
														ruins.antialiasing = true;
														add(ruins);
										
										
														var smokeLeft:FlxSprite = new FlxSprite(-200,-100);
														smokeLeft.frames = Paths.getSparrowAtlas('smokeLeft');
														smokeLeft.animation.addByPrefix('idle', 'SmokeBlurLeft ', 24, true);
														smokeLeft.scrollFactor.set(0.4, 0.4);
														smokeLeft.antialiasing = true;
														smokeLeft.animation.play('idle'); 
														add(smokeLeft);
										
														var smokeRight:FlxSprite = new FlxSprite(1100,-100);
														smokeRight.frames = Paths.getSparrowAtlas('smokeRight');
														smokeRight.animation.addByPrefix('idle', 'SmokeRight ', 24, true);
														smokeRight.scrollFactor.set(0.4, 0.4);
														smokeRight.antialiasing = true;
														smokeRight.animation.play('idle');
														
														add(smokeRight);
										
										
														var tankWatchtower:FlxSprite = new FlxSprite(100,120);
														tankWatchtower.frames = Paths.getSparrowAtlas('tankWatchtower');
														tankWatchtower.animation.addByPrefix('bop', 'watchtower gradient color instance 1', 24, true);
														tankWatchtower.scrollFactor.set(0.5, 0.5);
														tankWatchtower.antialiasing = true;
													
														add(tankWatchtower);
														
														if (daSong == 'stress')
														{
															tankmanRun = new FlxTypedGroup<TankmenBG>();
															add(tankmanRun);
														}
										
										
														var ground:FlxSprite = new FlxSprite(-420, -150).loadGraphic(Paths.image('tankGround'));
														ground.scrollFactor.set();
														ground.antialiasing = true;
														ground.setGraphicSize(Std.int(ground.width * 1.15));
														ground.scrollFactor.set(1, 1);
														
														ground.updateHitbox();
														add(ground);
										
														tankBop1 = new FlxSprite(-500,650);
														tankBop1.frames = Paths.getSparrowAtlas('tank0');
														tankBop1.animation.addByPrefix('bop', 'fg tankhead far right instance 1', 24);
														tankBop1.scrollFactor.set(1.7, 1.5);
														tankBop1.antialiasing = true;
										
														tankBop2 = new FlxSprite(-300,750);
														tankBop2.frames = Paths.getSparrowAtlas('tank1');
														tankBop2.animation.addByPrefix('bop','fg tankhead 5 instance 1', 24);
														tankBop2.scrollFactor.set(2.0, 0.2);
														tankBop2.antialiasing = true;
										
														tankBop3 = new FlxSprite(450,940);
														tankBop3.frames = Paths.getSparrowAtlas('tank2');
														tankBop3.animation.addByPrefix('bop','foreground man 3 instance 1', 24);
														tankBop3.scrollFactor.set(1.5, 1.5);
														tankBop3.antialiasing = true;
										
														tankBop4 = new FlxSprite(1300,1200);
														tankBop4.frames = Paths.getSparrowAtlas('tank3');
														tankBop4.animation.addByPrefix('bop','fg tankhead 4 instance 1', 24);
														tankBop4.scrollFactor.set(3.5, 2.5);
														tankBop4.antialiasing = true;
										
														tankBop5 = new FlxSprite(1300,900);
														tankBop5.frames = Paths.getSparrowAtlas('tank4');
														tankBop5.animation.addByPrefix('bop','fg tankman bobbin 3 instance 1', 24);
														tankBop5.scrollFactor.set(1.5, 1.5);
														tankBop5.antialiasing = true;
										
														tankBop6 = new FlxSprite(1620,700);
														tankBop6.frames = Paths.getSparrowAtlas('tank5');
														tankBop6.animation.addByPrefix('bop','fg tankhead far right instance 1', 24);
														tankBop6.scrollFactor.set(1.5, 1.5);
														tankBop6.antialiasing = true;
										
														tankWatchtower.animation.play('bop');
														tankBop1.animation.play('bop');
														tankBop2.animation.play('bop');
														tankBop3.animation.play('bop');
														tankBop4.animation.play('bop');
														tankBop5.animation.play('bop');
														tankBop6.animation.play('bop');
										
												}
												case 'inverted-ascension' | 'echoes' | 'artificial-lust':
													{
														normalStage = new FlxTypedGroup<FlxSprite>();
														add(normalStage);
														defaultCamZoom = 0.64;
														curStage = 'festival';
														var bg:FlxSprite = new FlxSprite(0, 0);
														switch (SONG.song.toLowerCase()) {
															case 'inverted-ascension':
																bg = new FlxSprite(-550, -160).loadGraphic(Paths.image('mods/starlight/morning/bg'));
															case 'echoes':
																bg = new FlxSprite(-550, -160).loadGraphic(Paths.image('mods/starlight/dusk/bg'));
															case 'artificial-lust':
																bg = new FlxSprite(-550, -160).loadGraphic(Paths.image('mods/starlight/night/bg'));
														}
														bg.antialiasing = true;
														bg.scrollFactor.set(0.5, 0.5);
														bg.active = false;
														normalStage.add(bg);
										
														var stage:FlxSprite = new FlxSprite(-510, -260).loadGraphic(Paths.image('mods/starlight/stage'));
														stage.antialiasing = true;
														stage.active = false;
														normalStage.add(stage);
										
														phillyCityLights = new FlxTypedGroup<FlxSprite>();
														add(phillyCityLights);
										
														for (i in 0...4)
														{
															var light:FlxSprite = new FlxSprite(-510, -260).loadGraphic(Paths.image('mods/starlight/light' + i, 'shared'));
															if (i != 0)
																light.visible = false;
															light.antialiasing = true;
															phillyCityLights.add(light);
															
														}
										
														headlights= new FlxSprite(-510, -80);
														headlights.frames = Paths.getSparrowAtlas('mods/starlight/headlights');
														headlights.antialiasing = true;
														headlights.animation.addByPrefix('idle', 'lightsrepeated', 24, false);
														headlights.animation.play('idle');
														add(headlights);
										
														max = new Character(1100, 225, 'max');
														/*max.frames = Paths.getSparrowAtlas('Max');
														max.antialiasing = true;
														max.animation.addByPrefix('idle', 'MAX', 24, false);
														max.animation.play('idle');*/
														add(max);
										
														abel = new Character(-180, 140, 'abel');
														/*abel.frames = Paths.getSparrowAtlas('Abel');
														abel.antialiasing = true;
														abel.animation.addByPrefix('idle', 'ABEL', 24, false);
														abel.animation.play('idle');*/
														add(abel);
										
														frontbop = new FlxSprite(-510, 950);
														frontbop.frames = Paths.getSparrowAtlas('mods/starlight/frontboppers');
														frontbop.antialiasing = true;
														frontbop.animation.addByPrefix('idle', 'frontboppers', 24, false);
														frontbop.animation.play('idle');
														normalStage.add(frontbop);
										
														cj = new FlxSprite(150, 400);
														cj.frames = Paths.getSparrowAtlas('mods/starlight/CJBG');
														cj.scale.set(0.9, 0.9);
														cj.updateHitbox();
														cj.antialiasing = true;
														cj.animation.addByPrefix('idle', 'CJ',24, false);
														cj.animation.play('idle');
														switch (SONG.song.toLowerCase()) {
															case 'echoes':
																add(cj);
														}
													}
				}
			}
		}
		var gfVersion:String = 'gf';

		switch (SONG.gfVersion)
		{
			case 'gf-car':
				gfVersion = 'gf-car';
			case 'gf-christmas':
				gfVersion = 'gf-christmas';
			case 'gf-pixel':
				gfVersion = 'gf-pixel';
			case 'gf-bosip':
				gfVersion = 'gf-bosip';
			case 'gf-bob':
				gfVersion = 'gf-bob';
			default:
				gfVersion = 'gf';
		}

		if (storyWeek == 8)
			gfVersion = 'gf-drip';

		if (daSong == 'meltdown' || daSong == 'sabotage')
			gfVersion = 'ggf';

		if (storyWeek == 16)
			gfVersion = 'gf-whitty';

		if (daSong == 'remorse')
			gfVersion = 'gf-tied';

		if (storyWeek == 18)
			gfVersion = 'gf-sketch';

		if (storyWeek == 7)
			gfVersion = 'gf-tankman';
		if (daSong == 'stress')
			gfVersion = 'picoSpeaker';
		if (daSong == 'artificial-lust')
			gfVersion = 'nogf';

		gf = new Character(400, 130, gfVersion);
		gf.scrollFactor.set(0.95, 0.95);

		dad = new Character(100, 100, SONG.player2);

		camPos = new FlxPoint(dad.getGraphicMidpoint().x, dad.getGraphicMidpoint().y);

		switch (SONG.gfVersion)
		{
			case 'gf-bosip':
				gf.y -= 40;
				gf.x -= 30;
		}
		switch (SONG.player2)
		{
			case 'gf':
				dad.setPosition(gf.x, gf.y);
				gf.visible = false;
				if (isStoryMode)
				{
					camPos.x += 600;
					tweenCamIn();
				}

			case "spooky":
				dad.y += 200;
			case "monster":
				dad.y += 100;
			case 'monster-christmas':
				dad.y += 130;
			case 'dad':
				camPos.x += 400;
			case 'pico':
				camPos.x += 600;
				dad.y += 300;
			case 'parents-christmas':
				dad.x -= 500;
			case 'bob':
				camPos.x += 600;
				dad.y += 300;
				case 'king':
					camPos.x += 300;
					dad.y += 300;
				case 'hypedking':
					camPos.x += 300;
					dad.y += 300;
					case 'blackout':
						camPos.x += 300;
						dad.y += 300;
			case 'gloop-bob':
				camPos.x += 600;
				dad.y += 300;
			case 'angrybob':
				camPos.x += 600;
				dad.y += 300;
			case 'hellbob':
				camPos.x += 600;
				dad.y += 350;
			case 'glitched-bob':
				camPos.x += 600;
				dad.y += 300;
			case 'ron' | 'ron-b':
				camPos.x -= 27;
				camPos.y += 268;
				dad.y += 268;
				dad.x -= 27;
			case 'little-man':
				camPos.x -= 124;
				camPos.y += 644;
				dad.x += 124;
				dad.y += 644;
			case 'senpai':
				dad.x += 150;
				dad.y += 360;
				camPos.set(dad.getGraphicMidpoint().x + 300, dad.getGraphicMidpoint().y);
			case 'senpai-angry':
				dad.x += 150;
				dad.y += 360;
				camPos.set(dad.getGraphicMidpoint().x + 300, dad.getGraphicMidpoint().y);
			case 'spirit':
				dad.x -= 150;
				dad.y += 100;
				camPos.set(dad.getGraphicMidpoint().x + 300, dad.getGraphicMidpoint().y);
			case 'impostor':
				camPos.y += -200;
				camPos.x += 400;
				dad.y += 350;
				dad.x -= 100;
			case 'impostor2':
				camPos.y += -200;
				camPos.x += 400;
				dad.y += 350;
				dad.x -= 100;
			case 'annie':
				dad.y += 300;
				dad.x -= 100;
			case 'annie-drunk':
				dad.y += 130;
			case 'chara':
				dad.y += 300;
			case 'bob-from-the-other-mod':
				dad.y += 50;
			case 'bosip':
				dad.y -= 50;
				case 'angrysketchy':
					dad.x += 350;
					dad.y += 260;
				case 'sketchy':
					dad.x += -285;
					dad.y += 105;
				case 'tornsketchy':
					dad.x += -230;
					dad.y += 165;
					case 'tankman':
						//dad.x = dad.x
						dad.y += 180;
			
		}


		if (SONG.player2 == "blackout")
			{
				if(FlxG.save.data.distractions)
					{
					// trailArea.scrollFactor.set();
					var chartrail = new FlxTrail(dad, null, 50, 3, 0.7, 0.089);
					// chartrail.changeValuesEnabled(false, false, false, false);
					// chartrail.changeGraphic()
					add(chartrail);
					// chartrail.scrollFactor.set(1.1, 1.1);
					}
			}
		if (!FlxG.save.data.pc)
			boyfriend = new Boyfriend(770, 450, SONG.player1);
		else
			boyfriend = new Boyfriend(770, 450, 'pc');

		// REPOSITIONING PER STAGE
		switch (curStage)
		{
			case 'limo':
				boyfriend.y -= 220;
				boyfriend.x += 260;
				if(FlxG.save.data.distractions){
					resetFastCar();
					add(fastCar);
				}
				case 'DestroyedPaper':
					if(FlxG.save.data.distractions){
					var sketchyTrail = new FlxTrail(dad, null, 4, 16, 0.25, 0.080);
					add(sketchyTrail);
					}
					gf.x += -275;
			case 'mall':
				boyfriend.x += 200;

			case 'mallEvil':
				boyfriend.x += 320;
				dad.y -= 80;
			case 'school':
				boyfriend.x += 200;
				boyfriend.y += 220;
				gf.x += 180;
				gf.y += 300;
				case 'meltdown':
					gf.y -= 100;
				case 'sabotage':
					gf.y -= 100;
			case 'schoolEvil':
				if(FlxG.save.data.distractions){
				// trailArea.scrollFactor.set();
				var evilTrail = new FlxTrail(dad, null, 4, 24, 0.3, 0.069);
				// evilTrail.changeValuesEnabled(false, false, false, false);
				// evilTrail.changeGraphic()
				add(evilTrail);
				// evilTrail.scrollFactor.set(1.1, 1.1);
				}


				boyfriend.x += 200;
				boyfriend.y += 220;
				gf.x += 180;
				gf.y += 300;
				case 'day' | 'sunset':
					dad.x -= 150;
					dad.y -= 11;
					boyfriend.x += 191;
					boyfriend.y -= 20;
					gf.x -= 70;
					gf.y -= 50;
					camPos.x = 536.63;
					camPos.y = 449.94;
				case 'night':
					dad.x -= 370;
					dad.y += 39;
					boyfriend.x += 191;
					boyfriend.y -= 20;
					gf.x += 300;
					gf.y -= 50;
				case 'ass':
					gf.x += 120;
					boyfriend.x += 200;
				case 'wityangy':
					dad.x -= 200;
				case 'paper':
					gf.x += -275;
					case 'tankStage':
					{
						if (daSong != 'stress')
						{
							gf.y += -55;
							gf.x -= 200;
						}
						else
						{
							gf.y += -155;
							gf.x -= 90;
						}
		
						boyfriend.x += 40;
						dad.y += 60;
						dad.x -= 80;
					}
		}

			add(gf);

		// Shitty layering but whatev it works LOL
		if (curStage == 'limo')
			add(limo);

		add(dad);
		add(boyfriend);
		if (loadRep)
		{
			FlxG.watch.addQuick('rep rpesses',repPresses);
			FlxG.watch.addQuick('rep releases',repReleases);
			
			FlxG.save.data.botplay = true;
			FlxG.save.data.scrollSpeed = rep.replay.noteSpeed;
			FlxG.save.data.downscroll = rep.replay.isDownscroll;
			// FlxG.watch.addQuick('Queued',inputsQueued);
		}
		if (curStage == 'tankStage')
		{
			add(tankBop1);
			add(tankBop2);
			add(tankBop3);
			add(tankBop4);
			add(tankBop5);
			add(tankBop6);
		}

		var doof:DialogueBox = new DialogueBox(false, dialogue);
		// doof.x += 70;
		// doof.y = FlxG.height * 0.5;
		doof.scrollFactor.set();
		doof.finishThing = startCountdown;

		Conductor.songPosition = -5000;
		
		strumLine = new FlxSprite(0, 50).makeGraphic(FlxG.width, 10);
		strumLine.scrollFactor.set();
		
		if (FlxG.save.data.downscroll)
			strumLine.y = FlxG.height - 165;

		strumLineNotes = new FlxTypedGroup<FlxSprite>();
		add(strumLineNotes);
		add(grpNoteSplashes);

		playerStrums = new FlxTypedGroup<FlxSprite>();
		cpuStrums = new FlxTypedGroup<FlxSprite>();

		// startCountdown();

		if (SONG.song == null)
			trace('song is null???');
		else
			trace('song looks gucci');

		generateSong(SONG.song);

		trace('generated');

		// add(strumLine);

		camFollow = new FlxObject(0, 0, 1, 1);

		camFollow.setPosition(camPos.x, camPos.y);

		if (prevCamFollow != null)
		{
			camFollow = prevCamFollow;
			prevCamFollow = null;
		}

		add(camFollow);

		FlxG.camera.follow(camFollow, LOCKON, 0.04 * (30 / (cast (Lib.current.getChildAt(0), Main)).getFPS()));
		// FlxG.camera.setScrollBounds(0, FlxG.width, 0, FlxG.height);
		FlxG.camera.zoom = defaultCamZoom;
		FlxG.camera.focusOn(camFollow.getPosition());

		FlxG.worldBounds.set(0, 0, FlxG.width, FlxG.height);

		FlxG.fixedTimestep = false;

		if (FlxG.save.data.songPosition) // I dont wanna talk about this code :(
			{
				songPosBG = new FlxSprite(0, 10).loadGraphic(Paths.image('healthBar'));
				if (FlxG.save.data.downscroll)
					songPosBG.y = FlxG.height * 0.9 + 45; 
				songPosBG.screenCenter(X);
				songPosBG.scrollFactor.set();
				add(songPosBG);
				
				songPosBar = new FlxBar(songPosBG.x + 4, songPosBG.y + 4, LEFT_TO_RIGHT, Std.int(songPosBG.width - 8), Std.int(songPosBG.height - 8), this,
					'songPositionBar', 0, 90000);
				songPosBar.scrollFactor.set();
				songPosBar.createFilledBar(FlxColor.GRAY, FlxColor.LIME);
				add(songPosBar);
	
				var songName = new FlxText(songPosBG.x + (songPosBG.width / 2) - 20,songPosBG.y,0,SONG.song, 16);
				if (FlxG.save.data.downscroll)
					songName.y -= 3;
				songName.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
				songName.scrollFactor.set();
				add(songName);
				songName.cameras = [camHUD];
			}

		healthBarBG = new FlxSprite(0, FlxG.height * 0.9).loadGraphic(Paths.image('healthBar'));
		if (FlxG.save.data.downscroll)
			healthBarBG.y = 50;
		healthBarBG.screenCenter(X);
		healthBarBG.scrollFactor.set();
		add(healthBarBG);

		healthBar = new FlxBar(healthBarBG.x + 4, healthBarBG.y + 4, RIGHT_TO_LEFT, Std.int(healthBarBG.width - 8), Std.int(healthBarBG.height - 8), this,
			'health', 0, 2);
		healthBar.scrollFactor.set();
		healthBar.createFilledBar(0xFFFF0000, 0xFF66FF33);
		// healthBar
		add(healthBar);

		// Add Kade Engine watermark
		kadeEngineWatermark = new FlxText(4,healthBarBG.y + 50,0,SONG.song + " " + (storyDifficulty == 2 ? "Hard" : storyDifficulty == 1 ? "Normal" : "Easy") + (Main.watermarks ? " - KE " + MainMenuState.kadeEngineVer : ""), 16);
		kadeEngineWatermark.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
		kadeEngineWatermark.scrollFactor.set();
		add(kadeEngineWatermark);

		if (FlxG.save.data.downscroll)
			kadeEngineWatermark.y = FlxG.height * 0.9 + 45;

		scoreTxt = new FlxText(FlxG.width / 2 - 235, healthBarBG.y + 50, 0, "", 20);
		if (!FlxG.save.data.accuracyDisplay)
			scoreTxt.x = healthBarBG.x + healthBarBG.width / 2;
		scoreTxt.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
		scoreTxt.scrollFactor.set();
		if (offsetTesting)
			scoreTxt.x += 300;
		if(FlxG.save.data.botplay) scoreTxt.x = FlxG.width / 2 - 20;													  
		add(scoreTxt);

		var creditTxt:FlxText = new FlxText(5, 5, (Main.watermarks ? "Made by Klavier Gayming" : ""), 20);
		creditTxt.scrollFactor.set();
		creditTxt.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(creditTxt);

		replayTxt = new FlxText(healthBarBG.x + healthBarBG.width / 2 - 75, healthBarBG.y + (FlxG.save.data.downscroll ? 100 : -100), 0, "REPLAY", 20);
		replayTxt.setFormat(Paths.font("vcr.ttf"), 42, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
		replayTxt.scrollFactor.set();
		if (loadRep)
		{
			add(replayTxt);
		}
		// Literally copy-paste of the above, fu
		botPlayState = new FlxText(healthBarBG.x + healthBarBG.width / 2 - 75, healthBarBG.y + (FlxG.save.data.downscroll ? 100 : -100), 0, "BOTPLAY", 20);
		botPlayState.setFormat(Paths.font("vcr.ttf"), 42, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
		botPlayState.scrollFactor.set();
		
		if(FlxG.save.data.botplay && !loadRep) add(botPlayState);

		iconP1 = new HealthIcon(SONG.player1, true);
		iconP1.y = healthBar.y - (iconP1.height / 2);
		add(iconP1);

		iconP2 = new HealthIcon(SONG.player2, false);
		iconP2.y = healthBar.y - (iconP2.height / 2);
		add(iconP2);

		strumLineNotes.cameras = [camHUD];
		notes.cameras = [camHUD];
		healthBar.cameras = [camHUD];
		healthBarBG.cameras = [camHUD];
		iconP1.cameras = [camHUD];
		iconP2.cameras = [camHUD];
		scoreTxt.cameras = [camHUD];
		doof.cameras = [camHUD];
		creditTxt.cameras = [camHUD];
		if (FlxG.save.data.songPosition)
		{
			songPosBG.cameras = [camHUD];
			songPosBar.cameras = [camHUD];
		}
		kadeEngineWatermark.cameras = [camHUD];
		grpNoteSplashes.cameras = [camHUD];
		if (loadRep)
			replayTxt.cameras = [camHUD];
		if (FlxG.save.data.botplay)
			botPlayState.cameras = [camHUD];

		#if android
		mcontrols = new Mobilecontrols();
		switch (mcontrols.mode)
		{
			case VIRTUALPAD_RIGHT | VIRTUALPAD_LEFT | VIRTUALPAD_CUSTOM:
				controls.setVirtualPad(mcontrols._virtualPad, FULL, NONE);
			case HITBOX:
				controls.setHitBox(mcontrols._hitbox);
			default:
		}
		trackedinputs = controls.trackedinputs;
		controls.trackedinputs = [];

		var camcontrol = new FlxCamera();
		FlxG.cameras.add(camcontrol);
		camcontrol.bgColor.alpha = 0;
		mcontrols.cameras = [camcontrol];

		mcontrols.visible = false;

		add(mcontrols);
		#end

		// if (SONG.song == 'South')
		// FlxG.camera.alpha = 0.7;
		// UI_camera.zoom = 1;

		// cameras = [FlxG.cameras.list[1]];
		startingSong = true;
		
		trace('starting');

		if (isStoryMode)
		{
			switch (StringTools.replace(curSong," ", "-").toLowerCase())
			{
				case "winter-horrorland":
					var blackScreen:FlxSprite = new FlxSprite(0, 0).makeGraphic(Std.int(FlxG.width * 2), Std.int(FlxG.height * 2), FlxColor.BLACK);
					add(blackScreen);
					blackScreen.scrollFactor.set();
					camHUD.visible = false;

					new FlxTimer().start(0.1, function(tmr:FlxTimer)
					{
						remove(blackScreen);
						FlxG.sound.play(Paths.sound('Lights_Turn_On'));
						camFollow.y = -2050;
						camFollow.x += 200;
						FlxG.camera.focusOn(camFollow.getPosition());
						FlxG.camera.zoom = 1.5;

						new FlxTimer().start(0.8, function(tmr:FlxTimer)
						{
							camHUD.visible = true;
							remove(blackScreen);
							FlxTween.tween(FlxG.camera, {zoom: defaultCamZoom}, 2.5, {
								ease: FlxEase.quadInOut,
								onComplete: function(twn:FlxTween)
								{
									startCountdown();
								}
							});
						});
					});
				case 'senpai':
					schoolIntro(doof);
				case 'roses':
					FlxG.sound.play(Paths.sound('ANGRY'));
					schoolIntro(doof);
				case 'thorns':
					schoolIntro(doof);
				case 'nerves' | 'release' | 'fading':
					schoolIntro(doof);
					case 'ballistic' | 'ballistic-old':
						turnToCrazyWhitty();
						startCountdown();
				case 'headache':
					var introText:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image('mods/gar/garIntroText'));
					introText.setGraphicSize(Std.int(introText.width * 1.5));
					introText.scrollFactor.set();
					camHUD.visible = false;

					add(introText);

					new FlxTimer().start(0.1, function(tmr:FlxTimer)
					{
						// FlxG.sound.play(Paths.sound('Lights_Turn_On'));
					
						new FlxTimer().start(3, function(tmr:FlxTimer)
						{
							FlxTween.tween(FlxG.camera, {zoom: defaultCamZoom}, 2.5, {
								ease: FlxEase.quadInOut,
								onComplete: function(twn:FlxTween)
								{
									FlxG.sound.music.fadeOut(2.2, 0);
									remove(introText);
									camHUD.visible = true;
									schoolIntro(doof);
								}
							});
						});
					});
				default:
					startCountdown();
			}
		}
		else
			{
				switch (curSong.toLowerCase())
				{
					case 'ballistic' | 'ballistic-old':
						turnToCrazyWhitty();
						startCountdown();
					default:
						startCountdown();
				}
			}

		
		//if (!loadRep)
			//rep = new Replay("na");

		new FlxTimer().start(1, function(tmr:FlxTimer){
			curTime += 1;
			timeHit();
			tmr.reset(1);
		});

		if (FlxG.save.data.botplay && FlxG.save.data.hudless)
			camHUD.visible = false;

		super.create();
	}

	function turnToCrazyWhitty()
		{
	
			remove(iconP2);
			remove(iconP1);
			remove(healthBarBG);
			remove(healthBar);
	
			iconP2 = new HealthIcon('whittyCrazy', false);
			iconP2.y = healthBar.y - (iconP2.height / 2);
	
			iconP1 = new HealthIcon(SONG.player1, true);
			iconP1.y = healthBar.y - (iconP1.height / 2);
	
			add(healthBarBG);
			add(healthBar);
	
			add(iconP2);
			add(iconP1);
	
			iconP1.cameras = [camHUD];
			iconP2.cameras = [camHUD];
	
			healthBar.cameras = [camHUD];
			healthBarBG.cameras = [camHUD];
	
			remove(dad);
			remove(gf);
			dad = new Character(100,100,'whittyCrazy');
			add(gf);
			add(dad);
	
			if (isStoryMode)
			{
				iconP1.visible = false;
				iconP2.visible = false;
			}
	
		}
	function schoolIntro(?dialogueBox:DialogueBox):Void
	{
		var black:FlxSprite = new FlxSprite(-100, -100).makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.BLACK);
		black.scrollFactor.set();
		add(black);

		var red:FlxSprite = new FlxSprite(-100, -100).makeGraphic(FlxG.width * 2, FlxG.height * 2, 0xFFff1b31);
		red.scrollFactor.set();

		var senpaiEvil:FlxSprite = new FlxSprite();
		senpaiEvil.frames = Paths.getSparrowAtlas('weeb/senpaiCrazy');
		senpaiEvil.animation.addByPrefix('idle', 'Senpai Pre Explosion', 24, false);
		senpaiEvil.setGraphicSize(Std.int(senpaiEvil.width * 6));
		senpaiEvil.scrollFactor.set();
		senpaiEvil.updateHitbox();
		senpaiEvil.screenCenter();

		//bob :)

		// pre lowercasing the song name (schoolIntro)
		var songLowercase = StringTools.replace(PlayState.SONG.song, " ", "-").toLowerCase();
			switch (songLowercase) {
				case 'dad-battle': songLowercase = 'dadbattle';
				case 'philly-nice': songLowercase = 'philly';
			}
		if (songLowercase == 'roses' || songLowercase == 'thorns')
		{
			remove(black);

			if (songLowercase == 'thorns')
			{
				add(red);
			}
		}

		new FlxTimer().start(0.3, function(tmr:FlxTimer)
		{
			black.alpha -= 0.15;

			if (black.alpha > 0)
			{
				tmr.reset(0.3);
			}
			else
			{
				if (dialogueBox != null)
				{
					inCutscene = true;

					if (songLowercase == 'thorns')
					{
						add(senpaiEvil);
						senpaiEvil.alpha = 0;
						new FlxTimer().start(0.3, function(swagTimer:FlxTimer)
						{
							senpaiEvil.alpha += 0.15;
							if (senpaiEvil.alpha < 1)
							{
								swagTimer.reset();
							}
							else
							{
								senpaiEvil.animation.play('idle');
								FlxG.sound.play(Paths.sound('Senpai_Dies'), 1, false, null, true, function()
								{
									remove(senpaiEvil);
									remove(red);
									FlxG.camera.fade(FlxColor.WHITE, 0.01, true, function()
									{
										add(dialogueBox);
									}, true);
								});
								new FlxTimer().start(3.2, function(deadTime:FlxTimer)
								{
									FlxG.camera.fade(FlxColor.WHITE, 1.6, false);
								});
							}
						});
					}
					else
					{
						add(dialogueBox);
					}
				}
				else
					startCountdown();

				remove(black);
			}
		});
	}

	var startTimer:FlxTimer;
	var perfectMode:Bool = false;

	var luaWiggles:Array<WiggleEffect> = [];

	#if windows
	public static var luaModchart:ModchartState = null;
	#end

	function startCountdown():Void
	{
		#if android
		mcontrols.visible = true;
		#end
		inCutscene = false;

		generateStaticArrows(0);
		generateStaticArrows(1);


		#if windows
		if (executeModchart)
		{
			luaModchart = ModchartState.createModchartState();
			luaModchart.executeState('start',[PlayState.SONG.song]);
		}
		#end

		talking = false;
		startedCountdown = true;
		Conductor.songPosition = 0;
		Conductor.songPosition -= Conductor.crochet * 5;

		var swagCounter:Int = 0;

		startTimer = new FlxTimer().start(Conductor.crochet / 1000, function(tmr:FlxTimer)
		{
			dad.dance();
			gf.dance();
			boyfriend.playAnim('idle');

			var introAssets:Map<String, Array<String>> = new Map<String, Array<String>>();
			introAssets.set('default', ['ready', "set", "go"]);
			introAssets.set('school', [
				'weeb/pixelUI/ready-pixel',
				'weeb/pixelUI/set-pixel',
				'weeb/pixelUI/date-pixel'
			]);
			introAssets.set('schoolEvil', [
				'weeb/pixelUI/ready-pixel',
				'weeb/pixelUI/set-pixel',
				'weeb/pixelUI/date-pixel'
			]);

			var introAlts:Array<String> = introAssets.get('default');
			var altSuffix:String = "";

			for (value in introAssets.keys())
			{
				if (value == curStage)
				{
					introAlts = introAssets.get(value);
					altSuffix = '-pixel';
				}
			}

			switch (swagCounter)

			{
				case 0:
					FlxG.sound.play(Paths.sound('intro3' + altSuffix), 0.6);
				case 1:
					var ready:FlxSprite = new FlxSprite().loadGraphic(Paths.image(introAlts[0]));
					ready.scrollFactor.set();
					ready.updateHitbox();

					if (curStage.startsWith('school'))
						ready.setGraphicSize(Std.int(ready.width * daPixelZoom));

					ready.screenCenter();
					add(ready);
					FlxTween.tween(ready, {y: ready.y += 100, alpha: 0}, Conductor.crochet / 1000, {
						ease: FlxEase.cubeInOut,
						onComplete: function(twn:FlxTween)
						{
							ready.destroy();
						}
					});
					FlxG.sound.play(Paths.sound('intro2' + altSuffix), 0.6);
				case 2:
					var set:FlxSprite = new FlxSprite().loadGraphic(Paths.image(introAlts[1]));
					set.scrollFactor.set();

					if (curStage.startsWith('school'))
						set.setGraphicSize(Std.int(set.width * daPixelZoom));

					set.screenCenter();
					add(set);
					FlxTween.tween(set, {y: set.y += 100, alpha: 0}, Conductor.crochet / 1000, {
						ease: FlxEase.cubeInOut,
						onComplete: function(twn:FlxTween)
						{
							set.destroy();
						}
					});
					FlxG.sound.play(Paths.sound('intro1' + altSuffix), 0.6);
				case 3:
					var go:FlxSprite = new FlxSprite().loadGraphic(Paths.image(introAlts[2]));
					go.scrollFactor.set();

					if (curStage.startsWith('school'))
						go.setGraphicSize(Std.int(go.width * daPixelZoom));

					go.updateHitbox();

					go.screenCenter();
					add(go);
					FlxTween.tween(go, {y: go.y += 100, alpha: 0}, Conductor.crochet / 1000, {
						ease: FlxEase.cubeInOut,
						onComplete: function(twn:FlxTween)
						{
							go.destroy();
						}
					});
					FlxG.sound.play(Paths.sound('introGo' + altSuffix), 0.6);
				case 4:
			}

			swagCounter += 1;
			// generateSong('fresh');
		}, 5);
	}

	var previousFrameTime:Int = 0;
	var lastReportedPlayheadPosition:Int = 0;
	var songTime:Float = 0;


	var songStarted = false;

	function startSong():Void
	{
		startingSong = false;
		songStarted = true;
		previousFrameTime = FlxG.game.ticks;
		lastReportedPlayheadPosition = 0;

		if (!paused)
		{
			FlxG.sound.playMusic(Paths.inst(PlayState.SONG.song), 1, false);
		}

		FlxG.sound.music.onComplete = endSong;
		vocals.play();

		// Song duration in a float, useful for the time left feature
		songLength = FlxG.sound.music.length;

		if (FlxG.save.data.songPosition)
		{
			remove(songPosBG);
			remove(songPosBar);
			remove(songName);

			songPosBG = new FlxSprite(0, 10).loadGraphic(Paths.image('healthBar'));
			if (FlxG.save.data.downscroll)
				songPosBG.y = FlxG.height * 0.9 + 45; 
			songPosBG.screenCenter(X);
			songPosBG.scrollFactor.set();
			add(songPosBG);

			songPosBar = new FlxBar(songPosBG.x + 4, songPosBG.y + 4, LEFT_TO_RIGHT, Std.int(songPosBG.width - 8), Std.int(songPosBG.height - 8), this,
				'songPositionBar', 0, songLength - 1000);
			songPosBar.numDivisions = 1000;
			songPosBar.scrollFactor.set();
			songPosBar.createFilledBar(FlxColor.GRAY, FlxColor.LIME);
			add(songPosBar);

			var songName = new FlxText(songPosBG.x + (songPosBG.width / 2) - 20,songPosBG.y,0,SONG.song, 16);
			if (FlxG.save.data.downscroll)
				songName.y -= 3;
			songName.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
			songName.scrollFactor.set();
			add(songName);

			songPosBG.cameras = [camHUD];
			songPosBar.cameras = [camHUD];
			songName.cameras = [camHUD];
		}
		
		// Song check real quick
		switch(curSong)
		{
			case 'Bopeebo' | 'Philly Nice' | 'Blammed' | 'Cocoa' | 'Eggnog': allowedToHeadbang = true;
			default: allowedToHeadbang = false;
		}
		
		#if windows
		// Updating Discord Rich Presence (with Time Left)
		DiscordClient.changePresence(detailsText + " " + SONG.song + " (" + storyDifficultyText + ") " + Ratings.GenerateLetterRank(accuracy), "\nAcc: " + HelperFunctions.truncateFloat(accuracy, 2) + "% | Score: " + songScore + " | Misses: " + misses  , iconRPC);
		#end
	}

	var debugNum:Int = 0;

	private function generateSong(dataPath:String):Void
	{
		// FlxG.log.add(ChartParser.parse());

		var songData = SONG;
		Conductor.changeBPM(songData.bpm);

		curSong = songData.song;

		if (SONG.needsVoices)
			vocals = new FlxSound().loadEmbedded(Paths.voices(PlayState.SONG.song));
		else
			vocals = new FlxSound();

		trace('loaded vocals');

		FlxG.sound.list.add(vocals);

		notes = new FlxTypedGroup<Note>();
		add(notes);

		var noteData:Array<SwagSection>;

		// NEW SHIT
		noteData = songData.notes;

		var playerCounter:Int = 0;

		// pre lowercasing the song name (generateSong)
		var songLowercase = StringTools.replace(PlayState.SONG.song, " ", "-").toLowerCase();
			switch (songLowercase) {
				case 'dad-battle': songLowercase = 'dadbattle';
				case 'philly-nice': songLowercase = 'philly';
			}
		// Per song offset check
		#if windows
			var songPath = 'assets/data/' + songLowercase + '/';
			
			for(file in sys.FileSystem.readDirectory(songPath))
			{
				var path = haxe.io.Path.join([songPath, file]);
				if(!sys.FileSystem.isDirectory(path))
				{
					if(path.endsWith('.offset'))
					{
						trace('Found offset file: ' + path);
						songOffset = Std.parseFloat(file.substring(0, file.indexOf('.off')));
						break;
					}else {
						trace('Offset file not found. Creating one @: ' + songPath);
						sys.io.File.saveContent(songPath + songOffset + '.offset', '');
					}
				}
			}
		#end
		var daBeats:Int = 0; // Not exactly representative of 'daBeats' lol, just how much it has looped
		for (section in noteData)
		{
			var coolSection:Int = Std.int(section.lengthInSteps / 4);

			for (songNotes in section.sectionNotes)
			{
				var daStrumTime:Float = songNotes[0] + FlxG.save.data.offset + songOffset;
				if (daStrumTime < 0)
					daStrumTime = 0;
				var daNoteData:Int = Std.int(songNotes[1] % 4);

				var gottaHitNote:Bool = section.mustHitSection;

				if (songNotes[1] > 3)
				{
					gottaHitNote = !section.mustHitSection;
				}

				var oldNote:Note;
				if (unspawnNotes.length > 0)
					oldNote = unspawnNotes[Std.int(unspawnNotes.length - 1)];
				else
					oldNote = null;

				var swagNote:Note = new Note(daStrumTime, daNoteData, oldNote);
				swagNote.sustainLength = songNotes[2];
				swagNote.scrollFactor.set(0, 0);

				var susLength:Float = swagNote.sustainLength;

				susLength = susLength / Conductor.stepCrochet;
				unspawnNotes.push(swagNote);

				for (susNote in 0...Math.floor(susLength))
				{
					oldNote = unspawnNotes[Std.int(unspawnNotes.length - 1)];

					var sustainNote:Note = new Note(daStrumTime + (Conductor.stepCrochet * susNote) + Conductor.stepCrochet, daNoteData, oldNote, true);
					sustainNote.scrollFactor.set();
					unspawnNotes.push(sustainNote);

					sustainNote.mustPress = gottaHitNote;

					if (sustainNote.mustPress)
					{
						sustainNote.x += FlxG.width / 2; // general offset
					}
				}

				swagNote.mustPress = gottaHitNote;

				if (swagNote.mustPress)
				{
					swagNote.x += FlxG.width / 2; // general offset
				}
				else
				{
				}
			}
			daBeats += 1;
		}

		// trace(unspawnNotes.length);
		// playerCounter += 1;

		unspawnNotes.sort(sortByShit);

		generatedMusic = true;
	}

	function sortByShit(Obj1:Note, Obj2:Note):Int
	{
		return FlxSort.byValues(FlxSort.ASCENDING, Obj1.strumTime, Obj2.strumTime);
	}

	private function generateStaticArrows(player:Int):Void
	{
		for (i in 0...4)
		{
			// FlxG.log.add(i);
			var babyArrow:FlxSprite = new FlxSprite(0, strumLine.y);

			switch (SONG.noteStyle)
			{
				case 'pixel':
					babyArrow.loadGraphic(Paths.image('weeb/pixelUI/arrows-pixels'), true, 17, 17);
					babyArrow.animation.add('green', [6]);
					babyArrow.animation.add('red', [7]);
					babyArrow.animation.add('blue', [5]);
					babyArrow.animation.add('purplel', [4]);

					babyArrow.setGraphicSize(Std.int(babyArrow.width * daPixelZoom));
					babyArrow.updateHitbox();
					babyArrow.antialiasing = false;

					switch (Math.abs(i))
					{
						case 0:
							babyArrow.x += Note.swagWidth * 0;
							babyArrow.animation.add('static', [0]);
							babyArrow.animation.add('pressed', [4, 8], 12, false);
							babyArrow.animation.add('confirm', [12, 16], 24, false);
						case 1:
							babyArrow.x += Note.swagWidth * 1;
							babyArrow.animation.add('static', [1]);
							babyArrow.animation.add('pressed', [5, 9], 12, false);
							babyArrow.animation.add('confirm', [13, 17], 24, false);
						case 2:
							babyArrow.x += Note.swagWidth * 2;
							babyArrow.animation.add('static', [2]);
							babyArrow.animation.add('pressed', [6, 10], 12, false);
							babyArrow.animation.add('confirm', [14, 18], 12, false);
						case 3:
							babyArrow.x += Note.swagWidth * 3;
							babyArrow.animation.add('static', [3]);
							babyArrow.animation.add('pressed', [7, 11], 12, false);
							babyArrow.animation.add('confirm', [15, 19], 24, false);
					}
				
				case 'normal':
				{
					babyArrow.frames = Paths.getSparrowAtlas('notes/'+ FlxG.save.data.noteAsset + '_assets','shared');
					babyArrow.animation.addByPrefix('green', 'arrowUP');
					babyArrow.animation.addByPrefix('blue', 'arrowDOWN');
					babyArrow.animation.addByPrefix('purple', 'arrowLEFT');
					babyArrow.animation.addByPrefix('red', 'arrowRIGHT');
	
					babyArrow.antialiasing = true;
					babyArrow.setGraphicSize(Std.int(babyArrow.width * 0.7));
	
					switch (Math.abs(i))
					{
						case 0:
							babyArrow.x += Note.swagWidth * 0;
							babyArrow.animation.addByPrefix('static', 'arrowLEFT');
							babyArrow.animation.addByPrefix('pressed', 'left press', 24, false);
							babyArrow.animation.addByPrefix('confirm', 'left confirm', 24, false);
						case 1:
							babyArrow.x += Note.swagWidth * 1;
							babyArrow.animation.addByPrefix('static', 'arrowDOWN');
							babyArrow.animation.addByPrefix('pressed', 'down press', 24, false);
							babyArrow.animation.addByPrefix('confirm', 'down confirm', 24, false);
						case 2:
							babyArrow.x += Note.swagWidth * 2;
							babyArrow.animation.addByPrefix('static', 'arrowUP');
							babyArrow.animation.addByPrefix('pressed', 'up press', 24, false);
							babyArrow.animation.addByPrefix('confirm', 'up confirm', 24, false);
						case 3:
							babyArrow.x += Note.swagWidth * 3;
							babyArrow.animation.addByPrefix('static', 'arrowRIGHT');
							babyArrow.animation.addByPrefix('pressed', 'right press', 24, false);
							babyArrow.animation.addByPrefix('confirm', 'right confirm', 24, false);
						}
				}
				default:
				{
					babyArrow.frames = Paths.getSparrowAtlas('notes/'+FlxG.save.data.noteAsset+'_assets','shared');
					babyArrow.animation.addByPrefix('green', 'arrowUP');
					babyArrow.animation.addByPrefix('blue', 'arrowDOWN');
					babyArrow.animation.addByPrefix('purple', 'arrowLEFT');
					babyArrow.animation.addByPrefix('red', 'arrowRIGHT');

					babyArrow.antialiasing = true;
					babyArrow.setGraphicSize(Std.int(babyArrow.width * 0.7));

					switch (Math.abs(i))
					{
						case 0:
							babyArrow.x += Note.swagWidth * 0;
							babyArrow.animation.addByPrefix('static', 'arrowLEFT');
							babyArrow.animation.addByPrefix('pressed', 'left press', 24, false);
							babyArrow.animation.addByPrefix('confirm', 'left confirm', 24, false);
						case 1:
							babyArrow.x += Note.swagWidth * 1;
							babyArrow.animation.addByPrefix('static', 'arrowDOWN');
							babyArrow.animation.addByPrefix('pressed', 'down press', 24, false);
							babyArrow.animation.addByPrefix('confirm', 'down confirm', 24, false);
						case 2:
							babyArrow.x += Note.swagWidth * 2;
							babyArrow.animation.addByPrefix('static', 'arrowUP');
							babyArrow.animation.addByPrefix('pressed', 'up press', 24, false);
							babyArrow.animation.addByPrefix('confirm', 'up confirm', 24, false);
						case 3:
							babyArrow.x += Note.swagWidth * 3;
							babyArrow.animation.addByPrefix('static', 'arrowRIGHT');
							babyArrow.animation.addByPrefix('pressed', 'right press', 24, false);
							babyArrow.animation.addByPrefix('confirm', 'right confirm', 24, false);
					}
				}
			}

			babyArrow.updateHitbox();
			babyArrow.scrollFactor.set();

			if (!isStoryMode)
			{
				babyArrow.y -= 10;
				babyArrow.alpha = 0;
				FlxTween.tween(babyArrow, {y: babyArrow.y + 10, alpha: 1}, 1, {ease: FlxEase.circOut, startDelay: 0.5 + (0.2 * i)});
			}

			babyArrow.ID = i;

			switch (player)
			{
				case 0:
					cpuStrums.add(babyArrow);
				case 1:
					playerStrums.add(babyArrow);
			}

			if (FlxG.save.data.middlescroll && player == 0)
			{
				babyArrow.visible = false;
			}

			if (FlxG.save.data.middlescroll)
			{
				babyArrow.x -= 275;
			}



			babyArrow.animation.play('static');
			babyArrow.x += 50;
			babyArrow.x += ((FlxG.width / 2) * player);

			
			cpuStrums.forEach(function(spr:FlxSprite)
			{					
				spr.centerOffsets(); //CPU arrows start out slightly off-center
			});

			strumLineNotes.add(babyArrow);
		}
	}

	function tweenCamIn():Void
	{
		FlxTween.tween(FlxG.camera, {zoom: 1.3}, (Conductor.stepCrochet * 4 / 1000), {ease: FlxEase.elasticInOut});
	}

	override function openSubState(SubState:FlxSubState)
	{
		if (paused)
		{
			if (FlxG.sound.music != null)
			{
				FlxG.sound.music.pause();
				vocals.pause();
			}

			#if windows
			DiscordClient.changePresence("PAUSED on " + SONG.song + " (" + storyDifficultyText + ") " + Ratings.GenerateLetterRank(accuracy), "Acc: " + HelperFunctions.truncateFloat(accuracy, 2) + "% | Score: " + songScore + " | Misses: " + misses  , iconRPC);
			#end
			if (!startTimer.finished)
				startTimer.active = false;
		}

		super.openSubState(SubState);
	}

	override function closeSubState()
	{
		if (paused)
		{
			if (FlxG.sound.music != null && !startingSong)
			{
				resyncVocals();
			}

			if (!startTimer.finished)
				startTimer.active = true;
			paused = false;

			#if windows
			if (startTimer.finished)
			{
				DiscordClient.changePresence(detailsText + " " + SONG.song + " (" + storyDifficultyText + ") " + Ratings.GenerateLetterRank(accuracy), "\nAcc: " + HelperFunctions.truncateFloat(accuracy, 2) + "% | Score: " + songScore + " | Misses: " + misses, iconRPC, true, songLength - Conductor.songPosition);
			}
			else
			{
				DiscordClient.changePresence(detailsText, SONG.song + " (" + storyDifficultyText + ") " + Ratings.GenerateLetterRank(accuracy), iconRPC);
			}
			#end
		}

		super.closeSubState();
	}
	

	function resyncVocals():Void
	{
		vocals.pause();

		FlxG.sound.music.play();
		Conductor.songPosition = FlxG.sound.music.time;
		vocals.time = Conductor.songPosition;
		vocals.play();

		#if windows
		DiscordClient.changePresence(detailsText + " " + SONG.song + " (" + storyDifficultyText + ") " + Ratings.GenerateLetterRank(accuracy), "\nAcc: " + HelperFunctions.truncateFloat(accuracy, 2) + "% | Score: " + songScore + " | Misses: " + misses  , iconRPC);
		#end
	}

	private var paused:Bool = false;
	var startedCountdown:Bool = false;
	var canPause:Bool = true;
	var nps:Int = 0;
	var maxNPS:Int = 0;

	public static var songRate = 1.5;
	
	function switchEdgy(edgy:Bool)
	{
		var bfX = boyfriend.x;
		var bfY = boyfriend.y;
		var dadX = dad.x;
		var dadY = dad.y;
		var gfX = gf.x;
		var gfY = gf.y;
		if (edgy)
		{
			uBg.animation.play('edgy');
			remove(boyfriend);
			boyfriend = new Boyfriend(bfX, bfY, 'bf-edgy');
			add(boyfriend);
			remove(dad);
			dad = new Character(dadX, dadY, 'updike-edgy');
			add(dad);
			remove(gf);
			gf = new Character(gfX, gfY, 'gf-tied-edgy');
			add(gf);
		}
		else
		{
			uBg.animation.play('bg');
			remove(boyfriend);
			boyfriend = new Boyfriend(bfX, bfY, 'bf-updike');
			add(boyfriend);
			remove(dad);
			dad = new Character(dadX, dadY, 'updike');
			add(dad);
			remove(gf);
			gf = new Character(gfX, gfY, 'gf-tied');
			add(gf);
		}
	}

	override public function update(elapsed:Float)
	{
		if (shakeCam)
		{
			FlxG.camera.shake(0.02, 0.03);
		}
		#if !debug
		perfectMode = false;
		#end


		if (FlxG.save.data.botplay && FlxG.keys.justPressed.ONE)
			camHUD.visible = !camHUD.visible;

		#if windows
		if (executeModchart && luaModchart != null && songStarted)
		{
			luaModchart.setVar('songPos',Conductor.songPosition);
			luaModchart.setVar('hudZoom', camHUD.zoom);
			luaModchart.setVar('cameraZoom',FlxG.camera.zoom);
			luaModchart.executeState('update', [elapsed]);

			for (i in luaWiggles)
			{
				trace('wiggle le gaming');
				i.update(elapsed);
			}

			/*for (i in 0...strumLineNotes.length) {
				var member = strumLineNotes.members[i];
				member.x = luaModchart.getVar("strum" + i + "X", "float");
				member.y = luaModchart.getVar("strum" + i + "Y", "float");
				member.angle = luaModchart.getVar("strum" + i + "Angle", "float");
			}*/

			FlxG.camera.angle = luaModchart.getVar('cameraAngle', 'float');
			camHUD.angle = luaModchart.getVar('camHudAngle','float');

			if (luaModchart.getVar("showOnlyStrums",'bool'))
			{
				healthBarBG.visible = false;
				kadeEngineWatermark.visible = false;
				healthBar.visible = false;
				iconP1.visible = false;
				iconP2.visible = false;
				scoreTxt.visible = false;
			}
			else
			{
				healthBarBG.visible = true;
				kadeEngineWatermark.visible = true;
				healthBar.visible = true;
				iconP1.visible = true;
				iconP2.visible = true;
				scoreTxt.visible = true;
			}

			var p1 = luaModchart.getVar("strumLine1Visible",'bool');
			var p2 = luaModchart.getVar("strumLine2Visible",'bool');

			for (i in 0...4)
			{
				strumLineNotes.members[i].visible = p1;
				if (i <= playerStrums.length)
					playerStrums.members[i].visible = p2;
			}

		}

		#end

		if (curStage == 'wityangy')
		{
			gf.playAnim('scared');
			wBg2.animation.play('gaming');
		}
		// reverse iterate to remove oldest notes first and not invalidate the iteration
		// stop iteration as soon as a note is not removed
		// all notes should be kept in the correct order and this is optimal, safe to do every frame/update
		{
			var balls = notesHitArray.length-1;
			while (balls >= 0)
			{
				var cock:Date = notesHitArray[balls];
				if (cock != null && cock.getTime() + 1000 < Date.now().getTime())
					notesHitArray.remove(cock);
				else
					balls = 0;
				balls--;
			}
			nps = notesHitArray.length;
			if (nps > maxNPS)
				maxNPS = nps;
		}

		if (FlxG.keys.justPressed.NINE)
		{
			if (iconP1.animation.curAnim.name == 'bf-old')
				iconP1.animation.play(SONG.player1);
			else
				iconP1.animation.play('bf-old');
		}

		switch (curStage)
		{
			case 'philly':
				if (trainMoving)
				{
					trainFrameTiming += elapsed;

					if (trainFrameTiming >= 1 / 24)
					{
						updateTrainPos();
						trainFrameTiming = 0;
					}
				}
				// phillyCityLights.members[curLight].alpha -= (Conductor.crochet / 1000) * FlxG.elapsed;
		}
		if (SONG.song.toLowerCase() == 'onslaught' && IsNoteSpinning){
			var thisX:Float =  Math.sin(SpinAmount * (SpinAmount / 2)) * 100;
			var thisY:Float =  Math.sin(SpinAmount * (SpinAmount)) * 100;
			var yVal = Std.int(windowY + thisY);
			var xVal = Std.int(windowX + thisX);
			if (!FlxG.save.data.shakingscreen)
				Lib.application.window.move(xVal,yVal);
			for (str in playerStrums){
				str.angle = str.angle + SpinAmount;
				SpinAmount = SpinAmount + 0.0003;
			}
		}
		else
		{
			for (str in playerStrums){
				str.angle = str.health;
			}
		}

		super.update(elapsed);

		scoreTxt.text = Ratings.CalculateRanking(songScore,songScoreDef,nps,maxNPS,accuracy);
		if (!FlxG.save.data.accuracyDisplay)
			scoreTxt.text = "Score: " + songScore;

		if (FlxG.keys.justPressed.ENTER #if android || FlxG.android.justReleased.BACK #end && startedCountdown && canPause)
		{
			persistentUpdate = false;
			persistentDraw = true;
			paused = true;

			// 1 / 1000 chance for Gitaroo Man easter egg
			if (FlxG.random.bool(0.1))
			{
				trace('GITAROO MAN EASTER EGG');
				FlxG.switchState(new GitarooPause());
			}
			else
			{
				if (FlxG.save.data.botplay)
					camHUD.visible = true;

				openSubState(new PauseSubState(boyfriend.getScreenPosition().x, boyfriend.getScreenPosition().y));
			}
		}

		if (FlxG.keys.justPressed.SEVEN)
		{
			#if windows
			DiscordClient.changePresence("Chart Editor", null, null, true);
			#end
			FlxG.switchState(new ChartingState());
			#if windows
			if (luaModchart != null)
			{
				luaModchart.die();
				luaModchart = null;
			}
			#end
		}

		// FlxG.watch.addQuick('VOL', vocals.amplitudeLeft);
		// FlxG.watch.addQuick('VOLRight', vocals.amplitudeRight);

		iconP1.setGraphicSize(Std.int(FlxMath.lerp(150, iconP1.width, 0.50)));
		iconP2.setGraphicSize(Std.int(FlxMath.lerp(150, iconP2.width, 0.50)));

		iconP1.updateHitbox();
		iconP2.updateHitbox();

		var iconOffset:Int = 26;

		if (curBeat == 2 && curSong == 'Ron' || daSong == 'ron bside' && curBeat == 2)
			{
				var bruh:FlxSprite = new FlxSprite();
				bruh.loadGraphic(Paths.image('mods/bob/longbob','shared'));
				bruh.antialiasing = true;
				bruh.active = false;
				bruh.scrollFactor.set();
				bruh.screenCenter();
				add(bruh);
				FlxTween.tween(bruh, {alpha: 0},1, {
					ease: FlxEase.cubeInOut,
					onComplete: function(twn:FlxTween)
					{
						bruh.destroy();
					}
				});
			}
			if (curSong == 'Ron' || daSong == 'ron bside')
			{
				if (curBeat == 7)
				{
					FlxTween.tween(FlxG.camera, {zoom: 1.5}, 0.4, {ease: FlxEase.expoOut,});
					dad.playAnim('cheer', true);
				}
				else if (curBeat == 119)
				{
					FlxTween.tween(FlxG.camera, {zoom: 1.5}, 0.4, {ease: FlxEase.expoOut,});
					dad.playAnim('cheer', true);
				}
				else if (curBeat == 215)
				{
					FlxG.camera.follow(dad, LOCKON, 0.04 * (30 / (cast (Lib.current.getChildAt(0), Main)).getFPS()));
					FlxTween.tween(FlxG.camera, {zoom: 1.5}, 0.4, {ease: FlxEase.expoOut,});
					dad.playAnim('cheer', true);
				}
				else
				{
					FlxG.camera.follow(camFollow, LOCKON, 0.04 * (30 / (cast (Lib.current.getChildAt(0), Main)).getFPS()));
				}
			}

		iconP1.x = healthBar.x + (healthBar.width * (FlxMath.remapToRange(healthBar.percent, 0, 100, 100, 0) * 0.01) - iconOffset);
		iconP2.x = healthBar.x + (healthBar.width * (FlxMath.remapToRange(healthBar.percent, 0, 100, 100, 0) * 0.01)) - (iconP2.width - iconOffset);

		if (health > 2)
			health = 2;
		if (healthBar.percent < 20)
			iconP1.animation.curAnim.curFrame = 1;
		else
			iconP1.animation.curAnim.curFrame = 0;

		if (healthBar.percent > 80)
			iconP2.animation.curAnim.curFrame = 1;
		else
			iconP2.animation.curAnim.curFrame = 0;

		/* if (FlxG.keys.justPressed.NINE)
			FlxG.switchState(new Charting()); */

		#if debug
		if (FlxG.keys.justPressed.EIGHT)
		{
			FlxG.switchState(new AnimationDebug(SONG.player2));
			#if windows
			if (luaModchart != null)
			{
				luaModchart.die();
				luaModchart = null;
			}
			#end
		}

		if (FlxG.keys.justPressed.ZERO)
		{
			FlxG.switchState(new AnimationDebug(SONG.player1));
			#if windows
			if (luaModchart != null)
			{
				luaModchart.die();
				luaModchart = null;
			}
			#end
		}

		#end

		if (startingSong)
		{
			if (startedCountdown)
			{
				Conductor.songPosition += FlxG.elapsed * 1000;
				if (Conductor.songPosition >= 0)
					startSong();
			}
		}
		else
		{
			// Conductor.songPosition = FlxG.sound.music.time;
			Conductor.songPosition += FlxG.elapsed * 1000;
			/*@:privateAccess
			{
				FlxG.sound.music._channel.
			}*/
			songPositionBar = Conductor.songPosition;

			if (!paused)
			{
				songTime += FlxG.game.ticks - previousFrameTime;
				previousFrameTime = FlxG.game.ticks;

				// Interpolation type beat
				if (Conductor.lastSongPos != Conductor.songPosition)
				{
					songTime = (songTime + Conductor.songPosition) / 2;
					Conductor.lastSongPos = Conductor.songPosition;
					// Conductor.songPosition += FlxG.elapsed * 1000;
					// trace('MISSED FRAME');
				}
			}

			// Conductor.lastSongPos = FlxG.sound.music.time;
		}

		if (generatedMusic && PlayState.SONG.notes[Std.int(curStep / 16)] != null)
		{
			// Make sure Girlfriend cheers only for certain songs
			if(allowedToHeadbang)
			{
				// Don't animate GF if something else is already animating her (eg. train passing)
				if(gf.animation.curAnim.name == 'danceLeft' || gf.animation.curAnim.name == 'danceRight' || gf.animation.curAnim.name == 'idle')
				{
					// Per song treatment since some songs will only have the 'Hey' at certain times
					switch(curSong)
					{
						case 'Philly Nice':
						{
							// General duration of the song
							if(curBeat < 250)
							{
								// Beats to skip or to stop GF from cheering
								if(curBeat != 184 && curBeat != 216)
								{
									if(curBeat % 16 == 8)
									{
										// Just a garantee that it'll trigger just once
										if(!triggeredAlready)
										{
											gf.playAnim('cheer');
											triggeredAlready = true;
										}
									}else triggeredAlready = false;
								}
							}
						}
						case 'Bopeebo':
						{
							// Where it starts || where it ends
							if(curBeat > 5 && curBeat < 130)
							{
								if(curBeat % 8 == 7)
								{
									if(!triggeredAlready)
									{
										gf.playAnim('cheer');
										triggeredAlready = true;
									}
								}else triggeredAlready = false;
							}
						}
						case 'Blammed':
						{
							if(curBeat > 30 && curBeat < 190)
							{
								if(curBeat < 90 || curBeat > 128)
								{
									if(curBeat % 4 == 2)
									{
										if(!triggeredAlready)
										{
											gf.playAnim('cheer');
											triggeredAlready = true;
										}
									}else triggeredAlready = false;
								}
							}
						}
						case 'Cocoa':
						{
							if(curBeat < 170)
							{
								if(curBeat < 65 || curBeat > 130 && curBeat < 145)
								{
									if(curBeat % 16 == 15)
									{
										if(!triggeredAlready)
										{
											gf.playAnim('cheer');
											triggeredAlready = true;
										}
									}else triggeredAlready = false;
								}
							}
						}
						case 'Eggnog':
						{
							if(curBeat > 10 && curBeat != 111 && curBeat < 220)
							{
								if(curBeat % 8 == 7)
								{
									if(!triggeredAlready)
									{
										gf.playAnim('cheer');
										triggeredAlready = true;
									}
								}else triggeredAlready = false;
							}
						}
					}
				}
			}
			
			#if windows
			if (luaModchart != null)
				luaModchart.setVar("mustHit",PlayState.SONG.notes[Std.int(curStep / 16)].mustHitSection);
			#end

			if (camFollow.x != dad.getMidpoint().x + 150 && !PlayState.SONG.notes[Std.int(curStep / 16)].mustHitSection)
			{
				var offsetX = 0;
				var offsetY = 0;
				#if windows
				if (luaModchart != null)
				{
					offsetX = luaModchart.getVar("followXOffset", "float");
					offsetY = luaModchart.getVar("followYOffset", "float");
				}
				#end
				camFollow.setPosition(dad.getMidpoint().x + 150 + offsetX, dad.getMidpoint().y - 100 + offsetY);
				#if windows
				if (luaModchart != null)
					luaModchart.executeState('playerTwoTurn', []);
				#end
				// camFollow.setPosition(lucky.getMidpoint().x - 120, lucky.getMidpoint().y + 210);

				switch (dad.curCharacter)
				{
					case 'mom':
						camFollow.y = dad.getMidpoint().y;
					case 'senpai':
						camFollow.y = dad.getMidpoint().y - 430;
						camFollow.x = dad.getMidpoint().x - 100;
					case 'senpai-angry':
						camFollow.y = dad.getMidpoint().y - 430;
						camFollow.x = dad.getMidpoint().x - 100;
				}

				if (dad.curCharacter == 'mom')
					vocals.volume = 1;
			}

			if (PlayState.SONG.notes[Std.int(curStep / 16)].mustHitSection && camFollow.x != boyfriend.getMidpoint().x - 100)
			{
				var offsetX = 0;
				var offsetY = 0;
				#if windows
				if (luaModchart != null)
				{
					offsetX = luaModchart.getVar("followXOffset", "float");
					offsetY = luaModchart.getVar("followYOffset", "float");
				}
				#end
				camFollow.setPosition(boyfriend.getMidpoint().x - 100 + offsetX, boyfriend.getMidpoint().y - 100 + offsetY);

				#if windows
				if (luaModchart != null)
					luaModchart.executeState('playerOneTurn', []);
				#end

				switch (curStage)
				{
					case 'limo':
						camFollow.x = boyfriend.getMidpoint().x - 300;
					case 'mall':
						camFollow.y = boyfriend.getMidpoint().y - 200;
					case 'school':
						camFollow.x = boyfriend.getMidpoint().x - 200;
						camFollow.y = boyfriend.getMidpoint().y - 200;
					case 'schoolEvil':
						camFollow.x = boyfriend.getMidpoint().x - 200;
						camFollow.y = boyfriend.getMidpoint().y - 200;
				}
			}
		}

		if (camZooming)
		{
			FlxG.camera.zoom = FlxMath.lerp(defaultCamZoom, FlxG.camera.zoom, 0.95);
			camHUD.zoom = FlxMath.lerp(1, camHUD.zoom, 0.95);
		}

		FlxG.watch.addQuick("beatShit", curBeat);
		FlxG.watch.addQuick("stepShit", curStep);

		if (curSong == 'Fresh')
		{
			switch (curBeat)
			{
				case 16:
					camZooming = true;
					gfSpeed = 2;
				case 48:
					gfSpeed = 1;
				case 80:
					gfSpeed = 2;
				case 112:
					gfSpeed = 1;
				case 163:
					// FlxG.sound.music.stop();
					// FlxG.switchState(new TitleState());
			}
		}

		if (curSong == 'Bopeebo')
		{
			switch (curBeat)
			{
				case 128, 129, 130:
					vocals.volume = 0;
					// FlxG.sound.music.stop();
					// FlxG.switchState(new PlayState());
			}
		}

		if (health <= 0)
		{
			boyfriend.stunned = true;

			persistentUpdate = false;
			persistentDraw = false;
			paused = true;

			vocals.stop();
			FlxG.sound.music.stop();

			openSubState(new GameOverSubstate(boyfriend.getScreenPosition().x, boyfriend.getScreenPosition().y));

			#if windows
			// Game Over doesn't get his own variable because it's only used here
			DiscordClient.changePresence("GAME OVER -- " + SONG.song + " (" + storyDifficultyText + ") " + Ratings.GenerateLetterRank(accuracy),"\nAcc: " + HelperFunctions.truncateFloat(accuracy, 2) + "% | Score: " + songScore + " | Misses: " + misses  , iconRPC);
			#end

			// FlxG.switchState(new GameOverState(boyfriend.getScreenPosition().x, boyfriend.getScreenPosition().y));
		}
 		if (FlxG.save.data.resetButton)
		{
			if(FlxG.keys.justPressed.R)
				{
					boyfriend.stunned = true;

					persistentUpdate = false;
					persistentDraw = false;
					paused = true;
		
					vocals.stop();
					FlxG.sound.music.stop();
		
					openSubState(new GameOverSubstate(boyfriend.getScreenPosition().x, boyfriend.getScreenPosition().y));
		
					#if windows
					// Game Over doesn't get his own variable because it's only used here
					DiscordClient.changePresence("GAME OVER -- " + SONG.song + " (" + storyDifficultyText + ") " + Ratings.GenerateLetterRank(accuracy),"\nAcc: " + HelperFunctions.truncateFloat(accuracy, 2) + "% | Score: " + songScore + " | Misses: " + misses  , iconRPC);
					#end
		
					// FlxG.switchState(new GameOverState(boyfriend.getScreenPosition().x, boyfriend.getScreenPosition().y));
				}
		}

		if (unspawnNotes[0] != null)
		{
			if (unspawnNotes[0].strumTime - Conductor.songPosition < 3500)
			{
				var dunceNote:Note = unspawnNotes[0];
				notes.add(dunceNote);

				var index:Int = unspawnNotes.indexOf(dunceNote);
				unspawnNotes.splice(index, 1);
			}
		}

		if (generatedMusic)
			{
				notes.forEachAlive(function(daNote:Note)
				{	

					// instead of doing stupid y > FlxG.height
					// we be men and actually calculate the time :)
					if (daNote.tooLate)
					{
						daNote.active = false;
						daNote.visible = false;
					}
					else
					{
						daNote.visible = true;
						daNote.active = true;
					}
					
					if (!daNote.modifiedByLua)
						{
							if (FlxG.save.data.downscroll)
							{
								if (daNote.mustPress)
									daNote.y = (playerStrums.members[Math.floor(Math.abs(daNote.noteData))].y + 0.45 * (Conductor.songPosition - daNote.strumTime) * FlxMath.roundDecimal(FlxG.save.data.scrollSpeed == 1 ? SONG.speed : FlxG.save.data.scrollSpeed, 2));
								else
									daNote.y = (strumLineNotes.members[Math.floor(Math.abs(daNote.noteData))].y + 0.45 * (Conductor.songPosition - daNote.strumTime) * FlxMath.roundDecimal(FlxG.save.data.scrollSpeed == 1 ? SONG.speed : FlxG.save.data.scrollSpeed, 2));
								if(daNote.isSustainNote)
								{
									// Remember = minus makes notes go up, plus makes them go down
									if(daNote.animation.curAnim.name.endsWith('end') && daNote.prevNote != null)
										daNote.y += daNote.prevNote.height;
									else
										daNote.y += daNote.height / 2;
	
									// If not in botplay, only clip sustain notes when properly hit, botplay gets to clip it everytime
									if(!FlxG.save.data.botplay)
									{
										if((!daNote.mustPress || daNote.wasGoodHit || daNote.prevNote.wasGoodHit && !daNote.canBeHit) && daNote.y - daNote.offset.y * daNote.scale.y + daNote.height >= (strumLine.y + Note.swagWidth / 2))
										{
											// Clip to strumline
											var swagRect = new FlxRect(0, 0, daNote.frameWidth * 2, daNote.frameHeight * 2);
											swagRect.height = (strumLineNotes.members[Math.floor(Math.abs(daNote.noteData))].y + Note.swagWidth / 2 - daNote.y) / daNote.scale.y;
											swagRect.y = daNote.frameHeight - swagRect.height;
	
											daNote.clipRect = swagRect;
										}
									}else {
										var swagRect = new FlxRect(0, 0, daNote.frameWidth * 2, daNote.frameHeight * 2);
										swagRect.height = (strumLineNotes.members[Math.floor(Math.abs(daNote.noteData))].y + Note.swagWidth / 2 - daNote.y) / daNote.scale.y;
										swagRect.y = daNote.frameHeight - swagRect.height;
	
										daNote.clipRect = swagRect;
									}
								}
							}else
							{
								if (daNote.mustPress)
									daNote.y = (playerStrums.members[Math.floor(Math.abs(daNote.noteData))].y - 0.45 * (Conductor.songPosition - daNote.strumTime) * FlxMath.roundDecimal(FlxG.save.data.scrollSpeed == 1 ? SONG.speed : FlxG.save.data.scrollSpeed, 2));
								else
									daNote.y = (strumLineNotes.members[Math.floor(Math.abs(daNote.noteData))].y - 0.45 * (Conductor.songPosition - daNote.strumTime) * FlxMath.roundDecimal(FlxG.save.data.scrollSpeed == 1 ? SONG.speed : FlxG.save.data.scrollSpeed, 2));
								if(daNote.isSustainNote)
								{
									daNote.y -= daNote.height / 2;
	
									if(!FlxG.save.data.botplay)
									{
										if((!daNote.mustPress || daNote.wasGoodHit || daNote.prevNote.wasGoodHit && !daNote.canBeHit) && daNote.y + daNote.offset.y * daNote.scale.y <= (strumLine.y + Note.swagWidth / 2))
										{
											// Clip to strumline
											var swagRect = new FlxRect(0, 0, daNote.width / daNote.scale.x, daNote.height / daNote.scale.y);
											swagRect.y = (strumLineNotes.members[Math.floor(Math.abs(daNote.noteData))].y + Note.swagWidth / 2 - daNote.y) / daNote.scale.y;
											swagRect.height -= swagRect.y;
	
											daNote.clipRect = swagRect;
										}
									}else {
										var swagRect = new FlxRect(0, 0, daNote.width / daNote.scale.x, daNote.height / daNote.scale.y);
										swagRect.y = (strumLineNotes.members[Math.floor(Math.abs(daNote.noteData))].y + Note.swagWidth / 2 - daNote.y) / daNote.scale.y;
										swagRect.height -= swagRect.y;
	
										daNote.clipRect = swagRect;
									}
								}
							}
						}
		
	
					if (!daNote.mustPress && daNote.wasGoodHit)
					{
						if (SONG.song != 'Tutorial')
							camZooming = true;

						var altAnim:String = "";
	
						if (SONG.notes[Math.floor(curStep / 16)] != null)
						{
							if (SONG.notes[Math.floor(curStep / 16)].altAnim)
								altAnim = '-alt';
						}
	
						switch (Math.abs(daNote.noteData))
						{
							case 2:
								dad.playAnim('singUP' + altAnim, true);
							case 3:
								dad.playAnim('singRIGHT' + altAnim, true);
							case 1:
								dad.playAnim('singDOWN' + altAnim, true);
							case 0:
								dad.playAnim('singLEFT' + altAnim, true);
						}
						if (curStage == 'night') {
							switch (Math.abs(daNote.noteData))
							{
								case 2:
									pc.playAnim('singUP', true);
								case 3:
									pc.playAnim('singRIGHT', true);
								case 1:
									pc.playAnim('singDOWN', true);
								case 0:
									pc.playAnim('singLEFT', true);
							}
						}
						if (curStage == 'festival')
						{
							switch (Math.abs(daNote.noteData))
							{
								case 2:
								{
									if (FlxG.random.bool(50))
										max.playAnim('singUP');
									else
										abel.playAnim('singUP');
								}
								case 3:
								{
									if (FlxG.random.bool(50))
										max.playAnim('singRIGHT');
									else
										abel.playAnim('singRIGHT');
								}
								case 1:
								{
									if (FlxG.random.bool(50))
										max.playAnim('singDOWN');
									else
										abel.playAnim('singDOWN');
								}
								case 0:
								{
									if (FlxG.random.bool(50))
										max.playAnim('singLEFT');
									else
										abel.playAnim('singLEFT');
								}
							}
						}
						
						if (FlxG.save.data.cpuStrums)
						{
							cpuStrums.forEach(function(spr:FlxSprite)
							{
								if (Math.abs(daNote.noteData) == spr.ID)
								{
									spr.animation.play('confirm', true);
									// i wonder what will happen if i add some stuff here :flush:
									if (noteSplashOp && !FlxG.save.data.middlescroll)
									{
										var recycledNote = grpNoteSplashes.recycle(NoteSplash);
										recycledNote.setupNoteSplash(spr.x, spr.y, daNote.noteData);
										grpNoteSplashes.add(recycledNote);
									}

								}
								if (spr.animation.curAnim.name == 'confirm' && !curStage.startsWith('school'))
								{
									spr.centerOffsets();
									spr.offset.x -= 13;
									spr.offset.y -= 13;
								}
								else
									spr.centerOffsets();
							});
						}
	
						#if windows
						if (luaModchart != null)
							luaModchart.executeState('playerTwoSing', [Math.abs(daNote.noteData), Conductor.songPosition]);
						#end

						dad.holdTimer = 0;
	
						if (SONG.needsVoices)
							vocals.volume = 1;
	
						daNote.active = false;


						daNote.kill();
						notes.remove(daNote, true);
						daNote.destroy();
					}

					if (daNote.mustPress && !daNote.modifiedByLua)
					{
						daNote.visible = playerStrums.members[Math.floor(Math.abs(daNote.noteData))].visible;
						daNote.x = playerStrums.members[Math.floor(Math.abs(daNote.noteData))].x;
						if (!daNote.isSustainNote)
							daNote.angle = playerStrums.members[Math.floor(Math.abs(daNote.noteData))].angle;
						daNote.alpha = playerStrums.members[Math.floor(Math.abs(daNote.noteData))].alpha;
					}
					else if (!daNote.wasGoodHit && !daNote.modifiedByLua)
					{
						daNote.visible = strumLineNotes.members[Math.floor(Math.abs(daNote.noteData))].visible;
						daNote.x = strumLineNotes.members[Math.floor(Math.abs(daNote.noteData))].x;
						if (!daNote.isSustainNote)
							daNote.angle = strumLineNotes.members[Math.floor(Math.abs(daNote.noteData))].angle;
						daNote.alpha = strumLineNotes.members[Math.floor(Math.abs(daNote.noteData))].alpha;
					}
					
					

					if (daNote.isSustainNote)
						daNote.x += daNote.width / 2 + 17;
					

					//trace(daNote.y);
					// WIP interpolation shit? Need to fix the pause issue
					// daNote.y = (strumLine.y - (songTime - daNote.strumTime) * (0.45 * PlayState.SONG.speed));
	
					if ((daNote.mustPress && daNote.tooLate && !FlxG.save.data.downscroll || daNote.mustPress && daNote.tooLate && FlxG.save.data.downscroll) && daNote.mustPress)
					{
							if (daNote.isSustainNote && daNote.wasGoodHit)
							{
								daNote.kill();
								notes.remove(daNote, true);
							}
							else
							{
								health -= 0.075;
								vocals.volume = 0;
								if (theFunne)
									noteMiss(daNote.noteData, daNote);
							}
		
							daNote.visible = false;
							daNote.kill();
							notes.remove(daNote, true);
						}
					
				});
			}

		if (FlxG.save.data.cpuStrums)
		{
			cpuStrums.forEach(function(spr:FlxSprite)
			{
				if (spr.animation.finished)
				{
					spr.animation.play('static');
					spr.centerOffsets();
				}
			});
		}

		if (!inCutscene)
			keyShit();


		#if debug
		if (FlxG.keys.justPressed.ONE)
			endSong();
		#end
	}

	function endSong():Void
	{
		//if (!loadRep)
			//rep.SaveReplay(saveNotes);
		//else
		//{
		//	FlxG.save.data.botplay = false;
		//	FlxG.save.data.scrollSpeed = 1;
		//	FlxG.save.data.downscroll = false;
		//}

		if (FlxG.save.data.fpsCap > 290)
			(cast (Lib.current.getChildAt(0), Main)).setFPSCap(290);


		if (FlxG.save.data.botplay)
			FlxG.autoPause = true;

		#if windows
		if (luaModchart != null)
		{
			luaModchart.die();
			luaModchart = null;
		}
		#end

		canPause = false;
		FlxG.sound.music.volume = 0;
		vocals.volume = 0;
		if (SONG.validScore)
		{
			// adjusting the highscore song name to be compatible
			// would read original scores if we didn't change packages
			var songHighscore = StringTools.replace(PlayState.SONG.song, " ", "-");
			switch (songHighscore) {
				case 'Dad-Battle': songHighscore = 'Dadbattle';
				case 'Philly-Nice': songHighscore = 'Philly';
			}

			#if !switch
			Highscore.saveScore(songHighscore, Math.round(songScore), storyDifficulty);
			#end
		}

		if (offsetTesting)
		{
			FlxG.sound.playMusic(Paths.music('freakyMenu'));
			offsetTesting = false;
			LoadingState.loadAndSwitchState(new OptionsMenu());
			FlxG.save.data.offset = offsetTest;
		}
		else
		{
			if (isStoryMode)
			{
				campaignScore += Math.round(songScore);

				storyPlaylist.remove(storyPlaylist[0]);

				if (storyPlaylist.length <= 0)
				{
					FlxG.sound.playMusic(Paths.music('freakyMenu'));

					transIn = FlxTransitionableState.defaultTransIn;
					transOut = FlxTransitionableState.defaultTransOut;

					if (!isMod)
						FlxG.switchState(new StoryMenuState());
					else if (daSong == 'split')
						FlxG.switchState(new VideoState('videos/Cutscene4Subtitles-credits.webm', new StoryMenuState()));
					else
						FlxG.switchState(new ModsStoryState());

					#if windows
					if (luaModchart != null)
					{
						luaModchart.die();
						luaModchart = null;
					}
					#end

					// if ()
					StoryMenuState.weekUnlocked[Std.int(Math.min(storyWeek + 1, StoryMenuState.weekUnlocked.length - 1))] = true;

					if (SONG.validScore)
					{
						NGio.unlockMedal(60961);
						Highscore.saveWeekScore(storyWeek, campaignScore, storyDifficulty);
					}

					FlxG.save.data.weekUnlocked = StoryMenuState.weekUnlocked;
					FlxG.save.flush();
				}
				else
				{
					var difficulty:String = "";

					if (storyDifficulty == 0)
						difficulty = '-easy';

					if (storyDifficulty == 2)
						difficulty = '-hard';

					trace('LOADING NEXT SONG');
					// pre lowercasing the next story song name
					var nextSongLowercase = StringTools.replace(PlayState.storyPlaylist[0], " ", "-").toLowerCase();
						switch (nextSongLowercase) {
							case 'dad-battle': nextSongLowercase = 'dadbattle';
							case 'philly-nice': nextSongLowercase = 'philly';
						}
					trace(nextSongLowercase + difficulty);

					// pre lowercasing the song name (endSong)
					var songLowercase = StringTools.replace(PlayState.SONG.song, " ", "-").toLowerCase();
					switch (songLowercase) {
						case 'dad-battle': songLowercase = 'dadbattle';
						case 'philly-nice': songLowercase = 'philly';
					}
					if (songLowercase == 'eggnog')
					{
						var blackShit:FlxSprite = new FlxSprite(-FlxG.width * FlxG.camera.zoom,
							-FlxG.height * FlxG.camera.zoom).makeGraphic(FlxG.width * 3, FlxG.height * 3, FlxColor.BLACK);
						blackShit.scrollFactor.set();
						add(blackShit);
						camHUD.visible = false;

						FlxG.sound.play(Paths.sound('Lights_Shut_off'));
					}

					FlxTransitionableState.skipNextTransIn = true;
					FlxTransitionableState.skipNextTransOut = true;
					prevCamFollow = camFollow;

					PlayState.SONG = Song.loadFromJson(nextSongLowercase + difficulty, PlayState.storyPlaylist[0]);
					FlxG.sound.music.stop();

					if (daSong == 'nerves')
						FlxG.switchState(new VideoState('videos/garcello_dies.webm', new PlayState(), true));
					else if (daSong == 'jump-in')
						FlxG.switchState(new VideoState('videos/Cutscene2Subtitles.webm', new PlayState()));
					else if (daSong == 'swing')
						FlxG.switchState(new VideoState('videos/Cutscene3Subtitles.webm', new PlayState()));
					else if (daSong == 'ugh')
						FlxG.switchState(new VideoState('videos/gunsCutscene.webm', new PlayState(), true));
					else if (daSong == 'guns')
						FlxG.switchState(new VideoState('videos/stressCutscene.webm', new PlayState(), true));
					else
						LoadingState.loadAndSwitchState(new PlayState());
				}
			}
			else
			{
				trace('WENT BACK TO FREEPLAY??');
				if (!isMod)
					FlxG.switchState(new FreeplayState());
				else
					FlxG.switchState(new ModsFreeplayState());
			}
		}
	}


	var endingSong:Bool = false;

	var hits:Array<Float> = [];
	var offsetTest:Float = 0;

	var timeShown = 0;
	var currentTimingShown:FlxText = null;

	private function popUpScore(daNote:Note):Void
		{
			var noteDiff:Float = Math.abs(Conductor.songPosition - daNote.strumTime);
			var wife:Float = EtternaFunctions.wife3(noteDiff, Conductor.timeScale);
			// boyfriend.playAnim('hey');
			vocals.volume = 1;
	
			var placement:String = Std.string(combo);
	
			var coolText:FlxText = new FlxText(0, 0, 0, placement, 32);
			coolText.screenCenter();
			coolText.x = FlxG.width * 0.55;
			coolText.y -= 350;
			coolText.cameras = [camHUD];
			//
	
			var rating:FlxSprite = new FlxSprite();
			var score:Float = 350;

			if (FlxG.save.data.accuracyMod == 1)
				totalNotesHit += wife;

			var daRating = daNote.rating;

			switch(daRating)
			{
				case 'shit':
					score = -300;
					combo = 0;
					misses++;
					health -= 0.2;
					ss = false;
					shits++;
					if (FlxG.save.data.accuracyMod == 0)
						totalNotesHit += 0.25;
					if (FlxG.save.data.hitsound != 'none')
						{
							FlxG.sound.play(Paths.sound('hitsounds/' + FlxG.save.data.hitsound + '_hit'));
						}
				case 'bad':
					daRating = 'bad';
					score = 0;
					health -= 0.06;
					ss = false;
					bads++;
					if (FlxG.save.data.accuracyMod == 0)
						totalNotesHit += 0.50;
					if (FlxG.save.data.hitsound != 'none')
						{
							FlxG.sound.play(Paths.sound('hitsounds/' + FlxG.save.data.hitsound + '_hit'));
							FlxG.sound.volume = 0.5;
						}
				case 'good':
					daRating = 'good';
					score = 200;
					ss = false;
					goods++;
					if (health < 2)
						health += 0.04;
					if (FlxG.save.data.accuracyMod == 0)
						totalNotesHit += 0.75;
					if (FlxG.save.data.hitsound != 'none')
						{
							FlxG.sound.play(Paths.sound('hitsounds/' + FlxG.save.data.hitsound + '_hit'));
							FlxG.sound.volume = 0.5;
						}
				case 'sick':
					if (health < 2)
						health += 0.1;
					if (FlxG.save.data.accuracyMod == 0)
						totalNotesHit += 1;
					sicks++;
					if (FlxG.save.data.hitsound != 'none')
						{
							FlxG.sound.play(Paths.sound('hitsounds/' + FlxG.save.data.hitsound + '_hit'));
							FlxG.sound.volume = 0.5;
						}
					if (noteSplashOp)
					{
						var recycledNote = grpNoteSplashes.recycle(NoteSplash);
						recycledNote.setupNoteSplash(daNote.x, daNote.y, daNote.noteData);
						grpNoteSplashes.add(recycledNote);
					}
			}

			// trace('Wife accuracy loss: ' + wife + ' | Rating: ' + daRating + ' | Score: ' + score + ' | Weight: ' + (1 - wife));

			if (daRating != 'shit' || daRating != 'bad')
				{
	
	
			songScore += Math.round(score);
			songScoreDef += Math.round(ConvertScore.convertScore(noteDiff));
	
			/* if (combo > 60)
					daRating = 'sick';
				else if (combo > 12)
					daRating = 'good'
				else if (combo > 4)
					daRating = 'bad';
			 */
	
			var pixelShitPart1:String = "";
			var pixelShitPart2:String = '';
	
			if (curStage.startsWith('school'))
			{
				pixelShitPart1 = 'weeb/pixelUI/';
				pixelShitPart2 = '-pixel';
			}
	
			rating.loadGraphic(Paths.image(pixelShitPart1 + daRating + pixelShitPart2));
			rating.screenCenter();
			rating.y -= 50;
			rating.x = coolText.x - 125;
			
			if (FlxG.save.data.changedHit)
			{
				rating.x = FlxG.save.data.changedHitX;
				rating.y = FlxG.save.data.changedHitY;
			}
			rating.acceleration.y = 550;
			rating.velocity.y -= FlxG.random.int(140, 175);
			rating.velocity.x -= FlxG.random.int(0, 10);
			
			var msTiming = HelperFunctions.truncateFloat(noteDiff, 3);
			if(FlxG.save.data.botplay) msTiming = 0;							   

			if (currentTimingShown != null)
				remove(currentTimingShown);

			currentTimingShown = new FlxText(0,0,0,"0ms");
			timeShown = 0;
			switch(daRating)
			{
				case 'shit' | 'bad':
					currentTimingShown.color = FlxColor.RED;
				case 'good':
					currentTimingShown.color = FlxColor.GREEN;
				case 'sick':
					currentTimingShown.color = FlxColor.CYAN;
			}
			currentTimingShown.borderStyle = OUTLINE;
			currentTimingShown.borderSize = 1;
			currentTimingShown.borderColor = FlxColor.BLACK;
			currentTimingShown.text = msTiming + "ms";
			currentTimingShown.size = 20;

			if (msTiming >= 0.03 && offsetTesting)
			{
				//Remove Outliers
				hits.shift();
				hits.shift();
				hits.shift();
				hits.pop();
				hits.pop();
				hits.pop();
				hits.push(msTiming);

				var total = 0.0;

				for(i in hits)
					total += i;
				

				
				offsetTest = HelperFunctions.truncateFloat(total / hits.length,2);
			}

			if (currentTimingShown.alpha != 1)
				currentTimingShown.alpha = 1;

			if(!FlxG.save.data.botplay) add(currentTimingShown);
			
			var comboSpr:FlxSprite = new FlxSprite().loadGraphic(Paths.image(pixelShitPart1 + 'combo' + pixelShitPart2));
			comboSpr.screenCenter();
			comboSpr.x = rating.x;
			comboSpr.y = rating.y + 100;
			comboSpr.acceleration.y = 600;
			comboSpr.velocity.y -= 150;

			currentTimingShown.screenCenter();
			currentTimingShown.x = comboSpr.x + 100;
			currentTimingShown.y = rating.y + 100;
			currentTimingShown.acceleration.y = 600;
			currentTimingShown.velocity.y -= 150;
	
			comboSpr.velocity.x += FlxG.random.int(1, 10);
			currentTimingShown.velocity.x += comboSpr.velocity.x;
			if(!FlxG.save.data.botplay) add(rating);
	
			if (!curStage.startsWith('school'))
			{
				rating.setGraphicSize(Std.int(rating.width * 0.7));
				rating.antialiasing = true;
				comboSpr.setGraphicSize(Std.int(comboSpr.width * 0.7));
				comboSpr.antialiasing = true;
			}
			else
			{
				rating.setGraphicSize(Std.int(rating.width * daPixelZoom * 0.7));
				comboSpr.setGraphicSize(Std.int(comboSpr.width * daPixelZoom * 0.7));
			}
	
			currentTimingShown.updateHitbox();
			comboSpr.updateHitbox();
			rating.updateHitbox();
	
			currentTimingShown.cameras = [camHUD];
			comboSpr.cameras = [camHUD];
			rating.cameras = [camHUD];

			var seperatedScore:Array<Int> = [];
	
			var comboSplit:Array<String> = (combo + "").split('');

			// make sure we have 3 digits to display (looks weird otherwise lol)
			if (comboSplit.length == 1)
			{
				seperatedScore.push(0);
				seperatedScore.push(0);
			}
			else if (comboSplit.length == 2)
				seperatedScore.push(0);

			for(i in 0...comboSplit.length)
			{
				var str:String = comboSplit[i];
				seperatedScore.push(Std.parseInt(str));
			}
	
			var daLoop:Int = 0;
			for (i in seperatedScore)
			{
				var numScore:FlxSprite = new FlxSprite().loadGraphic(Paths.image(pixelShitPart1 + 'num' + Std.int(i) + pixelShitPart2));
				numScore.screenCenter();
				numScore.x = rating.x + (43 * daLoop) - 50;
				numScore.y = rating.y + 100;
				numScore.cameras = [camHUD];

				if (!curStage.startsWith('school'))
				{
					numScore.antialiasing = true;
					numScore.setGraphicSize(Std.int(numScore.width * 0.5));
				}
				else
				{
					numScore.setGraphicSize(Std.int(numScore.width * daPixelZoom));
				}
				numScore.updateHitbox();
	
				numScore.acceleration.y = FlxG.random.int(200, 300);
				numScore.velocity.y -= FlxG.random.int(140, 160);
				numScore.velocity.x = FlxG.random.float(-5, 5);
	
				add(numScore);
	
				FlxTween.tween(numScore, {alpha: 0}, 0.2, {
					onComplete: function(tween:FlxTween)
					{
						numScore.destroy();
					},
					startDelay: Conductor.crochet * 0.002
				});
	
				daLoop++;
			}
			/* 
				trace(combo);
				trace(seperatedScore);
			 */
	
			coolText.text = Std.string(seperatedScore);
			// add(coolText);
	
			FlxTween.tween(rating, {alpha: 0}, 0.2, {
				startDelay: Conductor.crochet * 0.001,
				onUpdate: function(tween:FlxTween)
				{
					if (currentTimingShown != null)
						currentTimingShown.alpha -= 0.02;
					timeShown++;
				}
			});

			FlxTween.tween(comboSpr, {alpha: 0}, 0.2, {
				onComplete: function(tween:FlxTween)
				{
					coolText.destroy();
					comboSpr.destroy();
					if (currentTimingShown != null && timeShown >= 20)
					{
						remove(currentTimingShown);
						currentTimingShown = null;
					}
					rating.destroy();
				},
				startDelay: Conductor.crochet * 0.001
			});
	
			curSection += 1;
			}
		}

	public function NearlyEquals(value1:Float, value2:Float, unimportantDifference:Float = 10):Bool
		{
			return Math.abs(FlxMath.roundDecimal(value1, 1) - FlxMath.roundDecimal(value2, 1)) < unimportantDifference;
		}

		var upHold:Bool = false;
		var downHold:Bool = false;
		var rightHold:Bool = false;
		var leftHold:Bool = false;	

		private function keyShit():Void // I've invested in emma stocks
			{
				// control arrays, order L D R U
				var holdArray:Array<Bool> = [controls.LEFT, controls.DOWN, controls.UP, controls.RIGHT];
				var pressArray:Array<Bool> = [
					controls.LEFT_P,
					controls.DOWN_P,
					controls.UP_P,
					controls.RIGHT_P
				];
				var releaseArray:Array<Bool> = [
					controls.LEFT_R,
					controls.DOWN_R,
					controls.UP_R,
					controls.RIGHT_R
				];
				#if windows
				if (luaModchart != null){
				if (controls.LEFT_P){luaModchart.executeState('keyPressed',["left"]);};
				if (controls.DOWN_P){luaModchart.executeState('keyPressed',["down"]);};
				if (controls.UP_P){luaModchart.executeState('keyPressed',["up"]);};
				if (controls.RIGHT_P){luaModchart.executeState('keyPressed',["right"]);};
				};
				#end
		 
				// Prevent player input if botplay is on
				if(FlxG.save.data.botplay)
				{
					holdArray = [false, false, false, false];
					pressArray = [false, false, false, false];
					releaseArray = [false, false, false, false];
				} 
				// HOLDS, check for sustain notes
				if (holdArray.contains(true) && /*!boyfriend.stunned && */ generatedMusic)
				{
					notes.forEachAlive(function(daNote:Note)
					{
						if (daNote.isSustainNote && daNote.canBeHit && daNote.mustPress && holdArray[daNote.noteData])
							goodNoteHit(daNote);
					});
				}
		 
				// PRESSES, check for note hits
				if (pressArray.contains(true) && /*!boyfriend.stunned && */ generatedMusic)
				{
					boyfriend.holdTimer = 0;
		 
					var possibleNotes:Array<Note> = []; // notes that can be hit
					var directionList:Array<Int> = []; // directions that can be hit
					var dumbNotes:Array<Note> = []; // notes to kill later
					var directionsAccounted:Array<Bool> = [false,false,false,false]; // we don't want to do judgments for more than one presses
					
					notes.forEachAlive(function(daNote:Note)
					{
						if (daNote.canBeHit && daNote.mustPress && !daNote.tooLate && !daNote.wasGoodHit)
						{
							if (!directionsAccounted[daNote.noteData])
							{
								if (directionList.contains(daNote.noteData))
								{
									directionsAccounted[daNote.noteData] = true;
									for (coolNote in possibleNotes)
									{
										if (coolNote.noteData == daNote.noteData && Math.abs(daNote.strumTime - coolNote.strumTime) < 10)
										{ // if it's the same note twice at < 10ms distance, just delete it
											// EXCEPT u cant delete it in this loop cuz it fucks with the collection lol
											dumbNotes.push(daNote);
											break;
										}
										else if (coolNote.noteData == daNote.noteData && daNote.strumTime < coolNote.strumTime)
										{ // if daNote is earlier than existing note (coolNote), replace
											possibleNotes.remove(coolNote);
											possibleNotes.push(daNote);
											break;
										}
									}
								}
								else
								{
									possibleNotes.push(daNote);
									directionList.push(daNote.noteData);
								}
							}
						}
					});

					trace('\nCURRENT LINE:\n' + directionsAccounted);
		 
					for (note in dumbNotes)
					{
						FlxG.log.add("killing dumb ass note at " + note.strumTime);
						note.kill();
						notes.remove(note, true);
						note.destroy();
					}
		 
					possibleNotes.sort((a, b) -> Std.int(a.strumTime - b.strumTime));
		 
					var dontCheck = false;

					for (i in 0...pressArray.length)
					{
						if (pressArray[i] && !directionList.contains(i))
							dontCheck = true;
					}

					if (perfectMode)
						goodNoteHit(possibleNotes[0]);
					else if (possibleNotes.length > 0 && !dontCheck)
					{
						if (!FlxG.save.data.ghost)
						{
							for (shit in 0...pressArray.length)
								{ // if a direction is hit that shouldn't be
									if (pressArray[shit] && !directionList.contains(shit))
										noteMiss(shit, null);
								}
						}
						for (coolNote in possibleNotes)
						{
							if (pressArray[coolNote.noteData])
							{
								if (mashViolations != 0)
									mashViolations--;
								scoreTxt.color = FlxColor.WHITE;
								goodNoteHit(coolNote);
							}
						}
					}
					else if (!FlxG.save.data.ghost)
						{
							for (shit in 0...pressArray.length)
								if (pressArray[shit])
									noteMiss(shit, null);
						}

					if(dontCheck && possibleNotes.length > 0 && FlxG.save.data.ghost && !FlxG.save.data.botplay)
					{
						if (mashViolations > 8)
						{
							trace('mash violations ' + mashViolations);
							scoreTxt.color = FlxColor.RED;
							noteMiss(0,null);
						}
						else
							mashViolations++;
					}

				}
				
				notes.forEachAlive(function(daNote:Note)
				{
					if(FlxG.save.data.downscroll && daNote.y > strumLine.y ||
					!FlxG.save.data.downscroll && daNote.y < strumLine.y)
					{
						// Force good note hit regardless if it's too late to hit it or not as a fail safe
						if(FlxG.save.data.botplay && daNote.canBeHit && daNote.mustPress ||
						FlxG.save.data.botplay && daNote.tooLate && daNote.mustPress)
						{
							if(loadRep)
							{
								//trace('ReplayNote ' + tmpRepNote.strumtime + ' | ' + tmpRepNote.direction);
								if(rep.replay.songNotes.contains(HelperFunctions.truncateFloat(daNote.strumTime, 2)))
								{
									goodNoteHit(daNote);
									boyfriend.holdTimer = daNote.sustainLength;
								}
							}else {
								goodNoteHit(daNote);
								boyfriend.holdTimer = daNote.sustainLength;
							}
						}
					}
				});
				
				if (boyfriend.holdTimer > Conductor.stepCrochet * 4 * 0.001 && (!holdArray.contains(true) || FlxG.save.data.botplay))
				{
					if (boyfriend.animation.curAnim.name.startsWith('sing') && !boyfriend.animation.curAnim.name.endsWith('miss'))
						boyfriend.playAnim('idle');
				}
		 
				playerStrums.forEach(function(spr:FlxSprite)
				{
					if (pressArray[spr.ID] && spr.animation.curAnim.name != 'confirm')
						spr.animation.play('pressed');
					if (!holdArray[spr.ID])
						spr.animation.play('static');
		 
					if (spr.animation.curAnim.name == 'confirm' && !curStage.startsWith('school'))
					{
						spr.centerOffsets();
						spr.offset.x -= 13;
						spr.offset.y -= 13;
					}
					else
						spr.centerOffsets();
				});
			}

	function noteMiss(direction:Int = 1, daNote:Note):Void
	{
		if (!boyfriend.stunned)
		{
			health -= 0.04;
			if (combo > 5 && gf.animOffsets.exists('sad'))
			{
				gf.playAnim('sad');
			}
			combo = 0;
			misses++;

			//var noteDiff:Float = Math.abs(daNote.strumTime - Conductor.songPosition);
			//var wife:Float = EtternaFunctions.wife3(noteDiff, FlxG.save.data.etternaMode ? 1 : 1.7);

			if (FlxG.save.data.accuracyMod == 1)
				totalNotesHit -= 1;

			songScore -= 10;

			FlxG.sound.play(Paths.soundRandom('missnote', 1, 3), FlxG.random.float(0.1, 0.2));
			// FlxG.sound.play(Paths.sound('missnote1'), 1, false);
			// FlxG.log.add('played imss note');

			switch (direction)
			{
				case 0:
					boyfriend.playAnim('singLEFTmiss', true);
				case 1:
					boyfriend.playAnim('singDOWNmiss', true);
				case 2:
					boyfriend.playAnim('singUPmiss', true);
				case 3:
					boyfriend.playAnim('singRIGHTmiss', true);
			}

			#if windows
			if (luaModchart != null)
				luaModchart.executeState('playerOneMiss', [direction, Conductor.songPosition]);
			#end


			updateAccuracy();
		}
	}

	/*function badNoteCheck()
		{
			// just double pasting this shit cuz fuk u
			// REDO THIS SYSTEM!
			var upP = controls.UP_P;
			var rightP = controls.RIGHT_P;
			var downP = controls.DOWN_P;
			var leftP = controls.LEFT_P;
	
			if (leftP)
				noteMiss(0);
			if (upP)
				noteMiss(2);
			if (rightP)
				noteMiss(3);
			if (downP)
				noteMiss(1);
			updateAccuracy();
		}
	*/
	function updateAccuracy() 
		{
			totalPlayed += 1;
			accuracy = Math.max(0,totalNotesHit / totalPlayed * 100);
			accuracyDefault = Math.max(0, totalNotesHitDefault / totalPlayed * 100);
		}


	function getKeyPresses(note:Note):Int
	{
		var possibleNotes:Array<Note> = []; // copypasted but you already know that

		notes.forEachAlive(function(daNote:Note)
		{
			if (daNote.canBeHit && daNote.mustPress && !daNote.tooLate)
			{
				possibleNotes.push(daNote);
				possibleNotes.sort((a, b) -> Std.int(a.strumTime - b.strumTime));
			}
		});
		if (possibleNotes.length == 1)
			return possibleNotes.length + 1;
		return possibleNotes.length;
	}
	
	var mashing:Int = 0;
	var mashViolations:Int = 0;

	var etternaModeScore:Int = 0;

	function noteCheck(controlArray:Array<Bool>, note:Note):Void // sorry lol
		{
			var noteDiff:Float = Math.abs(note.strumTime - Conductor.songPosition);

			note.rating = Ratings.CalculateRating(noteDiff);

			/* if (loadRep)
			{
				if (controlArray[note.noteData])
					goodNoteHit(note, false);
				else if (rep.replay.keyPresses.length > repPresses && !controlArray[note.noteData])
				{
					if (NearlyEquals(note.strumTime,rep.replay.keyPresses[repPresses].time, 4))
					{
						goodNoteHit(note, false);
					}
				}
			} */
			
			if (controlArray[note.noteData])
			{
				goodNoteHit(note, (mashing > getKeyPresses(note)));
				
				/*if (mashing > getKeyPresses(note) && mashViolations <= 2)
				{
					mashViolations++;

					goodNoteHit(note, (mashing > getKeyPresses(note)));
				}
				else if (mashViolations > 2)
				{
					// this is bad but fuck you
					playerStrums.members[0].animation.play('static');
					playerStrums.members[1].animation.play('static');
					playerStrums.members[2].animation.play('static');
					playerStrums.members[3].animation.play('static');
					health -= 0.4;
					trace('mash ' + mashing);
					if (mashing != 0)
						mashing = 0;
				}
				else
					goodNoteHit(note, false);*/

			}
		}

		function goodNoteHit(note:Note, resetMashViolation = true):Void
			{

				if (mashing != 0)
					mashing = 0;

				var noteDiff:Float = Math.abs(note.strumTime - Conductor.songPosition);

				note.rating = Ratings.CalculateRating(noteDiff);

				// add newest note to front of notesHitArray
				// the oldest notes are at the end and are removed first
				if (!note.isSustainNote)
					notesHitArray.unshift(Date.now());

				if (!resetMashViolation && mashViolations >= 1)
					mashViolations--;

				if (mashViolations < 0)
					mashViolations = 0;

				if (!note.wasGoodHit)
				{
					if (!note.isSustainNote)
					{
						popUpScore(note);
						combo += 1;
					}
					else
						totalNotesHit += 1;
	

					switch (note.noteData)
					{
						case 2:
							boyfriend.playAnim('singUP', true);
						case 3:
							boyfriend.playAnim('singRIGHT', true);
						case 1:
							boyfriend.playAnim('singDOWN', true);
						case 0:
							boyfriend.playAnim('singLEFT', true);
					}
		
					#if windows
					if (luaModchart != null)
						luaModchart.executeState('playerOneSing', [note.noteData, Conductor.songPosition]);
					#end


					if(!loadRep && note.mustPress)
						saveNotes.push(HelperFunctions.truncateFloat(note.strumTime, 2));
					
					playerStrums.forEach(function(spr:FlxSprite)
					{
						if (Math.abs(note.noteData) == spr.ID)
						{
							spr.animation.play('confirm', true);
						}
					});
					
					note.wasGoodHit = true;
					vocals.volume = 1;
		
					note.kill();
					notes.remove(note, true);
					note.destroy();
					
					updateAccuracy();
				}
			}
		

	var fastCarCanDrive:Bool = true;

	function resetFastCar():Void
	{
		if(FlxG.save.data.distractions){
			fastCar.x = -12600;
			fastCar.y = FlxG.random.int(140, 250);
			fastCar.velocity.x = 0;
			fastCarCanDrive = true;
		}
	}

	function fastCarDrive()
	{
		if(FlxG.save.data.distractions){
			FlxG.sound.play(Paths.soundRandom('carPass', 0, 1), 0.7);

			fastCar.velocity.x = (FlxG.random.int(170, 220) / FlxG.elapsed) * 3;
			fastCarCanDrive = false;
			new FlxTimer().start(2, function(tmr:FlxTimer)
			{
				resetFastCar();
			});
		}
	}

	function InvisibleNotes()
		{
			FlxG.sound.play(Paths.sound('Meow'));
			for (str in playerStrums)
				{
					str.visible = false;
				}
			for (str in strumLineNotes)
				{
					str.visible = false;
				}
		}
		function VisibleNotes()
		{
			FlxG.sound.play(Paths.sound('woeM'));
			for (str in playerStrums)
				{
					str.visible = true;
				}
			for (str in strumLineNotes)
				{
					str.visible = true;
				}
		}

	var trainMoving:Bool = false;
	var trainFrameTiming:Float = 0;

	var trainCars:Int = 8;
	var trainFinishing:Bool = false;
	var trainCooldown:Int = 0;

	function trainStart():Void
	{
		if(FlxG.save.data.distractions){
			trainMoving = true;
			if (!trainSound.playing)
				trainSound.play(true);
		}
	}

	var startedMoving:Bool = false;

	function updateTrainPos():Void
	{
		if(FlxG.save.data.distractions){
			if (trainSound.time >= 4700)
				{
					startedMoving = true;
					gf.playAnim('hairBlow');
				}
		
				if (startedMoving)
				{
					phillyTrain.x -= 400;
		
					if (phillyTrain.x < -2000 && !trainFinishing)
					{
						phillyTrain.x = -1150;
						trainCars -= 1;
		
						if (trainCars <= 0)
							trainFinishing = true;
					}
		
					if (phillyTrain.x < -4000 && trainFinishing)
						trainReset();
				}
		}

	}

	function trainReset():Void
	{
		if(FlxG.save.data.distractions){
			gf.playAnim('hairFall');
			phillyTrain.x = FlxG.width + 200;
			trainMoving = false;
			// trainSound.stop();
			// trainSound.time = 0;
			trainCars = 8;
			trainFinishing = false;
			startedMoving = false;
		}
	}

	function lightningStrikeShit():Void
	{
		FlxG.sound.play(Paths.soundRandom('thunder_', 1, 2));
		halloweenBG.animation.play('lightning');

		lightningStrikeBeat = curBeat;
		lightningOffset = FlxG.random.int(8, 24);

		boyfriend.playAnim('scared', true);
		gf.playAnim('scared', true);
	}

	var danced:Bool = false;

	function timeHit():Void {
		// I'll add more stuff here soon ig
		// Just a simple time song event system for dummies :troll:
		// WORKS ONLY IN SECONDS, AND NO MILISECONDS!!!!
	}
	override function stepHit()
	{
		super.stepHit();
		if (FlxG.sound.music.time > Conductor.songPosition + 20 || FlxG.sound.music.time < Conductor.songPosition - 20)
		{
			resyncVocals();
		}

		if (daSong == 'artificial-lust')
		{
			if (curStep == 226)
			{
				dad.playAnim('showtime');
			}
		}
		if (dad.curCharacter == 'tankman' && SONG.song.toLowerCase() == 'ugh')
			{
				if (curStep == 59 || curStep == 443 || curStep == 523 || curStep == 827)
				{
					dad.addOffset("singUP", 45, 0);
					
					dad.animation.getByName('singUP').frames = dad.animation.getByName('ughAnim').frames;
				}
				if (curStep == 64 || curStep == 448 || curStep == 528 || curStep == 832)
				{
					dad.addOffset("singUP", 24, 56);
					dad.animation.getByName('singUP').frames = dad.animation.getByName('oldSingUP').frames;
				}
			}

		#if windows
		if (executeModchart && luaModchart != null)
		{
			luaModchart.setVar('curStep',curStep);
			luaModchart.executeState('stepHit',[curStep]);
		}
		#end
		trace('curstep ' + curStep);

		if (SONG.song.toLowerCase() == 'stress')
		{
						//RIGHT
			for(i in 0...picoStep.right.length)
			{
				if (curStep == picoStep.right[i])
				{
					gf.playAnim('shoot' + FlxG.random.int(1, 2), true);
									//var tankmanRunner:TankmenBG = new TankmenBG();
				}
			}
							//LEFT
			for(i in 0...picoStep.left.length)
			{
				if (curStep == picoStep.left[i])
				{
					gf.playAnim('shoot' + FlxG.random.int(3, 4), true);
				}
			}

						//Left tankspawn
				for (i in 0...tankStep.left.length)
				{
					if (curStep == tankStep.left[i]){
						var tankmanRunner:TankmenBG = new TankmenBG();
						tankmanRunner.resetShit(FlxG.random.int(630, 730) * -1, 255, true, 1, 1.5);
				
						tankmanRun.add(tankmanRunner);
					}
				}
				
							//Right spawn
			for(i in 0...tankStep.right.length)
			{
				if (curStep == tankStep.right[i]){
				var tankmanRunner:TankmenBG = new TankmenBG();
				tankmanRunner.resetShit(FlxG.random.int(1500, 1700) * 1, 275, false, 1, 1.5);
				tankmanRun.add(tankmanRunner);
				}
			}
		}

		if (SONG.song.toLowerCase() == 'sketched out')
			{
				if (curStep == 1)
				{
					remove(dad);
					dad = new Character(-240, 200, 'angrysketchy');
					add(dad);
				}
				if (dad.curCharacter != 'sketchy' && curStep < 500)
				{
					remove(dad);
					dad = new Character(-240, 200, 'sketchy');
					add(dad);
				}
				if(curStep == 512)
				{
					remove(dad);
					dad = new Character(-240, 200, 'angrysketchy');
					add(dad);
				}
				if(curStep == 1083)
				{
					shakeCam = true;
				}
				if(curStep == 1092)
				{
					shakeCam = false;
				}
			}
			if (SONG.song.toLowerCase() == 'rip and tear')
			{
				if(curStep == 64)
				{
					shakeCam = true;
				}
				if(curStep == 127)
				{
					shakeCam = false;
				}
				if(curStep == 192)
				{
					shakeCam = true;
				}
				if(curStep == 256)
				{
					shakeCam = false;
				}
				if(curStep == 320)
				{
					shakeCam = true;
				}
				if(curStep == 384)
				{
					shakeCam = false;
				}
				if(curStep == 424)
				{
					shakeCam = true;
				}
				if(curStep == 448)
				{
					shakeCam = false;
				}
				if(curStep == 479)
				{
					shakeCam = true;
				}
				if(curStep == 484)
				{
					shakeCam = false;
				}
				if(curStep == 495)
				{
					shakeCam = true;
				}
				if(curStep == 510)
				{
					shakeCam = false;
				}
				if(curStep == 577)
				{
					shakeCam = true;
				}
				if(curStep == 640)
				{
					shakeCam = false;
				}
				if(curStep == 702)
				{
					shakeCam = true;
				}
				if(curStep == 768)
				{
					shakeCam = false;
				}
				if(curStep == 832)
				{
					shakeCam = true;
				}
				if(curStep == 864)
				{
					shakeCam = false;
				}
				if(curStep == 896)
				{
					shakeCam = true;
				}
				if(curStep == 1008)
				{
					shakeCam = false;
				}
			}



		// yes this updates every step.
		// yes this is bad
		// but i'm doing it to update misses and accuracy
		#if windows
		// Song duration in a float, useful for the time left feature
		songLength = FlxG.sound.music.length;

		// Updating Discord Rich Presence (with Time Left)
		DiscordClient.changePresence(detailsText + " " + SONG.song + " (" + storyDifficultyText + ") " + Ratings.GenerateLetterRank(accuracy), "Acc: " + HelperFunctions.truncateFloat(accuracy, 2) + "% | Score: " + songScore + " | Misses: " + misses  , iconRPC,true,  songLength - Conductor.songPosition);
		#end

		if (dad.curCharacter == 'garcellodead' && SONG.song.toLowerCase() == 'release')
			{
				if (curStep == 838)
				{
					dad.playAnim('coolguy', true);
				}
			}
	
			if (dad.curCharacter == 'garcelloghosty' && SONG.song.toLowerCase() == 'fading')
			{
				if (curStep == 247)
				{
					dad.playAnim('farewell', true);
				}
			}
	
			if (dad.curCharacter == 'garcelloghosty' && SONG.song.toLowerCase() == 'fading')
			{
				if (curStep == 240)
				{
					new FlxTimer().start(0.1, function(tmr:FlxTimer)
					{
						dad.alpha -= 0.05;
						
						iconP2.alpha -= 0.05;
	
						if (dad.alpha > 0)
						{
							tmr.reset(0.1);
						}
					});
				}
			}

		if (curStep == 896 && daSong == 'remorse')
			switchEdgy(true);
		else if (curStep == 1024 && daSong == 'remorse')
			switchEdgy(false);

		if (daSong == 'withered' && curStep == 616)
		{
			daBob = new FlxSprite(dad.x, dad.y);
			daBob.frames = Paths.getSparrowAtlas('mods/bob/cutscene/BobCutscene','shared');
			daBob.animation.addByPrefix('transform','bob mad',24,false);
			daBob.animation.play('transform');
			dad.visible = false;
			add(daBob);
			FlxG.sound.play(Paths.sound('OhScary'));
			new FlxTimer().start(0.1, function(tmr:FlxTimer){
				if (!daBob.animation.curAnim.finished)
					tmr.reset(0.1);
				else
				{
					var oldDadX = dad.x;
					var oldDadY = dad.y;
					remove(daBob);
					remove(dad);
					dad = new Character(oldDadX + 60, oldDadY + 30, 'hellbob');
					add(dad);
					dad.visible = true;
					iconP2.animation.play('hellbob');
					camHUD.shake(0.003, 20.07);
				}
			});
		}

					// Animations for Vs impostor
		if (curStep == 1802 && daSong == 'sussus-moogus')
            {
                gf.playAnim('dead', false);

            }
		if (curStep == 1794 && daSong == 'sussus-moogus')
            {
                dad.playAnim('shoot1', false);
            }
		if (curStep == 1620 && daSong == 'sabotage')
            {
				FlxG.sound.play(Paths.soundRandom('gunshot', 0, 15));
                dad.playAnim('shoot2', false);
            }
		if (curStep == 1640 && daSong == 'sabotage')
            {
                boyfriend.playAnim('scaredamong', false);
            }
		if (curStep == 1647 && daSong == 'sabotage')
            {
                boyfriend.playAnim('deadamong', false);
			}
		if (curStep == 1647 && daSong == 'sabotage')
			{
					boyfriend.playAnim('deadamong', false);
			}
        if (curStep == 2048 && daSong == 'meltdown')
            {
                boyfriend.playAnim('hey', false);

            }
		if (curStep == 1812 && daSong == 'sussus-moogus')
            {
                dad.playAnim('idle', true);
			}


		// chara song events	
			if (daSong == 'megalo strike back' && curStep == 1166)
				dad.playAnim('star', true);

			if (dad.animation.curAnim.finished && dad.curCharacter == 'chara' && daSong == 'megalo strike back' && curStep >= 1166 && curStep < 1225)
				dad.playAnim('star', true); // we do a lil trollin


			if (daSong == 'megalo strike back' && curStep >= 2021 && curStep < 2078)
			{
				FlxG.camera.shake(0.003, 6.46);
				camPos.set(dad.getGraphicMidpoint().x, dad.getGraphicMidpoint().y + 30);
				defaultCamZoom = 1.1;
				dad.playAnim('stare', true);
			}
			if (curStep == 2078 && daSong == 'megalo strike back')
			{
				doTheThing();
			}
			if (curStep == 2357 && daSong == 'megalo strike back')
				doTheThing();

	}
	function doTheThing():Void {
		// dad pos for the bf thing
		var oldDadX = dad.x;
		var oldDadY = dad.y;
		//changin dad pos
		dad.x = boyfriend.x;
		dad.y = boyfriend.y;
		// changing bf pos
		boyfriend.x = oldDadX;
		boyfriend.y = oldDadY;
		// changing the flip
		boyfriend.flipX = !boyfriend.flipX;
		// flippin dad
		dad.flipX = !dad.flipX;

		// updatin hitbox for both
		dad.updateHitbox();
		boyfriend.updateHitbox();
	}

	var lightningStrikeBeat:Int = 0;
	var lightningOffset:Int = 8;

	override function beatHit()
	{
		super.beatHit();

		if (generatedMusic)
		{
			notes.sort(FlxSort.byY, (FlxG.save.data.downscroll ? FlxSort.ASCENDING : FlxSort.DESCENDING));
		}

		#if windows
		if (executeModchart && luaModchart != null)
		{
			luaModchart.setVar('curBeat',curBeat);
			luaModchart.executeState('beatHit',[curBeat]);
		}
		#end

		if (curSong == 'Tutorial' && dad.curCharacter == 'gf') {
			if (curBeat % 2 == 1 && dad.animOffsets.exists('danceLeft'))
				dad.playAnim('danceLeft');
			if (curBeat % 2 == 0 && dad.animOffsets.exists('danceRight'))
				dad.playAnim('danceRight');
		}

		if (SONG.notes[Math.floor(curStep / 16)] != null)
		{
			if (SONG.notes[Math.floor(curStep / 16)].changeBPM)
			{
				Conductor.changeBPM(SONG.notes[Math.floor(curStep / 16)].bpm);
				FlxG.log.add('CHANGED BPM!');
			}
			// else
			// Conductor.changeBPM(SONG.bpm);

			// Dad doesnt interupt his own notes
			if (SONG.notes[Math.floor(curStep / 16)].mustHitSection && dad.curCharacter != 'gf')
				dad.dance();
		}
		// FlxG.log.add('change bpm' + SONG.notes[Std.int(curStep / 16)].changeBPM);
		wiggleShit.update(Conductor.crochet);

		// HARDCODING FOR MILF ZOOMS!
		if (curSong.toLowerCase() == 'milf' && curBeat >= 168 && curBeat < 200 && camZooming && FlxG.camera.zoom < 1.35)
		{
			FlxG.camera.zoom += 0.015;
			camHUD.zoom += 0.03;
		}

		if (camZooming && FlxG.camera.zoom < 1.35 && curBeat % 4 == 0)
		{
			FlxG.camera.zoom += 0.015;
			camHUD.zoom += 0.03;
		}

		iconP1.setGraphicSize(Std.int(iconP1.width + 30));
		iconP2.setGraphicSize(Std.int(iconP2.width + 30));

		iconP1.updateHitbox();
		iconP2.updateHitbox();

		if (curBeat % gfSpeed == 0)
		{
			gf.dance();
		}

		if (!boyfriend.animation.curAnim.name.startsWith("sing"))
		{
			boyfriend.playAnim('idle');
		}
		if (curBeat == 283 && daSong == 'nyaw')
			{
				boyfriend.playAnim('hey', true);
			}
			if (curBeat == 434 && daSong == 'nyaw')
			{
				dad.playAnim('stare', true);
					new FlxTimer().start(1.1, function(tmr:FlxTimer)
					{
					var black:FlxSprite = new FlxSprite(-100, -100).makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.BLACK);
					black.scrollFactor.set();
					add(black);
					});
			}
			if (curBeat == 31 && daSong == 'nyaw')
			{
				dad.playAnim('meow', true);
			}
			if (curBeat == 135 && daSong == 'nyaw')
			{
				dad.playAnim('meow', true);
			}
			if (curBeat == 363 && daSong == 'nyaw')
			{
				dad.playAnim('meow', true);
			}
			if (curBeat == 203 && daSong == 'nyaw')
			{
				dad.playAnim('meow', true);
			}

		

		if (curBeat % 8 == 7 && curSong == 'Bopeebo')
		{
			boyfriend.playAnim('hey', true);
		}

		if (curBeat % 16 == 15 && SONG.song == 'Tutorial' && dad.curCharacter == 'gf' && curBeat > 16 && curBeat < 48)
			{
				boyfriend.playAnim('hey', true);
				dad.playAnim('cheer', true);
			}
		switch (curStage)
		{
			case 'school':
				if(FlxG.save.data.distractions){
					bgGirls.dance();
				}

			case 'mall':
				if(FlxG.save.data.distractions){
					upperBoppers.animation.play('bop', true);
					bottomBoppers.animation.play('bop', true);
					santa.animation.play('idle', true);
				}

			case 'limo':
				if(FlxG.save.data.distractions){
					grpLimoDancers.forEach(function(dancer:BackgroundDancer)
						{
							dancer.dance();
						});
		
						if (FlxG.random.bool(10) && fastCarCanDrive)
							fastCarDrive();
				}
			case "philly":
				if(FlxG.save.data.distractions){
					if (!trainMoving)
						trainCooldown += 1;
	
					if (curBeat % 4 == 0)
					{
						phillyCityLights.forEach(function(light:FlxSprite)
						{
							light.visible = false;
						});
	
						curLight = FlxG.random.int(0, phillyCityLights.length - 1);
	
						phillyCityLights.members[curLight].visible = true;
						// phillyCityLights.members[curLight].alpha = 1;
					}
				}

				if (curBeat % 8 == 4 && FlxG.random.bool(30) && !trainMoving && trainCooldown > 8)
				{
					if(FlxG.save.data.distractions){
						trainCooldown = FlxG.random.int(-4, 0);
						trainStart();
					}
				}
			case 'arcadeclosed':
				bottomBoppers.animation.play('bop');
				upperBoppers.animation.play('bop');
				if (curBeat % 4 == 0)
					{
						phillyCityLights.forEach(function(light:FlxSprite)
						{
							light.visible = false;
						});
	
						curLight = FlxG.random.int(0, phillyCityLights.length - 1);
	
						phillyCityLights.members[curLight].visible = true;
						// phillyCityLights.members[curLight].alpha = 1;
					}
			case 'arcadesunset':
				upperBoppers.animation.play('bop');
				littleGuys.animation.play('bop');
				if (curBeat % 4 == 0)
					{
						phillyCityLights.forEach(function(light:FlxSprite)
						{
							light.visible = false;
						});
	
						curLight = FlxG.random.int(0, phillyCityLights.length - 1);
	
						phillyCityLights.members[curLight].visible = true;
						// phillyCityLights.members[curLight].alpha = 1;
					}
			case 'arcade2':
				littleGuys.animation.play('bop');
				if (curBeat % 4 == 0)
					{
						phillyCityLights.forEach(function(light:FlxSprite)
						{
							light.visible = false;
						});
	
						curLight = FlxG.random.int(0, phillyCityLights.length - 1);
	
						phillyCityLights.members[curLight].visible = true;
						// phillyCityLights.members[curLight].alpha = 1;
					}
				case 'cj':
					if (curBeat % 4 == 0)
						{
							phillyCityLights.forEach(function(light:FlxSprite)
							{
								light.visible = false;
							});
		
							curLight = FlxG.random.int(0, phillyCityLights.length - 1);
		
							phillyCityLights.members[curLight].visible = true;
							// phillyCityLights.members[curLight].alpha = 1;
						}
		}

		if (isHalloween && FlxG.random.bool(10) && curBeat > lightningStrikeBeat + lightningOffset)
		{
			if(FlxG.save.data.distractions){
				lightningStrikeShit();
			}
		}
	}

	var curLight:Int = 0;
}
//picoshoot
typedef Ps = 
{
	var right:Array<Int>;
	var left:Array<Int>;
}
typedef Ts = 
{
	var right:Array<Int>;
	var left:Array<Int>;
}
