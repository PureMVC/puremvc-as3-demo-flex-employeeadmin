/*
 PureMVC AS3 Demo - Flex Employee Admin 
 Copyright (c) 2007-10 Clifford Hall <clifford.hall@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.as3.demos.flex.employeeadmin.view
{
	import flash.events.Event;
	import org.puremvc.as3.demos.flex.employeeadmin.ApplicationFacade;
	import org.puremvc.as3.demos.flex.employeeadmin.model.UserProxy;
	import org.puremvc.as3.demos.flex.employeeadmin.model.vo.UserVO;
	import org.puremvc.as3.demos.flex.employeeadmin.view.components.UserList;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;

	public class UserListMediator extends Mediator
	{
		private var userProxy:UserProxy;

		public static const NAME:String = "UserListMediator";

		public function UserListMediator( viewComponent:UserList )
		{
			super( NAME, viewComponent );
		}
		
		override public function onRegister():void
		{
			userList.addEventListener( UserList.NEW, 	onNew );
			userList.addEventListener( UserList.DELETE, onDelete);
			userList.addEventListener( UserList.SELECT, onSelect );

			userProxy = UserProxy( facade.retrieveProxy( UserProxy.NAME ) );
			userList.users = userProxy.users;
		}
		
		private function get userList():UserList
		{
			return viewComponent as UserList;
		}
		
		override public function listNotificationInterests():Array
		{
			return [
					ApplicationFacade.CANCEL_SELECTED,
					ApplicationFacade.USER_UPDATED
				   ];
		}
		
		override public function handleNotification( note:INotification ):void
		{
			switch ( note.getName() )
			{
				case ApplicationFacade.CANCEL_SELECTED:
					userList.deSelect();
					break;
					
				case ApplicationFacade.USER_UPDATED:
					userList.deSelect();
					break;
					
			}
		}
		
		private function onNew( event:Event ):void
		{
			sendNotification( ApplicationFacade.NEW_USER, 
							  new UserVO() );
		}
		
		private function onDelete( event:Event ):void
		{
			sendNotification( ApplicationFacade.DELETE_USER,
							  userList.selectedUser );
		}
		
		private function onSelect( event:Event ):void
		{
			sendNotification( ApplicationFacade.USER_SELECTED,
							  userList.selectedUser );
		}

	}
}