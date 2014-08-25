package ;
import flixel.FlxSprite;

/**
 * ...
 * @author ansh
 */
class Explosion extends FlxSprite{

	public function new(){
		super();
		loadGraphic(AssetPaths.finalExplosion2__png, true, 128, 128);
		animation.add("explosion", [0, 1, 2, 3, 4, 5, 6, 7, 8, 0], 10, false);
	}
}