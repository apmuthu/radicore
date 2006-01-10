<?xml version='1.0'?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml">

<!--
//*****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
//*****************************************************************************
-->

<xsl:variable name="select_one" select="/root/params/select_one"/>

<!-- display details horizontally -->
<xsl:template name="display_horizontal">
  <xsl:param name="zone"/>      <!-- could be 'main', 'inner', 'outer', etc -->
  <xsl:param name="multiple"/>  <!-- set this for more than one occurrence -->

  <xsl:variable name="table" select="name()"/>          <!-- current table name -->
  <xsl:variable name="position" select="position()"/>   <!-- current row within table -->

  <tr>
    <!-- set the row class to 'odd' or 'even' to determine the colour -->
    <xsl:attribute name="class">
      <xsl:choose>
        <xsl:when test="position()mod 2">odd</xsl:when>
        <xsl:otherwise>even</xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>

    <!-- step through the fields defined in the STRUCTURE element -->
    <xsl:for-each select="//structure/*[name()=$zone]/item/cell[@field]">

      <!-- get fieldname from the ID attribute -->
      <xsl:variable name="fieldname" select="@field" />

      <!-- select the field (identified in STRUCTURE) from the current row of the specified table -->
      <xsl:variable name="field" select="//*[name()=$table][position()=$position]/*[name()=$fieldname]" />

      <td>
        <!-- process the named field from the current row -->
        <xsl:call-template name="datafield">
          <xsl:with-param name="item"     select="$field"/>
          <xsl:with-param name="itemname" select="$fieldname"/>
          <xsl:with-param name="path"     select="$table"/>
          <xsl:with-param name="position" select="$position"/>
          <xsl:with-param name="multiple" select="$multiple"/>
        </xsl:call-template>
      </td>

    </xsl:for-each>
  </tr>

</xsl:template> <!-- display_horizontal -->




<!-- display details vertically -->
<!-- multi-column version, with each cell containing either a label or a value -->
<xsl:template name="display_vertical">
  <xsl:param name="zone"/>    <!-- could be 'main', 'inner', 'outer', etc -->
  <xsl:param name="noedit"/>  <!-- y = no edit, display only -->

  <xsl:variable name="table" select="name()"/>          <!-- current table name -->
  <xsl:variable name="table_row" select="position()"/>  <!-- current row within table -->

  <!-- output column settings -->
  <xsl:call-template name="column_group">
    <xsl:with-param name="table" select="$zone"/>
  </xsl:call-template>

  <!-- step through each row/item defined in the STRUCTURE element -->
  <xsl:for-each select="//structure/*[name()=$zone]/item">

    <xsl:variable name="struct_row" select="position()"/>   <!-- current row number -->

    <!-- build a node-set of field names to be processed for this row -->
    <xsl:variable name="fieldnames" select="cell[@field]/@field"/>

    <!-- build a node-set of field names which actually exist as data elements -->
    <xsl:variable name="fieldsfound" select="//*[name()=$table][position()=$table_row]/*[name()=$fieldnames]"/>

    <!-- build a node-set of fields which have the NODISPLAY attribute set -->
    <xsl:variable name="nodisplay" select="$fieldsfound[@nodisplay]"/>

    <!-- build a node-set of fields which have the DISPLAY-EMPY attribute se -->
    <xsl:variable name="display-empty" select="cell[@display-empty]/@field"/>

    <xsl:choose>
      <xsl:when test="count($fieldsfound) = count($nodisplay) and not($display-empty)">
        <!-- all the fields in this row have the NODISPLAY attribute set, so do not output anything -->
      </xsl:when>

      <xsl:otherwise>
        <!-- get fieldname from the FIELD attribute -->
        <xsl:variable name="fieldname" select="cell/@field" />

        <!-- obtain the value for this field from the current row of the specified table -->
        <xsl:variable name="fieldvalue" select="//*[name()=$table][position()=$table_row]/*[name()=$fieldname]" />

        <xsl:call-template name="display_vertical_row">
          <xsl:with-param name="zone"       select="$zone"/>
          <xsl:with-param name="table"      select="$table"/>
          <xsl:with-param name="table_row"  select="$table_row"/>
          <xsl:with-param name="struct_row" select="$struct_row"/>
          <xsl:with-param name="noedit"     select="$noedit"/>
        </xsl:call-template>

      </xsl:otherwise>

    </xsl:choose>

  </xsl:for-each>

