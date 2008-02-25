/*
 PureMVC AS3 Demo – AIR RSS Headlines 
 Copyright (c) 2007-08 Simon Bailey <simon.bailey@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.as3.demos.air.rssheadlines.view
{
	import flash.events.*;
	
	import org.puremvc.as3.demos.air.rssheadlines.ApplicationFacade;
	import org.puremvc.as3.demos.air.rssheadlines.model.ServiceProxy;
	import org.puremvc.as3.demos.air.rssheadlines.view.components.WindowControls;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import org.puremvc.as3.utilities.air.desktopcitizen.controller.WindowCloseCommand;
	

	public class WindowControlsMediator extends Mediator implements IMediator
	{
		public static const NAME:String = 'WindowControlsMediator';
		
		public function WindowControlsMediator( viewComponent:Object )
		{
			super( NAME, viewComponent );
			
			windowControls.addEventListener( WindowControls.CLOSE, onClose );
			windowControls.addEventListener( WindowControls.MIN, onMin );
			windowControls.addEventListener( WindowControls.DRAG, onDrag );
			windowControls.addEventListener( WindowControls.INTERVAL, onInterval );
			windowControls.addEventListener( WindowControls.FEED, onFeed );
			windowControls.addEventListener( WindowControls.SUBMIT, onSubmit );
			windowControls.addEventListener( WindowControls.CANCEL, onCancel );
			
			var serviceProxy:ServiceProxy = facade.retrieveProxy( ServiceProxy.NAME ) as ServiceProxy;
			windowControls.i_slider.value = Math.round(serviceProxy.duration/1000);
		}
		
		public function get windowControls():WindowControls
		{
			return viewComponent as WindowControls;
		}
		
		private function onClose( e:Event ):void
		{
			sendNotification( WindowCloseCommand.NAME );
			windowControls.stage.nativeWindow.close();
		}
		
		private function onMin( e:Event ):void
		{
			 windowControls.stage.nativeWindow.minimize();
		}
		
		private function onDrag( e:Event ):void
		{
			windowControls.stage.nativeWindow.startMove();
		}
		
		private function onInterval( e:Event ):void
		{
			sendNotification( ApplicationFacade.INTERVAL, windowControls.i_slider.value );
		}
		
		private function onFeed( e:Event ):void
		{
			windowControls.feedChange = true;
		}
		
		private function onSubmit( e:Event ):void
		{
			windowControls.feedChange = false;
			var url:String = windowControls.url_txt.text;
			sendNotification( ApplicationFacade.CHANGE_FEED, url );
		}
		
		private function onCancel( e:Event ):void
		{
			windowControls.url_txt.text = "";
			windowControls.feedChange = false;
		}
		
	}
}