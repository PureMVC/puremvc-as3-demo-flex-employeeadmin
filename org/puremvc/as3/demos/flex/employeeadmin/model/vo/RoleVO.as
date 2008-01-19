/*
 PureMVC AS3 Demo - Flex Employee Admin 
 Copyright (c) 2007-08 Clifford Hall <clifford.hall@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.as3.demos.flex.employeeadmin.model.vo
{
	import mx.collections.ArrayCollection;
	
	[Bindable]
	public class RoleVO
	{
		public function RoleVO ( username:String=null,
								 roles:Array=null )
		{
			if( username != null ) this.username = username;
			if( roles != null ) this.roles = new ArrayCollection( roles );
		} 
		public var username:String = '';
		public var roles:ArrayCollection = new ArrayCollection();
		
	}
}