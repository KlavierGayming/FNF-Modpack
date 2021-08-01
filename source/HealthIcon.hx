package;

import flixel.FlxSprite;
/**
 * why does this file exist i hate it >:(
 */
class HealthIcon extends FlxSprite
{
	/**
	 * Used for FreeplayState! If you use it elsewhere, prob gonna annoying
	 */
	public var sprTracker:FlxSprite;

	public function new(char:String = 'bf', isPlayer:Bool = false)
	{
		super();
		
		loadGraphic(Paths.image('iconGrid'), true, 150, 150);

		antialiasing = true;
		animation.add('bf', [0, 1], 0, false, isPlayer);
		animation.add('bf-car', [0, 1], 0, false, isPlayer);
		animation.add('bf-christmas', [0, 1], 0, false, isPlayer);
		animation.add('bf-pixel', [21, 21], 0, false, isPlayer);
		animation.add('spooky', [2, 3], 0, false, isPlayer);
		animation.add('pico', [4, 5], 0, false, isPlayer);
		animation.add('mom', [6, 7], 0, false, isPlayer);
		animation.add('mom-car', [6, 7], 0, false, isPlayer);
		animation.add('tankman', [8, 9], 0, false, isPlayer);
		animation.add('face', [10, 11], 0, false, isPlayer);
		animation.add('dad', [12, 13], 0, false, isPlayer);
		animation.add('senpai', [22, 22], 0, false, isPlayer);
		animation.add('senpai-angry', [22, 22], 0, false, isPlayer);
		animation.add('spirit', [23, 23], 0, false, isPlayer);
		animation.add('bf-old', [14, 15], 0, false, isPlayer);
		animation.add('gf', [16], 0, false, isPlayer);
		animation.add('gf-christmas', [16], 0, false, isPlayer);
		animation.add('gf-pixel', [16], 0, false, isPlayer);
		animation.add('parents-christmas', [17, 18], 0, false, isPlayer);
		animation.add('monster', [19, 20], 0, false, isPlayer);
		animation.add('monster-christmas', [19, 20], 0, false, isPlayer);
		animation.add('kapi', [24, 25], 0, false, isPlayer);
		animation.add('kapi-mad', [26], 0, false, isPlayer);
		animation.add('garcello', [28, 29], 0, false, isPlayer);
		animation.add('garcellotired', [30, 31], 0, false, isPlayer);
		animation.add('garcellodead', [32, 33], 0, false, isPlayer);
		animation.add('garcelloghosty', [33], 0, false, isPlayer);
		animation.add('impostor', [34, 35], 0, false, isPlayer);
		animation.add('impostor2', [34, 35], 0, false, isPlayer);
		animation.add('bfg', [0, 1], 0, false, isPlayer);
		animation.add('annie', [36, 37], 0, false, isPlayer);
		animation.add('annie-drunk', [38, 39], 0, false, isPlayer);
		animation.add('bob', [40, 41], 0, false, isPlayer);
		animation.add('angrybob', [42, 43], 0, false, isPlayer);
		animation.add('hellbob', [44, 45], 0, false, isPlayer);
		animation.add('ron', [46, 47], 0, false, isPlayer);
		animation.add('gloop-bob', [48, 49], 0, false, isPlayer);
		animation.add('glitched-bob', [50, 51], 0, false, isPlayer);
		animation.add('chara', [54, 55], 0, false, isPlayer);
		animation.add('bob-from-the-other-mod', [56, 57], 0, false, isPlayer);
		animation.add('bosip', [58, 59], 0, false, isPlayer);
		animation.add('amor', [60, 61], 0, false, isPlayer);
		animation.add('bf-night', [0, 1], 0, false, isPlayer);
		animation.add('whitty', [64, 65], 0, false, isPlayer);
		animation.add('whittyCrazy', [66, 67], false, isPlayer);
		animation.add('pc', [10, 11], 0, false, isPlayer);
		animation.add('updike', [62, 63], 0, false, isPlayer);
		animation.add('bf-updike', [0, 1], 0, false, isPlayer);
		animation.add('sketchy', [68, 69], 0, false, isPlayer);
		animation.add('tornsketchy', [70, 71], 0, false, isPlayer);
		animation.add('bf-sketch', [72, 73], 0, false, isPlayer);
		animation.add('ron-b', [74, 75], 0, false, isPlayer);
		animation.add('king', [76, 77],0, false, isPlayer);
		animation.add('hypedking', [78, 79],0, false, isPlayer);
		animation.add('blackout', [80, 81],0, false, isPlayer);
		animation.add('bf-holding-gf', [0, 1],0, false, isPlayer);
		animation.add('cj', [82, 83],0, false, isPlayer);
		animation.add('ruby', [84, 85],0, false, isPlayer);
		animation.add('bfgf', [0, 1],0, false, isPlayer);
		animation.add('duet', [86, 87],0, false, isPlayer);
		animation.add('max', [10, 11],0, false, isPlayer);
		animation.add('abel', [10, 11],0, false, isPlayer);
		animation.play(char);

		switch(char)
		{
			case 'bf-pixel' | 'senpai' | 'senpai-angry' | 'spirit' | 'gf-pixel':
				antialiasing = false;
		}

		scrollFactor.set();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width + 10, sprTracker.y - 30);
	}
}
