/*
 PureMVC AS3 Demo – AIR RSS Headlines 
 Copyright (c) 2007-08 Simon Bailey <simon.bailey@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.as3.demos.air.rssheadlines.view
{
	import flash.utils.Timer;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;

	import org.puremvc.as3.demos.air.rssheadlines.ApplicationFacade;
	import org.puremvc.as3.demos.air.rssheadlines.model.ServiceProxy;
	import org.puremvc.as3.demos.air.rssheadlines.model.vo.FeedVO;
	import org.puremvc.as3.demos.air.rssheadlines.view.components.Viewer;
	
	public class ViewerMediator extends Mediator implements IMediator
	{
		public static const NAME:String = 'ViewerMediator';
		
		public var article_number:int;
		
		private var serviceProxy:ServiceProxy;
		private var feedTimer:Timer;
		
		public function ViewerMediator( viewComponent:Object )
		{
			super( NAME, viewComponent );
		}
		
		override public function getMediatorName():String
		{
			return NAME;
		}
		
		public function get viewer():Viewer
		{
			return viewComponent as Viewer;
		}
		
		override public function listNotificationInterests():Array
		{
			return [
					ApplicationFacade.DATA
				   ];
		}
		
		override public function handleNotification( note:INotification ):void
		{
			switch ( note.getName() )
			{
				case ApplicationFacade.DATA:
					viewer.feedArticle = note.getBody() as FeedVO;
					break;
			}
		}
	}
}