</xsl:template> <!-- display_vertical -->

<xsl:template name="display_vertical_row">
  <xsl:param name="zone"/>        <!-- could be 'main', 'inner', 'outer', etc -->
  <xsl:param name="table"/>       <!-- name of data table -->
  <xsl:param name="table_row"/>   <!-- position of this data element -->
  <xsl:param name="struct_row"/>  <!-- position of this structure element -->
  <xsl:param name="noedit"/>      <!-- y = no edit, display only -->

  <tr>

    <!-- step through the cells defined in the STRUCTURE element for the current ROW -->
    <xsl:for-each select="//structure/*[name()=$zone]/item[position()=$struct_row]/cell">

    <td>

      <xsl:if test="@colspan">
        <xsl:attribute name="colspan"><xsl:value-of select="@colspan" /></xsl:attribute>
      </xsl:if>
      <xsl:if test="@rowspan">
        <xsl:attribute name="rowspan"><xsl:value-of select="@rowspan" /></xsl:attribute>
      </xsl:if>

        <xsl:choose>
          <xsl:when test="@label">
            <!-- get fieldname from the FIELD attribute of the following sibling -->
            <xsl:variable name="fieldname" select="string(following-sibling::*[@field]/@field)" />

            <!-- obtain the value for this field from the current row of the specified table -->
            <xsl:variable name="fieldvalue" select="//*[name()=$table][position()=$table_row]/*[name()=$fieldname]" />

            <xsl:choose>
              <!-- do nothing unless the field is actually present in the XML file -->
              <!-- and it does not have the @nodisplay attribute set -->
              <xsl:when test="$fieldvalue and not($fieldvalue/@nodisplay)">

                <!-- set classname for this label cell -->
                <xsl:attribute name="class">label</xsl:attribute>

                <xsl:choose>
                  <!-- insert indiator if field is required -->
                  <xsl:when test="$mode='insert' and ($fieldvalue/@pkey or $fieldvalue/@required)">
                    <span class="required">* </span>
                  </xsl:when>
                  <xsl:when test="$mode='update' and $fieldvalue/@required and not($fieldvalue/@pkey) and not($noedit)">
                    <span class="required">* </span>
                  </xsl:when>
                </xsl:choose>

                <xsl:value-of select="@label"/> <!-- output the value for the label -->

              </xsl:when>

              <xsl:otherwise>
                <xsl:text>&#160;</xsl:text> <!-- insert non-breaking space -->
              </xsl:otherwise>

            </xsl:choose>

          </xsl:when>

          <xsl:otherwise>
            <!-- get fieldname from the FIELD attribute -->
            <xsl:variable name="fieldname" select="@field" />

            <!-- obtain the value for this field from the current row of the specified table -->
            <xsl:variable name="fieldvalue" select="//*[name()=$table][position()=$table_row]/*[name()=$fieldname]" />

            <xsl:choose>
              <!-- do nothing unless the field is actually present in the XML file -->
              <!-- and it does not have the @nodisplay attribute set -->
              <xsl:when test="$fieldvalue and not($fieldvalue/@nodisplay)">

                <!-- process the named field from the current row -->
                <xsl:call-template name="datafield">
                  <xsl:with-param name="item"     select="$fieldvalue"/>
                  <xsl:with-param name="itemname" select="$fieldname"/>
                  <xsl:with-param name="path"     select="$table"/>
                  <xsl:with-param name="position" select="$table_row"/>
                  <xsl:with-param name="noedit"   select="$noedit"/>
                  <xsl:with-param name="str-size" select="@size"/>
                </xsl:call-template>

              </xsl:when>

              <xsl:otherwise>
                <xsl:text>&#160;</xsl:text> <!-- insert non-breaking space -->
              </xsl:otherwise>

            </xsl:choose>

          </xsl:otherwise>
        </xsl:choose>

      </td>

    </xsl:for-each>

  </tr>

</xsl:template> <!-- display_vertical_row -->




