/**
 *  Copyright 2008 Marvin Herman Froeder
 *  Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at
 *  http://www.apache.org/licenses/LICENSE-2.0
 *  Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
 *
 */
package {
 import advancedflex.debugger.aut.framework.TestCase;
 import advancedflex.debugger.aut.framework.ns.*;

 public class TestCaseSample2 extends TestCase {
  //test only.
  test function cc():void {
   console.print("aaa");
  }
  //test and check time if it is timeout.
  time function dd():int {
   console.print("bbb");
   return 10;
  }
 }
}