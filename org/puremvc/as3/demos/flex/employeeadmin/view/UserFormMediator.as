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
	import org.puremvc.as3.demos.flex.employeeadmin.model.enum.DeptEnum;
	import org.puremvc.as3.demos.flex.employeeadmin.view.components.UserForm;

	public class UserFormMediator extends Mediator implements IMediator
	{
		private var userProxy:UserProxy;
		
		public static const NAME:String = 'UserFormMediator';

		public function UserFormMediator( viewComponent:Object )
		{
			super( NAME, viewComponent );
			userForm.addEventListener( UserForm.ADD, onAdd );
			userForm.addEventListener( UserForm.UPDATE, onUpdate );
			userForm.addEventListener( UserForm.CANCEL, onCancel );

			userProxy = facade.retrieveProxy( UserProxy.NAME ) as UserProxy;
		}
		
		override public function getMediatorName():String
		{
			return NAME;
		}

		private function get userForm ():UserForm
		{
			return viewComponent as UserForm;
		}
		
		private function onAdd( event:Event ):void
		{
			var user:UserVO = userForm.user;
			userProxy.addItem( user );
			sendNotification( ApplicationFacade.USER_ADDED, user );
			clearForm();
		}
		
		private function onUpdate( event:Event ):void
		{
			var user:UserVO = userForm.user;
			userProxy.updateItem( user );
			sendNotification(  ApplicationFacade.USER_UPDATED, user );
			clearForm();
		}
		
		private function onCancel( event:Event ):void
		{
			sendNotification(  ApplicationFacade.CANCEL_SELECTED );
			clearForm();
		}
		
		override public function listNotificationInterests():Array
		{
			return [
					ApplicationFacade.NEW_USER,
					ApplicationFacade.USER_DELETED,
					ApplicationFacade.USER_SELECTED
					
				   ];
		}
		
		override public function handleNotification( note:INotification ):void
		{
			switch ( note.getName() )
			{
				case ApplicationFacade.NEW_USER:
					userForm.user = note.getBody() as UserVO;
					userForm.mode = UserForm.MODE_ADD;
					userForm.first.setFocus();
					break;
					
				case ApplicationFacade.USER_DELETED:
					userForm.user = null;
					clearForm();
					break;
					
				case ApplicationFacade.USER_SELECTED:
					userForm.user = note.getBody() as UserVO;
					userForm.mode = UserForm.MODE_EDIT;
					userForm.first.setFocus();
					break;
					
			}
		}
		
		private function clearForm():void
		{
			userForm.user = null;
			userForm.username.text = '';
			userForm.first.text = '';
			userForm.last.text = '';
			userForm.email.text = ''; 
			userForm.password.text = ''; 
			userForm.confirm.text = ''; 
			userForm.department.selectedItem = DeptEnum.NONE_SELECTED;
		}
	}
}