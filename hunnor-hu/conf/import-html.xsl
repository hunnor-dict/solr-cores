<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	 xmlns:dict="http://dict.hunnor.net" exclude-result-prefixes="dict">

	<xsl:template match="dict:entry" mode="html">
		<xsl:apply-templates select="dict:formGrp" mode="html"/>
		<xsl:if test="dict:senseGrp">
			<xsl:element name="ol">
				<xsl:attribute name="class">
					<xsl:value-of select="'senseGrp'"/>
					<xsl:if test="count(dict:senseGrp) = 1">
						<xsl:value-of select="' single'"/>
					</xsl:if>
				</xsl:attribute>
				<xsl:apply-templates select="dict:senseGrp" mode="html"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="dict:formGrp" mode="html">
		<xsl:if test="dict:form">
			<xsl:element name="ul">
				<xsl:attribute name="class">
					<xsl:value-of select="'form'"/>
					<xsl:if test="count(dict:form) = 1">
						<xsl:value-of select="' single'"/>
					</xsl:if>
				</xsl:attribute>
			<xsl:apply-templates mode="html"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="dict:form" mode="html">
		<li>
			<span class="orth">
				<xsl:value-of select="dict:orth"/>
			</span>
			<xsl:if test="@primary = 'yes'">
				<xsl:text> </xsl:text>
				<span class="pos">
					<xsl:value-of select="dict:pos"/>
				</span>
			</xsl:if>
			<xsl:apply-templates mode="html"/>
		</li>
	</xsl:template>

	<xsl:template match="dict:inflCode" mode="html">
		<xsl:text> </xsl:text>
		<xsl:element name="span">
			<xsl:attribute name="class">
				<xsl:value-of select="'infl '"/>
				<xsl:value-of select="@type"/>
			</xsl:attribute>
			<xsl:value-of select="."/>
		</xsl:element>
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
		<li>
			<xsl:if test="dict:sense">
				<xsl:element name="ol">
					<xsl:attribute name="class">
						<xsl:value-of select="'sense'"/>
						<xsl:if test="count(dict:sense) = 1">
							<xsl:value-of select="' single'"/>
						</xsl:if>
					</xsl:attribute>
					<xsl:apply-templates mode="html"/>
				</xsl:element>
			</xsl:if>
		</li>
	</xsl:template>

	<xsl:template match="dict:sense" mode="html">
		<li>
			<ul>
				<xsl:apply-templates mode="html"/>
			</ul>
		</li>
	</xsl:template>

	<xsl:template match="dict:lbl" mode="html">
		<li class="lbl">
			<xsl:choose>
				<xsl:when test="local-name(preceding-sibling::*[1]) = 'lbl'">
					<span class="glue"><xsl:text>, </xsl:text></span>
				</xsl:when>
				<xsl:when test="local-name(preceding-sibling::*[1]) = 'trans'">
					<span class="glue"><xsl:text>, </xsl:text></span>
				</xsl:when>
			</xsl:choose>
			<span class="lbl"><xsl:apply-templates mode="html"/></span>
		</li>
	</xsl:template>

	<xsl:template match="dict:trans" mode="html">
		<li class="trans">
			<xsl:choose>
				<xsl:when test="local-name(preceding-sibling::*[1]) = 'lbl'">
					<span class="glue"><xsl:text> </xsl:text></span>
				</xsl:when>
				<xsl:when test="local-name(preceding-sibling::*[1]) = 'trans'">
					<span class="glue"><xsl:text>, </xsl:text></span>
				</xsl:when>
				<xsl:when test="local-name(preceding-sibling::*[1]) = 'q'">
					<span class="glue"><xsl:text> </xsl:text></span>
				</xsl:when>
			</xsl:choose>
			<span class="trans"><xsl:apply-templates mode="html"/></span>
		</li>
	</xsl:template>

	<xsl:template match="dict:eg" mode="html">
		<li class="eg">
			<ul class="eg">
				<xsl:apply-templates mode="html"/>
			</ul>
		</li>
	</xsl:template>

	<xsl:template match="dict:q" mode="html">
		<li class="q">
			<xsl:choose>
				<xsl:when test="count(../preceding-sibling::*) = 0">
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="position() = 1">
							<span class="glue"><xsl:text>; </xsl:text></span>
						</xsl:when>
						<xsl:when test="local-name(preceding-sibling::*[1]) = 'q'">
							<span class="glue"><xsl:text>, </xsl:text></span>
						</xsl:when>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
			<span class="q"><xsl:apply-templates mode="html"/></span>
		</li>
	</xsl:template>

	<xsl:template match="*" mode="html"/>

</xsl:stylesheet>
