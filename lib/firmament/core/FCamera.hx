package firmament.core;
import firmament.component.physics.FPhysicsComponentInterface;
import firmament.component.render.FRenderComponentInterface;
import nme.display.Sprite;
import firmament.core.FEntity;
import firmament.core.FWorld;
import nme.display.BitmapData;
import nme.geom.Rectangle;
import nme.Lib;
import nme.display.Stage;
import nme.events.Event;
import firmament.component.render.FWireframeRenderComponent;
import firmament.util.FConfigHelper;
/**
 * Class: FCamera
 * 
 * Extends: Sprite
 * 
 * Implements: <FWorldPositionalInterface>
 * 
 * @author Jordan Wambaugh
 */

class FCamera extends Sprite ,implements FWorldPositionalInterface 
{
	public inline static var BEFORE_RENDER_EVENT = "beforeRenderEvent";
	public inline static var AFTER_RENDER_EVENT = "afterRenderEvent";

	var position:FVector;
	var topLeftPosition:FVector;
	var positionBase:String;
	var angle:Float;
	var zoom:Float;
	var displayWidth:Int;
	var displayHeight:Int;
	var _debugRender:Bool;
	var _debugRenderer:FWireframeRenderComponent;
	var calculatedTopLeft:Bool;
	
	/**
	 * Constructor: new
	 * 
	 * Parameters:
		 * width - Int The width of the camera
		 * height - Int The height of the camera
	 */
	public function new(?width:Int=100,?height:Int=100) 
	{
		super();
		this.zoom = 100;
		this.position = new FVector(0, 0);
		this.calculatedTopLeft = false;
		this.topLeftPosition = new FVector(0, 0);
		this.displayHeight = height;
		this.displayWidth = width;
		_debugRender = false;
		_debugRenderer = new FWireframeRenderComponent();

	}


	public function init(config:Dynamic){
		var c= new FConfigHelper(config);
		var pos = c.getVector('position',{x:0,y:0});
		this.x = pos.x;
		this.y = pos.y;

		var stage = Lib.current.stage;
		this.displayWidth = c.getNotNull("width",Float,stage.stageWidth);
		this.displayHeight = c.getNotNull("height",Float,stage.stageHeight);
		this.calculateTopLeftPosition(1);

	}
	
	public function render(worlds:Hash<FWorld>) {
		this.dispatchEvent(new Event(FCamera.BEFORE_RENDER_EVENT));
		this.graphics.clear();
		this.graphics.beginFill(0);
		this.graphics.drawRect(0, 0, this.displayWidth, this.displayHeight);
		this.graphics.endFill();
		
		//this.graphics.drawRect(0,0, this.displayWidth, this.displayHeight);
		var entityList:Array<FEntity> = new Array<FEntity>();
		var displayPadding = 4; //number of meters to pad in query for entities. Increase this if you have entities popping out at the edges
		for (world in worlds) {
			var entities = world.getEntitiesInBox(Math.floor(this.position.x - (this.displayWidth / 2 / this.zoom+displayPadding))
				,Math.floor(this.position.y - (this.displayHeight / 2 / this.zoom+displayPadding))
				,Math.floor(this.position.x + this.displayWidth / 2 / this.zoom+displayPadding)
				,Math.floor(this.position.y + this.displayHeight / 2 / this.zoom+displayPadding));
			
			//add entites marked for always rendering
			entities=entities.concat(world.getAlwaysRenderEntities());

			//Firmament.log(entities);
			if(entities!=null)
				entityList=entityList.concat(entities);
		}
		entityList.sort(function(a:FEntity,b:FEntity):Int{
			var cmp = a.getPhysicsComponent().getZPosition() -b.getPhysicsComponent().getZPosition();
			if (cmp==0) {
				return 0;	
			} else if (cmp > 0) return 1;
			return -1;
		});
		for (ent in entityList) {
			var rc = ent.getRenderComponent();
			if(rc!=null) rc.render(this);
		}
		this.dispatchEvent(new Event(FCamera.AFTER_RENDER_EVENT));
		if(_debugRender){
			for (ent in entityList) {
				_debugRenderer.setEntity(ent);
				_debugRenderer.render(this);
			}
		}

	}

	private function calculateTopLeftPosition(?parallax:Float=1) {
		//trace(this.width);
		this.topLeftPosition.x=this.position.x-(this.displayWidth/this.zoom/parallax)/2;
		this.topLeftPosition.y = this.position.y - (this.displayHeight / this.zoom/parallax) / 2;
		this.calculatedTopLeft = true;
	}
	
	public function getTopLeftPosition(?parallax:Float=1) {
		
		this.calculateTopLeftPosition(parallax);
		
		return this.topLeftPosition;
	}
	
	public function getBottomRightPosition(?parallax:Float=1){
		return new FVector(
			this.position.x + (this.displayWidth/this.zoom/parallax)/2
			,this.position.y + (this.displayHeight / this.zoom/parallax) / 2);

	}


	/**
	 * Function: setPosition
	 * 
	 * Parameters:
		 * pos - <FVector>
	 */
	public function setPosition(pos:FVector) {
		this.position = pos;
	}
	
	/**
	 * Function: getPosition
	 * 
	 * Returns:
		 * <FVector>
	 */
	public function getPosition():FVector {
		return this.position;
	}
	
	/**
	 * Function: getPositionX
	 * 
	 * Returns:
		 * Float
	 */
	public function getPositionX():Float {
		return this.position.x;
	}
	
		/**
	 * Function: getPositionY
	 * 
	 * Returns:
		 * Float
	 */
	public function getPositionY():Float {
		return this.position.y;
	}
	
	/**
	 * Function: getZoom
	 * 
	 * The zoom is 'pixels per meter'. By default, this value is set to 100, meaning we show 100 pixels for each meter in world space.
	 * 
	 * Returns: 
		 * Float - the camera's current zoom value.
	 * 
	 * 
	 * See Also: 
		 * <setZoom>
	 */
	public function getZoom():Float {
		return this.zoom;
	}
	
	/**
	 * Function: setZoom
	 * 
	 * The zoom is 'pixels per meter'. By default, this value is set to 100, meaning we show 100 pixels for each meter in world space.
	 * 
	 * Parameters:
		 * z - Float
	 * 
	 * See Also: 
		 * <getZoom>
	 */
	public function setZoom(z:Float) {
			this.zoom = z;
	}
	
	public function resizeToStage() {
		var stage = Lib.current.stage;
		this.displayWidth = stage.stageWidth;
		this.displayHeight = stage.stageHeight;
		//this.width = this.displayWidth;
		//this.height = this.displayHeight;
		this.calculateTopLeftPosition(1);
	}
	
	public function getWorldPosition(x:Float,y:Float) {
		return new FVector(
		(x / this.getZoom()) + (this.getPositionX() - (this.displayWidth / this.getZoom() / 2))
		,(y / this.getZoom()) + (this.getPositionY() - (this.displayHeight / this.getZoom() / 2)));

	}


	public function setDebugMode(debug:Bool){
		_debugRender = debug;
	}

	public function getAngle():Float{
		return 0;
	}
	public function setAngle(a:Float){
		//noop
	}
	
}
