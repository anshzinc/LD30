package ;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxRandom;
import flixel.util.FlxTimer;

/**
 * ...
 * @author ansh
 */
class EnemyAircraft extends FlxSprite {

	public function new(){
		super();
		
		loadGraphic(AssetPaths.enemyAircraft__png, false, 32, 32);
		x = FlxG.width;
		y = FlxRandom.floatRanged(0, FlxG.height);
		
		velocity.x = FlxRandom.floatRanged(5, -300);
		velocity.y = FlxRandom.floatRanged(0, 20);
		
		setFacing();
		
		facing = FlxObject.LEFT;
		
	}
	
	override public function update():Void {
		super.update();
	}
	
	private function setFacing():Void {
		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);
	}
}