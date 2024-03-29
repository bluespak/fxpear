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
package com.bluespak.utils;

/**
 * Source inspired by android.util.Pair
 * 
 * @author bluespak(bluespak@gmail.com)
 */
public class Tuple<F, S> {
	public final F first;
	public final S second;

	public Tuple(F first, S second) {
		this.first = first;
		this.second = second;
	}

	@Override
	public boolean equals(Object o) {
		if (!(o instanceof Tuple)) {
			return false;
		}
		Tuple<?, ?> p = (Tuple<?, ?>) o;
		return equal(p.first, first) && equal(p.second, second);
	}

	@Override
	public int hashCode() {
		return (first == null ? 0 : first.hashCode()) ^ (second == null ? 0 : second.hashCode());
	}

	private static boolean equal(Object a, Object b) {
		return a == b || (a != null && a.equals(b));
	}
}