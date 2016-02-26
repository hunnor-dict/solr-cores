<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	 xmlns:dict="http://dict.hunnor.net" exclude-result-prefixes="dict">

	<xsl:import href="import-html.xsl"/>

	<xsl:output method="xml" indent="no"/>

	<xsl:strip-space elements="*"/>

	<xsl:template match="dict:hnDict">
		<add>
			<xsl:apply-templates/>
		</add>
	</xsl:template>

	<xsl:template match="dict:entryGrp">
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="dict:entry">
		<doc>
			<field name="id">
				<xsl:value-of select="@id"/>
			</field>
			<xsl:if test="@status">
				<field name="status">
					<xsl:value-of select="@status"/>
				</field>
			</xsl:if>
			<xsl:for-each select="dict:formGrp/dict:form/dict:orth">
				<field name="roots">
					<xsl:value-of select="."/>
				</field>
			</xsl:for-each>
			<field name="sort">
				<xsl:value-of select="dict:formGrp/dict:form/dict:orth"/>
			</field>
			<xsl:for-each select="dict:formGrp/dict:form/dict:inflPar/dict:inflSeq">
				<field name="forms">
					<xsl:value-of select="."/>
				</field>
			</xsl:for-each>
			<xsl:for-each select="dict:formGrp/dict:form/dict:inflCode">
				<field name="par">
					<xsl:value-of select="."/>
				</field>
			</xsl:for-each>
			<xsl:for-each select="dict:senseGrp/dict:sense/dict:trans">
				<field name="trans">
					<xsl:value-of select="."/>
				</field>
			</xsl:for-each>
			<xsl:for-each select="dict:senseGrp/dict:sense/dict:eg/dict:q">
				<field name="eg">
					<xsl:value-of select="."/>
				</field>
			</xsl:for-each>
			<xsl:for-each select="dict:senseGrp/dict:sense/dict:eg/dict:trans">
				<field name="egTrans">
					<xsl:value-of select="."/>
				</field>
			</xsl:for-each>
			<field name="html">
				<xsl:text disable-output-escaping="yes">&lt;![CDATA[</xsl:text><xsl:apply-templates mode="html" select="."/><xsl:text disable-output-escaping="yes">]]&gt;</xsl:text>
			</field>
		</doc>
	</xsl:template>

</xsl:stylesheet>
