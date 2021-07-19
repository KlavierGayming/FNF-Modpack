package;

import ui.FlxVirtualPad;
import flixel.FlxG;
import flixel.util.FlxSave;
import flixel.math.FlxPoint;

class Config {
    var save:FlxSave;

    public function new() 
    {
        save = new FlxSave();
    	save.bind("saveconrtol");
    }

    public function setdownscroll(?value:Bool):Bool {
		if (save.data.isdownscroll == null) save.data.isdownscroll = false;
		
		save.data.isdownscroll = !save.data.isdownscroll;
		save.flush();
        return save.data.isdownscroll;
	}

    public function getdownscroll():Bool {
        if (save.data.isdownscroll != null) return save.data.isdownscroll;
        return false;
    }

	public function setneo(?value:Bool):Bool {
		if (save.data.isneo == null) save.data.isneo = false;
		
		save.data.isneo = !save.data.isneo;
		save.flush();
        return save.data.isneo;
	}

    public function getneo():Bool {
        if (save.data.isneo != null) return save.data.isneo;
        return false;
    }

	public function setperweek(?value:Bool):Bool {
		if (save.data.isperweek == null) save.data.isperweek = false;
		
		save.data.isperweek = !save.data.isperweek;
		save.flush();
        return save.data.isperweek;
	}
	

    public function getperweek():Bool {
        if (save.data.isperweek != null) return save.data.isperweek;
        return false;
    }

	public function setnoswitch(?value:Bool):Bool {
		if (save.data.isnoswitch == null) save.data.isnoswitch = false;
		
		save.data.isnoswitch = !save.data.isnoswitch;
		save.flush();
        return save.data.isnoswitch;
	}

    public function getnoswitch():Bool {
        if (save.data.isnoswitch != null) return save.data.isnoswitch;
        return false;
    }

	public function setnogf(?value:Bool):Bool {
		if (save.data.isnogf == null) save.data.isnogf = false;
		
		save.data.isnogf = !save.data.isnogf;
		save.flush();
        return save.data.isnogf;
	}

    public function getnogf():Bool {
        if (save.data.isnogf != null) return save.data.isnogf;
        return false;
    }

	public function setnobg(?value:Bool):Bool {
		if (save.data.isnobg == null) save.data.isnobg = false;
		
		save.data.isnobg = !save.data.isnobg;
		save.flush();
        return save.data.isnobg;
	}

    public function getnobg():Bool {
        if (save.data.isnobg != null) return save.data.isnobg;
        return false;
    }

	public function setoptimization(?value:Bool):Bool {
		if (save.data.isoptimization == null) save.data.isoptimization = false;
		
		save.data.isoptimization = !save.data.isoptimization;
		save.flush();
        return save.data.isoptimization;
	}

    public function getoptimization():Bool {
        if (save.data.isoptimization != null) return save.data.isoptimization;
        return false;
    }

	public function setnoicon(?value:Bool):Bool {
		if (save.data.isnoicon == null) save.data.isnoicon = false;
		
		save.data.isnoicon = !save.data.isnoicon;
		save.flush();
        return save.data.isnoicon;
	}

    public function getnoicon():Bool {
        if (save.data.isnoicon != null) return save.data.isnoicon;
        return false;
    }

	public function setpractice(?value:Bool):Bool {
		if (save.data.ispractice == null) save.data.ispractice = false;
		
		save.data.ispractice = !save.data.ispractice;
		save.flush();
        return save.data.ispractice;
	}

    public function getpractice():Bool {
        if (save.data.ispractice != null) return save.data.ispractice;
        return false;
    }

	public function setnocut(?value:Bool):Bool {
		if (save.data.isnocut == null) save.data.isnocut = false;
		
		save.data.isnocut = !save.data.isnocut;
		save.flush();
        return save.data.isnocut;
	}

    public function getnocut():Bool {
        if (save.data.isnocut != null) return save.data.isnocut;
        return false;
    }

    public function getcontrolmode():Int {
        // load control mode num from FlxSave
		if (save.data.buttonsmode != null) return save.data.buttonsmode[0];
        return 0;
    }

    public function setcontrolmode(mode:Int = 0):Int {
        // save control mode num from FlxSave
		if (save.data.buttonsmode == null) save.data.buttonsmode = new Array();
        save.data.buttonsmode[0] = mode;
        save.flush();

        return save.data.buttonsmode[0];
    }

    public function savecustom(_pad:FlxVirtualPad) {
		trace("saved");

		if (save.data.buttons == null)
		{
			save.data.buttons = new Array();

			for (buttons in _pad)
			{
				save.data.buttons.push(FlxPoint.get(buttons.x, buttons.y));
			}
		}else
		{
			var tempCount:Int = 0;
			for (buttons in _pad)
			{
				save.data.buttons[tempCount] = FlxPoint.get(buttons.x, buttons.y);
				tempCount++;
			}
		}
		save.flush();
	}

	public function loadcustom(_pad:FlxVirtualPad):FlxVirtualPad {
		//load pad
		if (save.data.buttons == null) return _pad;
		var tempCount:Int = 0;

		for(buttons in _pad)
		{
			buttons.x = save.data.buttons[tempCount].x;
			buttons.y = save.data.buttons[tempCount].y;
			tempCount++;
		}	
        return _pad;
	}

	public function setFrameRate(fps:Int = 60) {
		if (fps < 10) return;
		
		FlxG.stage.frameRate = fps;
		save.data.framerate = fps;
		save.flush();
	}

	public function getFrameRate():Int {
		if (save.data.framerate != null) return save.data.framerate;
		return 60;
	}
}