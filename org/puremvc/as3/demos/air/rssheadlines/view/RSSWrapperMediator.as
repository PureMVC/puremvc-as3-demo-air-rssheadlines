/*
 PureMVC AS3 Demo – AIR RSS Headlines 
 Copyright (c) 2007 Simon Bailey <simon.bailey@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.as3.demos.air.rssheadlines.view
{
	import org.puremvc.as3.demos.air.rssheadlines.ApplicationFacade;
	import org.puremvc.as3.demos.air.rssheadlines.view.components.RSSWrapper;
	
	import org.puremvc.interfaces.IMediator;
	import org.puremvc.interfaces.INotification;
	import org.puremvc.patterns.mediator.Mediator;

	public class RSSWrapperMediator extends Mediator implements IMediator
	{
		
		public static const NAME:String = "RSSWrapperMediator";
		
		public function RSSWrapperMediator( viewComponent:Object )
		{
			super( viewComponent );
			
			facade.registerMediator( new ViewerMediator ( rssWrapper.viewContainer ) );			
			facade.registerMediator( new WindowControlsMediator ( rssWrapper.windowControls ) );
		}
		
		override public function getMediatorName():String
		{
			return NAME;
		}
		
		public function get rssWrapper():RSSWrapper
		{
			return viewComponent as RSSWrapper;
		}
		
		override public function listNotificationInterests():Array
		{
			return [
					ApplicationFacade.XML_DATA,
					ApplicationFacade.CHANGE_FEED
				   ];
		}
		
		override public function handleNotification( note:INotification ):void
		{
			switch ( note.getName() )
			{
				case ApplicationFacade.XML_DATA:
					rssWrapper.got_feed = true;
					break;
				case ApplicationFacade.CHANGE_FEED:
					rssWrapper.got_feed = false;
					break;
			}
		}
	}
}