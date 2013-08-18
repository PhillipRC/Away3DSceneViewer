package nop.away3d 
{
	import away3d.cameras.Camera3D;
	import away3d.containers.ObjectContainer3D;
	import away3d.containers.View3D;
	import away3d.events.AssetEvent;
	import away3d.events.LoaderEvent;
	import away3d.library.assets.AssetType;
	import away3d.loaders.Loader3D;
	import away3d.loaders.parsers.AWD2Parser;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	/**
	 * The AWDViewer class shows a scene contained within an AWD file utalizing the away3d library.
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
		 * Creates a new AWDViewer.
		 */
		public function AWDViewer() 
		{
			super();
		}
		
		/**
		 * Initialize the objects needed to load and view the AWD file.
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
			loader3D.addEventListener(AssetEvent.ASSET_COMPLETE, handleAssetComplete);
			loader3D.addEventListener(LoaderEvent.RESOURCE_COMPLETE, handleLoaderComplete);
		}
		
		/**
		 * Display an AWD file.
		 * @param	inPath Path to the AWD file
		 */
		public function showByURL(inPath:String):void
		{
			initialize();
			loader3D.load( new URLRequest(inPath) );
		}
		
		/**
		 * Handles the ASSET_COMPLETE event from the loader3D, which is called as each asset within the AWD is loaded.
		 * @param	e
		 */
		private function handleAssetComplete(e:AssetEvent):void 
		{
			switch (e.asset.assetType)
			{
				case (AssetType.CAMERA):
					camera = (e.asset as Camera3D);
					view.camera = camera;
					break;
			}
		}
		
		/**
		 * Handles the RESOURCE_COMPLETE event from the loader3D, which is called when the entire AWD file has been parsed.
		 * @param	e
		 */
		private function handleLoaderComplete(e:LoaderEvent):void 
		{
			view.scene.addChild((e.currentTarget as ObjectContainer3D));
			view.render();
		}
		
	}

}