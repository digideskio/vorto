/*******************************************************************************
 * Copyright (c) 2015 Bosch Software Innovations GmbH and others.
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
 *******************************************************************************/
package org.eclipse.vorto.codegen.examples.rml.templates

import org.eclipse.vorto.codegen.api.IFileTemplate
import org.eclipse.vorto.codegen.api.mapping.InvocationContext
import org.eclipse.vorto.core.api.model.informationmodel.InformationModel

/**
 * @author Alexander Edelmann - Robert Bosch (SEA) Pte. Ltd.
 */
class RMLTemplate implements IFileTemplate<InformationModel> {

	override getFileName(InformationModel context) {
		'''«context.name».rml'''
	}
	
	override getPath(InformationModel context) {
		return "rml/"
	}
	
	override getContent(InformationModel context, InvocationContext invocationContext) {
		
		'''
		<device xmlns="http://rml.xped.com">
			<description>
				<manufacturer>Xped</manufacturer>
				<mmodel>«context.name»</mmodel>
				<category>«invocationContext.getMappedElement(context,"rml").getAttributeValue("cat","0000")»</category>
				<version>1.0</version>
				<web></web>
			</description>
			<model>
				«FOR functionblockProperty : context.properties»
					«new RMLModelSectionTemplate().getContent(functionblockProperty.type,invocationContext)»
				«ENDFOR»
			</model>
			<view>
				<screen name="main">
					<groupbox title="$(NICKNAME)" skin="wood">
						«FOR functionblockProperty : context.properties»
						«new RMLViewSectionTemplate().getContent(functionblockProperty.type,invocationContext)»
						«ENDFOR»
						<spacer stretch="4"/>
					</groupbox>
				</screen>
			</view>
		</device>
		'''
	}
}