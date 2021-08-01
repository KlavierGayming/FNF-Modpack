package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;

using StringTools;

class Character extends FlxSprite
{
	public var animOffsets:Map<String, Array<Dynamic>>;
	public var debugMode:Bool = false;

	public var isPlayer:Bool = false;
	public var curCharacter:String = 'bf';

	public var holdTimer:Float = 0;

	public function new(x:Float, y:Float, ?character:String = "bf", ?isPlayer:Bool = false)
	{
		super(x, y);

		animOffsets = new Map<String, Array<Dynamic>>();
		curCharacter = character;
		this.isPlayer = isPlayer;

		var tex:FlxAtlasFrames;
		antialiasing = true;

		switch (curCharacter)
		{
						case 'cj':
							// DAD ANIMATION LOADING CODE
							tex = Paths.getSparrowAtlas('characters/cj_assets','shared');
							frames = tex;
							animation.addByPrefix('idle', 'cj idle dance', 24, false);
							animation.addByPrefix('singUP', 'cj Sing Note UP0', 24, false);
							animation.addByPrefix('singLEFT', 'cj Sing Note LEFT0', 24, false);
							animation.addByPrefix('singRIGHT', 'cj Sing Note RIGHT0', 24, false);
							animation.addByPrefix('singDOWN', 'cj Sing Note DOWN0', 24, false);
							animation.addByPrefix('ha', 'cj singleha0', 24, false);
							animation.addByPrefix('haha', 'cj doubleha0', 24, false);
							animation.addByPrefix('intro', 'cj intro0', 24, false);
			
							addOffset('idle');
							addOffset('intro', 590, 232);
							addOffset("singUP", -46, 28);
							addOffset("singRIGHT", -20, 37);
							addOffset("singLEFT", -2, 3);
							addOffset("singDOWN", -20, -20);
							addOffset('ha', -46, 28);
							addOffset('haha', -46, 28);
			
							playAnim('idle');
						case 'ruby':
							// DAD ANIMATION LOADING CODE
							tex = Paths.getSparrowAtlas('characters/ruby_assets','shared');
							frames = tex;
							//animation.addByIndices('idle', 'ruby idle dance', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], "", 24, false);
							animation.addByPrefix('idle', 'ruby idle dance', 24, true);
							animation.addByPrefix('singUP', 'ruby Sing Note UP0', 24, false);
							animation.addByPrefix('singLEFT', 'ruby Sing Note LEFT0', 24, false);
							animation.addByPrefix('singRIGHT', 'ruby Sing Note RIGHT0', 24, false);
							animation.addByPrefix('singDOWN', 'ruby Sing Note DOWN0', 24, false);
			
							addOffset('idle');
							addOffset("singUP", -18, 42);
							addOffset("singRIGHT", -17, 19);
							addOffset("singLEFT", -22, 0);
							addOffset("singDOWN", -23, -38);
			
							playAnim('idle');
						case 'max':
							tex = Paths.getSparrowAtlas('characters/Max','shared');
							frames = tex;
							animation.addByPrefix('idle', 'MAXIDLE', 24, true);
							animation.addByPrefix('singUP', 'MAXUP', 24, false);
							animation.addByPrefix('singLEFT', 'MAXLEFT', 24, false);
							animation.addByPrefix('singRIGHT', 'MAXRIGHT', 24, false);
							animation.addByPrefix('singDOWN', 'MAXDOWN', 24, false);
			
							addOffset('idle');
							addOffset("singUP", 0, 29);
							addOffset("singRIGHT", 3, 46);
							addOffset("singLEFT", 39, 47);
							addOffset("singDOWN", 2, 0);
			
							playAnim('idle');
						case 'abel':
							tex = Paths.getSparrowAtlas('characters/Abel','shared');
							frames = tex;
							animation.addByPrefix('idle', 'ABLENOGUITAR', 24, true);
							animation.addByPrefix('idle2', 'ABELIDLE', 24, true);
							animation.addByPrefix('singUP', 'ABELUP', 24, false);
							animation.addByPrefix('singLEFT', 'ABELLEFT', 24, false);
							animation.addByPrefix('singRIGHT', 'ABELRIGHT', 24, false);
							animation.addByPrefix('singDOWN', 'ABELDOWN', 24, false);
			
							addOffset('idle');
							addOffset('idle2', 50, -80);
							addOffset("singUP", 53, -52);
							addOffset("singRIGHT", 47, -87);
							addOffset("singLEFT", 61, -74);
							addOffset("singDOWN", 46, -87);
			
							playAnim('idle');
						case 'duet':
							tex = Paths.getSparrowAtlas('characters/duet_assets','shared');
							frames = tex;
							animation.addByPrefix('idle', 'duet idle dance', 24, true);
							animation.addByPrefix('showtime', 'duet SHOWTIME', 24, false);
							animation.addByPrefix('singUP', 'duet Sing Note UP', 24, false);
							animation.addByPrefix('singLEFT', 'duet Sing Note LEFT', 24, false);
							animation.addByPrefix('singRIGHT', 'duet Sing Note RIGHT', 24, false);
							animation.addByPrefix('singDOWN', 'duet Sing Note DOWN', 24, false);
							animation.addByPrefix('oldsingDOWN', 'duet Sing Note DOWN', 24, false);
			
							addOffset('idle');
							addOffset('showtime', 14, -62);
							addOffset("singUP", -16, 42);
							addOffset("singRIGHT", 53, 18);
							addOffset("singLEFT", 8, 0);
							addOffset("singDOWN", 17, -39);
			
							playAnim('idle');
							case 'nogf':
								// GIRLFRIEND CODE
								tex = Paths.getSparrowAtlas('characters/NoGF','shared');
								frames = tex;
								animation.addByPrefix('cheer', 'GF Cheer', 24, false);
								animation.addByPrefix('singLEFT', 'GF left note', 24, false);
								animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
								animation.addByPrefix('singUP', 'GF Up Note', 24, false);
								animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
								animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
								animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
								animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
								animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
								animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
								animation.addByPrefix('scared', 'GF FEAR', 24);
				
								addOffset('cheer');
								addOffset('sad', -2, -21);
								addOffset('danceLeft', 0, -9);
								addOffset('danceRight', 0, -9);
				
								addOffset("singUP", 0, 4);
								addOffset("singRIGHT", 0, -20);
								addOffset("singLEFT", 0, -19);
								addOffset("singDOWN", 0, -20);
								addOffset('hairBlow', 45, -8);
								addOffset('hairFall', 0, -9);
				
								addOffset('scared', -2, -17);
				
								playAnim('danceRight');
			case 'bf-holding-gf' | 'bfgf':
				
				frames = Paths.getSparrowAtlas('tankman/bfAndGF','shared');
				animation.addByPrefix('idle', 'BF idle dance w gf0', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS0', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS0', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS0', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS0', 24, false);

				addOffset('idle', 0, 0);
				addOffset("singUP", -29, 10);
				addOffset("singRIGHT", -41, 23);
				addOffset("singLEFT", 12, 7);
				addOffset("singDOWN", -10, -10);
				addOffset("singUPmiss", -29, 10);
				addOffset("singRIGHTmiss", -41, 23);
				addOffset("singLEFTmiss", 12, 7);
				addOffset("singDOWNmiss", -10, -10);
				playAnim('idle');

				flipX = true;
			case 'tankman':
				tex = Paths.getSparrowAtlas('tankman/tankmanCaptain','shared');
				frames = tex;
				animation.addByPrefix('idle', "Tankman Idle Dance", 24);
				animation.addByPrefix('oldSingUP', 'Tankman UP note ', 24, false);
				animation.addByPrefix('singUP', 'Tankman UP note ', 24, false);
				animation.addByPrefix('oldSingDOWN', 'Tankman DOWN note ', 24, false);
				animation.addByPrefix('singDOWN', 'Tankman DOWN note ', 24, false);
				animation.addByPrefix('singLEFT', 'Tankman Right Note ', 24, false);
				animation.addByPrefix('singRIGHT', 'Tankman Note Left ', 24, false);

				animation.addByPrefix('ughAnim', 'TANKMAN UGH', 24, false);
				animation.addByPrefix('prettyGoodAnim', 'PRETTY GOOD', 24, false);

				addOffset('idle');
				addOffset("singUP", 24, 56);
				addOffset("oldSingUP", 24, 56);
				addOffset("singRIGHT", -1, -7);
				addOffset("singLEFT", 100, -14);
				addOffset("singDOWN", 98, -90);
				addOffset("oldSingDOWN", 98, -90);
				//addOffset("ughAnim", 45, 0);
				addOffset("prettyGoodAnim", 45, 20);
				playAnim('idle');
				flipX = true;
			case 'picoSpeaker':
				
				tex = Paths.getSparrowAtlas('tankman/picoSpeaker','shared');
				frames = tex;
				
				animation.addByIndices('idle', 'Pico shoot 1', [10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24], "", 24, true);

				animation.addByIndices('shoot1', 'Pico shoot 1', [0, 1, 2, 3, 4, 5, 6, 7], "", 24, true);
				animation.addByIndices('shoot2', 'Pico shoot 2', [0, 1, 2, 3, 4, 5, 6, 7], "", 24, false);
				animation.addByIndices('shoot3', 'Pico shoot 3', [0, 1, 2, 3, 4, 5, 6, 7], "", 24, false);
				animation.addByIndices('shoot4', 'Pico shoot 4', [0, 1, 2, 3, 4, 5, 6, 7], "", 24, false);
				
				addOffset('shoot1', 0, 0);
				addOffset('shoot2', -1, -128);
				addOffset('shoot3', 412, -64);
				addOffset('shoot4', 439, -19);

				playAnim('shoot1');

			case 'gf-tankman':
				frames = Paths.getSparrowAtlas('tankman/gfTankman','shared');
				
				animation.addByPrefix('cheer', 'GF Dancing at Gunpoint', 24, false);
				animation.addByPrefix('singLEFT', 'GF Dancing at Gunpoint', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Dancing at Gunpoint', 24, false);
				animation.addByPrefix('singUP', 'GF Dancing at Gunpoint', 24, false);
				animation.addByPrefix('singDOWN', 'GF Dancing at Gunpoint', 24, false);
				animation.addByIndices('sad', 'GF Crying at Gunpoint ', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing at Gunpoint', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing at Gunpoint', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				
				addOffset('cheer');
				addOffset("singUP", 0, 4);
				addOffset("singRIGHT", 0, -20);
				addOffset("singLEFT", 0, -19);
				addOffset("singDOWN", 0, -20);
				addOffset('sad', -2, -21);
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);
				updateHitbox();
				

				playAnim('danceRight');
			case 'blackout':
				tex = Paths.getSparrowAtlas('mods/king/blackout','shared');
				frames = tex;
				animation.addByPrefix('idle', 'idle', 24);
				animation.addByPrefix('singUP', 'up', 24);
				animation.addByPrefix('singRIGHT', 'right', 24);
				animation.addByPrefix('singDOWN', 'down', 24);
				animation.addByPrefix('singLEFT', 'left', 24);
			
				addOffset('idle');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");
	
				playAnim('idle');
			case 'glitched-bob':
				tex = Paths.getSparrowAtlas('mods/bob/ScaryBobAaaaah');
				frames = tex;
				animation.addByPrefix('idle', "idle???-", 24, false);
				animation.addByPrefix('singUP', 'up', 24, false);
				animation.addByPrefix('singDOWN', 'down', 24, false);
				animation.addByPrefix('singLEFT', 'left', 24, false);
				animation.addByPrefix('singRIGHT', 'right', 24, false);

				addOffset('idle');
			case 'bob':
				tex = Paths.getSparrowAtlas('mods/bob/bob_asset');
				frames = tex;
				animation.addByPrefix('idle', "bob_idle", 24, false);
				animation.addByPrefix('singUP', 'bob_UP', 24, false);
				animation.addByPrefix('singDOWN', 'bob_DOWN', 24, false);
				animation.addByPrefix('singLEFT', 'bob_LEFT', 24, false);
				animation.addByPrefix('singRIGHT', 'bob_RIGHT', 24, false);

				addOffset('idle');

				flipX = true;
				case 'king':
					tex = Paths.getSparrowAtlas('mods/king/king');
					frames = tex;
					animation.addByPrefix('idle', 'idle', 24);
					animation.addByPrefix('singUP', 'up', 24);
					animation.addByPrefix('singRIGHT', 'right', 24);
					animation.addByPrefix('singDOWN', 'down', 24);
					animation.addByPrefix('singLEFT', 'left', 24);
					
					addOffset('idle');
					addOffset("singUP");
					addOffset("singRIGHT");
					addOffset("singLEFT");
					addOffset("singDOWN");
		
					playAnim('idle');
				case 'hypedking':
					tex = Paths.getSparrowAtlas('mods/king/hypedking');
					frames = tex;
					animation.addByPrefix('idle', 'idle', 24);
					animation.addByPrefix('singUP', 'up', 24);
					animation.addByPrefix('singRIGHT', 'right', 24);
					animation.addByPrefix('singDOWN', 'down', 24);
					animation.addByPrefix('singLEFT', 'left', 24);
				
					addOffset('idle');
					addOffset("singUP");
					addOffset("singRIGHT");
					addOffset("singLEFT");
					addOffset("singDOWN");
		
					playAnim('idle');
			case 'gf-tied':
			{
				tex = Paths.getSparrowAtlas('mods/updike/gf_but_spicy','shared');
				frames = tex;
				animation.addByIndices('danceLeft', 'GF Dancing Beat ', [14, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat ', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByPrefix('cry', 'gf sad');

				playAnim('danceRight'); // i hate this
			}
			case 'gf-tied-edgy':
			{
				tex = Paths.getSparrowAtlas('mods/updike/gf_but_spicy','shared');
				frames = tex;
				animation.addByIndices('danceLeft', 'GF Dancing Beat edgy', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat edgy', [14, 15, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
	
				playAnim('danceRight'); // i hate this
			}
			case 'bf-updike':
			{
				tex = Paths.getSparrowAtlas('mods/updike/bf_assets','shared');
				frames = tex;
				animation.addByPrefix('idle', 'BF idle dance0', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS0', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS0', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS0', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS0', 24, false);
			
				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				playAnim('idle');
				flipX = true;
			}
			case 'bf-edgy':
				{
					tex = Paths.getSparrowAtlas('mods/updike/bf_assets','shared');
					frames = tex;
					animation.addByPrefix('idle', 'BF idle dance edgy0', 24, false);
					animation.addByPrefix('singUP', 'BF NOTE UP edgy0', 24, false);
					animation.addByPrefix('singLEFT', 'BF NOTE LEFT edgy0', 24, false);
					animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT edgy0', 24, false);
					animation.addByPrefix('singDOWN', 'BF NOTE DOWN edgy0', 24, false);
					animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS edgy0', 24, false);
					animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS edgy0', 24, false);
					animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS edgy0', 24, false);
					animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS edgy0', 24, false);
					addOffset('idle', -5);
					addOffset("singUP", -29, 27);
					addOffset("singRIGHT", -38, -7);
					addOffset("singLEFT", 12, -6);
					addOffset("singDOWN", -10, -50);
					addOffset("singUPmiss", -29, 27);
					addOffset("singRIGHTmiss", -30, 21);
					addOffset("singLEFTmiss", 12, 24);
					addOffset("singDOWNmiss", -11, -19);
					playAnim('idle');
					flipX = true;
				}
			case 'gloop-bob':
				tex = Paths.getSparrowAtlas('mods/bob/oohscary');
				frames = tex;
				animation.addByPrefix('idle', "bob_idle", 24, false);
				animation.addByPrefix('singUP', 'bob_UP', 24, false);
				animation.addByPrefix('singDOWN', 'bob_DOWN', 24, false);
				animation.addByPrefix('singLEFT', 'bob_LEFT', 24, false);
				animation.addByPrefix('singRIGHT', 'bob_RIGHT', 24, false);
				animation.addByPrefix('Transform', 'bob_transform', 24, false);

				addOffset('idle');
	
				flipX = false;
				case 'gf-whitty':
					tex = Paths.getSparrowAtlas('mods/whitty/GF_Standing_Sway', 'shared');
					frames = tex;
					animation.addByPrefix('sad', 'Sad', 24, false);
					animation.addByPrefix('danceLeft', 'Idle Left', 24, false);
					animation.addByPrefix('danceRight', 'Idle Right', 24, false);
					animation.addByPrefix('scared', 'Scared', 24, false);
	
					addOffset('sad', -140, -153);
					addOffset('danceLeft', -140, -153);
					addOffset('danceRight', -140, -153);
					addOffset('scared', -140, -153);
	
					playAnim('danceRight');
					case 'whitty': // whitty reg (lofight,overhead)
					tex = Paths.getSparrowAtlas('mods/whitty/WhittySprites', 'shared');
					frames = tex;
					animation.addByPrefix('idle', 'Idle', 24);
					animation.addByPrefix('singUP', 'Sing Up', 24);
					animation.addByPrefix('singRIGHT', 'Sing Right', 24);
					animation.addByPrefix('singDOWN', 'Sing Down', 24);
					animation.addByPrefix('singLEFT', 'Sing Left', 24);
	
					addOffset('idle', 0,0 );
					addOffset("singUP", -6, 50);
					addOffset("singRIGHT", 0, 27);
					addOffset("singLEFT", -10, 10);
					addOffset("singDOWN", 0, -30);
				case 'whittyCrazy': // whitty crazy (ballistic)
					tex = Paths.getSparrowAtlas('mods/whitty/WhittyCrazy', 'shared');
					frames = tex;
					animation.addByPrefix('idle', 'Whitty idle dance', 24);
					animation.addByPrefix('singUP', 'Whitty Sing Note UP', 24);
					animation.addByPrefix('singRIGHT', 'whitty sing note right', 24);
					animation.addByPrefix('singDOWN', 'Whitty Sing Note DOWN', 24);
					animation.addByPrefix('singLEFT', 'Whitty Sing Note LEFT', 24);
	
					addOffset('idle', 50);
					addOffset("singUP", 50, 85);
					addOffset("singRIGHT", 100, -75);
					addOffset("singLEFT", 50);
					addOffset("singDOWN", 75, -150);
				
			case 'angrybob':
				tex = Paths.getSparrowAtlas('mods/bob/angrybob_asset');
				frames = tex;
				animation.addByPrefix('idle', "bob_idle", 24, false);
				animation.addByPrefix('singUP', 'bob_UP', 24, false);
				animation.addByPrefix('singDOWN', 'bob_DOWN', 24, false);
				animation.addByPrefix('singLEFT', 'bob_RIGHT', 24, false);
				animation.addByPrefix('singRIGHT', 'bob_LEFT', 24, false);

				addOffset('idle');

				flipX = true;
			
			case 'hellbob':
				tex = Paths.getSparrowAtlas('mods/bob/hellbob_assets');
				frames = tex;
				animation.addByPrefix('idle', "bobismad", 24);
				animation.addByPrefix('singUP', 'lol', 24, false);
				animation.addByPrefix('singDOWN', 'lol', 24, false);
				animation.addByPrefix('singUPmiss', 'lol', 24);
				animation.addByPrefix('singDOWNmiss', 'lol', 24);

				//addOffset('idle', 0, 27);

				playAnim('idle');

				flipX = true;
			case 'ron':
				tex = Paths.getSparrowAtlas('mods/bob/Tankman');
				frames = tex;
				animation.addByPrefix('idle', "Idle", 24);
				animation.addByPrefix('singUP', 'Sing Up', 24, false);
				animation.addByPrefix('singDOWN', 'Sing Down', 24, false);
				animation.addByPrefix('singLEFT', 'Sing Left', 24, false);
				animation.addByPrefix('singRIGHT', 'Sing Right', 24, false);
				animation.addByPrefix('cheer', 'Ugh', 24, false);
				addOffset('idle');
				addOffset("singUP", 42, 38);
				addOffset("singLEFT", 98, -27);
				addOffset("singRIGHT", -89, -51);
				addOffset("singDOWN", 40, -120);
				addOffset("Ugh", 71, -40);
				case 'ron-b':
					tex = Paths.getSparrowAtlas('mods/bob/TankmanB');
					frames = tex;
					animation.addByPrefix('idle', "Idle", 24);
					animation.addByPrefix('singUP', 'Sing Up', 24, false);
					animation.addByPrefix('singDOWN', 'Sing Down', 24, false);
					animation.addByPrefix('singLEFT', 'Sing Left', 24, false);
					animation.addByPrefix('singRIGHT', 'Sing Right', 24, false);
					animation.addByPrefix('cheer', 'Ugh', 24, false);
					addOffset('idle');
					addOffset("singUP", 42, 38);
					addOffset("singLEFT", 98, -27);
					addOffset("singRIGHT", -89, -51);
					addOffset("singDOWN", 40, -120);
					addOffset("Ugh", 71, -40);
			case 'chara':
				tex = Paths.getSparrowAtlas('mods/chara/chara'); // :flush:
				frames = tex;
				animation.addByIndices('idle', 'chara', [0, 1, 2, 3, 4, 5], "", 24);
				animation.addByPrefix('singUP', 'chara up', 24);
				animation.addByPrefix('singDOWN','chara down', 24);
				animation.addByPrefix('singLEFT', 'chara left', 24);
				animation.addByPrefix('singRIGHT', 'chara right', 24);
				animation.addByPrefix('star', 'chara zave', 24);
				animation.addByPrefix('stare', 'chara zrick', 24);
				animation.addByPrefix('oldRight', 'chara right', 24); // for the side switch stuff :)

				playAnim('idle');
			case 'impostor':
				// Water Vapor#0180 dm him and ask for a special surprise
				tex = Paths.getSparrowAtlas('characters/impostor','shared');
				frames = tex;
				animation.addByPrefix('idle', 'impostor idle', 12);
				animation.addByPrefix('singUP', 'impostor up', 12);
				animation.addByPrefix('singRIGHT', 'impostor right', 12);
				animation.addByPrefix('singDOWN', 'impostor down', 12);
				animation.addByPrefix('singLEFT', 'impostor left', 12);
				animation.addByPrefix('shoot1', 'impostor shoot 1', 24);
				animation.addByPrefix('shoot2', 'impostor shoot 2', 24);

				addOffset('idle');
				addOffset("singUP", -84, 0);
				addOffset("singRIGHT", -61, -20);
				addOffset("singLEFT", 91, -12);
				addOffset("singDOWN", -36, -65);
				addOffset("shoot1", -54, 75);
				addOffset("shoot2", -27, 124);

				playAnim('idle');

			case 'impostor2':
				// Water Vapor#0180 is the impostor
				tex = Paths.getSparrowAtlas('characters/impostor2','shared');
				frames = tex;
				animation.addByPrefix('idle', 'impostor idle', 12);
				animation.addByPrefix('singUP', 'impostor up', 12);
				animation.addByPrefix('singRIGHT', 'impostor right', 12);
				animation.addByPrefix('singDOWN', 'impostor down', 12);
				animation.addByPrefix('singLEFT', 'impostor left', 12);

				addOffset('idle');
				addOffset("singUP", -84, 0);
				addOffset("singRIGHT", -61, -20);
				addOffset("singLEFT", 91, -12);
				addOffset("singDOWN", -36, -65);

				playAnim('idle');
				case 'ggf':
					tex = Paths.getSparrowAtlas('characters/ggf','shared');
					frames = tex;
					animation.addByPrefix('cheer', 'GF Cheer', 24, true);
					animation.addByPrefix('singLEFT', 'GF left note', 24, false);
					animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
					animation.addByPrefix('singUP', 'GF Up Note', 24, false);
					animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
					animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
					animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
					animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
					animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
					animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
					animation.addByPrefix('scared', 'GF FEAR', 24);
	
					addOffset('cheer');
					addOffset('sad', -2, -2);
					addOffset('danceLeft', 0, -9);
					addOffset('danceRight', 0, -9);
	
					addOffset("singUP", 0, 4);
					addOffset("singRIGHT", 0, -20);
					addOffset("singLEFT", 0, -19);
					addOffset("singDOWN", 0, -20);
					addOffset('hairBlow', 45, -8);
					addOffset('hairFall', 0, -9);
	
					addOffset('scared', -2, -17);
	
					playAnim('danceRight');

					case 'bfg':
						var tex = Paths.getSparrowAtlas('characters/bfghost','shared');
						frames = tex;
						animation.addByPrefix('idle', 'BF idle dance', 24, false);
						animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
						animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
						animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
						animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
						animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
						animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
						animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
						animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
						animation.addByPrefix('hey', 'BF HEY', 24, false);
		
						animation.addByPrefix('firstDeath', "BF dies", 24, false);
						animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
						animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);
		
						animation.addByPrefix('scared', 'BF idle shaking', 24);
		
						addOffset('idle', -5);
						addOffset("singUP", -29, 27);
						addOffset("singRIGHT", -38, -7);
						addOffset("singLEFT", 12, -6);
						addOffset("singDOWN", -10, -50);
						addOffset("singUPmiss", -29, 27);
						addOffset("singRIGHTmiss", -30, 21);
						addOffset("singLEFTmiss", 12, 24);
						addOffset("singDOWNmiss", -11, -19);
						addOffset("hey", 7, 4);
						addOffset('firstDeath', 37, 11);
						addOffset('deathLoop', 37, 5);
						addOffset('deathConfirm', 37, 69);
						addOffset('scared', -4);
		
						playAnim('idle');
		
						flipX = true;
		
			case 'gf':
				// GIRLFRIEND CODE
				tex = Paths.getSparrowAtlas('characters/GF_assets');
				frames = tex;
				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24);

				addOffset('cheer');
				addOffset('sad', -2, -2);
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);

				addOffset("singUP", 0, 4);
				addOffset("singRIGHT", 0, -20);
				addOffset("singLEFT", 0, -19);
				addOffset("singDOWN", 0, -20);
				addOffset('hairBlow', 45, -8);
				addOffset('hairFall', 0, -9);

				addOffset('scared', -2, -17);

				playAnim('danceRight');

				case 'gf-sketch':
					// GIRLFRIEND CODE
					tex = Paths.getSparrowAtlas('characters/GF_sketch');
					frames = tex;
					animation.addByPrefix('cheer', 'GF Cheer', 24, false);
					animation.addByPrefix('singLEFT', 'GF left note', 24, false);
					animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
					animation.addByPrefix('singUP', 'GF Up Note', 24, false);
					animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
					animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
					animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
					animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
					animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
					animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
					animation.addByPrefix('scared', 'GF FEAR', 24);
	
					addOffset('cheer');
					addOffset('sad', -2, -2);
					addOffset('danceLeft', 0, -9);
					addOffset('danceRight', 0, -9);
	
					addOffset("singUP", 0, 4);
					addOffset("singRIGHT", 0, -20);
					addOffset("singLEFT", 0, -19);
					addOffset("singDOWN", 0, -20);
					addOffset('hairBlow', 45, -8);
					addOffset('hairFall', 0, -9);
	
					addOffset('scared', -2, -17);
	
					playAnim('danceRight');

				case 'gf-drip':
					// GIRLFRIEND CODE
					tex = Paths.getSparrowAtlas('mods/kapi/GF_assets');
					frames = tex;
					animation.addByPrefix('cheer', 'GF Cheer', 24, false);
					animation.addByPrefix('singLEFT', 'GF left note', 24, false);
					animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
					animation.addByPrefix('singUP', 'GF Up Note', 24, false);
					animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
					animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
					animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
					animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
					animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
					animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
					animation.addByPrefix('scared', 'GF FEAR', 24);
	
					addOffset('cheer');
					addOffset('sad', -2, -2);
					addOffset('danceLeft', 0, -9);
					addOffset('danceRight', 0, -9);
	
					addOffset("singUP", 0, 4);
					addOffset("singRIGHT", 0, -20);
					addOffset("singLEFT", 0, -19);
					addOffset("singDOWN", 0, -20);
					addOffset('hairBlow', 45, -8);
					addOffset('hairFall', 0, -9);
	
					addOffset('scared', -2, -17);
	
					playAnim('danceRight');

			case 'gf-christmas':
				tex = Paths.getSparrowAtlas('characters/gfChristmas');
				frames = tex;
				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24);

				addOffset('cheer');
				addOffset('sad', -2, -2);
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);

				addOffset("singUP", 0, 4);
				addOffset("singRIGHT", 0, -20);
				addOffset("singLEFT", 0, -19);
				addOffset("singDOWN", 0, -20);
				addOffset('hairBlow', 45, -8);
				addOffset('hairFall', 0, -9);

				addOffset('scared', -2, -17);

				playAnim('danceRight');

			case 'gf-car':
				tex = Paths.getSparrowAtlas('characters/gfCar');
				frames = tex;
				animation.addByIndices('singUP', 'GF Dancing Beat Hair blowing CAR', [0], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat Hair blowing CAR', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat Hair blowing CAR', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24,
					false);

				addOffset('danceLeft', 0);
				addOffset('danceRight', 0);

				playAnim('danceRight');

			case 'gf-pixel':
				tex = Paths.getSparrowAtlas('characters/gfPixel');
				frames = tex;
				animation.addByIndices('singUP', 'GF IDLE', [2], "", 24, false);
				animation.addByIndices('danceLeft', 'GF IDLE', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF IDLE', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);

				addOffset('danceLeft', 0);
				addOffset('danceRight', 0);

				playAnim('danceRight');

				setGraphicSize(Std.int(width * PlayState.daPixelZoom));
				updateHitbox();
				antialiasing = false;

				case 'gf-bob':
					tex = Paths.getSparrowAtlas('characters/Bob_gf');
					frames = tex;
					animation.addByIndices('sad', 'gf sad', [0], "", 24, false);
					animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
					animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24,
						false);
	
					addOffset('danceLeft', 0);
					addOffset('danceRight', 0);
					addOffset('sad', 0);
	
					playAnim('danceRight');
				case 'gf-bosip':
					tex = Paths.getSparrowAtlas('characters/Bosip_gf');
					frames = tex;
					animation.addByIndices('sad', 'gf sad', [0], "", 24, false);
					animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
					animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24,
						false);
	
