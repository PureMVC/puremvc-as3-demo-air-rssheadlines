/*
 PureMVC AS3 Demo – AIR RSS Headlines 
 Copyright (c) 2007-08 Simon Bailey <simon.bailey@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.as3.demos.air.rssheadlines.controller
{
	import mx.controls.Alert;
	
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import org.puremvc.as3.demos.air.rssheadlines.ApplicationFacade;

	public class ErrorCommand extends SimpleCommand implements ICommand
	{
		
		override public function execute( note:INotification ):void
		{
			var error:String = note.getBody() as String;
			Alert.show(String(error), "Alert", Alert.OK);
		}
		
	}
}