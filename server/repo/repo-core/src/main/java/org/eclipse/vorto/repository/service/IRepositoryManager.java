/**
 * Copyright (c) 2015-2016 Bosch Software Innovations GmbH and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * and Eclipse Distribution License v1.0 which accompany this distribution.
 *
 * The Eclipse Public License is available at
 * http://www.eclipse.org/legal/epl-v10.html
 * The Eclipse Distribution License is available at
 * http://www.eclipse.org/org/documents/edl-v10.php.
 *
 * Contributors:
 * Bosch Software Innovations GmbH - Please refer to git log
 */
package org.eclipse.vorto.repository.service;


import org.eclipse.vorto.http.model.ModelId;


public interface IRepositoryManager {
	
	/**
	 * creates a complete backup of the repository content
	 * @return
	 * @throws Exception
	 */
	byte[] backup() throws Exception;
	
	/**
	 * restores the given backup. Previous data will be lost!!
	 * @param inputStream
	 * @throws Exception
	 */
	void restore(byte[] backup) throws Exception;
	
	/**
	 * Removes the model with the given model id from the repository. 
	 * @param modelId
	 */
	void removeModel(ModelId modelId);
}
