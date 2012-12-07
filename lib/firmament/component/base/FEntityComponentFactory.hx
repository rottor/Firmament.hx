package firmament.component.base;


import firmament.component.animation.FAnimationComponent;
import firmament.component.base.FEntityComponent;
import firmament.component.event.FEntityEmitterComponent;
import firmament.component.event.FEventMapperComponent;
import firmament.component.physics.FBox2DComponent;
import firmament.component.physics.FNoPhysicsComponent;
import firmament.component.render.FTilesheetRenderComponent;
import firmament.component.render.FWireframeRenderComponent;

class FEntityComponentFactory{
	public static function createComponent(type:String):FEntityComponent {
		var className = getClassFromType(type);
		var c =Type.resolveClass(className);
		if(c==null){
			throw "class "+className+" could not be found.";
		}
		var component:FEntityComponent = Type.createInstance(c,[]);
		if(component == null){
			throw "Component of type "+type+" with class "+className+" could not be instantiated!";
		}
		return component;
	}

	public static function getClassFromType(type:String){
		var map = {
			"box2d":"firmament.component.physics.FBox2DComponent"
			,"noPhysics":"firmament.component.physics.FNoPhysicsComponent"
			,"wireframe":"firmament.component.render.FWireframeRenderComponent"
			,"tilesheet":"firmament.component.render.FTilesheetRenderComponent"
			,"animation":"firmament.component.animation.FAnimationComponent"
			,"eventMapper":"firmament.component.event.FEventMapperComponent"
			,"entityEmitter":"firmament.component.event.FEntityEmitterComponent"
		};

		var cls = Reflect.field(map,type);
		if(cls == null) return type;
		return cls;
	}

}



