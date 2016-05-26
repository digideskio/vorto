package org.eclipse.vorto.codegen.examples.rml.templates

import org.eclipse.vorto.codegen.api.IMappingContext
import org.eclipse.vorto.codegen.api.MappingRuleHelper
import org.eclipse.vorto.core.api.model.functionblock.FunctionblockModel

class RMLViewSectionTemplate extends AbstractRMLSectionTemplate {
	
	private IMappingContext mappingContext;
	
	new (IMappingContext mappingContext) {
		this.mappingContext = mappingContext;
	}
		
	override getContent(FunctionblockModel context) {
		'''
		«IF context.functionblock.configuration != null»
			«FOR property : context.functionblock.configuration.properties»
				<controlbox bind="«property.name» stretch="«IF mappingContext.hasRules(property)»«new MappingRuleHelper(mappingContext.getMappingRuleByObject(property).get(0)).getStereoTypeAttribute("rml","stretch").value»«ELSE»1«ENDIF»">
					<localetitle>
						<en>«IF mappingContext.hasRules(property)»«new MappingRuleHelper(mappingContext.getMappingRuleByObject(property).get(0)).getStereoTypeAttribute("rml","i18n_en").value»«ENDIF»</en>
						<de>«IF mappingContext.hasRules(property)»«new MappingRuleHelper(mappingContext.getMappingRuleByObject(property).get(0)).getStereoTypeAttribute("rml","i18n_de").value»«ENDIF»</de>
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