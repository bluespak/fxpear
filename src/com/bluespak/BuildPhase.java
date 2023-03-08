/*
 * Copyright 2012-Present bluespak. All rights reserved.
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.bluespak;

/**
 * @author bluespak(bluespak@gmail.com)
 */
public enum BuildPhase {
	LOCAL, ALPHA, BETA, REAL, UNDEFINED;

	private static final String KEY_BUILD_PHASE = "build.phase";

	private static BuildPhase myPhase = null;

	public static BuildPhase determine() {
		if (null == myPhase) {
			String phase = ConfigManager.getProperty(KEY_BUILD_PHASE);
			try {
				myPhase = BuildPhase.valueOf(phase);
			} catch (IllegalArgumentException e) {
				myPhase = UNDEFINED;
			}
		}

		return myPhase;
	}
	
	public static void destroy() {
		myPhase = null;
	}
}
