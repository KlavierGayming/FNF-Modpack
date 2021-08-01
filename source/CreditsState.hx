package;
import flixel.*;
import flixel.text.FlxText;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.*;
import flixel.tweens.FlxTween;

class CreditsState extends MusicBeatState
{
    var menuItems:Array<String> = ['KadeDev','Klavier Gayming',"Zack'sGamerz",'Peppy'];
    var curSelected:Int = 0;
    var grpOptions:FlxTypedGroup<FlxText>;
    var description:FlxText;

    override function create() {
		super.create();

        var bg:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image('menuDesat'));
        bg.color = FlxColor.PURPLE;
        add(bg);
        
		grpOptions = new FlxTypedGroup<FlxText>();
		add(grpOptions);

		
		for (i in 0...menuItems.length)
		{
			var optionText:FlxText = new FlxText(20, 20 + (i * 50), 0, menuItems[i], 50);
			optionText.ID = i;
            optionText.setFormat(Paths.font('funkin.otf'), 32, FlxColor.WHITE, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
			grpOptions.add(optionText);
		}
        description = new FlxText(0, FlxG.height - 25, 0, "", 16);
        var blackThing:FlxSprite = new FlxSprite(0, FlxG.height - 8).makeGraphic(FlxG.width * 2, 16, FlxColor.BLACK);
        blackThing.alpha = 0.35;
        add(blackThing);
        add(description);
    }
    override function update(elapsed:Float)
    {
        super.update(elapsed);
		if (controls.UP_P)
			curSelected -= 1;

		if (controls.DOWN_P)
			curSelected += 1;

        if (curSelected < 0)
			curSelected = menuItems.length - 1;

		if (curSelected >= menuItems.length)
			curSelected = 0;

        grpOptions.forEach(function(txt:FlxText)
            {
                txt.color = FlxColor.WHITE;
                if (txt.ID == curSelected)
                {
                    txt.color = 0xFF1fffbc;
                }
            });

        switch (menuItems[curSelected])
        {
            case 'KadeDev':
                description.text = 'Made the engine used for this';
            case 'Klavier Gayming':
                description.text = 'Made basically everything else except the engine and the things listed below';
            case 'Peppy':
                description.text = 'Gave me the code for the starlight mayhem cutscenes (didnt end up using them but thanks anyways)';
            case "Zack'sGamerz":
                description.text = 'Gave me code for Note Splash';
        }
        if (controls.ACCEPT)
        {
            switch (menuItems[curSelected])
            {
                case 'KadeDev':
                    fancyOpenURL('https://www.youtube.com/channel/UCoYksltIxNuSHz_ERzoRP6g');
                case 'Klavier Gayming':
                    fancyOpenURL('https://www.youtube.com/channel/UCcaaRaMVhZulqORqfbr17zw');
                case 'Peppy':
                    fancyOpenURL('https://www.youtube.com/channel/UCmGq-hQDmdYcF26FLBsfwaA');
                case "Zack'sGamerz":
                    fancyOpenURL('https://www.youtube.com/channel/UCbWNOpUvvruwi3pbYVC_yWQ');
            }
        }
    }
}