package ;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxRandom;
import flixel.util.FlxTimer;

/**
 * ...
 * @author ansh
 */
class TestGameState extends FlxState {

	private var aircraft:Aircraft;
	private var enemyAircraft:EnemyAircraft;
	
	private var bulletGroup:BulletGroup;
	private var enemyGroup:EnemyGroup;
	
	private var enemyBulletGroup:BulletGroup;
	
	private var ground:Ground;
	
	private var explosion:Explosion;
	private var aircraftAlive = true;
	
	private var scoreText:FlxText;
	private var playAgain:FlxSprite;
	
	override public function create() {
		super.create();
		FlxG.camera.bgColor = FlxColor.AQUAMARINE;
		
		aircraft = new Aircraft();
		add(aircraft);

		ground = new Ground(); 
		add(ground);
		
		enemyAircraft = new EnemyAircraft();
		add(enemyAircraft);
		
		bulletGroup = new BulletGroup();
		add(bulletGroup);
		
		enemyGroup = new EnemyGroup();
		add(enemyGroup);
		
		var timer = new FlxTimer(1.5, spawnEnemyAircrafts, 0);
		
		explosion = new Explosion();
		add(explosion);
		
		scoreText = new FlxText(10, 10, 100, "" + Reg.score, 32, true);
		add(scoreText);
		
		enemyBulletGroup = new BulletGroup();
		add(enemyBulletGroup);
	}
	
	public function spawnEnemyAircrafts(timer: FlxTimer):Void {
			var enemyID = new EnemyAircraft();	
			enemyGroup.add(enemyID);
	}
	
	private function fireBullets():Void {
		if (FlxG.keys.anyJustPressed(["SPACE"])) {
			if (aircraftAlive) {
				bulletGroup.add(new Bullet(aircraft, "player"));
			}
		}
	}
	
	private var attackerSprite:FlxSprite = null;
	
	private function fireBulletFromAttacker(attacker:FlxSprite):Void {
		attackerSprite = null;
		attackerSprite = attacker;
		var fireTimely = new FlxTimer(3 , releaseABullet, 2); 
	}
	
	private var count = 0;
	private function releaseABullet(timer:FlxTimer):Void {
		if (count < 10) {
			enemyBulletGroup.add(new Bullet(attackerSprite, "enemy"));
		}
		count += 1;
	}
	
	private function handleCollisions():Void {
		for (bullet in bulletGroup) {
			for (enemy in enemyGroup) {
				FlxG.collide(bullet, enemy, collision);
				if (bullet.isOnScreen(FlxG.camera) == false) {
					bulletGroup.remove(bullet, true);
				}
				
				if (enemy.isOnScreen(FlxG.camera) == false) {
					enemyGroup.remove(enemy, true);
				} else {
					fireBulletFromAttacker(enemy);
				}
				
				if (enemy.y - aircraft.y < 400 || aircraft.y - enemy.y < 300 || enemy.x - aircraft.x < 300) {
					fireBulletFromAttacker(enemy);
				}
			}
		}
		
		FlxG.collide(ground, aircraft, groundCollision);
		
	}
	
	private function groundCollision(ground:FlxSprite, s:FlxSprite):Void {
		explosion.setPosition(aircraft.x - explosion.width / 2, ground.y - explosion.height / 2);
		explosion.animation.play("explosion", true, 0);
		remove(aircraft);
		aircraftAlive = false;
		
		var gameOver = new FlxSprite(FlxG.width / 2 - 150, FlxG.height / 2 - 150, AssetPaths.gameOver__png);
		add(gameOver);
		
		var gameOverText = new FlxText(gameOver.x - gameOver.width / 2, gameOver.y + gameOver.height + 50, 400, "Your Score: " + Reg.score, 40, true);
		add(gameOverText);
		
		playAgain = new FlxSprite(gameOverText.x + gameOverText.width + 30, gameOverText.y, AssetPaths.playAgain__png);
		add(playAgain);
		
	}
	
	private function checkPlayAgain():Void {
		if (FlxG.mouse.justPressed) {
			if (FlxG.mouse.inCoords(playAgain.x, playAgain.y, playAgain.width, playAgain.height)) {
				FlxG.resetState();
				FlxG.log.notice("Play clicked");
			}
		}
	}
	
	private function collision(a:Bullet, b:FlxSprite):Void {
		if (a.firer == "player" && a.firer != "enemy") {
			explosion.setPosition(a.x - explosion.width / 2, a.y - explosion.height / 2);
			explosion.animation.play("explosion", true, 0);
			Reg.score += 1;
			scoreText.text = "" + Reg.score;
			remove(a);
			remove(b);
			bulletGroup.remove(a);
			enemyGroup.remove(b);
		}
	}
	
	override public function update () {
		super.update();
		fireBullets();
		handleCollisions();
		
			checkPlayAgain();
			
		for (bullet in enemyBulletGroup) {
			FlxG.collide(aircraft, bullet, aircraftHit);
		}
	}	
	
	private function aircraftHit(aircraft:FlxSprite, bullet:FlxSprite):Void {
		explosion.setPosition(aircraft.x - explosion.width / 2, ground.y - explosion.height / 2);
		explosion.animation.play("explosion", true, 0);
		remove(aircraft);
		aircraftAlive = false;
		
		var gameOver = new FlxSprite(FlxG.width / 2 - 150, FlxG.height / 2 - 150, AssetPaths.gameOver__png);
		add(gameOver);
		
		var gameOverText = new FlxText(gameOver.x - gameOver.width / 2, gameOver.y + gameOver.height + 50, 400, "Your Score: " + Reg.score, 40, true);
		add(gameOverText);
		
		playAgain = new FlxSprite(gameOverText.x + gameOverText.width + 30, gameOverText.y, AssetPaths.playAgain__png);
		add(playAgain);
	}

	override public function destroy() {
		super.destroy();
	}
	
	public function getBulletGroup():BulletGroup {
		return this.bulletGroup;
	}
}