<!--
// This is my standard template for including a data item from an XML input
// file in an HTML file for output to a web browser.
//
// It is possible that the same XSL template will be used by scripts which run
// in different modes, therefore the way that fields are defined in the HTML
// output may have to be altered. Script modes are defined in the $mode parameter
// which is defined at runtime (when the XSL transformation is performed). The
// values and meanings are as follows:
// $mode='list'   - all fields are non-editable and there is no SUBMIT button
// $mode='insert' - all fields are editable
// $mode='update' - all fields except primary keys are editable
// $mode='read'   - all fields are non-editable and there is no SUBMIT button
// $mode='delete' - all fields are non-editable, there is a SUBMIT button
// $mode='search' - fields allow the input of search criteria only
//
// The input to this template is the name of a data item from the XML file. The
// type of form control used to display the item will be specified in the 'control'
// attribute. Other processing options will also be specified as attributes.
//
// If no control attribute is specified the default will be 'textfield'.
// Other control types are:
// 'radiogroup' - radio buttons populated from an option list
// 'dropdown' - a pulldown/dropdown display populated from an option list
// 'popup' - a picklist which is another screen
// 'multiline' - a multiline text box
//
-->

<xsl:template name="datafield">
  <xsl:param name="item"/>       <!-- the item value -->
  <xsl:param name="itemname"/>   <!-- the item name -->
  <xsl:param name="multiple"/>   <!-- set this for more than one occurrence -->
  <xsl:param name="path"/>       <!-- the entity name -->
  <xsl:param name="position"/>   <!-- the row number -->
  <xsl:param name="noedit"/>     <!-- no edit, display only -->
  <xsl:param name="str-size"/>   <!-- size value from the screen structure file -->

  <xsl:choose>

    <xsl:when test="$itemname='selectbox'">
      <!-- insert a checkbox to make selections -->
      <xsl:call-template name="selectbox">
        <xsl:with-param name="path" select="$path"/>
        <xsl:with-param name="position" select="$position"/>
      </xsl:call-template>
    </xsl:when>

    <xsl:otherwise>

      <!-- do nothing unless the item is present -->
      <xsl:if test="$item">

        <xsl:choose>

          <xsl:when test="$item/@nodisplay">
            <!-- 'nodisplay' attribute set, so display nothing -->
            <xsl:text> </xsl:text>
          </xsl:when>

          <xsl:when test="$item/@control='dropdown'">
            <xsl:call-template name="dropdown">
              <xsl:with-param name="item" select="$item"/>
              <xsl:with-param name="multiple" select="$multiple"/>
              <xsl:with-param name="noedit" select="$noedit"/>
              <xsl:with-param name="path" select="$path"/>
              <xsl:with-param name="position" select="$position"/>
            </xsl:call-template>
          </xsl:when>

          <xsl:when test="$item/@control='filepicker'">
            <xsl:call-template name="filepicker">
              <xsl:with-param name="item" select="$item"/>
              <xsl:with-param name="multiple" select="$multiple"/>
              <xsl:with-param name="noedit" select="$noedit"/>
            </xsl:call-template>
          </xsl:when>

          <xsl:when test="$item/@control='multiline'">
            <xsl:call-template name="multiline">
              <xsl:with-param name="item" select="$item"/>
              <xsl:with-param name="multiple" select="$multiple"/>
              <xsl:with-param name="noedit" select="$noedit"/>
            </xsl:call-template>
          </xsl:when>

          <xsl:when test="$item/@control='popup'">
            <xsl:call-template name="popup">
              <xsl:with-param name="item" select="$item"/>
              <xsl:with-param name="multiple" select="$multiple"/>
              <xsl:with-param name="noedit" select="$noedit"/>
              <xsl:with-param name="path" select="$path"/>
              <xsl:with-param name="position" select="$position"/>
            </xsl:call-template>
          </xsl:when>

          <xsl:when test="$item/@control='radiogroup'">
            <xsl:call-template name="radiogroup">
              <xsl:with-param name="item" select="$item"/>
              <xsl:with-param name="multiple" select="$multiple"/>
              <xsl:with-param name="noedit" select="$noedit"/>
              <xsl:with-param name="path" select="$path"/>
              <xsl:with-param name="position" select="$position"/>
            </xsl:call-template>
          </xsl:when>

          <xsl:otherwise> <!-- this is the default control type -->
            <xsl:call-template name="textfield">
              <xsl:with-param name="item" select="$item"/>
              <xsl:with-param name="multiple" select="$multiple"/>
              <xsl:with-param name="noedit" select="$noedit"/>
              <xsl:with-param name="path" select="$path"/>
              <xsl:with-param name="position" select="$position"/>
              <xsl:with-param name="str-size" select="$str-size"/>
            </xsl:call-template>
          </xsl:otherwise>

        </xsl:choose>

      </xsl:if>

    </xsl:otherwise>

  </xsl:choose>

  <!-- check if field has error attribute set -->
  <xsl:if test="$item/@error">
    <br/><span class="error"><xsl:value-of select="$item/@error"/></span>
  </xsl:if>

