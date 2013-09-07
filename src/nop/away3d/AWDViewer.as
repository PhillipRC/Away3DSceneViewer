package nop.away3d
{
	import away3d.animators.SkeletonAnimationSet;
	import away3d.animators.SkeletonAnimator;
	import away3d.cameras.Camera3D;
	import away3d.containers.ObjectContainer3D;
	import away3d.containers.View3D;
	import away3d.entities.Mesh;
	import away3d.events.LoaderEvent;
	import away3d.library.assets.AssetType;
	import away3d.loaders.Loader3D;
	import away3d.loaders.parsers.AWD2Parser;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * The AWDViewer class shows a scene contained within an AWD file utilizing the away3d library.
	 * @author Phillip R. Cargo
	 */
	public class AWDViewer extends Sprite
	{
		/**
		 * Reference to the view.
		 */
		public var view:View3D;
		
		/**
		 * Reference to the loader3D.
		 */
		protected var loader3D:Loader3D;
		
		/**
		 * Reference to the camera used in the view.
		 */
		public var camera:Camera3D;
		
		/**
		 * Default name of animation to play.
		 */
		public var defaultAnimationName:String;
		
		/**
		 * Creates a new AWDViewer.
		 */
		public function AWDViewer()
		{
			super();
		}
		
		/**
		 * Initialize the objects needed to create the view and load the AWD file.
		 * @return
		 */
		private function initialize():void
		{
			// setup the view
			view = new View3D();
			view.antiAlias = 4;
			addChild(view);
			
			// setup the loader3D
			Loader3D.enableParser(AWD2Parser);
			loader3D = new Loader3D();
			loader3D.addEventListener(LoaderEvent.RESOURCE_COMPLETE, handleLoaderComplete);
		}
		
		/**
		 * Display an AWD file.
		 * @param	inPath Path to the AWD file
		 */
		public function showByURL(inPath:String):void
		{
			initialize();
			loader3D.load(new URLRequest(inPath));
		}
		
		/**
		 * Handles the RESOURCE_COMPLETE event from the loader3D, which is called when the entire AWD file has been parsed.
		 * @param	e
		 */
		private function handleLoaderComplete(e:LoaderEvent):void
		{
			var loader3D:ObjectContainer3D = (e.currentTarget as ObjectContainer3D);
			
			// add the Loader3D to the scene
			view.scene.addChild(loader3D);
			
			// setup the camera
			setCameraByIndex();
			
			// animate the meshs
			animateMeshs(defaultAnimationName);
			
			// start a render loop
			addEventListener(Event.ENTER_FRAME, handleEnterFrame);
		}
		
		/**
		 * Handles the ENTER_FRAME event.
		 * @param	e
		 */
		private function handleEnterFrame(e:Event):void 
		{
			// render the view
			view.render();
		}
		
		protected function setupCamera():void
		{
			// grab the cameras in the scene
			var objectContainer3D:Vector.<ObjectContainer3D> = SceneHelper.getObjectContainer3DFromScene(view.scene, AssetType.CAMERA);
			
			// use the first camera for the scene
			if (objectContainer3D.length != 0)
			{
				// if there is a camera use it
				view.camera = objectContainer3D[0] as Camera3D;
			}
			else
			{
				// todo create a default hover camera
			}
		}
		
		/**
		 * Looks through the view.scene for a Mesh and attempts to run the inDefaultAnimationName.
		 * @param	inObjectContainer3D
		 * @param	defaultAnimationName
		 */
		protected function animateMeshs(inDefaultAnimationName:String = null):void
		{
			// grab the meshs in the scene
			var objectContainer3D:Vector.<ObjectContainer3D> = SceneHelper.getObjectContainer3DFromScene(view.scene, AssetType.MESH);
			
			// loop through the meshes
			for (var meshIdx:uint = 0; meshIdx < objectContainer3D.length; meshIdx++)
			{
				var mesh:Mesh = (objectContainer3D[meshIdx] as Mesh);
				if (mesh.animator != null)
				{
					switch (getQualifiedClassName(mesh.animator))
					{
						// animate SkeletonAnimator
						case("away3d.animators::SkeletonAnimator"): 
							var animator:SkeletonAnimator = (mesh.animator as SkeletonAnimator)
							var animationName:String;
							
							if (inDefaultAnimationName == null)
								animationName = (animator.animationSet as SkeletonAnimationSet).animationNames[0];
							else
								animationName = inDefaultAnimationName;
							
							// animate the mesh
							try
							{
								animator.play(animationName);
							}
							catch (e:Error)
							{
								// default name not found
							}
							break;
					}
				}
			}
		}
		
		/**
		 * Set the views camera to the indicated camera.
		 * @param	inCameraIndex
		 */
		public function setCameraByIndex( inCameraIndex:uint = 0 ):void
		{
			// grab the cameras in the scene
			var objectContainer3D:Vector.<ObjectContainer3D> = SceneHelper.getObjectContainer3DFromScene(view.scene, AssetType.CAMERA);
			
			// test to see if there is a camera at inCameraIndex
			if ( (objectContainer3D.length > 0) && (inCameraIndex <= objectContainer3D.length-1) )
			{
				// todo add transition
				view.camera = objectContainer3D[inCameraIndex] as Camera3D;
			}
			else
			{
				// todo there are no cameras, create a default hover camera
			}
		}
		
		/**
		 * Looks through the scene for the next camera.
		 */
		public function setCameraNext():void
		{
			// grab the cameras in the scene
			view.camera = SceneHelper.getObjectContainer3DByOffset(view.camera) as Camera3D;
		}
	}
}