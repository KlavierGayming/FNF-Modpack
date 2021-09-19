package;

import flash.system.System;
import flixel.*;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class FuckOff extends MusicBeatState
{
	override function create()
	{
		super.create();
		var text:FlxText = new FlxText(0, 0, 0, "If you want early downloads like this, fuck off and get off my channel.");
		text.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		text.screenCenter();
		new FlxTimer().start(2, function(tmr:FlxTimer)
		{
			fancyOpenURL('https://www.youtube.com/watch?v=dQw4w9WgXcQ');
			System.exit(0);
		});
	}
}