</xsl:template> <!-- datafield -->





<!--
****************************************************************************************
* DROPDOWN - create a dropdown list of items
****************************************************************************************
-->
<xsl:template name="dropdown">
  <xsl:param name="item"/>        <!-- the lookup value -->
  <xsl:param name="multiple"/>    <!-- optional, causes position number to be added to item name -->
  <xsl:param name="noedit"/>
  <xsl:param name="path"/>        <!-- the entity name -->
  <xsl:param name="position"/>    <!-- the row number -->

  <!-- this turns the value of the optionlist attribute into a node set -->
  <xsl:variable name="optionlist" select="//lookup/*[name()=$item/@optionlist]"/>

  <xsl:choose>

    <xsl:when test="$mode='list' or $mode='read' or $mode='delete' or $item/@noedit or $noedit or ($mode='update' and $item/@pkey)">

      <!-- item is read only, so output as plain text -->

      <!-- look for an option where the id attribute equals the lookup value -->
      <xsl:variable name="option" select="$optionlist/option[@id=$item]" />
      <xsl:choose>
        <xsl:when test="$option">
          <!-- entry found, so use it -->
          <xsl:value-of select="$option"/>
        </xsl:when>
        <xsl:otherwise>
          <!-- entry not found, so default to lookup value -->
          <xsl:value-of select="$item"/>
        </xsl:otherwise>
      </xsl:choose>

    </xsl:when>

    <xsl:otherwise> <!-- field can be modified -->

      <!-- create a select statement for $item with a list of options -->
      <select class="select">

        <xsl:attribute name="name">
          <xsl:choose>

            <!-- if 'multiple' is set then include row number in item name -->
            <xsl:when test="$multiple">
              <xsl:value-of select="concat(name($item),'[',$position,']')"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="name($item)"/>
            </xsl:otherwise>

          </xsl:choose>
        </xsl:attribute>

        <xsl:for-each select="$optionlist/option">
          <!-- use the 'id' attribute of the node as the 'value' attribute of 'option' -->
          <option value="{@id}" >
            <xsl:choose>
              <xsl:when test="$item=@id">
                <!-- this option has been selected -->
                <xsl:attribute name="selected">selected</xsl:attribute>
              </xsl:when>
              <xsl:when test="$item=node()">
                <!-- this option has been selected (variation for ENUM fields) -->
                <xsl:attribute name="selected">selected</xsl:attribute>
              </xsl:when>
            </xsl:choose>
            <!-- output the value of the current option -->
            <xsl:value-of select="node()"/>
          </option>
        </xsl:for-each>

      </select>

    </xsl:otherwise>

  </xsl:choose>

</xsl:template> <!-- dropdown -->



