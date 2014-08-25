package ;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.util.FlxMath;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState 
{
	private var title:FlxSprite;
	
	
	private var howTo:FlxSprite;
	private var play:FlxSprite;
	/**
	 * Function that is called up when to state is created to set it up.
	 */
	override public function create():Void 
	{
		super.create();
		
		FlxG.camera.bgColor = FlxColor.GREEN;
		
		title = new FlxSprite(100, 0, AssetPaths.etInvasion__png);
		add(title);
		
		howTo = new FlxSprite(0, 300, AssetPaths.howTo__png);
		add(howTo);
		
		play = new FlxSprite(FlxG.width / 2, FlxG.height / 2, AssetPaths.playButton2__png);
		add(play);
	}

	private function input():Void
	{
		if (FlxG.mouse.justPressed) {
			if (FlxG.mouse.inCoords(play.x, play.y, play.width, play.height)) {
				FlxG.switchState(new TestGameState());
				FlxG.log.notice("Play clicked");
			}
		}
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
		howTo.destroy();
		title.destroy();
		play.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
		input();
	}
}