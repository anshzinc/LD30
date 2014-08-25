package ;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;

/**
 * ...
 * @author ansh
 */
class Ground extends FlxSprite {

	public function new() {
		super();
		makeGraphic(FlxG.width, 60, FlxColor.BROWN);
		x = 0; 
		y = FlxG.height - 60;
		
		immovable = true;
	}
}