<!--
****************************************************************************************
* FILEPICKER - create a text field for a file name that is populated from a file picker
****************************************************************************************
-->
<xsl:template name="filepicker">
  <xsl:param name="item"/>
  <xsl:param name="multiple"/>
  <xsl:param name="noedit"/>

  <xsl:choose>

    <xsl:when test="$mode='list' or $mode='read' or $mode='delete' or $noedit or not($item/@task_id)">
      <!-- if $mode is read/delete then field is read only (not editable) -->
      <!-- therefore picker button is not wanted -->
      <!-- also ignore if $filepicker is not supplied -->

      <!-- display the image -->
      <div class="picker-image">
        <xsl:call-template name="image">
          <xsl:with-param name="item" select="$item"/>
        </xsl:call-template>
      </div>

      <!-- display the file name -->
      <div class="picker-text">
        <xsl:value-of select="$item"/>
      </div>

    </xsl:when>

    <xsl:otherwise>

      <!-- display the image -->
      <div class="picker-image">
        <xsl:call-template name="image">
          <xsl:with-param name="item" select="$item"/>
        </xsl:call-template>
      </div>

      <!-- display current value in a text box -->
      <div class="picker-text">
        <xsl:call-template name="textfield">
          <xsl:with-param name="item" select="$item"/>
          <xsl:with-param name="multiple" select="$multiple"/>
        </xsl:call-template>
      </div>

      <!-- create a picker button -->
      <div class="picker-button">
        <input type="image" name="{$item/@task_id}" src="images/popup.gif" alt="Call picker form to obtain file name" />
      </div>

    </xsl:otherwise>

  </xsl:choose>

</xsl:template> <!-- filepicker -->




<!--
****************************************************************************************
* HIDDEN - create a hidden field
****************************************************************************************
-->
<xsl:template name="hidden">
  <xsl:param name="item"/>

  <input type="hidden" name="{name($item)}" value="{$item}" />

  <!-- check if field has error attribute set -->
  <xsl:if test="$item/@error">
    <br/><span class="error"><xsl:value-of select="$item/@error"/></span>
  </xsl:if>

</xsl:template> <!-- hidden -->



<!--
****************************************************************************************
* ICON - display an image
****************************************************************************************
-->
<xsl:template name="icon">
  <xsl:param name="icon"/>
  <xsl:param name="width"/>
  <xsl:param name="height"/>

  <!-- if entry is non-blank show it as an image -->
  <xsl:if test="$icon">
    <div class="center">
      <img src="{$icon}" alt="{$icon}">
        <!-- height and width are optional -->
        <xsl:if test="$height">
          <xsl:attribute name="height"><xsl:value-of select="$height"/></xsl:attribute>
        </xsl:if>
        <xsl:if test="$width">
          <xsl:attribute name="width"><xsl:value-of select="$width"/></xsl:attribute>
        </xsl:if>
      </img>
    </div>
  </xsl:if>

</xsl:template> <!-- icon -->



<!--
****************************************************************************************
* IMAGE - display an image
****************************************************************************************
-->
<xsl:template name="image">
  <xsl:param name="item"/>

  <xsl:if test="string-length($item)">
    <xsl:if test="$item/@image">

      <!-- display file as image -->
      <img>
        <xsl:attribute name="src"><xsl:value-of select="$item"/></xsl:attribute>
        <!-- height and width are optional -->
        <xsl:if test="$item/@imageheight">
          <xsl:attribute name="height"><xsl:value-of select="$item/@imageheight"/></xsl:attribute>
        </xsl:if>
        <xsl:if test="$item/@imagewidth">
          <xsl:attribute name="width"><xsl:value-of select="$item/@imagewidth"/></xsl:attribute>
        </xsl:if>
      </img>
      <xsl:text>&#160;</xsl:text> <!-- insert non-breaking space -->

    </xsl:if>
  </xsl:if>

</xsl:template> <!-- IMAGE -->




<!--
****************************************************************************************
* MESSAGE - output zero or more message lines
****************************************************************************************
-->
<xsl:template name="message">

  <xsl:if test="//infomsg/*">
    <div class="infomsg">
      <xsl:for-each select="//infomsg/line">
        <p><xsl:value-of select="node()"/></p>
      </xsl:for-each>
    </div>
  </xsl:if>

  <xsl:if test="//errmsg/*">
    <div class="errmsg">
      <xsl:for-each select="//errmsg/line">
        <p><xsl:value-of select="node()"/></p>
      </xsl:for-each>
    </div>
  </xsl:if>

</xsl:template> <!-- MESSAGE -->


