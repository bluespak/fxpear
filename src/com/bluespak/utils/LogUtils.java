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

import java.io.InputStream;
import java.util.Properties;

import org.apache.commons.io.IOUtils;
import org.apache.log4j.Level;
import org.apache.log4j.Logger;

/**
 * @author bluespak(bluespak@gmail.com)
 */
public class LogUtils {
	private static final Logger LOG = Logger.getLogger(LogUtils.class);
	
	private static final boolean D_LOGGABLE;
	private static final boolean I_LOGGABLE;
	private static final boolean W_LOGGABLE;
	private static final boolean E_LOGGABLE;
	private static final boolean F_LOGGABLE;
	
	static {
		Properties p = new Properties();
		InputStream input = null;
		
		Level logLevel;
		try {
			input = LogUtils.class.getClassLoader().getResourceAsStream("log4j.properties");
			p.load(input);
			
			String logLevelStr = p.getProperty("log4j.rootLogger").split(",")[0];
			logLevel = Level.toLevel(logLevelStr);
		} catch(Exception e) {
			e.printStackTrace();
			System.err.println("Cannot load log4j configuration: Setting LOGLEVEL as WARN");
			logLevel = Level.WARN;
		} finally {
			IOUtils.closeQuietly(input);
		}

		D_LOGGABLE = Level.DEBUG.isGreaterOrEqual(logLevel);
		I_LOGGABLE = Level.INFO.isGreaterOrEqual(logLevel);
		W_LOGGABLE = Level.WARN.isGreaterOrEqual(logLevel);
		E_LOGGABLE = Level.ERROR.isGreaterOrEqual(logLevel);
		F_LOGGABLE = Level.FATAL.isGreaterOrEqual(logLevel);
	}
	
	public static void d(final String logFormat, final Object... args) {
		if (D_LOGGABLE) {
			Tuple<String, Throwable> log = produceLog(logFormat, args);
			
			if (null == log.second) {
				LOG.debug(log.first);
			} else {
				LOG.debug(log.first, log.second);
			}
		}
	}

	public static void i(final String logFormat, final Object... args) {
		if (I_LOGGABLE) {
			Tuple<String, Throwable> log = produceLog(logFormat, args);
			
			if (null == log.second) {
				LOG.info(log.first);
			} else {
				LOG.info(log.first, log.second);
			}
		}
	}

	public static void w(final String logFormat, final Object... args) {
		if (W_LOGGABLE) {
			Tuple<String, Throwable> log = produceLog(logFormat, args);
			
			if (null == log.second) {
				LOG.warn(log.first);
			} else {
				LOG.warn(log.first, log.second);
			}
		}
	}

	public static void e(final String logFormat, final Object... args) {
		if (E_LOGGABLE) {
			Tuple<String, Throwable> log = produceLog(logFormat, args);
			
			if (null == log.second) {
				LOG.error(log.first);
			} else {
				LOG.error(log.first, log.second);
			}
		}
	}

	public static void f(final Logger logger, final String logFormat, final Object... args) {
		if (F_LOGGABLE) {
			Tuple<String, Throwable> log = produceLog(logFormat, args);
			
			if (null == log.second) {
				LOG.fatal(log.first);
			} else {
				LOG.fatal(log.first, log.second);
			}
		}
	}
	
	private static Tuple<String, Throwable> produceLog(final String logFormat, final Object... args) {
		String logMsg;
		Throwable t;

		if (null == args || args.length == 0) {
			logMsg = logFormat;
			t = null;
		} else {
			Object[] logArgs;
			
			if (args[args.length - 1] instanceof Throwable) {
				t = (Throwable)args[args.length - 1];
				logArgs = new Object[args.length - 1];
				System.arraycopy(args, 0, logArgs, 0, args.length - 1);
			} else {
				t = null;
				logArgs = args;
			}
			
			logMsg = String.format(logFormat, logArgs);
		}

		return new Tuple<String, Throwable>(logMsg, t);
	}
}
