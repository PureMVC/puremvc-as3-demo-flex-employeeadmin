/*
 PureMVC AS3 Demo - Flex Employee Admin 
 Copyright (c) 2007 Clifford Hall <clifford.hall@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.as3.demos.flex.employeeadmin.controller
{
	import mx.controls.Alert;

	import org.puremvc.interfaces.ICommand;
	import org.puremvc.interfaces.INotification;
	import org.puremvc.patterns.command.SimpleCommand;

	public class AddRoleResultCommand extends SimpleCommand implements ICommand
	{
		override public function execute( notification:INotification ):void
		{
			var result:Boolean = notification.getBody() as Boolean;
			if ( result == false ) {
				Alert.show ('Role already exists for this user!','Add User Role');
			}
		}
		
	}
}