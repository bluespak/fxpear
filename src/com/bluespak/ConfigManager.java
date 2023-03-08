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

import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;


import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.StringUtils;

import com.bluespak.utils.LogUtils;

/**
 * @author bluespak(bluespak@gmail.com)
 */
public final class ConfigManager {
	private static final Map<String, String> PROPERTIES = new HashMap<String, String>();
	private String fileName;
	
	public void build() throws Exception {
		Properties p = new Properties();
		InputStream input = null;
		try {
			input = getClass().getClassLoader().getResourceAsStream(fileName);
			p.load(input);

			for (Map.Entry<?, ?> entry : p.entrySet()) {
				PROPERTIES.put(entry.getKey().toString(), entry.getValue().toString());
			}
		} catch (IOException e) {
			throw e;
		} finally {
			IOUtils.closeQuietly(input);
		}

		LogUtils.i("Properties Manager loaded %s property entries", PROPERTIES.size());
	}

	public static String getProperty(final String key) {
		String prop = PROPERTIES.get(key);
		if (null != prop) {
			return prop;
		} else {
			LogUtils.w("Unable to load property - %s", key);
			return StringUtils.EMPTY;
		}
	}
	
	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
}