					addOffset('danceLeft', 0);
					addOffset('danceRight', 0);
					addOffset('sad', 0);
	
					playAnim('danceRight');

			case 'dad':
		    {
				// DAD ANIMATION LOADING CODE
				if (!FlxG.save.data.optimizechars)
					tex = Paths.getSparrowAtlas('characters/DADDY_DEAREST', 'shared');
				else
					tex = Paths.getSparrowAtlas('optimized_characters/DADDY_DEAREST', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'Dad idle dance', 24);
				animation.addByPrefix('singUP', 'Dad Sing Note UP', 24);
				animation.addByPrefix('singRIGHT', 'Dad Sing Note RIGHT', 24);
				animation.addByPrefix('singDOWN', 'Dad Sing Note DOWN', 24);
				animation.addByPrefix('singLEFT', 'Dad Sing Note LEFT', 24);

				addOffset('idle');
				addOffset("singUP", -6, 50);
				addOffset("singRIGHT", 0, 27);
				addOffset("singLEFT", -10, 10);
				addOffset("singDOWN", 0, -30);

				playAnim('idle');
			}
			case 'bf-sketch':
				var tex = Paths.getSparrowAtlas('characters/bfSketch');
				frames = tex;
				animation.addByPrefix('idle', 'bf-sketch idle dance', 24, false);
				animation.addByPrefix('singUP', 'bf-sketch NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'bf-sketch NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'bf-sketch NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'bf-sketch NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'bf-sketch NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'bf-sketch NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'bf-sketch NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'bf-sketch NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'bf-sketc HEY', 24, false);

