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

import org.eclipse.vorto.codegen.api.mapping.InvocationContext
import org.eclipse.vorto.core.api.model.functionblock.FunctionblockModel

class RMLViewSectionTemplate extends AbstractRMLSectionTemplate {
			
	override getContent(FunctionblockModel context, InvocationContext invocationContext) {
		'''
		«IF context.functionblock.configuration != null»
			«FOR property : context.functionblock.configuration.properties»
				<controlbox bind="«property.name» stretch="«invocationContext.getMappedElement(property,"rml").getAttributeValue("stretch","1")»>
					<localetitle>
						<en>«invocationContext.getMappedElement(property,"rml").getAttributeValue("i18n_en","")»</en>
						<de>«invocationContext.getMappedElement(property,"rml").getAttributeValue("i18n_de","")»</de>
					</localetitle>
					«IF isEnumProperty(property)»
					<toggleswitch bind="«property.name»"/>
					«ELSEIF isRangeProperty(property)»
					<scrolldialwheel bind="«property.name»"/>
					«ENDIF»
				</controlbox>
			«ENDFOR»
		«ENDIF»
		'''
	}
}