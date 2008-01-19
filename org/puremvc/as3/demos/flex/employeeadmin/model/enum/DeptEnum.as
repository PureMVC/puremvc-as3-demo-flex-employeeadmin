/*
 PureMVC AS3 Demo - Flex Employee Admin 
 Copyright (c) 2007-08 Clifford Hall <clifford.hall@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.as3.demos.flex.employeeadmin.model.enum
{
	
	[Bindable]
	public class DeptEnum
	{
		public static const NONE_SELECTED:DeptEnum 	= new DeptEnum( '--None Selected--'	,-1 );
		public static const ACCT:DeptEnum 			= new DeptEnum( 'Accounting'		, 0 );
		public static const SALES:DeptEnum 			= new DeptEnum( 'Sales'				, 1 );
		public static const PLANT:DeptEnum 			= new DeptEnum( 'Plant'				, 2 );
		public static const SHIPPING:DeptEnum 		= new DeptEnum( 'Shipping'			, 3 );
		public static const QC:DeptEnum 			= new DeptEnum( 'Quality Control'	, 4 );
		
		public var ordinal:int;
		public var value:String;
		
		public function DeptEnum ( value:String, ordinal:int )
		{
			this.value = value;
			this.ordinal = ordinal;
		}

		public static function get list():Array
		{
			return [ ACCT, 
					 SALES, 
					 PLANT
				   ];
		}

		public static function get comboList():Array
		{
			var cList:Array = DeptEnum.list;
			cList.unshift( NONE_SELECTED );
			return cList;
		}
		
		public function equals( enum:RoleEnum ):Boolean
		{
			return ( this.ordinal == enum.ordinal && this.value == enum.value );
		}
	}
}