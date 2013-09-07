package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import nop.away3d.AWDViewer;
	
	/**
	 * ...
	 * @author Phillip R. Cargo
	 */
	public class Main extends Sprite
	{
		protected var awdViewer:AWDViewer;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			// create AWDViewer
			awdViewer = new AWDViewer();
			addChild(awdViewer);
			
			// set the default animation to play
			awdViewer.defaultAnimationName = "HellKnight_Stand";
			
			// load the hellknight
			awdViewer.showByURL('assets/hellknight.awd');
			// awdViewer.showByURL('assets/plane.awd');
			
			// listen for a mouse click
			addEventListener(MouseEvent.CLICK, handleMouseClick);
		}
		
		/**
		 * Handle when the mouse is clicked on the AWDView.
		 * @param	e
		 */
		private function handleMouseClick(e:MouseEvent):void 
		{
			awdViewer.setCameraNext();
		}
	}	
}