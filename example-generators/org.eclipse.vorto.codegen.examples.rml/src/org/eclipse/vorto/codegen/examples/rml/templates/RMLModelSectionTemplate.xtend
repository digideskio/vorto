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

import org.eclipse.vorto.codegen.api.IMappingContext
import org.eclipse.vorto.core.api.model.datatype.ConstraintIntervalType
import org.eclipse.vorto.core.api.model.datatype.Enum
import org.eclipse.vorto.core.api.model.datatype.ObjectPropertyType
import org.eclipse.vorto.core.api.model.functionblock.FunctionblockModel

class RMLModelSectionTemplate extends AbstractRMLSectionTemplate {
	
	private IMappingContext mappingContext;
	
	new (IMappingContext mappingContext) {
		this.mappingContext = mappingContext;
	}
		
	override getContent(FunctionblockModel context) {
		'''
		«IF context.functionblock.configuration != null»
			«FOR property : context.functionblock.configuration.properties»
				«IF isEnumProperty(property)»
					«var enumeration = ((property.type as ObjectPropertyType).type) as Enum»
					«var index = 0»
					<enum id="«property.name»" cmd="/p" mode="#readwrite">
						«FOR literal : enumeration.enums »
						<item name="«literal.name»" value="«index++»"/>
						«ENDFOR»
					</enum>
				«ELSEIF isRangeProperty(property)»
					«var minValue = getConstraintValue(property,ConstraintIntervalType.MIN)»
					«var maxValue = getConstraintValue(property,ConstraintIntervalType.MAX)»
					«var scaleValue = getConstraintValue(property,ConstraintIntervalType.SCALING)»
					<range id="«property.name»" cmd="/s" min="«minValue»" max="«maxValue»" step="«IF scaleValue != null»«scaleValue»«ELSE»1«ENDIF»"/>
				«ENDIF»
			«ENDFOR»
		«ENDIF»
		'''
	}
}