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