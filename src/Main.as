package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import nop.away3d.AWDViewer;
	
	/**
	 * ...
	 * @author Phillip R. Cargo
	 */
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			var awdViewer:AWDViewer = new AWDViewer();
			addChild(awdViewer);
			awdViewer.showByURL('assets/plane.awd');
		}
		
	}
	
}