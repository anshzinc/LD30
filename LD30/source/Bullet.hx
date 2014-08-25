package ;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxColor;

/**
 * ...
 * @author ansh
 */
class Bullet extends FlxSprite {
	
	private var speed = 500;

	public var firer:String = "";
	private var aircraft:FlxSprite;
	
	
	public function new(aircraft:FlxSprite, firer:String) {
		super();
		
		this.firer = firer;
		this.aircraft = aircraft;
		
		makeGraphic(20, 3, FlxColor.RED);
		x = aircraft.x + aircraft.width / 2 ;
		y = aircraft.y + aircraft.height / 2;
		if (aircraft.facing == FlxObject.RIGHT) {
			velocity.x = speed;
			if (aircraft.angle == -45) {
				velocity.y = -speed;
			} 
			if (aircraft.angle == 45) {
				velocity.y = speed;
			}
		} else {
			velocity.x = -speed;
			if (aircraft.angle == -45) {
				velocity.y = speed;
			} 
			if (aircraft.angle == 45) {
				velocity.y = -speed;
			}
		}
		
		angle = aircraft.angle;
	}
	override public function destroy():Void {
		super.destroy();
	}
}