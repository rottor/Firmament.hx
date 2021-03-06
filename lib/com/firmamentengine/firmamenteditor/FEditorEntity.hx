package com.firmamentengine.firmamenteditor;
import firmament.core.FEntity;
import firmament.util.FEntityCompat;
import firmament.ui.FDialog;
/**
 * ...
 * @author Jordan Wambaugh
 */
using firmament.util.FEntityCompat;
class FEditorEntity extends FEntity
{

	var originalSprite:Dynamic;
	var fileName:String;
	public function new(config:Dynamic) 
	{
		//filter out any custom components
		for(key in Reflect.fields(config.components)){
			if(key!='animation' && key!='render' && key!='physics'){
				Reflect.deleteField(config.components,key);
			}
		}
		
		this.fileName = config.entityFile;

		//must preserve original config for editor
		if(config.components.render!=null){
			this.originalSprite = config.components.render.image;
			//need to use our own image loader here since we don't have compiled assets
			if(Std.is(config.components.render.image,String)){
				config.components.render.image = ResourceLoader.loadImage(config.components.render.image);
			}
		}
		super(config);
		
		
	}
	
	public function setFileName(n:String) {
		this.fileName = n;
	}
	public function getFileName() {
		return this.fileName;
	}
	public function getMapConfig():Dynamic {
		var p = this.getPhysicsComponent();

		return { 
			entityFile:this.fileName
			,config: {
				components:{
					physics:{
						position: {x:p.getPositionX(),y:getPositionY()}
						,angle: p.getAngle()
						}
					}
				}
			};
		
	}
	
}