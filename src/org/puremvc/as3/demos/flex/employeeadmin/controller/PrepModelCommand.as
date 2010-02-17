/*
 PureMVC AS3 Demo - Flex Employee Admin 
 Copyright (c) 2007-10 Clifford Hall <clifford.hall@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.as3.demos.flex.employeeadmin.controller
{
	import org.puremvc.as3.demos.flex.employeeadmin.model.RoleProxy;
	import org.puremvc.as3.demos.flex.employeeadmin.model.UserProxy;
	import org.puremvc.as3.demos.flex.employeeadmin.model.enum.DeptEnum;
	import org.puremvc.as3.demos.flex.employeeadmin.model.enum.RoleEnum;
	import org.puremvc.as3.demos.flex.employeeadmin.model.vo.RoleVO;
	import org.puremvc.as3.demos.flex.employeeadmin.model.vo.UserVO;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	public class PrepModelCommand extends SimpleCommand
	{
		/**
		 * Prepare the Model.
		 */
		override public function execute( note:INotification ) : void	
		{
			// Create User Proxy, 
			var userProxy:UserProxy = new UserProxy();
			
			//Populate it with dummy data 
			userProxy.addItem( new UserVO("lstooge","Larry", "Stooge", "larry@stooges.com", "ijk456",DeptEnum.ACCT ) );
			userProxy.addItem( new UserVO("cstooge","Curly", "Stooge", "curly@stooges.com", "xyz987",DeptEnum.SALES ) );
			userProxy.addItem( new UserVO("mstooge","Moe", "Stooge", "moe@stooges.com", "abc123",DeptEnum.PLANT ) );

			// register it
			facade.registerProxy( userProxy );

			// Create Role Proxy
			var roleProxy:RoleProxy = new RoleProxy();
			
			//Populate it with dummy data 
			roleProxy.addItem( new RoleVO( "lstooge", [ RoleEnum.PAYROLL,
											  			RoleEnum.EMP_BENEFITS ] ) );
			roleProxy.addItem( new RoleVO( "cstooge", [ RoleEnum.ACCT_PAY,
											  			RoleEnum.ACCT_RCV,
											  			RoleEnum.GEN_LEDGER ] ) );
			roleProxy.addItem( new RoleVO( "mstooge", [ RoleEnum.INVENTORY,
											  			RoleEnum.PRODUCTION,
											  			RoleEnum.SALES,
											  			RoleEnum.SHIPPING ] ) );
			// register it
			facade.registerProxy( roleProxy );
		}
	}
}