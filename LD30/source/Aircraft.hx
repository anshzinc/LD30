package ;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxColor;

/**
 * ...
 * @author ansh
 */
class Aircraft extends FlxSprite {

	private var accelerationX = 50;
	
	public function new() {
		super();
		
		loadGraphic(AssetPaths.aircraft__png, false, 32, 32);
		velocity.x = 50;
		x = FlxG.width / 2;
		y = FlxG.height / 2 - 30;
		
		maxVelocity.set(500, 500);
		drag.set(30, 30);
		
		setFacing();
	}
	
	private function setFacing():Void {
		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);
	}

	private function wrap():Void {
		if (x >= FlxG.width) {
			x -= FlxG.width;
		}
		
		if (x <= 0) {
			x += FlxG.width;
		}
		
		if (y <= 0) {
			y = 0;
		}
		
		/*if (y <= 0) {
			y += FlxG.width;
		}
		
		if (y >= FlxG.width) {
			y -= FlxG.width;
		}*/
	}
	
	private function move():Void {
		if (FlxG.keys.justPressed.RIGHT) {
			acceleration.x = accelerationX;
			if (facing != FlxObject.RIGHT) 
				facing = FlxObject.RIGHT;
		} 
		
		if (FlxG.keys.justPressed.LEFT) {
			acceleration.x = -accelerationX;
			if (facing != FlxObject.LEFT)
				facing = FlxObject.LEFT;
		} 
		
		if (FlxG.keys.justPressed.UP) {
			var accelerationY = 100;
			acceleration.y = -accelerationY;
			if (facing == FlxObject.RIGHT) {
				angle = -45;
			} 
			if (facing == FlxObject.LEFT) {
				angle = 45;
			}
		}
		
		if (FlxG.keys.justPressed.DOWN) {
			var accelerationY = 100;
			acceleration.y = accelerationY;
			if (facing == FlxObject.RIGHT) {
				angle = 45;
			} 
			if (facing == FlxObject.LEFT) {
				angle = -45;
			}
		}
		
		if (FlxG.keys.anyJustReleased(["LEFT", "RIGHT"])) {
			acceleration.x = 0;
		}

		if (FlxG.keys.anyJustReleased([ "UP", "DOWN"])) {
			acceleration.y = 0;
			angle = 0;
		}
	}
	
	
	
	override public function update():Void {
		super.update();
		
		wrap();
			
		move();
		
	}
	
	override public function destroy():Void {
		super.destroy();
		destroy();
	}
}