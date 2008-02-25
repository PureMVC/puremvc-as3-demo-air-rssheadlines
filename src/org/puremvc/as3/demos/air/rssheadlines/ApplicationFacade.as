/*
 PureMVC AS3 Demo – AIR RSS Headlines 
 Copyright (c) 2007 Simon Bailey <simon.bailey@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.as3.demos.air.rssheadlines
{
	import org.puremvc.as3.demos.air.rssheadlines.controller.*;
	
	import org.puremvc.as3.interfaces.IFacade;
	import org.puremvc.as3.patterns.facade.Facade;
	import org.puremvc.as3.patterns.observer.Notification;

	public class ApplicationFacade extends Facade implements IFacade
	{
		
		/**
		 * Notification name constants
		 */
		 public static const STARTUP:String     = "startUp";
		 
		 // Got xml
		 public static const XML_DATA:String    = "xmlData";
		 // Got the feed
		 public static const DATA:String        = "data";
		 // Error retrieving feed
		 public static const ERROR:String       = "error";
		 // Change in interval
		 public static const INTERVAL:String    = "interval";
		 // Change feed
		 public static const CHANGE_FEED:String = "changeFeed";
		 
		 
		/**
		 * Singleton ApplicationFacade Factory Method
		 */
		public static function getInstance():ApplicationFacade
		{
			if ( instance == null ) instance = new ApplicationFacade();
			return instance as ApplicationFacade;
		}
		
		public function startup( app:RSSHeadlines ):void
		{
			sendNotification( STARTUP, app );
		}
		
		override protected function initializeController():void
		{
			super.initializeController();
			
			registerCommand( STARTUP, StartupCommand );
			registerCommand( INTERVAL, IntervalCommand );
			registerCommand( ERROR, ErrorCommand );
			registerCommand( CHANGE_FEED, ChangeFeedCommand );
		}
		
	}
}