<!--
****************************************************************************************
* MULTILINE - create a multiline field in a form area
****************************************************************************************
-->
<xsl:template name="multiline">
  <xsl:param name="item"/>
  <xsl:param name="noedit"/>

  <xsl:choose>

    <xsl:when test="$mode='search'">
      <!-- use a normal input box instead of a multiline textarea -->
      <input class="text" type="text" name="{name($item)}" value="{$item}" size="{$item/@cols}"/>
    </xsl:when>

    <xsl:when test="$mode='list' or $noedit">
      <!-- display as plain text -->
      <xsl:value-of select="$item"/>
    </xsl:when>

    <xsl:otherwise>

      <!-- create multiline field to allow data to be input or amended -->
      <textarea class="textarea">
        <xsl:attribute name="name"><xsl:value-of select="name($item)"/></xsl:attribute>
        <xsl:attribute name="rows"><xsl:value-of select="$item/@rows"/></xsl:attribute>
        <xsl:attribute name="cols"><xsl:value-of select="$item/@cols"/></xsl:attribute>
        <!-- under certain conditions set this field to read only -->
        <xsl:if test="$mode='read' or $mode='delete' or $item/@noedit or $noedit">
          <xsl:attribute name="readonly">readonly</xsl:attribute>
        </xsl:if>
        <!-- now insert the item value -->
        <xsl:value-of select="$item"/>
      </textarea>

    </xsl:otherwise>

  </xsl:choose>

</xsl:template> <!-- multiline -->




<!--
****************************************************************************************
* NOEDIT - create a display-only (non-editable) field
****************************************************************************************
-->
<xsl:template name="noedit">
  <xsl:param name="item"/>

  <xsl:value-of select="$item"/>

  <!-- check if field has error attribute set -->
  <xsl:if test="$item/@error">
    <br/><span class="error"><xsl:value-of select="$item/@error"/></span>
  </xsl:if>

</xsl:template> <!-- noedit -->




<!--
****************************************************************************************
* POPUP - create a text field for a foreign key that is populated from a popup screen
****************************************************************************************
-->
<xsl:template name="popup">
  <xsl:param name="item"/>      <!-- key pointing to foreign table -->
  <xsl:param name="noedit"/>    <!-- no edit, display only -->
  <xsl:param name="path"/>      <!-- the entity name -->
  <xsl:param name="position"/>  <!-- the row number -->
  <xsl:param name="multiple"/>    <!-- optional, causes position number to be added to item name -->

  <!-- this turns the value of the foreignfield attribute into a node set -->
  <xsl:variable name="foreign_field" select="//*[name()=$path][position()=$position]/*[name()=$item/@foreign_field]"/>

  <xsl:choose>

    <!-- if $mode is read/delete then field is read only (not editable) -->
    <!-- therefore popup button is not wanted -->
    <!-- also ignore if $popupname is not supplied, or 'noedit' switch is set -->
    <xsl:when test="$mode='list' or $mode='read' or $mode='delete'
                or ($mode='update' and $item/@pkey) or $noedit or $item/@noedit or not($item/@task_id)">
      <xsl:choose>
        <xsl:when test="$foreign_field">
          <!-- display the value of the field obtained from the foreign table -->
          <xsl:value-of select="$foreign_field"/>
        </xsl:when>
        <xsl:otherwise>
          <!-- display the value of the foreign key -->
          <xsl:value-of select="$item"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:when>

    <xsl:otherwise>

      <div class="popuptext">
        <!-- include this value in the POST array -->
        <input type="hidden" name="{name($item)}" value="{$item}" />
        <!-- display the value of the field from the foreign table -->
        <xsl:value-of select="$foreign_field"/>
      </div>

      <div class="popupbutton">
        <!-- create a popup button -->
        <input type="image" name="{$item/@task_id}" src="images/popup.gif" alt="Call popup form to obtain value" />
      </div>

    </xsl:otherwise>

  </xsl:choose>

</xsl:template> <!-- popup -->




