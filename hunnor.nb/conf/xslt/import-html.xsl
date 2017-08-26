<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	 xmlns:dict="http://dict.hunnor.net" exclude-result-prefixes="dict">

	<xsl:template match="dict:entry" mode="html">
		<xsl:apply-templates select="dict:formGrp" mode="html"/>
		<xsl:if test="dict:senseGrp">
			<xsl:text disable-output-escaping="yes">&lt;ol class="senseGrp</xsl:text>
			<xsl:if test="count(dict:senseGrp) = 1">
				<xsl:text disable-output-escaping="yes"> single</xsl:text>
			</xsl:if>
			<xsl:text disable-output-escaping="yes">"></xsl:text>
			<xsl:apply-templates select="dict:senseGrp" mode="html"/>
			<xsl:text disable-output-escaping="yes">&lt;/ol></xsl:text>
		</xsl:if>
	</xsl:template>

	<xsl:template match="dict:formGrp" mode="html">
		<xsl:if test="dict:form">
			<xsl:text disable-output-escaping="yes">&lt;ul class="form</xsl:text>
			<xsl:if test="count(dict:form) = 1">
				<xsl:text disable-output-escaping="yes"> single</xsl:text>
			</xsl:if>
			<xsl:text disable-output-escaping="yes">"></xsl:text>
			<xsl:apply-templates mode="html"/>
			<xsl:text disable-output-escaping="yes">&lt;/ul></xsl:text>
		</xsl:if>
	</xsl:template>

	<xsl:template match="dict:form" mode="html">
		<xsl:text disable-output-escaping="yes">&lt;li></xsl:text>
		<xsl:text disable-output-escaping="yes">&lt;span class="orth"></xsl:text>
		<xsl:value-of select="dict:orth"/>
		<xsl:text disable-output-escaping="yes">&lt;/span></xsl:text>
		<xsl:if test="@primary = 'yes'">
			<xsl:text> </xsl:text>
			<xsl:text disable-output-escaping="yes">&lt;span class="pos"></xsl:text>
			<xsl:value-of select="dict:pos"/>
			<xsl:text disable-output-escaping="yes">&lt;/span></xsl:text>
		</xsl:if>
		<xsl:apply-templates mode="html"/>
		<xsl:text disable-output-escaping="yes">&lt;/li></xsl:text>
	</xsl:template>

	<xsl:template match="dict:inflCode" mode="html">
		<xsl:text> </xsl:text>
		<xsl:text disable-output-escaping="yes">&lt;span class="infl </xsl:text>
		<xsl:value-of select="@type"/>
		<xsl:text disable-output-escaping="yes">"></xsl:text>
		<xsl:value-of select="."/>
		<xsl:text disable-output-escaping="yes">&lt;/span></xsl:text>
	</xsl:template>

	<xsl:template match="dict:inflPar" mode="html">
		<xsl:choose>
			<xsl:when test="preceding-sibling::dict:inflPar">
				<xsl:text>; </xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text> (</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:apply-templates mode="html"/>
		<xsl:if test="not(following-sibling::dict:inflPar)">
			<xsl:text>)</xsl:text>
		</xsl:if>
	</xsl:template>

	<xsl:template match="dict:inflSeq" mode="html">
		<xsl:if test="preceding-sibling::dict:inflSeq">
			<xsl:text>, </xsl:text>
		</xsl:if>
		<xsl:apply-templates mode="html"/>
	</xsl:template>

	<xsl:template match="dict:senseGrp" mode="html">
		<xsl:text disable-output-escaping="yes">&lt;li></xsl:text>
		<xsl:if test="dict:sense">
			<xsl:text disable-output-escaping="yes">&lt;ol class="sense</xsl:text>
			<xsl:if test="count(dict:sense) = 1">
				<xsl:text disable-output-escaping="yes"> single</xsl:text>
			</xsl:if>
			<xsl:text disable-output-escaping="yes">"></xsl:text>
			<xsl:apply-templates mode="html"/>
			<xsl:text disable-output-escaping="yes">&lt;/ol></xsl:text>
		</xsl:if>
		<xsl:text disable-output-escaping="yes">&lt;/li></xsl:text>
	</xsl:template>

	<xsl:template match="dict:sense" mode="html">
		<xsl:text disable-output-escaping="yes">&lt;li></xsl:text>
		<xsl:text disable-output-escaping="yes">&lt;ul></xsl:text>
		<xsl:apply-templates mode="html"/>
		<xsl:text disable-output-escaping="yes">&lt;/ul></xsl:text>
		<xsl:text disable-output-escaping="yes">&lt;/li></xsl:text>
	</xsl:template>

	<xsl:template match="dict:lbl" mode="html">
		<xsl:text disable-output-escaping="yes">&lt;li class="lbl"></xsl:text>
		<xsl:choose>
			<xsl:when test="local-name(preceding-sibling::*[1]) = 'lbl'">
				<xsl:text disable-output-escaping="yes">&lt;span class="glue">, &lt;/span></xsl:text>
			</xsl:when>
			<xsl:when test="local-name(preceding-sibling::*[1]) = 'trans'">
				<xsl:text disable-output-escaping="yes">&lt;span class="glue">, &lt;/span></xsl:text>
			</xsl:when>
		</xsl:choose>
		<xsl:text disable-output-escaping="yes">&lt;span class="lbl"></xsl:text><xsl:apply-templates mode="html"/><xsl:text disable-output-escaping="yes">&lt;/span></xsl:text>
		<xsl:text disable-output-escaping="yes">&lt;/li></xsl:text>
	</xsl:template>

	<xsl:template match="dict:trans" mode="html">
		<xsl:text disable-output-escaping="yes">&lt;li class="trans"></xsl:text>
		<xsl:choose>
			<xsl:when test="local-name(preceding-sibling::*[1]) = 'lbl'">
				<xsl:text disable-output-escaping="yes">&lt;span class="glue"> &lt;/span></xsl:text>
			</xsl:when>
			<xsl:when test="local-name(preceding-sibling::*[1]) = 'trans'">
				<xsl:text disable-output-escaping="yes">&lt;span class="glue">, &lt;/span></xsl:text>
			</xsl:when>
			<xsl:when test="local-name(preceding-sibling::*[1]) = 'q'">
				<xsl:text disable-output-escaping="yes">&lt;span class="glue"> &lt;/span></xsl:text>
			</xsl:when>
		</xsl:choose>
		<xsl:text disable-output-escaping="yes">&lt;span class="trans"></xsl:text><xsl:apply-templates mode="html"/><xsl:text disable-output-escaping="yes">&lt;/span></xsl:text>
		<xsl:text disable-output-escaping="yes">&lt;/li></xsl:text>
	</xsl:template>

	<xsl:template match="dict:eg" mode="html">
		<xsl:text disable-output-escaping="yes">&lt;li class="eg"></xsl:text>
		<xsl:text disable-output-escaping="yes">&lt;ul class="eg"></xsl:text>
		<xsl:apply-templates mode="html"/>
		<xsl:text disable-output-escaping="yes">&lt;/ul></xsl:text>
		<xsl:text disable-output-escaping="yes">&lt;/li></xsl:text>
	</xsl:template>

	<xsl:template match="dict:q" mode="html">
		<xsl:text disable-output-escaping="yes">&lt;li class="q"></xsl:text>
		<xsl:choose>
			<xsl:when test="count(../preceding-sibling::*) = 0">
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="position() = 1">
						<xsl:text disable-output-escaping="yes">&lt;span class="glue">; &lt;/span></xsl:text>
					</xsl:when>
					<xsl:when test="local-name(preceding-sibling::*[1]) = 'q'">
						<xsl:text disable-output-escaping="yes">&lt;span class="glue">, &lt;/span></xsl:text>
					</xsl:when>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:text disable-output-escaping="yes">&lt;span class="q"></xsl:text><xsl:apply-templates mode="html"/><xsl:text disable-output-escaping="yes">&lt;/span></xsl:text>
		<xsl:text disable-output-escaping="yes">&lt;/li></xsl:text>
	</xsl:template>

	<xsl:template match="*" mode="html"/>

</xsl:stylesheet>
