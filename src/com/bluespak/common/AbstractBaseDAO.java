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
package com.bluespak.common;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * @author bluespak(bluespak@gmail.com)
 */
public abstract class AbstractBaseDAO {
	@Autowired
	private SqlSessionFactory sqlSessionFactory;

	/**
	 * Retrieve a single row mapped from the SQL statement.
	 * 
	 * @param sqlId SQL id defined in mapper XML file
	 * @param defaultValue value to distinguish database error and no row found
	 * @return <code>null</code> if there was a database error, <code>defaultValue</code> if there was no row found by SQL execution,
	 * Mapped object if the SQL execution was successful and there was a row.
	 * @throws Exception 
	 */
	protected <T> T selectOne(SqlSession session, String sqlId, T defaultValue) throws Exception {
		return selectOne(session, sqlId, null, defaultValue);
	}

	/**
	 * Retrieve a single row mapped from the SQL statement.
	 * 
	 * @param sqlId SQL id defined in mapper XML file
	 * @param param parameter object to pass to the statement.
	 * @param defaultValue value to distinguish database error and no row found
	 * @return <code>null</code> if there was a database error, <code>defaultValue</code> if there was no row found by SQL execution,
	 * Mapped object if the SQL execution was successful and there was a row.
	 * @throws Exception 
	 */
	protected <T> T selectOne(SqlSession session, String sqlId, Object param, T defaultValue) throws Exception {

		try {
			T data;
			System.out.println("AbstractBaseDAO.selectOne==Start param="+param);
			System.out.println("AbstractBaseDAO.selectOne==sqlId="+sqlId);
			System.out.println("AbstractBaseDAO.selectOne==session="+session);
			if (null == param) {
				data = session.selectOne(makeStatementId(sqlId));
			} else {
				System.out.println("AbstractBaseDAO before select");
				data = session.selectOne(makeStatementId(sqlId), param);
				System.out.println("AbstractBaseDAO After select");
				System.out.println("AbstractBaseDAO After data="+data);
			}
			System.out.println("AbstractBaseDAO.selectOne== End" );
			
			return data;
		} catch (Exception e) {
			System.out.println(e.toString());
			throw e;
		}
	}

	/**
	 * Retrieve  a list of mapped objects from the SQL statement.
	 * @param sqlId SQL id defined in mapper XML file
	 * @param defaultValue value to distinguish database error and no row found
	 * @return <code>null</code> if there was a database error, <code>defaultValue</code> if there was no row found by SQL execution,
	 * Mapped object if the SQL execution was successful and there was a row.
	 * @throws Exception 
	 */
	protected <T> List<T> selectList(SqlSession session, String sqlId, List<T> defaultValue) throws Exception {
		return selectList(session, sqlId, null, defaultValue);
	}
	
	/**
	 * Retrieve  a list of mapped objects from the SQL statement.
	 * @param sqlId SQL id defined in mapper XML file
	 * @param param parameter object to pass to the statement.
	 * @param defaultValue value to distinguish database error and no row found
	 * @return <code>null</code> if there was a database error, <code>defaultValue</code> if there was no row found by SQL execution,
	 * Mapped object if the SQL execution was successful and there was a row.
	 * @throws Exception 
	 */
	protected <T> List<T> selectList(SqlSession session, String sqlId, Object param, List<T> defaultValue) throws Exception {

		try {
			List<T> data;
			if (null == param) {
				data = session.selectList(makeStatementId(sqlId));
		/*
			}else if (((List<T>) param). get("snum") !=null && param.get("qnum") !=null) {
				
				RowBounds rowBounds = new RowBounds(param.get("snum"), param.get("qnum"));
				data = session.selectList(makeStatementId(sqlId), param, rowBounds);
		*/	
			}else {
				data = session.selectList(makeStatementId(sqlId), param);
			}
			
			return data;
		} catch (Exception e) {
			System.out.println(e.toString());
			throw e;
		}
	}
	
	/**
	 * Retrieve a converted Map originated from list of resulting objects from the SQL statement.
	 * 
	 * @param sqlId SQL id defined in mapper XML file
	 * @param defaultValue value to distinguish database error and no row found
	 * @param mapKey property to use as key for each value in the list.
	 * @return <code>null</code> if there was a database error, <code>defaultValue</code> if there was no row found by SQL execution,
	 * Mapped object if the SQL execution was successful and there was a row.
	 * @throws Exception 
	 */
	protected <K, V> Map<K, V> selectMap(SqlSession session, String sqlId, Map<K, V> defaultValue, String mapKey) throws Exception {
		return selectMap(session, sqlId, null, defaultValue, mapKey);
	}
	
