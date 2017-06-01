<?xml version="1.0" encoding="UTF-8"?>
<!--

	(c) 2009 Scott Trenda <korisu@gmail.com>
	MIT license
	Please send any functional corrections to korisu@gmail.com.

	Correctly outputs content of disable-output-escaping calls in Firefox and other transformToFragment-based browsers.
	Usage:
		<xsl:call-template name="disable-output-escaping">
			<xsl:with-param name="string" select="value" />
		</xsl:call-template>
	The value of the string parameter defaults to the string-value of the context node.

	Changes:
	2010-03-21 Named entity support added by request from Gregory Coburn

-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:doe="disable-output-escaping" exclude-result-prefixes="doe">
    
    <xsl:output method="html"
                indent="yes"
                encoding="UTF-8"/>

    <xsl:variable name="disable-output-escaping-name-tokens"
        >ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_</xsl:variable>

    <xsl:template name="disable-output-escaping">
        <xsl:param name="string" select="."/>
        <xsl:choose>
            <xsl:when test="system-property('xsl:vendor') = 'libxslt'">
                <xsl:value-of select="$string" disable-output-escaping="yes"/>
            </xsl:when>
            <xsl:when test="system-property('xsl:vendor') = 'Microsoft'">
                <xsl:value-of select="$string" disable-output-escaping="yes"/>
            </xsl:when>
            <xsl:when test="system-property('xsl:vendor') = 'Opera'">
                <xsl:value-of select="$string" disable-output-escaping="yes"/>
            </xsl:when>
            <!--
			<xsl:when test="system-property('xsl:vendor') != 'Transformiix'">
				<xsl:value-of select="$string" disable-output-escaping="yes" />
			</xsl:when>