<!--
****************************************************************************************
* RADIOGROUP - create a group of radio buttons
****************************************************************************************
-->
<xsl:template name="radiogroup">
  <xsl:param name="item"/>        <!-- the lookup value -->
  <xsl:param name="multiple"/>    <!-- optional, causes position number to be added to item name -->
  <xsl:param name="noedit"/>
  <xsl:param name="path"/>
  <xsl:param name="position"/>

  <!-- this turns the value of the optionlist attribute into a node set -->
  <xsl:variable name="optionlist" select="//*[name()=$item/@optionlist]"/>

  <!-- alignment is 'vertical' or 'horizontal' (default is 'horizontal') -->
  <xsl:variable name="align" select="substring($item/@align,1,1)"/>

  <xsl:choose>

    <xsl:when test="$mode='list' or $mode='read' or $mode='delete' or $item/@noedit or $noedit or ($mode='update' and $item/@pkey)">

      <!-- item is read only, so output as plain text -->

      <!-- look for an option where the id attribute equals the lookup value -->
      <xsl:variable name="option" select="$optionlist/*[@id=$item]" />

      <xsl:choose>
        <xsl:when test="$option">
          <!-- entry found, so use it -->
          <xsl:value-of select="$option"/>
        </xsl:when>
        <xsl:otherwise>
          <!-- entry not found, so default to lookup value -->
          <xsl:value-of select="$item"/>
        </xsl:otherwise>
      </xsl:choose>

    </xsl:when>

    <xsl:otherwise> <!-- field can be modified -->

      <!-- create an input statement for $item with a list of options -->
      <xsl:for-each select="$optionlist/*">

        <input class="radio" type="radio" >

          <xsl:attribute name="name">
            <xsl:choose>
              <!-- if 'multiple' is set then include row number in item name -->
              <xsl:when test="$multiple">
                <xsl:value-of select="concat(name($optionlist),'[',$position,']')"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="name($optionlist)"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>

          <xsl:attribute name="value"><xsl:value-of select="@id" /></xsl:attribute>

          <!-- use the 'id' attribute of the node as the 'value' attribute -->
          <xsl:if test="$item=@id">
            <!-- this option has been selected -->
            <xsl:attribute name="checked">checked</xsl:attribute>
          </xsl:if>

          <xsl:if test="$item=node()">
            <!-- this option has been selected (variation for ENUM fields) -->
            <xsl:attribute name="checked">checked</xsl:attribute>
          </xsl:if>

        </input>

        <!-- output the value of the current option -->
        <xsl:value-of select="node()"/>

        <!-- insert single space as a separator -->
        <xsl:text> </xsl:text>

        <xsl:if test="$align='v'">
          <!-- alignment is vertical, so insert line break after each option -->
          <br/>
        </xsl:if>

      </xsl:for-each>

    </xsl:otherwise>

  </xsl:choose>

</xsl:template> <!-- radiogroup -->



<!--
****************************************************************************************
* REPLACE - replace ne string with another
****************************************************************************************
-->
<xsl:template name="replace">
  <xsl:param name="text"/>
  <xsl:param name="replace"/>
  <xsl:param name="by"/>

  <xsl:choose>
    <xsl:when test="contains($text, $replace)">
      <xsl:value-of select="substring-before($text, $replace)"/>
      <xsl:value-of select="$by"/>
      <xsl:call-template name="replace">
        <xsl:with-param name="replace" select="$replace"/>
        <xsl:with-param name="by"      select="$by"/>
        <xsl:with-param name="text"    select="substring-after($text, $replace)"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="$text"/>
    </xsl:otherwise>
  </xsl:choose>

</xsl:template> <!-- REPLACE -->




<!--
****************************************************************************************
* SELECTBOX - create a checkbox so that the user can select this row
****************************************************************************************
-->
<xsl:template name="selectbox">
  <xsl:param name="path"/>
  <xsl:param name="position"/>

  <div class="center">

    <xsl:choose>
      <xsl:when test="$path"> <!-- use $path and $position -->

        <xsl:choose>

          <xsl:when test="$select_one">
            <input class="radio" type="radio" name="select" value="{$position}"/>
          </xsl:when>

          <xsl:otherwise>
            <!-- create a checkbox which allows the current row to be selected -->
            <input class="checkbox" type="checkbox" name="select[{$position}]" >
              <!-- look for a sibling element called 'selected' with a value of 'true' -->
              <xsl:choose>
              <xsl:when test="//*[name()=$path][position()=$position]/selected='T'">
                <xsl:attribute name="checked">checked</xsl:attribute>
              </xsl:when>
              <xsl:when test="//*[name()=$path][position()=$position]/selected='1'">
                <xsl:attribute name="checked">checked</xsl:attribute>
              </xsl:when>
              </xsl:choose>
            </input>
          </xsl:otherwise>

        </xsl:choose>

      </xsl:when>
      <xsl:otherwise> <!-- use current path and position() -->

        <xsl:choose>

          <xsl:when test="$select_one">
            <input class="radio" type="radio" name="select" value="{position()}"/>
          </xsl:when>

          <xsl:otherwise>
            <!-- create a checkbox which allows the current row to be selected -->
            <input class="checkbox" type="checkbox" name="select[{position()}]" >
              <xsl:if test="selected='T' or selected='1'">
                <!-- this is to be marked as selected in the initial display -->
                <xsl:attribute name="checked">checked</xsl:attribute>
              </xsl:if>
            </input>
          </xsl:otherwise>

        </xsl:choose>

      </xsl:otherwise>
    </xsl:choose>

  </div>