	/**
	 * Retrieve a converted Map originated from list of resulting objects from the SQL statement.
	 * 
	 * @param sqlId SQL id defined in mapper XML file
	 * @param param parameter object to pass to the statement.
	 * @param defaultValue value to distinguish database error and no row found
	 * @param mapKey property to use as key for each value in the list.
	 * @return <code>null</code> if there was a database error, <code>defaultValue</code> if there was no row found by SQL execution,
	 * Mapped object if the SQL execution was successful and there was a row.
	 * @throws Exception 
	 */
	protected <K, V> Map<K, V> selectMap(SqlSession session, String sqlId, Object param, Map<K, V> defaultValue, String mapKey) throws Exception {

		try {
			Map<K, V> data;
			if (null == param) {
				data = session.selectMap(makeStatementId(sqlId), mapKey);
			} else {
				data = session.selectMap(makeStatementId(sqlId), param, mapKey);
			}
			
			return data;
		} catch (Exception e) {
			throw e;
		}
	}
	
	/**
	 * Execute an insert statement.
	 * 
	 * @param sqlId SQL id defined in mapper XML file
	 * @return The number of rows affected by the insert, <code>null</code> if there was a database error.
	 * @throws Exception 
	 */
	protected Integer insert(SqlSession session,String sqlId) throws Exception {
		return insert(session, sqlId, null);
	}

	/**
	 * Execute an insert statement.
	 * 
	 * @param sqlId SQL id defined in mapper XML file
	 * @param param parameter object to pass to the statement.
	 * @return The number of rows affected by the insert, <code>null</code> if there was a database error.
	 * @throws Exception 
	 */
	protected Integer insert(SqlSession session,String sqlId, Object param) throws Exception {

		try {
			int data;
			if (null == param) {
				data = session.insert(makeStatementId(sqlId));
			} else {
				System.out.println("DAO.insert param="+param);
				data = session.insert(makeStatementId(sqlId), param);
				System.out.println("insert complete");
				
			}
				
			return data;
		} catch (Exception e) {
			throw e;
		}
	}
	
	/**
	 * Execute an update statement.
	 * 
	 * @param sqlId SQL id defined in mapper XML file
	 * @return The number of rows affected by the update, <code>null</code> if there was a database error.
	 * @throws Exception 
	 */
	protected Integer update(SqlSession session,String sqlId) throws Exception {
		return update(session, sqlId, null);
	}

	/**
	 * Execute an update statement.
	 * 
	 * @param sqlId SQL id defined in mapper XML file
	 * @param param parameter object to pass to the statement.
	 * @return The number of rows affected by the update, <code>null</code> if there was a database error.
	 * @throws Exception 
	 */
	protected Integer update(SqlSession session, String sqlId, Object param) throws Exception {

		try {
			int data;
			if (null == param) {
				data = session.update(makeStatementId(sqlId));
			} else {
				data = session.update(makeStatementId(sqlId), param);
			}

			return data;
		} catch (Exception e) {
			throw e;
		}
	}	
	
	/**
	 * Execute an delete statement.
	 * 
	 * @param sqlId SQL id defined in mapper XML file
	 * @return The number of rows affected by the delete, <code>null</code> if there was a database error.
	 * @throws Exception 
	 */
	protected Integer delete(SqlSession session,String sqlId) throws Exception {
		return delete(session,sqlId, null);
	}

	/**
	 * Execute an delete statement.
	 * 
	 * @param sqlId SQL id defined in mapper XML file
	 * @param param parameter object to pass to the statement.
	 * @return The number of rows affected by the delete, <code>null</code> if there was a database error.
	 * @throws Exception 
	 */
	protected Integer delete(SqlSession session,String sqlId, Object param) throws Exception {
		try {
			int data;
			if (null == param) {
				data = session.delete(makeStatementId(sqlId));
			} else {
				data = session.delete(makeStatementId(sqlId), param);
			}

			return data;
		} catch (Exception e) {
			throw e;
		}
	}
	
	public SqlSessionFactory getSqlSessionFactory() {
		return sqlSessionFactory;
	}

	public void setSqlSessionFactory(SqlSessionFactory sqlSessionFactory) {
		this.sqlSessionFactory = sqlSessionFactory;
	}

	private String makeStatementId(final String sqlId) {
		return getSqlmapNamespace() + "." + sqlId;
	}

	/**
	 * @return The SQL namespace of mapper XML file
	 */
	protected abstract String getSqlmapNamespace();
}
