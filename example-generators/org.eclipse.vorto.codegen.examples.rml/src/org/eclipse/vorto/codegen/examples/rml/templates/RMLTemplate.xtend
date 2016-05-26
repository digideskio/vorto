package org.eclipse.vorto.codegen.examples.rml.templates

import org.eclipse.vorto.codegen.api.IFileTemplate
import org.eclipse.vorto.core.api.model.informationmodel.InformationModel
import org.eclipse.vorto.codegen.api.IMappingContext
import org.eclipse.vorto.core.api.model.mapping.StereoTypeTarget
import org.eclipse.vorto.codegen.api.MappingRuleHelper

/**
 * @author Alexander Edelmann - Robert Bosch (SEA) Pte. Ltd.
 */
class RMLTemplate implements IFileTemplate<InformationModel> {

	private IMappingContext mappingContext;
	
	new (IMappingContext mappingContext) {
		this.mappingContext = mappingContext;
	}

	override getFileName(InformationModel context) {
		'''«context.name».rml'''
	}
	
	override getPath(InformationModel context) {
		return "rml/"
	}
	
	override getContent(InformationModel context) {
		
		'''
		<device xmlns="http://rml.xped.com">
			<description>
				<manufacturer>Xped</manufacturer>
				<mmodel>«context.name»</mmodel>
				<category>«IF mappingContext.hasRules(context)»«new MappingRuleHelper(mappingContext.getMappingRuleByObject(context).get(0)).getStereoTypeAttribute("rml","cat").value»«ENDIF»</category>
				<version>1.0</version>
				<web></web>
			</description>
			<model>
				«FOR functionblockProperty : context.properties»
					«new RMLModelSectionTemplate(mappingContext).getContent(functionblockProperty.type)»
				«ENDFOR»
			</model>
			<view>
				<screen name="main">
					<groupbox title="$(NICKNAME)" skin="wood">
						«FOR functionblockProperty : context.properties»
						«new RMLViewSectionTemplate(mappingContext).getContent(functionblockProperty.type)»
						«ENDFOR»
						<spacer stretch="4"/>
					</groupbox>
				</screen>
			</view>
		</device>
		'''
	}
}