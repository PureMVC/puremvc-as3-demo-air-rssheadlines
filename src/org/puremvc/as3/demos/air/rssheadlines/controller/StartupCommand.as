/*
 PureMVC AS3 Demo – AIR RSS Headlines 
 Copyright (c) 2007 Simon Bailey <simon.bailey@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.as3.demos.air.rssheadlines.controller
{
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	import org.puremvc.as3.utilities.air.desktopcitizen.DesktopCitizenConstants;

	import org.puremvc.as3.demos.air.rssheadlines.*;
	import org.puremvc.as3.demos.air.rssheadlines.model.ServiceProxy;
	import org.puremvc.as3.demos.air.rssheadlines.view.ApplicationMediator;

	public class StartupCommand extends SimpleCommand implements ICommand
	{
		/**
		 * Register the Proxies and Mediators.
		 * 
		 * Get the View Components for the Mediators from the app,
		 * which passed a reference to itself on the notification.
		 */
		 override public function execute( note:INotification ):void
		 {
		 	
		 	var app:RSSHeadlines = note.getBody() as RSSHeadlines;
		 	
		 	facade.registerProxy( new ServiceProxy() );
			
			facade.registerMediator( new ApplicationMediator( app ) );
			sendNotification( DesktopCitizenConstants.WINDOW_OPEN, app.stage ); 
		 }
	}
}