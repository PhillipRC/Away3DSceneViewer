package nop.away3d 
{
	import away3d.containers.ObjectContainer3D;
	import away3d.containers.Scene3D;
	/**
	 * A set of methods used to traverse objects within an ObjectContainer3D.
	 * @author Phillip R. Cargo
	 */
	public class SceneHelper 
	{
		public function SceneHelper() 
		{
			// TODO: extend away3d.containers.Scene3D
		}
		
		/**
		 * Look through the inScene and return all the children of inAssetType.
		 * @param	inAssetType
		 * @return
		 */
		public static function getObjectContainer3DFromScene(inScene:Scene3D, inAssetType:String):Vector.<ObjectContainer3D>
		{
			var returnValue:Vector.<ObjectContainer3D> = new Vector.<ObjectContainer3D>();
			var sceneChildren:uint = inScene.numChildren;
			
			if ( sceneChildren == 0 ) return returnValue;
			
			// loop through the children of the view.scene
			for (var childIdx:uint = 0; childIdx < sceneChildren; childIdx ++ )
			{
				var children:Vector.<ObjectContainer3D> = ObjectContainer3DHelper.getChildrenByAssetType(inScene.getChildAt(childIdx), inAssetType);
				for (var subIdx:uint = 0; subIdx < children.length; subIdx ++ )
					returnValue.push(children[subIdx]);
			}
			
			return returnValue;
		}
		
		/**
		 * Returns an ObjectContainer3D relative to the inObjectContainer3D.
		 * @param	inObjectContainer3D
		 * @param	inOffset
		 * @return
		 */
		public static function getObjectContainer3DByOffset(inObjectContainer3D:ObjectContainer3D,inOffset:int=1):ObjectContainer3D
		{	
			var returnValue:ObjectContainer3D = null;
			
			var obj:Vector.<ObjectContainer3D> = getObjectContainer3DFromScene(inObjectContainer3D.scene, inObjectContainer3D.assetType);
			
			if ( obj.length == 0 ) return returnValue;
			
			for (var idx:uint = 0; idx < obj.length; idx++)
			{
				if ( obj[idx].id == inObjectContainer3D.id )
				{
					// grab the next one
					var rtnIdx:int = idx + inOffset;
					if ( rtnIdx >= obj.length ) rtnIdx = rtnIdx % obj.length;	// wrap the result
					if ( rtnIdx < 0 ) rtnIdx = obj.length + rtnIdx;				// account for neg
					returnValue = obj[rtnIdx];
					break;
				}
			}
			
			return returnValue;
		}
	}
}