/*
 PureMVC AS3 Demo – AIR RSS Headlines 
 Copyright (c) 2007-08 Simon Bailey <simon.bailey@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.as3.demos.air.rssheadlines.view
{
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import org.puremvc.as3.utilities.air.desktopcitizen.DesktopCitizenConstants;
	
	import org.puremvc.as3.demos.air.rssheadlines.*;
	import org.puremvc.as3.demos.air.rssheadlines.ApplicationFacade;
	import org.puremvc.as3.demos.air.rssheadlines.view.components.RSSWrapper;

	public class ApplicationMediator extends Mediator implements IMediator
	{
		
		public static const NAME:String = "ApplicationMediator";
		
		public function ApplicationMediator( viewComponent:Object )
		{
			super( NAME, viewComponent );
			
			facade.registerMediator( new ViewerMediator ( rssWrapper.viewContainer ) );			
			facade.registerMediator( new WindowControlsMediator ( rssWrapper.windowControls ) );
		}
		
		public function get app():RSSHeadlines
		{
			return viewComponent as RSSHeadlines;
		}
		
		public function get rssWrapper():RSSWrapper
		{
			return app.rssWrapper as RSSWrapper;
		}

		override public function listNotificationInterests():Array
		{
			return [
					DesktopCitizenConstants.WINDOW_READY,
					ApplicationFacade.XML_DATA,
					ApplicationFacade.CHANGE_FEED
				   ];
		}
		
		override public function handleNotification( note:INotification ):void
		{
			switch ( note.getName() )
			{
				case DesktopCitizenConstants.WINDOW_READY:
					app.showControls = true;
					break;
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