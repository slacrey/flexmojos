/**
 *  Copyright 2008 Marvin Herman Froeder
 *  Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at
 *  http://www.apache.org/licenses/LICENSE-2.0
 *  Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
 *
 */
package info.flexmojos.unitestingsupport.flexunit
{
	import flexunit.framework.*;
	
	import info.flexmojos.test.report.ErrorReport;
	import info.flexmojos.unitestingsupport.SocketReporter;
	import info.flexmojos.unitestingsupport.util.ClassnameUtil;

	public class FlexUnitListener implements TestListener
	{
		
		private var socketReporter:SocketReporter = SocketReporter.getInstance();
		
		public static function run(tests:Array):int {
    		var result:TestResult = new TestResult();
	        result.addListener(new FlexUnitListener());

			var suite:TestSuite = new TestSuite();
			
			for each (var test:Class in tests)
			{
				var testCase:* = new test();
				if(testCase is Test)
				{
					suite.addTestSuite(test);
				}
			}
	        
    	    suite.runWithResult( result );
    	    
    	    return suite.countTestCases();
		}
		
    	/**
    	 * Called when a Test starts.
    	 * @param Test the test.
    	 */
    	public function startTest( test : Test ) : void
		{
			socketReporter.addMethod( test.className, test[ "methodName" ] );
		}
		
		/**
		 * Called when a Test ends.
		 * @param Test the test.
		 */
		public function endTest( test : Test ) : void
		{	
			socketReporter.testFinished(test.className);
		}
	
		/**
		 * Called when an error occurs.
		 * @param test the Test that generated the error.
		 * @param error the Error.
		 */
		public function addError( test : Test, error : Error ) : void
		{
			var failure:ErrorReport = new ErrorReport();
			failure.type = ClassnameUtil.getClassName(error);
			failure.message = error.message;
			failure.stackTrace = error.getStackTrace();

			socketReporter.addError(test.className, test[ "methodName" ], failure);
		}

		/**
		 * Called when a failure occurs.
		 * @param test the Test that generated the failure.
		 * @param error the failure.
		 */
		public function addFailure( test : Test, error : AssertionFailedError ) : void
		{
			var failure:ErrorReport = new ErrorReport();
			failure.type = ClassnameUtil.getClassName(error);
			failure.message = error.message;
			failure.stackTrace = error.getStackTrace();
			
			socketReporter.addFailure(test.className, test[ "methodName" ], failure);
		}

	}
}