-->
            <xsl:when
                test="contains($string, '&lt;') and not(contains(substring-before($string, '&lt;'), '&amp;'))">
                <xsl:variable name="element-name"
                    select="substring-before(substring-after($string, '&lt;'), substring(translate(substring-after($string, '&lt;'), $disable-output-escaping-name-tokens, ''), 1, 1))"/>
                <xsl:choose>
                    <xsl:when test="string-length($element-name)">
                        <xsl:variable name="all-content"
                            select="substring-after($string, concat('&lt;', $element-name))"/>
                        <xsl:variable name="attr-content"
                            select="substring-before($all-content, '&gt;')"/>
                        <xsl:variable name="value-content"
                            select="substring-after($all-content, '&gt;')"/>
                        <xsl:variable name="closed-element-name"
                            select="concat('&lt;/', $element-name, '&gt;')"/>
                        <xsl:variable name="is-closed"
                            select="contains($value-content, $closed-element-name)"/>

                        <xsl:value-of select="substring-before($string, '&lt;')"/>

                        <xsl:element name="{$element-name}">
                            <xsl:call-template name="disable-output-escaping-attributes">
                                <xsl:with-param name="string"
                                    select="normalize-space($attr-content)"/>
                            </xsl:call-template>
                            <!-- if it's a closed element -->
                            <xsl:if test="$is-closed">
                                <xsl:call-template name="disable-output-escaping">
                                    <xsl:with-param name="string"
                                        select="substring-before($value-content, $closed-element-name)"
                                    />
                                </xsl:call-template>
                            </xsl:if>
                        </xsl:element>

                        <xsl:call-template name="disable-output-escaping">
                            <xsl:with-param name="string">
                                <xsl:choose>
                                    <xsl:when test="$is-closed">
                                        <xsl:value-of
                                            select="substring-after($value-content, $closed-element-name)"
                                        />
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="$value-content"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:with-param>
                        </xsl:call-template>

                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="concat(substring-before($string, '&lt;'), '&lt;')"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>

            <!-- Named entities -->
            <xsl:when
                test="contains($string, '&amp;') and contains(substring-after($string, '&amp;'), ';')">
                <xsl:value-of select="substring-before($string, '&amp;')"/>
                <xsl:variable name="entity"
                    select="$doe:entities[@name = substring-before(substring-after($string, '&amp;'), ';')]"/>
                <xsl:choose>
                    <xsl:when test="$entity">
                        <xsl:value-of select="$entity/@value"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of
                            select="concat('&amp;', substring-before(substring-after($string, '&amp;'), ';'), ';')"
                        />
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:call-template name="disable-output-escaping">
                    <xsl:with-param name="string"
                        select="substring-after(substring-after($string, '&amp;'), ';')"/>
                </xsl:call-template>
            </xsl:when>

            <xsl:otherwise>
                <xsl:value-of select="$string"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- Parse through, creating attributes until > is encountered outside an attribute -->
    <xsl:template name="disable-output-escaping-attributes">
        <xsl:param name="string"/>

        <xsl:variable name="attribute-name">
            <xsl:variable name="next"
                select="substring(translate($string, $disable-output-escaping-name-tokens, ''), 1, 1)"/>
            <xsl:choose>
                <xsl:when test="$next != ''">
                    <xsl:value-of select="substring-before($string, $next)"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$string"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:if test="$attribute-name != ''">
            <xsl:variable name="attr-string" select="substring-after($string, $attribute-name)"/>
            <xsl:variable name="is-empty"
                select="not(starts-with(normalize-space($attr-string), '='))"/>
            <xsl:variable name="delimiter"
                select="substring(normalize-space(substring-after($attr-string, '=')), 1, 1)"/>

            <xsl:attribute name="{$attribute-name}">
                <xsl:choose>
                    <xsl:when test="$is-empty">
                        <xsl:value-of select="$attribute-name"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of
                            select="substring-before(substring-after($attr-string, $delimiter), $delimiter)"
                        />
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>

            <xsl:variable name="remaining">
                <xsl:choose>
                    <xsl:when test="$is-empty">
                        <xsl:value-of select="$attr-string"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of
                            select="substring-after(substring-after($attr-string, $delimiter), $delimiter)"
                        />
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>

            <xsl:call-template name="disable-output-escaping-attributes">
                <xsl:with-param name="string" select="normalize-space($remaining)"/>
            </xsl:call-template>

        </xsl:if>
    </xsl:template>

    <xsl:variable name="doe:entities" select="document('')//doe:entity"/>
    <doe:entity name="nbsp" value="&#160;"/>
    <doe:entity name="iexcl" value="&#161;"/>
    <doe:entity name="cent" value="&#162;"/>
    <doe:entity name="pound" value="&#163;"/>
    <doe:entity name="curren" value="&#164;"/>
    <doe:entity name="yen" value="&#165;"/>
    <doe:entity name="brvbar" value="&#166;"/>
    <doe:entity name="sect" value="&#167;"/>
    <doe:entity name="uml" value="&#168;"/>
    <doe:entity name="copy" value="&#169;"/>
    <doe:entity name="ordf" value="&#170;"/>
    <doe:entity name="laquo" value="&#171;"/>
    <doe:entity name="not" value="&#172;"/>
    <doe:entity name="shy" value="&#173;"/>
    <doe:entity name="reg" value="&#174;"/>
    <doe:entity name="macr" value="&#175;"/>
    <doe:entity name="deg" value="&#176;"/>
    <doe:entity name="plusmn" value="&#177;"/>
    <doe:entity name="sup2" value="&#178;"/>
    <doe:entity name="sup3" value="&#179;"/>
    <doe:entity name="acute" value="&#180;"/>
    <doe:entity name="micro" value="&#181;"/>
    <doe:entity name="para" value="&#182;"/>
    <doe:entity name="middot" value="&#183;"/>
    <doe:entity name="cedil" value="&#184;"/>
    <doe:entity name="sup1" value="&#185;"/>
    <doe:entity name="ordm" value="&#186;"/>
    <doe:entity name="raquo" value="&#187;"/>
    <doe:entity name="frac14" value="&#188;"/>
    <doe:entity name="frac12" value="&#189;"/>
    <doe:entity name="frac34" value="&#190;"/>
    <doe:entity name="iquest" value="&#191;"/>
    <doe:entity name="Agrave" value="&#192;"/>
    <doe:entity name="Aacute" value="&#193;"/>
    <doe:entity name="Acirc" value="&#194;"/>
    <doe:entity name="Atilde" value="&#195;"/>
    <doe:entity name="Auml" value="&#196;"/>
    <doe:entity name="Aring" value="&#197;"/>
    <doe:entity name="AElig" value="&#198;"/>
    <doe:entity name="Ccedil" value="&#199;"/>
    <doe:entity name="Egrave" value="&#200;"/>
    <doe:entity name="Eacute" value="&#201;"/>
    <doe:entity name="Ecirc" value="&#202;"/>
    <doe:entity name="Euml" value="&#203;"/>
    <doe:entity name="Igrave" value="&#204;"/>
    <doe:entity name="Iacute" value="&#205;"/>
    <doe:entity name="Icirc" value="&#206;"/>
    <doe:entity name="Iuml" value="&#207;"/>
    <doe:entity name="ETH" value="&#208;"/>
    <doe:entity name="Ntilde" value="&#209;"/>
    <doe:entity name="Ograve" value="&#210;"/>
    <doe:entity name="Oacute" value="&#211;"/>
    <doe:entity name="Ocirc" value="&#212;"/>
    <doe:entity name="Otilde" value="&#213;"/>
    <doe:entity name="Ouml" value="&#214;"/>
    <doe:entity name="times" value="&#215;"/>
    <doe:entity name="Oslash" value="&#216;"/>
    <doe:entity name="Ugrave" value="&#217;"/>
    <doe:entity name="Uacute" value="&#218;"/>
    <doe:entity name="Ucirc" value="&#219;"/>
    <doe:entity name="Uuml" value="&#220;"/>
    <doe:entity name="Yacute" value="&#221;"/>
    <doe:entity name="THORN" value="&#222;"/>
    <doe:entity name="szlig" value="&#223;"/>
    <doe:entity name="agrave" value="&#224;"/>
    <doe:entity name="aacute" value="&#225;"/>
    <doe:entity name="acirc" value="&#226;"/>
    <doe:entity name="atilde" value="&#227;"/>
    <doe:entity name="auml" value="&#228;"/>
    <doe:entity name="aring" value="&#229;"/>
    <doe:entity name="aelig" value="&#230;"/>
    <doe:entity name="ccedil" value="&#231;"/>
    <doe:entity name="egrave" value="&#232;"/>
    <doe:entity name="eacute" value="&#233;"/>
    <doe:entity name="ecirc" value="&#234;"/>
    <doe:entity name="euml" value="&#235;"/>
    <doe:entity name="igrave" value="&#236;"/>
    <doe:entity name="iacute" value="&#237;"/>
    <doe:entity name="icirc" value="&#238;"/>
    <doe:entity name="iuml" value="&#239;"/>
    <doe:entity name="eth" value="&#240;"/>
    <doe:entity name="ntilde" value="&#241;"/>
    <doe:entity name="ograve" value="&#242;"/>
    <doe:entity name="oacute" value="&#243;"/>
    <doe:entity name="ocirc" value="&#244;"/>
    <doe:entity name="otilde" value="&#245;"/>
    <doe:entity name="ouml" value="&#246;"/>
    <doe:entity name="divide" value="&#247;"/>
    <doe:entity name="oslash" value="&#248;"/>
    <doe:entity name="ugrave" value="&#249;"/>
    <doe:entity name="uacute" value="&#250;"/>
    <doe:entity name="ucirc" value="&#251;"/>
    <doe:entity name="uuml" value="&#252;"/>
    <doe:entity name="yacute" value="&#253;"/>
    <doe:entity name="thorn" value="&#254;"/>
    <doe:entity name="yuml" value="&#255;"/>
    <doe:entity name="fnof" value="&#402;"/>
    <doe:entity name="Alpha" value="&#913;"/>
    <doe:entity name="Beta" value="&#914;"/>
    <doe:entity name="Gamma" value="&#915;"/>
    <doe:entity name="Delta" value="&#916;"/>
    <doe:entity name="Epsilon" value="&#917;"/>
    <doe:entity name="Zeta" value="&#918;"/>
    <doe:entity name="Eta" value="&#919;"/>
    <doe:entity name="Theta" value="&#920;"/>
    <doe:entity name="Iota" value="&#921;"/>
    <doe:entity name="Kappa" value="&#922;"/>
    <doe:entity name="Lambda" value="&#923;"/>
    <doe:entity name="Mu" value="&#924;"/>
    <doe:entity name="Nu" value="&#925;"/>
    <doe:entity name="Xi" value="&#926;"/>
    <doe:entity name="Omicron" value="&#927;"/>
    <doe:entity name="Pi" value="&#928;"/>
    <doe:entity name="Rho" value="&#929;"/>
    <doe:entity name="Sigma" value="&#931;"/>
    <doe:entity name="Tau" value="&#932;"/>
    <doe:entity name="Upsilon" value="&#933;"/>
    <doe:entity name="Phi" value="&#934;"/>
    <doe:entity name="Chi" value="&#935;"/>
    <doe:entity name="Psi" value="&#936;"/>
    <doe:entity name="Omega" value="&#937;"/>
    <doe:entity name="alpha" value="&#945;"/>
    <doe:entity name="beta" value="&#946;"/>
    <doe:entity name="gamma" value="&#947;"/>
    <doe:entity name="delta" value="&#948;"/>
    <doe:entity name="epsilon" value="&#949;"/>
    <doe:entity name="zeta" value="&#950;"/>
    <doe:entity name="eta" value="&#951;"/>
    <doe:entity name="theta" value="&#952;"/>
    <doe:entity name="iota" value="&#953;"/>
    <doe:entity name="kappa" value="&#954;"/>
    <doe:entity name="lambda" value="&#955;"/>
    <doe:entity name="mu" value="&#956;"/>
    <doe:entity name="nu" value="&#957;"/>
    <doe:entity name="xi" value="&#958;"/>
    <doe:entity name="omicron" value="&#959;"/>
    <doe:entity name="pi" value="&#960;"/>
    <doe:entity name="rho" value="&#961;"/>
    <doe:entity name="sigmaf" value="&#962;"/>
    <doe:entity name="sigma" value="&#963;"/>
    <doe:entity name="tau" value="&#964;"/>
    <doe:entity name="upsilon" value="&#965;"/>
    <doe:entity name="phi" value="&#966;"/>
    <doe:entity name="chi" value="&#967;"/>
    <doe:entity name="psi" value="&#968;"/>
    <doe:entity name="omega" value="&#969;"/>
    <doe:entity name="thetasym" value="&#977;"/>
    <doe:entity name="upsih" value="&#978;"/>
    <doe:entity name="piv" value="&#982;"/>
    <doe:entity name="bull" value="&#8226;"/>
    <doe:entity name="hellip" value="&#8230;"/>
    <doe:entity name="prime" value="&#8242;"/>
    <doe:entity name="Prime" value="&#8243;"/>
    <doe:entity name="oline" value="&#8254;"/>
    <doe:entity name="frasl" value="&#8260;"/>
    <doe:entity name="weierp" value="&#8472;"/>
    <doe:entity name="image" value="&#8465;"/>
    <doe:entity name="real" value="&#8476;"/>
    <doe:entity name="trade" value="&#8482;"/>
    <doe:entity name="alefsym" value="&#8501;"/>
    <doe:entity name="larr" value="&#8592;"/>
    <doe:entity name="uarr" value="&#8593;"/>
    <doe:entity name="rarr" value="&#8594;"/>
    <doe:entity name="darr" value="&#8595;"/>
    <doe:entity name="harr" value="&#8596;"/>
    <doe:entity name="crarr" value="&#8629;"/>
    <doe:entity name="lArr" value="&#8656;"/>
    <doe:entity name="uArr" value="&#8657;"/>
    <doe:entity name="rArr" value="&#8658;"/>
    <doe:entity name="dArr" value="&#8659;"/>
    <doe:entity name="hArr" value="&#8660;"/>
    <doe:entity name="forall" value="&#8704;"/>
    <doe:entity name="part" value="&#8706;"/>
    <doe:entity name="exist" value="&#8707;"/>
    <doe:entity name="empty" value="&#8709;"/>
    <doe:entity name="nabla" value="&#8711;"/>
    <doe:entity name="isin" value="&#8712;"/>
    <doe:entity name="notin" value="&#8713;"/>
    <doe:entity name="ni" value="&#8715;"/>
    <doe:entity name="prod" value="&#8719;"/>
    <doe:entity name="sum" value="&#8721;"/>
    <doe:entity name="minus" value="&#8722;"/>
    <doe:entity name="lowast" value="&#8727;"/>
    <doe:entity name="radic" value="&#8730;"/>
    <doe:entity name="prop" value="&#8733;"/>
    <doe:entity name="infin" value="&#8734;"/>
    <doe:entity name="ang" value="&#8736;"/>
    <doe:entity name="and" value="&#8869;"/>
    <doe:entity name="or" value="&#8870;"/>
    <doe:entity name="cap" value="&#8745;"/>
    <doe:entity name="cup" value="&#8746;"/>
    <doe:entity name="int" value="&#8747;"/>
    <doe:entity name="there4" value="&#8756;"/>
    <doe:entity name="sim" value="&#8764;"/>
    <doe:entity name="cong" value="&#8773;"/>
    <doe:entity name="asymp" value="&#8776;"/>
    <doe:entity name="ne" value="&#8800;"/>
    <doe:entity name="equiv" value="&#8801;"/>
    <doe:entity name="le" value="&#8804;"/>
    <doe:entity name="ge" value="&#8805;"/>
    <doe:entity name="sub" value="&#8834;"/>
    <doe:entity name="sup" value="&#8835;"/>
    <doe:entity name="nsub" value="&#8836;"/>
    <doe:entity name="sube" value="&#8838;"/>
    <doe:entity name="supe" value="&#8839;"/>
    <doe:entity name="oplus" value="&#8853;"/>
    <doe:entity name="otimes" value="&#8855;"/>
    <doe:entity name="perp" value="&#8869;"/>
    <doe:entity name="sdot" value="&#8901;"/>
    <doe:entity name="lceil" value="&#8968;"/>
    <doe:entity name="rceil" value="&#8969;"/>
    <doe:entity name="lfloor" value="&#8970;"/>
    <doe:entity name="rfloor" value="&#8971;"/>
    <doe:entity name="lang" value="&#9001;"/>
    <doe:entity name="rang" value="&#9002;"/>
    <doe:entity name="loz" value="&#9674;"/>
    <doe:entity name="spades" value="&#9824;"/>
    <doe:entity name="clubs" value="&#9827;"/>
    <doe:entity name="hearts" value="&#9829;"/>
    <doe:entity name="diams" value="&#9830;"/>
    <doe:entity name="quot" value="&#34;"/>
    <doe:entity name="amp" value="&#38;"/>
    <doe:entity name="lt" value="&#60;"/>
    <doe:entity name="gt" value="&#62;"/>
    <doe:entity name="OElig" value="&#338;"/>
    <doe:entity name="oelig" value="&#339;"/>
    <doe:entity name="Scaron" value="&#352;"/>
    <doe:entity name="scaron" value="&#353;"/>
    <doe:entity name="Yuml" value="&#376;"/>
    <doe:entity name="circ" value="&#710;"/>
    <doe:entity name="tilde" value="&#732;"/>
    <doe:entity name="ensp" value="&#8194;"/>
    <doe:entity name="emsp" value="&#8195;"/>
    <doe:entity name="thinsp" value="&#8201;"/>
    <doe:entity name="zwnj" value="&#8204;"/>
    <doe:entity name="zwj" value="&#8205;"/>
    <doe:entity name="lrm" value="&#8206;"/>
    <doe:entity name="rlm" value="&#8207;"/>
    <doe:entity name="ndash" value="&#8211;"/>
    <doe:entity name="mdash" value="&#8212;"/>
    <doe:entity name="lsquo" value="&#8216;"/>
    <doe:entity name="rsquo" value="&#8217;"/>
    <doe:entity name="sbquo" value="&#8218;"/>
    <doe:entity name="ldquo" value="&#8220;"/>
    <doe:entity name="rdquo" value="&#8221;"/>
    <doe:entity name="bdquo" value="&#8222;"/>
    <doe:entity name="dagger" value="&#8224;"/>
    <doe:entity name="Dagger" value="&#8225;"/>
    <doe:entity name="permil" value="&#8240;"/>
    <doe:entity name="lsaquo" value="&#8249;"/>
    <doe:entity name="rsaquo" value="&#8250;"/>

</xsl:stylesheet>