				animation.addByPrefix('firstDeath', "bf-sketch dies", 24, false);
				animation.addByPrefix('deathLoop', "bf-sketch Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "bf-sketch Dead confirm", 24, false);

				animation.addByPrefix('scared', 'bf-sketch idle shaking', 24);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				addOffset("hey", 7, 4);
				addOffset('firstDeath', 37, 11);
				addOffset('deathLoop', 37, 5);
				addOffset('deathConfirm', 37, 69);
				addOffset('scared', -4);

				playAnim('idle');

				flipX = true;
			case 'sketchy':
				// DAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('characters/sketchy_assets');
				frames = tex;
				animation.addByPrefix('idle', 'sketchy idle', 24);
				animation.addByPrefix('singUP', 'sketchy up', 24);
				animation.addByPrefix('singRIGHT', 'sketchy right', 24);
				animation.addByPrefix('singDOWN', 'sketchy down', 24);
				animation.addByPrefix('singLEFT', 'sketchy left', 24);

				addOffset('idle', 10, 0);
				addOffset("singUP", -16, 100);
				addOffset("singRIGHT", -23, -75);
				addOffset("singLEFT", 50, -45);
				addOffset("singDOWN", 10, -60);

				playAnim('idle');

			case 'angrysketchy':
				// DAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('characters/angry_sketch');
				frames = tex;
				animation.addByPrefix('idle', 'sketchyidlealt', 24);
				animation.addByPrefix('singUP', 'sketchyupalt', 24);
				animation.addByPrefix('singRIGHT', 'sketchyrightalt', 24);
				animation.addByPrefix('singDOWN', 'sketchydownalt', 24);
				animation.addByPrefix('singLEFT', 'sketchyleftalt', 24);
				animation.addByPrefix('tear', 'sketchyrip', 24, false);

				addOffset('idle');
				addOffset("singUP", -66, 98);
				addOffset("singRIGHT", -90, -75);
				addOffset("singLEFT", -43, -49);
				addOffset("singDOWN", -64, -61);
				addOffset('tear', 45, 89);

				playAnim('idle');

			case 'tornsketchy':
				// DAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('characters/crumple');
				frames = tex;
				animation.addByPrefix('idle', 'crumpleidle', 24);
				animation.addByPrefix('singUP', 'crumpleup', 24);
				animation.addByPrefix('singRIGHT', 'crumpleright', 24);
				animation.addByPrefix('singDOWN', 'crumpledown', 24);
				animation.addByPrefix('singLEFT', 'crumpleleft', 24);

				addOffset('idle');
				addOffset("singUP", 34, 121);
				addOffset("singRIGHT", -50, -13);
				addOffset("singLEFT", 190, -20);
				addOffset("singDOWN", 10, -62);

				playAnim('idle');
			case 'updike':
			{
				// DAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('mods/updike/updike_assets', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'updingdong idle0', 24);
				animation.addByPrefix('singUP', 'updingdong up note0', 24);
				animation.addByPrefix('singRIGHT', 'updingdong right note0', 24);
				animation.addByPrefix('singDOWN', 'updingdong down note0', 24);
				animation.addByPrefix('singLEFT', 'updingdong left note0', 24);
	
	
				playAnim('idle');
			}
			case 'updike-edgy':
			{
				// DAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('mods/updike/updike_assets', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'updingdong idle edgy0', 24);
				animation.addByPrefix('singUP', 'updingdong up note edgy0', 24);
				animation.addByPrefix('singRIGHT', 'updingdong right note edgy0', 24);
				animation.addByPrefix('singDOWN', 'updingdong down note edgy0', 24);
				animation.addByPrefix('singLEFT', 'updingdong left note edgy0', 24);

				playAnim('idle');
			}
				case 'garcello':
				{
					// DAD ANIMATION LOADING CODE
					if (!FlxG.save.data.optimizechars)
						tex = Paths.getSparrowAtlas('mods/gar/garcello_assets', 'shared');
					else
						tex = Paths.getSparrowAtlas('optimized_characters/garc', 'shared');
					frames = tex;
					animation.addByPrefix('idle', 'garcello idle dance', 24);
					animation.addByPrefix('singUP', 'garcello Sing Note UP', 24);
					animation.addByPrefix('singRIGHT', 'garcello Sing Note RIGHT', 24);
					animation.addByPrefix('singDOWN', 'garcello Sing Note DOWN', 24);
					animation.addByPrefix('singLEFT', 'garcello Sing Note LEFT', 24);
	
					playAnim('idle');
				}
				case 'garcellotired':
					{
					// DAD ANIMATION LOADING CODE
					if (!FlxG.save.data.optimizechars)
						tex = Paths.getSparrowAtlas('mods/gar/garcellotired_assets', 'shared');
					else
						tex = Paths.getSparrowAtlas('optimized_characters/garc_tired', 'shared');
					frames = tex;
					animation.addByPrefix('idle', 'garcellotired idle dance', 24);
					animation.addByPrefix('singUP', 'garcellotired Sing Note UP', 24);
					animation.addByPrefix('singRIGHT', 'garcellotired Sing Note RIGHT', 24);
					animation.addByPrefix('singDOWN', 'garcellotired Sing Note DOWN', 24);
					animation.addByPrefix('singLEFT', 'garcellotired Sing Note LEFT', 24);
					animation.addByPrefix('singDOWN-alt', 'garcellotired cough', 24);
						
					playAnim('idle');
					}
					case 'garcellodead':
					{
						// DAD ANIMATION LOADING CODE
						tex = Paths.getSparrowAtlas('mods/gar/garcellodead_assets', 'shared');
						frames = tex;
						animation.addByPrefix('idle', 'garcello idle dance', 24);
						animation.addByPrefix('singUP', 'garcello Sing Note UP', 24);
						animation.addByPrefix('singRIGHT', 'garcello Sing Note RIGHT', 24);
						animation.addByPrefix('singDOWN', 'garcello Sing Note DOWN', 24);
						animation.addByPrefix('singLEFT', 'garcello Sing Note LEFT', 24);
						animation.addByPrefix('coolguy', 'garcello coolguy', 24);
							
						playAnim('idle');
					}
						case 'garcelloghosty':
						{
							// DAD ANIMATION LOADING CODE
							tex = Paths.getSparrowAtlas('mods/gar/garcelloghosty_assets', 'shared');
							frames = tex;
							animation.addByPrefix('idle', 'garcello idle dance', 24);
							animation.addByPrefix('singUP', 'garcello Sing Note UP', 24);
							animation.addByPrefix('singRIGHT', 'garcello Sing Note RIGHT', 24);
							animation.addByPrefix('singDOWN', 'garcello Sing Note DOWN', 24);
							animation.addByPrefix('singLEFT', 'garcello Sing Note LEFT', 24);
							animation.addByPrefix('farewell', 'garcello coolguy');
								
							playAnim('idle');
						}
				case 'kapi':
				{
					// DAD ANIMATION LOADING CODE
					tex = Paths.getSparrowAtlas('mods/kapi/DADDY_DEAREST', 'shared');
					frames = tex;
					animation.addByPrefix('idle', 'Dad idle dance', 24);
					animation.addByPrefix('singUP', 'Dad Sing Note UP', 24);
					animation.addByPrefix('singRIGHT', 'Dad Sing Note RIGHT', 24);
					animation.addByPrefix('singDOWN', 'Dad Sing Note DOWN', 24);
					animation.addByPrefix('singLEFT', 'Dad Sing Note LEFT', 24);
					animation.addByPrefix('meow', 'Dad meow', 24);
					animation.addByPrefix('stare', 'Dad stare', 24);
	
					addOffset('idle');
					addOffset("singUP", -6, 50);
					addOffset("singRIGHT", 0, 27);
					addOffset("singLEFT", -10, 10);
					addOffset("singDOWN", 0, -30);
	
					playAnim('idle');
				}
					case 'kapi-mad':
					{
						// DAD ANIMATION LOADING CODE
						tex = Paths.getSparrowAtlas('mods/kapi/KAPI_ANGRY', 'shared');
						frames = tex;
						animation.addByPrefix('idle', 'Dad idle dance', 24);
						animation.addByPrefix('singUP', 'Dad Sing Note UP', 24);
						animation.addByPrefix('singRIGHT', 'Dad Sing Note RIGHT', 24);
						animation.addByPrefix('singDOWN', 'Dad Sing Note DOWN', 24);
						animation.addByPrefix('singLEFT', 'Dad Sing Note LEFT', 24);
						animation.addByPrefix('meow', 'Dad meow', 24);
		
						addOffset('idle');
						addOffset("singUP", -6, 50);
						addOffset("singRIGHT", 0, 27);
						addOffset("singLEFT", -10, 10);
						addOffset("singDOWN", 0, -30);
		
						playAnim('idle');
					}
			case 'spooky':
			{
				if (!FlxG.save.data.optimizechars)
					tex = Paths.getSparrowAtlas('characters/spooky_kids_assets','shared');
				else
					tex = Paths.getSparrowAtlas('optimized_characters/spooky_kids_assets','shared');
				frames = tex;
				animation.addByPrefix('singUP', 'spooky UP NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'spooky DOWN note', 24, false);
				animation.addByPrefix('singLEFT', 'note sing left', 24, false);
				animation.addByPrefix('singRIGHT', 'spooky sing right', 24, false);
				animation.addByIndices('danceLeft', 'spooky dance idle', [0, 2, 6], "", 12, false);
				animation.addByIndices('danceRight', 'spooky dance idle', [8, 10, 12, 14], "", 12, false);

				addOffset('danceLeft');
				addOffset('danceRight');

				addOffset("singUP", -20, 26);
				addOffset("singRIGHT", -130, -14);
				addOffset("singLEFT", 130, -10);
				addOffset("singDOWN", -50, -130);

				playAnim('danceRight');
			}
			case 'mom':
				tex = Paths.getSparrowAtlas('characters/Mom_Assets');
				frames = tex;

				animation.addByPrefix('idle', "Mom Idle", 24, false);
				animation.addByPrefix('singUP', "Mom Up Pose", 24, false);
				animation.addByPrefix('singDOWN', "MOM DOWN POSE", 24, false);
				animation.addByPrefix('singLEFT', 'Mom Left Pose', 24, false);
				// ANIMATION IS CALLED MOM LEFT POSE BUT ITS FOR THE RIGHT
				// CUZ DAVE IS DUMB!
				animation.addByPrefix('singRIGHT', 'Mom Pose Left', 24, false);

				addOffset('idle');
				addOffset("singUP", 14, 71);
				addOffset("singRIGHT", 10, -60);
				addOffset("singLEFT", 250, -23);
				addOffset("singDOWN", 20, -160);

				playAnim('idle');

			case 'mom-car':
			{
				if (!FlxG.save.data.optimizechars)
					tex = Paths.getSparrowAtlas('characters/momCar','shared');
				else
					tex = Paths.getSparrowAtlas('optimized_characters/momCar','shared');
				frames = tex;

				animation.addByPrefix('idle', "Mom Idle", 24, false);
				animation.addByPrefix('singUP', "Mom Up Pose", 24, false);
				animation.addByPrefix('singDOWN', "MOM DOWN POSE", 24, false);
				animation.addByPrefix('singLEFT', 'Mom Left Pose', 24, false);
				// ANIMATION IS CALLED MOM LEFT POSE BUT ITS FOR THE RIGHT
				// CUZ DAVE IS DUMB!
				animation.addByPrefix('singRIGHT', 'Mom Pose Left', 24, false);

				addOffset('idle');
				addOffset("singUP", 14, 71);
				addOffset("singRIGHT", 10, -60);
				addOffset("singLEFT", 250, -23);
				addOffset("singDOWN", 20, -160);

				playAnim('idle');
			}
			case 'monster':
			{
				if (!FlxG.save.data.optimizechars)
					tex = Paths.getSparrowAtlas('characters/Monster_Assets','shared');
				else
					tex = Paths.getSparrowAtlas('optimized_characters/Monster_Assets','shared');
				frames = tex;
				animation.addByPrefix('idle', 'monster idle', 24, false);
				animation.addByPrefix('singUP', 'monster up note', 24, false);
				animation.addByPrefix('singDOWN', 'monster down', 24, false);
				animation.addByPrefix('singLEFT', 'Monster left note', 24, false);
				animation.addByPrefix('singRIGHT', 'Monster Right note', 24, false);

				addOffset('idle');
				addOffset("singUP", -20, 50);
				addOffset("singRIGHT", -51);
				addOffset("singLEFT", -30);
				addOffset("singDOWN", -30, -40);
				playAnim('idle');
			}
			case 'monster-christmas':
			{
				if (!FlxG.save.data.optimizechars)
					tex = Paths.getSparrowAtlas('characters/monsterChristmas','shared');
				else
					tex = Paths.getSparrowAtlas('optimized_characters/Monster_Assets','shared');
				frames = tex;
				animation.addByPrefix('idle', 'monster idle', 24, false);
				animation.addByPrefix('singUP', 'monster up note', 24, false);
				animation.addByPrefix('singDOWN', 'monster down', 24, false);
				animation.addByPrefix('singLEFT', 'Monster left note', 24, false);
				animation.addByPrefix('singRIGHT', 'Monster Right note', 24, false);

				addOffset('idle');
				addOffset("singUP", -20, 50);
				addOffset("singRIGHT", -51);
				addOffset("singLEFT", -30);
				addOffset("singDOWN", -40, -94);
				playAnim('idle');
			}
			case 'annie-drunk':
				{
					tex = Paths.getSparrowAtlas('mods/annie/christmas/monsterChristmas','shared');
					frames = tex;
					animation.addByPrefix('idle', 'monster idle', 24, false);
					animation.addByPrefix('singUP', 'monster up note', 24, false);
					animation.addByPrefix('singDOWN', 'monster down', 24, false);
					animation.addByPrefix('singLEFT', 'Monster left note', 24, false);
					animation.addByPrefix('singRIGHT', 'Monster Right note', 24, false);
	
					addOffset('idle');
					addOffset("singUP", -20, 50);
					addOffset("singRIGHT", -51);
					addOffset("singLEFT", -30);
					addOffset("singDOWN", -40, -94);
					playAnim('idle');
				}
			case 'pico':
			{
				if (FlxG.save.data.optimizechars)
					tex = Paths.getSparrowAtlas('optimized_characters/Pico_FNF_assetss','shared');
				else
					tex = Paths.getSparrowAtlas('characters/Pico_FNF_assetss','shared');
				frames = tex;
				animation.addByPrefix('idle', "Pico Idle Dance", 24);
				animation.addByPrefix('singUP', 'pico Up note0', 24, false);
				animation.addByPrefix('singDOWN', 'Pico Down Note0', 24, false);
				if (isPlayer)
				{
					animation.addByPrefix('singLEFT', 'Pico NOTE LEFT0', 24, false);
					animation.addByPrefix('singRIGHT', 'Pico Note Right0', 24, false);
					animation.addByPrefix('singRIGHTmiss', 'Pico Note Right Miss', 24, false);
					animation.addByPrefix('singLEFTmiss', 'Pico NOTE LEFT miss', 24, false);
				}
				else
				{
					// Need to be flipped! REDO THIS LATER!
					animation.addByPrefix('singLEFT', 'Pico Note Right0', 24, false);
					animation.addByPrefix('singRIGHT', 'Pico NOTE LEFT0', 24, false);
					animation.addByPrefix('singRIGHTmiss', 'Pico NOTE LEFT miss', 24, false);
					animation.addByPrefix('singLEFTmiss', 'Pico Note Right Miss', 24, false);
				}

				animation.addByPrefix('singUPmiss', 'pico Up note miss', 24);
				animation.addByPrefix('singDOWNmiss', 'Pico Down Note MISS', 24);

				addOffset('idle');
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -68, -7);
				addOffset("singLEFT", 65, 9);
				addOffset("singDOWN", 200, -70);
				addOffset("singUPmiss", -19, 67);
				addOffset("singRIGHTmiss", -60, 41);
				addOffset("singLEFTmiss", 62, 64);
				addOffset("singDOWNmiss", 210, -28);

				playAnim('idle');

				flipX = true;
			}
			case 'annie':
				{
					tex = Paths.getSparrowAtlas('mods/annie/Pico_FNF_assetss','shared');
					frames = tex;
					animation.addByPrefix('idle', "Pico Idle Dance", 24);
					animation.addByPrefix('singUP', 'pico Up note0', 24, false);
					animation.addByPrefix('singDOWN', 'Pico Down Note0', 24, false);
					if (isPlayer)
					{
						animation.addByPrefix('singLEFT', 'Pico NOTE LEFT0', 24, false);
						animation.addByPrefix('singRIGHT', 'Pico Note Right0', 24, false);
						animation.addByPrefix('singRIGHTmiss', 'Pico Note Right Miss', 24, false);
						animation.addByPrefix('singLEFTmiss', 'Pico NOTE LEFT miss', 24, false);
					}
					else
					{
						// Need to be flipped! REDO THIS LATER!
						animation.addByPrefix('singLEFT', 'Pico Note Right0', 24, false);
						animation.addByPrefix('singRIGHT', 'Pico NOTE LEFT0', 24, false);
						animation.addByPrefix('singRIGHTmiss', 'Pico NOTE LEFT miss', 24, false);
						animation.addByPrefix('singLEFTmiss', 'Pico Note Right Miss', 24, false);
					}
	
					animation.addByPrefix('singUPmiss', 'pico Up note miss', 24);
					animation.addByPrefix('singDOWNmiss', 'Pico Down Note MISS', 24);
	
					addOffset('idle');
					addOffset("singUP", -29, 27);
					addOffset("singRIGHT", -68, -7);
					addOffset("singLEFT", 65, 9);
					addOffset("singDOWN", 200, -70);
					addOffset("singUPmiss", -19, 67);
					addOffset("singRIGHTmiss", -60, 41);
					addOffset("singLEFTmiss", 62, 64);
					addOffset("singDOWNmiss", 210, -28);
	
					playAnim('idle');
	
					flipX = true;
				}

			case 'bf':
			{
				if (PlayState.storyWeek != 7)
					tex = Paths.getSparrowAtlas('characters/BOYFRIEND', 'shared');
				else if (FlxG.save.data.optimizechars)
					tex = Paths.getSparrowAtlas('optimized_characters/BOYFRIEND', 'shared');
				else
					tex = Paths.getSparrowAtlas('mods/kapi/BOYFRIEND','shared');
				frames = tex;

				trace(tex.frames.length);

				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

				animation.addByPrefix('scared', 'BF idle shaking', 24);
				animation.addByPrefix('oldLeft', 'BF NOTE LEFT0', 24);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				addOffset("hey", 7, 4);
				addOffset('firstDeath', 37, 11);
				addOffset('deathLoop', 37, 5);
				addOffset('deathConfirm', 37, 69);
				addOffset('scared', -4);

				playAnim('idle');

				flipX = true;
			}
			case 'bf-night':
				var tex = Paths.getSparrowAtlas('characters/BOYFRIENDnight', 'shared');
				frames = tex;

				trace(tex.frames.length);

				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

				animation.addByPrefix('scared', 'BF idle shaking', 24);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				addOffset("hey", 7, 4);
				addOffset('firstDeath', 37, 11);
				addOffset('deathLoop', 37, 5);
				addOffset('deathConfirm', 37, 69);
				addOffset('scared', -4);

				playAnim('idle');

				flipX = true;

			case 'amor':
				frames = Paths.getSparrowAtlas('characters/extra/amor_assets', 'shared');
				animation.addByPrefix('idle', 'Amor idle dance', 24, false);
				animation.addByPrefix('singUP', 'Amor Sing Note UP', 24, false);
				animation.addByPrefix('singDOWN', 'Amor Sing Note DOWN', 24, false);
				animation.addByPrefix('singLEFT', 'Amor Sing Note LEFT', 24, false);
				animation.addByPrefix('singRIGHT', 'Amor Sing Note RIGHT', 24, false);
				animation.addByPrefix('drop', 'Amor drop', 24, false);

				addOffset('idle');
				addOffset("singUP", 5, 41);
				addOffset("singRIGHT", -11, 2);
				addOffset("singLEFT", 25, 1);
				addOffset("singDOWN", -23, -16);
				addOffset("drop", 42, 156);

				playAnim('idle');
			case 'bob-from-the-other-mod':
				frames = Paths.getSparrowAtlas('characters/extra/bob_assets', 'shared');
				animation.addByPrefix('idle', 'BOB idle dance', 24, false);
				animation.addByPrefix('singUP', 'BOB Sing Note UP', 24, false);
				animation.addByPrefix('singDOWN', 'BOB Sing Note DOWN', 24, false);
				animation.addByPrefix('singLEFT', 'BOB Sing Note LEFT', 24, false);
				animation.addByPrefix('singRIGHT', 'BOB Sing Note RIGHT', 24, false);

				addOffset('idle');
				addOffset("singUP", -36, 57);
				addOffset("singRIGHT", -62, 32);
				addOffset("singLEFT",31, 13);
				addOffset("singDOWN", -31, -10);

				playAnim('idle');
			case 'bosip':
				frames = Paths.getSparrowAtlas('characters/extra/bosip_assets', 'shared');
				animation.addByPrefix('idle', 'Bosip idle dance', 24, false);
				animation.addByPrefix('singUP', 'Bosip Sing Note UP', 24, false);
				animation.addByPrefix('singDOWN', 'Bosip Sing Note DOWN', 24, false);
				animation.addByPrefix('singLEFT', 'Bosip Sing Note LEFT', 24, false);
				animation.addByPrefix('singRIGHT', 'Bosip Sing Note RIGHT', 24, false);

				addOffset('idle');
				addOffset("singUP", 23, 24);
				addOffset("singRIGHT", -6, -18);
				addOffset("singLEFT", 64, 7);
				addOffset("singDOWN", 22, -18);

				playAnim('idle');
			case 'pc':
				frames = Paths.getSparrowAtlas('characters/extra/pc', 'shared');
				animation.addByPrefix('idle', 'PC idle', 24, false);
				animation.addByPrefix('singUP', 'PC Note UP', 24, false);
				animation.addByPrefix('singDOWN', 'PC Note DOWN', 24, false);
				animation.addByPrefix('singLEFT', 'PC Note LEFT', 24, false);
				animation.addByPrefix('singRIGHT', 'PC Note RIGHT', 24, false);

				addOffset('idle');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");

				playAnim('idle');

			case 'bf-christmas':
			{
				if (!FlxG.save.data.optimizechars)
					frames = Paths.getSparrowAtlas('characters/bfChristmas');
				else
					frames = Paths.getSparrowAtlas('optimized_characters/BOYFRIEND','shared');
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				addOffset("hey", 7, 4);

				playAnim('idle');

				flipX = true;
			}
			case 'bf-car':
			{
				if (!FlxG.save.data.optimizechars)
					frames = Paths.getSparrowAtlas('characters/bfCar','shared');
				else
					frames = Paths.getSparrowAtlas('optimized_characters/BOYFRIEND','shared');
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				playAnim('idle');

				flipX = true;
			}
			case 'bf-pixel':
				frames = Paths.getSparrowAtlas('characters/bfPixel');
				animation.addByPrefix('idle', 'BF IDLE', 24, false);
				animation.addByPrefix('singUP', 'BF UP NOTE', 24, false);
				animation.addByPrefix('singLEFT', 'BF LEFT NOTE', 24, false);
				animation.addByPrefix('singRIGHT', 'BF RIGHT NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'BF DOWN NOTE', 24, false);
				animation.addByPrefix('singUPmiss', 'BF UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF DOWN MISS', 24, false);

				addOffset('idle');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");
				addOffset("singUPmiss");
				addOffset("singRIGHTmiss");
				addOffset("singLEFTmiss");
				addOffset("singDOWNmiss");

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				playAnim('idle');

				width -= 100;
				height -= 100;

				antialiasing = false;

				flipX = true;
			case 'bf-pixel-dead':
				frames = Paths.getSparrowAtlas('characters/bfPixelsDEAD');
				animation.addByPrefix('singUP', "BF Dies pixel", 24, false);
				animation.addByPrefix('firstDeath', "BF Dies pixel", 24, false);
				animation.addByPrefix('deathLoop', "Retry Loop", 24, true);
				animation.addByPrefix('deathConfirm', "RETRY CONFIRM", 24, false);
				animation.play('firstDeath');

				addOffset('firstDeath');
				addOffset('deathLoop', -37);
				addOffset('deathConfirm', -37);
				playAnim('firstDeath');
				// pixel bullshit
				setGraphicSize(Std.int(width * 6));
				updateHitbox();
				antialiasing = false;
				flipX = true;

			case 'senpai':
				frames = Paths.getSparrowAtlas('characters/senpai');
				animation.addByPrefix('idle', 'Senpai Idle', 24, false);
				animation.addByPrefix('singUP', 'SENPAI UP NOTE', 24, false);
				animation.addByPrefix('singLEFT', 'SENPAI LEFT NOTE', 24, false);
				animation.addByPrefix('singRIGHT', 'SENPAI RIGHT NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'SENPAI DOWN NOTE', 24, false);

				addOffset('idle');
				addOffset("singUP", 5, 37);
				addOffset("singRIGHT");
				addOffset("singLEFT", 40);
				addOffset("singDOWN", 14);

				playAnim('idle');

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				antialiasing = false;
			case 'senpai-angry':
				frames = Paths.getSparrowAtlas('characters/senpai');
				animation.addByPrefix('idle', 'Angry Senpai Idle', 24, false);
				animation.addByPrefix('singUP', 'Angry Senpai UP NOTE', 24, false);
				animation.addByPrefix('singLEFT', 'Angry Senpai LEFT NOTE', 24, false);
				animation.addByPrefix('singRIGHT', 'Angry Senpai RIGHT NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'Angry Senpai DOWN NOTE', 24, false);

				addOffset('idle');
				addOffset("singUP", 5, 37);
				addOffset("singRIGHT");
				addOffset("singLEFT", 40);
				addOffset("singDOWN", 14);
				playAnim('idle');

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				antialiasing = false;

			case 'spirit':
				frames = Paths.getPackerAtlas('characters/spirit');
				animation.addByPrefix('idle', "idle spirit_", 24, false);
				animation.addByPrefix('singUP', "up_", 24, false);
				animation.addByPrefix('singRIGHT', "right_", 24, false);
				animation.addByPrefix('singLEFT', "left_", 24, false);
				animation.addByPrefix('singDOWN', "spirit down_", 24, false);

				addOffset('idle', -220, -280);
				addOffset('singUP', -220, -240);
				addOffset("singRIGHT", -220, -280);
				addOffset("singLEFT", -200, -280);
				addOffset("singDOWN", 170, 110);

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				playAnim('idle');

				antialiasing = false;

			case 'parents-christmas':
			{
				if (!FlxG.save.data.optimizechars)
					frames = Paths.getSparrowAtlas('characters/mom_dad_christmas_assets');
				else
					frames = Paths.getSparrowAtlas('optimized_characters/parents-christmas','shared');
				animation.addByPrefix('idle', 'Parent Christmas Idle', 24, false);
				animation.addByPrefix('singUP', 'Parent Up Note Dad', 24, false);
				animation.addByPrefix('singDOWN', 'Parent Down Note Dad', 24, false);
				animation.addByPrefix('singLEFT', 'Parent Left Note Dad', 24, false);
				animation.addByPrefix('singRIGHT', 'Parent Right Note Dad', 24, false);

				animation.addByPrefix('singUP-alt', 'Parent Up Note Mom', 24, false);

				animation.addByPrefix('singDOWN-alt', 'Parent Down Note Mom', 24, false);
				animation.addByPrefix('singLEFT-alt', 'Parent Left Note Mom', 24, false);
				animation.addByPrefix('singRIGHT-alt', 'Parent Right Note Mom', 24, false);

				addOffset('idle');
				addOffset("singUP", -47, 24);
				addOffset("singRIGHT", -1, -23);
				addOffset("singLEFT", -30, 16);
				addOffset("singDOWN", -31, -29);
				addOffset("singUP-alt", -47, 24);
				addOffset("singRIGHT-alt", -1, -24);
				addOffset("singLEFT-alt", -30, 15);
				addOffset("singDOWN-alt", -30, -27);

				playAnim('idle');
			}
		}

		dance();

		if (isPlayer)
		{
			flipX = !flipX;

			// Doesn't flip for BF, since his are already in the right place???
			if (!curCharacter.startsWith('bf'))
			{
				// var animArray
				var oldRight = animation.getByName('singRIGHT').frames;
				animation.getByName('singRIGHT').frames = animation.getByName('singLEFT').frames;
				animation.getByName('singLEFT').frames = oldRight;

				// IF THEY HAVE MISS ANIMATIONS??
				if (animation.getByName('singRIGHTmiss') != null)
				{
					var oldMiss = animation.getByName('singRIGHTmiss').frames;
					animation.getByName('singRIGHTmiss').frames = animation.getByName('singLEFTmiss').frames;
					animation.getByName('singLEFTmiss').frames = oldMiss;
				}
			}
		}
	}

	override function update(elapsed:Float)
	{
		if (!curCharacter.startsWith('bf'))
		{
			if (animation.curAnim.name.startsWith('sing'))
			{
				holdTimer += elapsed;
			}

			var dadVar:Float = 4;

			if (curCharacter == 'dad')
				dadVar = 6.1;
			if (holdTimer >= Conductor.stepCrochet * dadVar * 0.001)
			{
				trace('dance');
				dance();
				holdTimer = 0;
			}
		}

		switch (curCharacter)
		{
			case 'gf':
				if (animation.curAnim.name == 'hairFall' && animation.curAnim.finished)
					playAnim('danceRight');
		}

		super.update(elapsed);
	}

	private var danced:Bool = false;

	/**
	 * FOR GF DANCING SHIT
	 */
	public function dance()
	{
		if (!debugMode)
		{
			switch (curCharacter)
			{
				case 'gf':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}
					case 'gf-bob':
						if (!animation.curAnim.name.startsWith('hair'))
						{
							danced = !danced;
	
							if (danced)
								playAnim('danceRight');
							else
								playAnim('danceLeft');
						}
						case 'gf-whitty':
							if (!animation.curAnim.name.startsWith('hair'))
							{
								danced = !danced;
		
								if (danced)
									playAnim('danceRight');
								else
									playAnim('danceLeft');
							}
						case 'gf-tied':
							if (!animation.curAnim.name.startsWith('hair'))
							{
								danced = !danced;
		
								if (danced)
									playAnim('danceRight');
								else
									playAnim('danceLeft');
							}
							case 'gf-tied-edgy':
								if (!animation.curAnim.name.startsWith('hair'))
								{
									danced = !danced;
			
									if (danced)
										playAnim('danceRight');
									else
										playAnim('danceLeft');
								}
								case 'gf-sketch':
									if (!animation.curAnim.name.startsWith('hair'))
									{
										danced = !danced;
				
										if (danced)
											playAnim('danceRight');
										else
											playAnim('danceLeft');
									}
						case 'gf-bosip':
							if (!animation.curAnim.name.startsWith('hair'))
							{
								danced = !danced;
		
								if (danced)
									playAnim('danceRight');
								else
									playAnim('danceLeft');
							}
					case 'ggf':
						if (!animation.curAnim.name.startsWith('hair'))
						{
							danced = !danced;
	
							if (danced)
								playAnim('danceRight');
							else
								playAnim('danceLeft');
						}
					case 'gf-drip':
						if (!animation.curAnim.name.startsWith('hair'))
						{
							danced = !danced;
	
							if (danced)
								playAnim('danceRight');
							else
								playAnim('danceLeft');
						}

				case 'gf-christmas':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}

				case 'gf-car':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}
				case 'gf-pixel':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}

				case 'spooky':
					danced = !danced;

					if (danced)
						playAnim('danceRight');
					else
						playAnim('danceLeft');
				default:
					playAnim('idle');
			}
		}
	}

	public function playAnim(AnimName:String, Force:Bool = false, Reversed:Bool = false, Frame:Int = 0):Void
	{
		animation.play(AnimName, Force, Reversed, Frame);

		var daOffset = animOffsets.get(AnimName);
		if (animOffsets.exists(AnimName))
		{
			offset.set(daOffset[0], daOffset[1]);
		}
		else
			offset.set(0, 0);

		if (curCharacter == 'gf')
		{
			if (AnimName == 'singLEFT')
			{
				danced = true;
			}
			else if (AnimName == 'singRIGHT')
			{
				danced = false;
			}

			if (AnimName == 'singUP' || AnimName == 'singDOWN')
			{
				danced = !danced;
			}
		}
	}

	public function addOffset(name:String, x:Float = 0, y:Float = 0)
	{
		animOffsets[name] = [x, y];
	}
}
