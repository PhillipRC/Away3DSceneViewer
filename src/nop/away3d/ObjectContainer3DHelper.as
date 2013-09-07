package nop.away3d 
{
	import away3d.containers.ObjectContainer3D;
	
	/**
	 * ...
	 * @author Phillip R. Cargo
	 */
	public class ObjectContainer3DHelper 
	{
		
		public function ObjectContainer3DHelper() 
		{
			// TODO: extend away3d.containers.ObjectContainer3D	
		}
		
		/**
		 * Recursively look through a ObjectContainer3D and return all the children of inAssetType.
		 * @param	inObjectContainer3D
		 * @param	inAssetType
		 * @return
		 */
		public static function getChildrenByAssetType(inObjectContainer3D:ObjectContainer3D, inAssetType:String):Vector.<ObjectContainer3D>
		{
			var returnValue:Vector.<ObjectContainer3D> = new Vector.<ObjectContainer3D>();
			
			if (inObjectContainer3D.numChildren == 0)
				return returnValue;
			
			for (var childIdx:uint = 0; childIdx < inObjectContainer3D.numChildren; childIdx++)
			{
				var child:ObjectContainer3D = inObjectContainer3D.getChildAt(childIdx);
				
				if (child.assetType == inAssetType)
					returnValue.push(child);
				
				if (child.numChildren != 0)
					getChildrenByAssetType(inObjectContainer3D, inAssetType);
					
				if (child.numChildren != 0)
				{
					var subChildObj:Vector.<ObjectContainer3D> = getChildrenByAssetType(child, inAssetType);
					for (var subChildIdx:uint = 0; subChildIdx < subChildObj.length; subChildIdx ++)
						returnValue.push(subChildObj[subChildIdx]);
				}
					
			}
			
			return returnValue;
		}
	}
}