</xsl:template> <!-- selectbox -->



<!--
****************************************************************************************
* TEXTFIELD - create a text field in a form area
****************************************************************************************
-->
<xsl:template name="textfield">
  <xsl:param name="item"/>
  <xsl:param name="multiple"/>
  <xsl:param name="noedit"/>
  <xsl:param name="path"/>
  <xsl:param name="position"/>
  <xsl:param name="str-size"/>

  <xsl:choose>

    <xsl:when test="$mode='list' or $mode='read' or $mode='delete' or $item/@noedit or $noedit or ($mode='update' and $item/@pkey)">

      <!-- item is read only, so output value as plain text -->
      <xsl:value-of select="$item"/>

    </xsl:when>

    <xsl:otherwise> <!-- field can be modified -->

      <input>

        <xsl:choose>

          <!-- if 'multiple' indicator is set include position number -->
          <xsl:when test="$multiple">
            <xsl:attribute name="name">
              <xsl:value-of select="concat(name($item),'[',$position,']')"/>
            </xsl:attribute>
          </xsl:when>
          <xsl:otherwise> <!-- use item name without any position number -->
            <xsl:attribute name="name">
              <xsl:value-of select="name($item)"/>
            </xsl:attribute>
          </xsl:otherwise>

        </xsl:choose>

        <xsl:choose>

          <!-- set type to either 'password' or 'text' -->
          <xsl:when test="$item/@password">
            <xsl:attribute name="class">password</xsl:attribute>
            <xsl:attribute name="type">password</xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="class">text</xsl:attribute>
            <xsl:attribute name="type">text</xsl:attribute>
          </xsl:otherwise>

        </xsl:choose>

        <xsl:attribute name="value"><xsl:value-of select="$item"/></xsl:attribute>
        <xsl:attribute name="maxlength"><xsl:value-of select="$item/@size"/></xsl:attribute>

        <xsl:choose>

          <xsl:when test="$multiple">
            <xsl:choose>
              <xsl:when test="$str-size">
                <!-- use size specified in screen structure file -->
                <xsl:attribute name="size"><xsl:value-of select="$str-size"/></xsl:attribute>
              </xsl:when>
              <xsl:when test="$item/@size > 20">
                <!-- item size > 20, so reduce display area to 20 characters -->
                <xsl:attribute name="size">20</xsl:attribute>
              </xsl:when>
              <xsl:otherwise>
                <xsl:attribute name="size"><xsl:value-of select="$item/@size"/></xsl:attribute>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:when>
          <xsl:otherwise>
            <xsl:choose>
              <xsl:when test="$str-size">
                <!-- use size specified in screen structure file -->
                <xsl:attribute name="size"><xsl:value-of select="$str-size"/></xsl:attribute>
              </xsl:when>
              <xsl:when test="$item/@size > 80">
                <!-- item size > 80, so reduce display area to 80 characters -->
                <xsl:attribute name="size">80</xsl:attribute>
              </xsl:when>
              <xsl:otherwise>
                <xsl:attribute name="size"><xsl:value-of select="$item/@size"/></xsl:attribute>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:otherwise>

        </xsl:choose>

      </input>

    </xsl:otherwise>

  </xsl:choose>

</xsl:template>

</xsl:stylesheet>