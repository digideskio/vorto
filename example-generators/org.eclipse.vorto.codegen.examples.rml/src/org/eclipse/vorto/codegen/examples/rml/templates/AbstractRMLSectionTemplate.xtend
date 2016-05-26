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

import org.eclipse.vorto.codegen.api.ITemplate
import org.eclipse.vorto.core.api.model.datatype.Constraint
import org.eclipse.vorto.core.api.model.datatype.ConstraintIntervalType
import org.eclipse.vorto.core.api.model.datatype.ObjectPropertyType
import org.eclipse.vorto.core.api.model.datatype.Property
import org.eclipse.vorto.core.api.model.functionblock.FunctionblockModel

abstract class AbstractRMLSectionTemplate implements ITemplate<FunctionblockModel> {
	
	def boolean isEnumProperty(Property property) {
		return (property.type instanceof ObjectPropertyType && (property.type as ObjectPropertyType).type instanceof org.eclipse.vorto.core.api.model.datatype.Enum)
	}
	
	def boolean isRangeProperty(Property  property) {
		if (!property.constraints.isNullOrEmpty) {
			for (Constraint constraint : property.constraints) {
				if (constraint.type == ConstraintIntervalType.MIN) {
					return true;
				}
			}
		}
		return false;
	}
	
	def String getConstraintValue(Property  property, ConstraintIntervalType constraintType) {
		if (!property.constraints.isNullOrEmpty) {
			for (Constraint constraint : property.constraints) {
				if (constraint.type == constraintType) {
					return constraint.constraintValues;
				}
			}
		}
		return null;
	}
}