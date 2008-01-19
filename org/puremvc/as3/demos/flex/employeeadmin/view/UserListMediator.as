/*
 PureMVC AS3 Demo - Flex Employee Admin 
 Copyright (c) 2007-08 Clifford Hall <clifford.hall@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.as3.demos.flex.employeeadmin.view
{
	import flash.events.Event;

	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import org.puremvc.as3.patterns.observer.Notification;

	import org.puremvc.as3.demos.flex.employeeadmin.ApplicationFacade;
	import org.puremvc.as3.demos.flex.employeeadmin.model.vo.UserVO;
	import org.puremvc.as3.demos.flex.employeeadmin.model.UserProxy;
	import org.puremvc.as3.demos.flex.employeeadmin.view.components.UserList;

	public class UserListMediator extends Mediator implements IMediator
	{
		private var userProxy:UserProxy;

		public static const NAME:String = 'UserListMediator';

		public function UserListMediator( viewComponent:Object )
		{
			super( NAME, viewComponent );
			
			userList.addEventListener( UserList.NEW, 	onNew );
			userList.addEventListener( UserList.DELETE, onDelete);
			userList.addEventListener( UserList.SELECT, onSelect );

			userProxy = facade.retrieveProxy( UserProxy.NAME ) as UserProxy;
			userList.users = userProxy.users;
		}
		
		override public function getMediatorName():String
		{
			return NAME;
		}

		private function get userList():UserList
		{
			return viewComponent as UserList;
		}
		
		private function onNew( event:Event ):void
		{
			var user:UserVO = new UserVO();
			sendNotification( ApplicationFacade.NEW_USER, user );
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
		
	}
}