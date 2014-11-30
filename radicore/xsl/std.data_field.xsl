<?xml version='1.0'?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml">
  
<!--
//*****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2014 by Radicore Software Limited <http://www.radicore.org>
//*****************************************************************************
-->
  
<xsl:output method="xml" 
            indent="yes"
            encoding="UTF-8"
/>

<!-- this template is needed to get around a bug in Firefox -->
<xsl:include href="disable-output-escaping.xsl"/>

<xsl:variable name="select_one" select="/root/params/select_one"/>

<!-- display details horizontally -->
<xsl:template name="display_horizontal">
  <xsl:param name="zone"/>      <!-- could be 'main', 'inner', 'outer', etc -->
  <xsl:param name="currocc"/>   <!-- current occurrence -->
  <xsl:param name="multiple"/>  <!-- set this for more than one occurrence -->
  <xsl:param name="noedit"/>    <!-- 'noedit' flag for this zone -->

  <xsl:variable name="table" select="name()"/>          <!-- current table name -->
  <xsl:variable name="position" select="position()"/>   <!-- current row within table -->
  <xsl:variable name="noselect" select="@noselect"/>    <!-- 'noselect' flag for this occurrence -->

  <xsl:variable name="real_noedit">
    <xsl:choose>
      <xsl:when test="string-length($noedit) > 0">
        <xsl:value-of select="'y'"/>  <!-- 'noedit' flag for this zone -->
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="@noedit"/>  <!-- 'noedit' flag for this occurrence -->
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <tr>
    <!-- set the row class to 'odd' or 'even' to determine the colour -->
    <xsl:attribute name="class">
      <xsl:choose>
        <xsl:when test="position()mod 2">odd</xsl:when>
        <xsl:otherwise>even</xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>

    <!-- step through the fields defined in the STRUCTURE element -->
    <xsl:for-each select="/root/structure/*[name()=$zone]/row/cell[@field]">

      <!-- get fieldname from the FIELD attribute -->
      <xsl:variable name="fieldname" select="@field" />

      <!-- select the field (identified in STRUCTURE) from the current row of the specified table -->
      <xsl:variable name="field" select="$currocc/*[name()=$fieldname]" />
      
      <!-- make available the current structure/row/cell and its attributes -->
      <xsl:variable name="cellattr" select="." />
      
      <!-- find out if a class has been defined for this column -->
      <xsl:variable name="col_pos" select="position()" />
      <xsl:variable name="col_class" select="/root/structure/*[name()=$zone]/columns/column[position()=$col_pos]/@class" />
      
      <!-- there may be several classes, so combine them into a single list separate by spaces -->
      <xsl:variable name="class_list" select="normalize-space(concat($col_class, ' ',$cellattr/@class, ' ',$field/@css_class))" />
      
      <td>
        <xsl:if test="$class_list">
          <xsl:attribute name="class"><xsl:value-of select="$class_list"/></xsl:attribute>
        </xsl:if>
        
        <xsl:choose>
          <xsl:when test="$cellattr/@class or $field/@css_class">
            <!-- surround field data in a <div> for the specified css class(es) -->
            <div>
              
              <xsl:attribute name="class"><xsl:value-of select="$class_list"/></xsl:attribute>
              
              <!-- process the named field from the current row -->
              <xsl:call-template name="datafield">
                <xsl:with-param name="item"     select="$field"/>
                <xsl:with-param name="itemname" select="$fieldname"/>
                <xsl:with-param name="path"     select="$table"/>
                <xsl:with-param name="multiple" select="$multiple"/>
                <xsl:with-param name="position" select="$position"/>
                <xsl:with-param name="noedit"   select="$real_noedit"/>
                <xsl:with-param name="noselect" select="$noselect"/>
                <xsl:with-param name="cellattr" select="$cellattr"/>
              </xsl:call-template>
              
            </div>
          </xsl:when>

          <xsl:otherwise>
            <!-- process the named field from the current row (withut enclosing in a <div>) -->
            <xsl:call-template name="datafield">
              <xsl:with-param name="item"     select="$field"/>
              <xsl:with-param name="itemname" select="$fieldname"/>
              <xsl:with-param name="path"     select="$table"/>
              <xsl:with-param name="multiple" select="$multiple"/>
              <xsl:with-param name="position" select="$position"/>
              <xsl:with-param name="noedit"   select="$real_noedit"/>
              <xsl:with-param name="noselect" select="$noselect"/>
              <xsl:with-param name="cellattr" select="$cellattr"/>
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>

      </td>

    </xsl:for-each>
  </tr>

</xsl:template> <!-- display_horizontal -->




<!-- display details vertically -->
<!-- multi-column version, with each cell containing either a label or a value -->
<xsl:template name="display_vertical">
  <xsl:param name="zone"/>    <!-- could be 'main', 'inner', 'outer', etc -->
  <xsl:param name="noedit"/>  <!-- 'noedit' flag for this zone -->

  <xsl:variable name="table" select="name()"/>          <!-- current table name -->
  <xsl:variable name="table_row" select="position()"/>  <!-- current row within table -->

  <xsl:variable name="real_noedit">
    <xsl:choose>
      <xsl:when test="string-length($noedit) > 0">
        <xsl:value-of select="'y'"/>  <!-- 'noedit' flag for this zone -->
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="@noedit"/>  <!-- 'noedit' flag for this occurrence -->
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <!-- output column settings -->
  <xsl:call-template name="column_group">
    <xsl:with-param name="zone" select="$zone"/>
  </xsl:call-template>

  <!-- step through each row/item defined in the STRUCTURE element -->
  <xsl:for-each select="/root/structure/*[name()=$zone]/row">

    <xsl:variable name="struct_row" select="position()"/>   <!-- current row number -->
    
    <!-- build a node-set of field names to be processed for this row -->
    <xsl:variable name="fieldnames" select="cell[@field]/@field"/>

    <!-- build a node-set of field names which are NULL or BLANK -->
    <xsl:variable name="blankfields" select="cell[@field='null' or @field='blank']"/>

    <!-- build a node-set of fields which have the NODISPLAY attribute set -->
    <xsl:variable name="nodisplay" select="cell[@nodisplay]"/>

    <!-- build a node-set of fields which have the DISPLAY-EMPTY attribute set -->
    <xsl:variable name="display-empty" select="cell[@display-empty]"/>

    <!-- build a node-set of field names which actually exist as data elements -->
    <xsl:variable name="fieldsfound" select="//*[name()=$table][position()=$table_row]/*[name()=$fieldnames]"/>

    <!-- build a node-set of fields which have the NODISPLAY attribute set -->
    <xsl:variable name="nodisplay2" select="$fieldsfound[@nodisplay]"/>

    <xsl:choose>
      <xsl:when test="count($fieldsfound) &lt;= (count($nodisplay) + count($nodisplay2))
                  and not(count($blankfields) &gt; 0)
                  and not($display-empty)">
        <!-- all the fields in this row have the NODISPLAY attribute set, so do not output anything -->
      </xsl:when>

      <xsl:otherwise>

        <xsl:call-template name="display_vertical_row">
          <xsl:with-param name="zone"       select="$zone"/>
          <xsl:with-param name="table"      select="$table"/>
          <xsl:with-param name="table_row"  select="$table_row"/>
          <xsl:with-param name="struct_row" select="$struct_row"/>
          <xsl:with-param name="noedit"     select="$real_noedit"/>
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

    <!-- step through the cells (both label and field) defined in the STRUCTURE element for the current ROW -->
    <xsl:for-each select="/root/structure/*[name()=$zone]/row[position()=$struct_row]/cell">
      
      <!-- make available the current structure/row/cell and its attributes -->
      <xsl:variable name="cellattr" select="."/>

      <td>

        <!-- look for optional attributes -->
        <xsl:if test="@class">
          <xsl:attribute name="class"><xsl:value-of select="@class" /></xsl:attribute>
        </xsl:if>
        <xsl:if test="@colspan">
          <xsl:attribute name="colspan"><xsl:value-of select="@colspan" /></xsl:attribute>
        </xsl:if>
        <xsl:if test="@rowspan">
          <xsl:attribute name="rowspan"><xsl:value-of select="@rowspan" /></xsl:attribute>
        </xsl:if>
        <xsl:if test="@align">
          <xsl:attribute name="align"><xsl:value-of select="@align" /></xsl:attribute>
        </xsl:if>
        <xsl:if test="@valign">
          <xsl:attribute name="valign"><xsl:value-of select="@valign" /></xsl:attribute>
        </xsl:if>

        <xsl:choose>
          <xsl:when test="@label">
            <!-- get fieldname from the FIELD attribute of the following sibling -->
            <xsl:variable name="fieldname" select="string(following-sibling::*[1]/@field)" />

            <!-- find out if the following sibling has the 'nodisplay' attribute set -->
            <xsl:variable name="nodisplay" select="string(following-sibling::*[1]/@nodisplay)" />

            <!-- obtain the value for this field from the current row of the specified table -->
            <xsl:variable name="fieldvalue" select="//*[name()=$table][position()=$table_row]/*[name()=$fieldname]" />

            <xsl:choose>
              <!-- do nothing unless the field is actually present in the XML file -->
              <!-- and it does not have the @nodisplay attribute set -->
              <xsl:when test="$fieldvalue and not($fieldvalue/@nodisplay) and not($nodisplay)">

                <xsl:if test="not(@class)">
                  <!-- set default classname for this label cell -->
                  <xsl:attribute name="class">label</xsl:attribute>
                </xsl:if>

                <xsl:choose>
                  <!-- insert indicator if field is required -->
                  <xsl:when test="$mode='insert' and ($fieldvalue/@pkey or $fieldvalue/@required)">
                    <span class="required">* </span>
                  </xsl:when>
                  <xsl:when test="$mode='search' and $fieldvalue/@required">
                    <span class="required">* </span>
                  </xsl:when>
                  <xsl:when test="$mode='update' and $fieldvalue/@required and not($fieldvalue/@pkey) and not($noedit='y')">
                    <span class="required">* </span>
                  </xsl:when>
                </xsl:choose>

                <xsl:value-of select="@label"/> <!-- output the value for the label -->

              </xsl:when>

              <xsl:otherwise>
                <xsl:choose>
                  <xsl:when test="$fieldname='blank' or $fieldname='null' or $fieldvalue/@nodisplay or $nodisplay">
                    <xsl:text></xsl:text> <!-- insert nothing -->
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:text>&#160;</xsl:text> <!-- insert non-breaking space -->
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:otherwise>

            </xsl:choose>

          </xsl:when>

          <xsl:otherwise>
            <!-- get fieldname from the FIELD attribute -->
            <xsl:variable name="fieldname" select="@field" />

            <!-- obtain the value for this field from the current row of the specified table -->
            <xsl:variable name="fieldvalue" select="//*[name()=$table][position()=$table_row]/*[name()=$fieldname]" />

           <xsl:if test="@class or $fieldvalue/@css_class">
             <!-- look for optional 'class' attribute in two places --> 
              <xsl:choose>
                <xsl:when test="@class and $fieldvalue/@css_class">
                  <xsl:attribute name="class"><xsl:value-of select="concat(@class,' ',$fieldvalue/@css_class)"/></xsl:attribute>
                </xsl:when>
                <xsl:when test="$fieldvalue/@css_class">
                  <xsl:attribute name="class"><xsl:value-of select="$fieldvalue/@css_class"/></xsl:attribute>
                </xsl:when>
                <xsl:when test="@class">
                  <xsl:attribute name="class"><xsl:value-of select="@class"/></xsl:attribute>
                </xsl:when>
              </xsl:choose>
            </xsl:if>
            
            <xsl:choose>
              <xsl:when test="($fieldname='blank' or $fieldname='null') and string-length(@label) = 0">
                <!-- this field is intentionally BLANK/NULL -->
                <xsl:text></xsl:text> <!-- insert nothing -->
              </xsl:when>

              <xsl:when test="$fieldvalue and not($fieldvalue/@nodisplay) and not(@nodisplay)">
                <!-- field is present in the XML file and does not have the @nodisplay attribute set, so display it -->

                <!-- process the named field from the current row -->
                <xsl:call-template name="datafield">
                  <xsl:with-param name="item"     select="$fieldvalue"/>
                  <xsl:with-param name="itemname" select="$fieldname"/>
                  <xsl:with-param name="path"     select="$table"/>
                  <xsl:with-param name="position" select="$table_row"/>
                  <xsl:with-param name="noedit"   select="$noedit"/>
                  <xsl:with-param name="cellattr" select="$cellattr"/>
                  
                </xsl:call-template>

              </xsl:when>

              <xsl:otherwise>
                <xsl:choose>
                  <xsl:when test="$fieldname='blank' or $fieldname='null' or $fieldvalue/@nodisplay">
                    <xsl:text></xsl:text> <!-- insert nothing -->
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:text>&#160;</xsl:text> <!-- insert non-breaking space -->
                  </xsl:otherwise>
                </xsl:choose>
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
// 'hidden' - included in POST, but not shown
// 'button' - display a submit button
// 'checkbox' - checkbox with a Yes/No option
// 'checkbox_multi' - multiple checkboxes
// 'radiogroup' - radio buttons populated from an option list
// 'dropdown' - a pulldown/dropdown display populated from an option list
// 'multidrop' - a dropdown which allows multiple selections
// 'popup' - a picklist which is another screen
// 'filepicker' - a text field for a file name that is populated from a file picker
// 'hyperlink' - display a hyperlink
// 'multiline' - a multiline text box
// 'quicksearch' - a quicksearch dropdown and textbox
//
-->

<xsl:template name="datafield">
  <xsl:param name="item"/>       <!-- the item value -->
  <xsl:param name="itemname"/>   <!-- the item name -->
  <xsl:param name="noedit"/>     <!-- no edit, display only -->
  <xsl:param name="path"/>       <!-- the entity name -->
  <xsl:param name="multiple"/>   <!-- set this for more than one occurrence -->
  <xsl:param name="position"/>   <!-- the row number -->
  <xsl:param name="noselect"/>   <!-- if set do not add 'select' column -->
  <xsl:param name="cellattr"/>   <!-- structure/row/cell atttributes -->

  <xsl:choose>

    <xsl:when test="$itemname='selectbox'">
      <xsl:if test="not($noselect)">
        <!-- insert a checkbox to make selections -->
        <xsl:call-template name="selectbox">
          <xsl:with-param name="path" select="$path"/>
          <xsl:with-param name="position" select="$position"/>
        </xsl:call-template>
      </xsl:if>
    </xsl:when>

    <xsl:otherwise>

      <!-- do nothing unless the item is present -->
      <xsl:if test="$item">

        <xsl:choose>

          <xsl:when test="$item/@nodisplay">
            <!-- 'nodisplay' attribute set, so display nothing -->
            <xsl:text> </xsl:text>
          </xsl:when>

          <xsl:when test="$item/@control='hidden'">
            <!-- this is a hidden field -->
            <xsl:call-template name="hidden">
              <xsl:with-param name="item" select="$item"/>
              <xsl:with-param name="multiple" select="$multiple"/>
              <xsl:with-param name="position" select="$position"/>
            </xsl:call-template>
          </xsl:when>
          
          <xsl:when test="$item/@control='button'">
            <!-- this is a hidden field -->
            <xsl:call-template name="button">
              <xsl:with-param name="item" select="$item"/>
              <xsl:with-param name="multiple" select="$multiple"/>
              <xsl:with-param name="position" select="$position"/>
            </xsl:call-template>
          </xsl:when>

          <xsl:when test="$item/@control='checkbox'">
            <xsl:choose>
              <xsl:when test="$mode='search'">
                <!-- make this a radio group to give 3 options - ON,OFF,UNDEFINED -->
                <xsl:call-template name="radiogroup">
                  <xsl:with-param name="item"     select="$item"/>
                  <xsl:with-param name="noedit"   select="$noedit"/>
                  <xsl:with-param name="multiple" select="$multiple"/>
                  <xsl:with-param name="position" select="$position"/>
                </xsl:call-template>
              </xsl:when>
              <xsl:otherwise>
                <xsl:call-template name="checkbox">
                  <xsl:with-param name="item"     select="$item"/>
                  <xsl:with-param name="noedit"   select="$noedit"/>
                  <xsl:with-param name="multiple" select="$multiple"/>
                  <xsl:with-param name="position" select="$position"/>
                </xsl:call-template>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:when>

          <xsl:when test="$item/@control='checkbox_multi'">
            <xsl:choose>
              <xsl:when test="$mode='search'">
                <!-- make this a radio group to give 3 options - ON,OFF,UNDEFINED -->
                <xsl:call-template name="radiogroup">
                  <xsl:with-param name="item"     select="$item"/>
                  <xsl:with-param name="noedit"   select="$noedit"/>
                  <xsl:with-param name="multiple" select="$multiple"/>
                  <xsl:with-param name="position" select="$position"/>
                </xsl:call-template>
              </xsl:when>
              <xsl:otherwise>
                <xsl:call-template name="checkbox_multi">
                  <xsl:with-param name="item"     select="$item"/>
                  <xsl:with-param name="noedit"   select="$noedit"/>
                  <xsl:with-param name="multiple" select="$multiple"/>
                  <xsl:with-param name="position" select="$position"/>
                </xsl:call-template>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:when>

          <xsl:when test="$item/@control='dropdown'">
            <xsl:call-template name="dropdown">
              <xsl:with-param name="item"     select="$item"/>
              <xsl:with-param name="noedit"   select="$noedit"/>
              <xsl:with-param name="multiple" select="$multiple"/>
              <xsl:with-param name="position" select="$position"/>
            </xsl:call-template>
          </xsl:when>

          <xsl:when test="$item/@control='multidrop'">
            <xsl:call-template name="multidrop">
              <xsl:with-param name="item"     select="$item"/>
              <xsl:with-param name="noedit"   select="$noedit"/>
              <xsl:with-param name="multiple" select="$multiple"/>
              <xsl:with-param name="position" select="$position"/>
            </xsl:call-template>
          </xsl:when>

          <xsl:when test="$item/@control='filepicker'">
            <xsl:call-template name="filepicker">
              <xsl:with-param name="item"     select="$item"/>
              <xsl:with-param name="noedit"   select="$noedit"/>
              <xsl:with-param name="multiple" select="$multiple"/>
              <xsl:with-param name="position" select="$position"/>
              <xsl:with-param name="cellattr" select="$cellattr"/>
            </xsl:call-template>
          </xsl:when>

          <xsl:when test="$item/@control='multiline'">
            <xsl:call-template name="multiline">
              <xsl:with-param name="item"     select="$item"/>
              <xsl:with-param name="noedit"   select="$noedit"/>
              <xsl:with-param name="multiple" select="$multiple"/>
              <xsl:with-param name="position" select="$position"/>
              <xsl:with-param name="cellattr" select="$cellattr"/>
            </xsl:call-template>
          </xsl:when>

          <xsl:when test="$item/@control='popup'">
            <xsl:call-template name="popup">
              <xsl:with-param name="item"     select="$item"/>
              <xsl:with-param name="noedit"   select="$noedit"/>
              <xsl:with-param name="path"     select="$path"/>
              <xsl:with-param name="multiple" select="$multiple"/>
              <xsl:with-param name="position" select="$position"/>
              <xsl:with-param name="cellattr" select="$cellattr"/>
            </xsl:call-template>
          </xsl:when>

          <xsl:when test="$item/@control='radiogroup'">
            <xsl:call-template name="radiogroup">
              <xsl:with-param name="item"     select="$item"/>
              <xsl:with-param name="noedit"   select="$noedit"/>
              <xsl:with-param name="multiple" select="$multiple"/>
              <xsl:with-param name="position" select="$position"/>
            </xsl:call-template>
          </xsl:when>

          <xsl:when test="$item/@control='hyperlink'">
            <xsl:choose>
              <xsl:when test="not($item/@noedit) and ($mode='insert' or $mode='update' or $mode='search')">
                <!-- change this into a modifiable text field -->
                <xsl:call-template name="textfield">
                  <xsl:with-param name="item"     select="$item"/>
                  <xsl:with-param name="noedit"   select="$noedit"/>
                  <xsl:with-param name="multiple" select="$multiple"/>
                  <xsl:with-param name="position" select="$position"/>
                  <xsl:with-param name="cellattr"    select="$cellattr"/>
                </xsl:call-template>
              </xsl:when>
              
              <xsl:otherwise>
                <xsl:choose>
                  <xsl:when test="$item/array">
                    <!-- display this as an array of hyperlinks -->
                    <xsl:for-each select="$item/array">
                      <xsl:call-template name="hyperlink">
                        <xsl:with-param name="item" select="."/>
                      </xsl:call-template>
                      <xsl:text>&#160; </xsl:text> <!-- insert two spaces as a separator -->
                    </xsl:for-each>
                  </xsl:when>
                  <xsl:otherwise>
                    <!-- display this as a single hyperlink -->
                    <xsl:call-template name="hyperlink">
                      <xsl:with-param name="item" select="$item"/>
                    </xsl:call-template>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:when>
          
          <xsl:when test="$item/@control='image'">
              <!-- display this as an image -->
              <xsl:call-template name="image">
                <xsl:with-param name="item"     select="$item"/>
                <xsl:with-param name="cellattr" select="$cellattr"/>
              </xsl:call-template>
          </xsl:when>
          
          <xsl:when test="$item/@control='image_hyperlink'">
            <!-- display this as a hyperlink around an image -->
            <xsl:call-template name="hyperlink">
              <xsl:with-param name="item"        select="$item"/>
              <xsl:with-param name="cellattr"    select="$cellattr"/>
            </xsl:call-template>
          </xsl:when>

          <xsl:otherwise> <!-- this is the default control type -->
            <xsl:call-template name="textfield">
              <xsl:with-param name="item"     select="$item"/>
              <xsl:with-param name="noedit"   select="$noedit"/>
              <xsl:with-param name="multiple" select="$multiple"/>
              <xsl:with-param name="position" select="$position"/>
              <xsl:with-param name="cellattr" select="$cellattr"/>
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
* BUTTON - create a submit button
****************************************************************************************
-->
<xsl:template name="button">
  <xsl:param name="item"/>
  <xsl:param name="multiple"/>    <!-- optional, causes position number to be added to item name -->
  <xsl:param name="position"/>    <!-- the row number -->
  
  <xsl:variable name="name">
    <xsl:choose>
      <!-- if 'multiple' indicator is set then include position number -->
      <xsl:when test="$multiple">
        <xsl:value-of select="concat($item/@id,'[',$position,']')"/>
      </xsl:when>
      <xsl:otherwise> <!-- use item name without any position number -->
        <xsl:value-of select="$item/@id"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  
  <input class="button" name="{$name}" id="{$name}" value="{$item}" >
    
    <xsl:choose>
      <xsl:when test="$item/@subtype">
        <xsl:attribute name="type">
          <xsl:value-of select="$item/@subtype"/> <!-- may be set to 'button' -->
        </xsl:attribute>
      </xsl:when>
      <xsl:otherwise>
        <xsl:attribute name="type">submit</xsl:attribute> <!-- default is 'submit' -->
      </xsl:otherwise>
    </xsl:choose>
    
    <xsl:call-template name="scripting_events">
      <!-- insert any scripting events which have been defined -->
      <xsl:with-param name="item" select="$item"/>
    </xsl:call-template>
    
  </input>
  
</xsl:template> <!-- button -->
  
  
  
<!--
****************************************************************************************
* CHECKBOX - create a single checkbox
****************************************************************************************
-->
<xsl:template name="checkbox">
  <xsl:param name="item"/>        <!-- the item name -->
  <xsl:param name="noedit"/>      <!-- optional, control is read-only -->
  <xsl:param name="multiple"/>    <!-- optional, causes position number to be added to item name -->
  <xsl:param name="position"/>    <!-- the row number -->

  <!-- text alignment is 'left' or 'right' (default is 'right') -->
  <xsl:variable name="align_lr" select="substring($item/@align_lr,1,1)" />

  <!--  if 'multiple' is set then include row number in item name -->
  <xsl:variable name="name">
    <xsl:choose>
      <xsl:when test="$multiple">
        <xsl:value-of select="concat(name($item),'[',$position,']')" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="name($item)" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:if test="$item/@javascript">
    <!-- output any javascript before the control -->
    <script language="javascript">
      <!--<xsl:value-of select="$item/@javascript" disable-output-escaping="yes"/>-->
      <xsl:call-template name="disable-output-escaping">
        <xsl:with-param name="string" select="$item/@javascript" />
      </xsl:call-template>
    </script>
  </xsl:if>

  <span class="checkbox">

    <xsl:if test="not($mode='list' or $mode='read' or $mode='delete' or $item/@noedit or $noedit='y')">
      <!-- create hidden field to send back OFF setting -->
      <!-- as checkbox control does not appear in POST array unless it is checked ON -->
      <input type="hidden" name="{$name}" value="0" />
    </xsl:if>
  
    <label>
      
      <xsl:if test="$item/@class">
        <!-- this entry has a 'class' attribute, so add it to the output stream -->
        <xsl:attribute name="class"><xsl:value-of select="$item/@class" /></xsl:attribute>
      </xsl:if>
      
      <xsl:if test="$align_lr='l'"> <!-- put label on the left -->
        <xsl:value-of select="$item/@label"/>
      </xsl:if>
  
      <!-- create a checkbox control -->
      <input type="checkbox" name="{$name}" id="{$name}">
  
        <xsl:if test="$item='T' or $item='Y' or $item='1'">
          <!-- this is to be marked as selected in the initial display -->
          <xsl:attribute name="checked">checked</xsl:attribute>
        </xsl:if>
  
        <xsl:if test="$mode='list' or $mode='read' or $mode='delete'
                   or $item/@noedit or $noedit='y'">
          <xsl:attribute name="disabled">disabled</xsl:attribute>
        </xsl:if>
  
        <xsl:call-template name="scripting_events">
          <!-- insert any scripting events which have been defined -->
          <xsl:with-param name="item" select="$item"/>
        </xsl:call-template>
  
      </input>
  
      <xsl:if test="not($align_lr='l')"> <!-- put label on the right -->
        <xsl:value-of select="$item/@label"/>
      </xsl:if>
      
    </label>

  </span>

</xsl:template> <!-- checkbox -->



<!--
****************************************************************************************
* CHECKBOX_MULTI - create multiple checkboxes (similar to a multi-choice dropdown)
****************************************************************************************
-->
<xsl:template name="checkbox_multi">
  <xsl:param name="item"/>        <!-- the item name -->
  <xsl:param name="noedit"/>      <!-- optional, control is read-only -->
  <xsl:param name="multiple"/>    <!-- optional, causes position number to be added to item name -->
  <xsl:param name="position"/>    <!-- the row number -->

  <!-- if optionlist name ends in '[]' change it to '.n' where 'n' is the row number -->
  <xsl:variable name="name1" select="string($item/@optionlist)"/>
  <xsl:variable name="name2">
    <xsl:choose>
      <xsl:when test="substring($name1, string-length($name1)-1) = '[]'">
        <xsl:value-of select="concat(substring($name1, 1, string-length($name1)-2),'.', $position -1)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$name1"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <!-- this turns the value of the optionlist attribute into a node set -->
  <xsl:variable name="optionlist" select="/root/lookup/*[name()=$name2]"/>

  <!-- alignment is 'vertical' or 'horizontal' (default is 'horizontal') -->
  <xsl:variable name="align_hv" select="substring($item/@align_hv,1,1)"/>

  <!-- text alignment is 'left' or 'right' (default is 'right') -->
  <xsl:variable name="align_lr" select="substring($item/@align_lr,1,1)" />

  <!--  if 'multiple' is set then include row number in item name -->
  <xsl:variable name="name">
    <xsl:choose>
      <xsl:when test="$multiple">
        <xsl:value-of select="concat(name($item),'[',$position,']')" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="name($item)" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:if test="$item/@javascript">
    <!-- output any javascript before the control -->
    <script language="javascript">
      <!--<xsl:value-of select="$item/@javascript" disable-output-escaping="yes"/>-->
      <xsl:call-template name="disable-output-escaping">
        <xsl:with-param name="string" select="$item/@javascript" />
      </xsl:call-template>
    </script>
  </xsl:if>

  <!-- create an input statement for $item with a list of options -->
  <xsl:for-each select="$optionlist/option">

    <span class="checkbox">

      <!-- ignore entries which have a blank description -->
      <xsl:if test="string-length(normalize-space(node())) > 0">

        <!-- construct name as name[value] so that each element has a unique name -->
        <xsl:variable name="name3" select="concat($name, '[', @key, ']')"/>

        <xsl:if test="not($mode='list' or $mode='read' or $mode='delete' or $item/@noedit or $noedit='y')">
          <!-- create hidden field to send back OFF setting -->
          <!-- as checkbox control does not appear in POST array unless it is checked ON -->
          <input type="hidden" name="{$name3}" value="0" />
        </xsl:if>

        <label>
          
          <xsl:if test="@class">
            <!-- this entry has a 'class' attribute, so add it to the output stream -->
            <xsl:attribute name="class"><xsl:value-of select="@class" /></xsl:attribute>
          </xsl:if>
          
           <xsl:if test="$align_lr='l'">  <!--  put label on the left -->
              <!-- output the value of the current option -->
              <xsl:value-of select="node()"/>
           </xsl:if>

          <input type="checkbox" name="{$name3}" id="{$name3}">
   
             <xsl:variable name="key" select="@key"/>
   
             <xsl:attribute name="value"><xsl:value-of select="@key" /></xsl:attribute>
   
             <xsl:if test="//*[name()=name($item)]/array[@value=$key]">
               <!-- this option has been selected -->
               <xsl:attribute name="checked">checked</xsl:attribute>
             </xsl:if>
   
             <xsl:if test="$mode='list' or $mode='read' or $mode='delete'
                        or $item/@noedit or $noedit='y'">
               <xsl:attribute name="disabled">disabled</xsl:attribute>
             </xsl:if>
   
             <xsl:call-template name="scripting_events">
               <!-- insert any scripting events which have been defined -->
               <xsl:with-param name="item" select="$optionlist/option[@key=$key]"/>
             </xsl:call-template>
   
           </input>
   
           <xsl:if test="not($align_lr='l')">  <!--  put label on the right -->
             <!-- output the value of the current option -->
             <xsl:value-of select="node()"/>
           </xsl:if>
          
        </label>

        <!-- insert single space as a separator -->
        <xsl:text> </xsl:text>

        <xsl:if test="$align_hv='v'">
          <!-- alignment is vertical, so insert line break after each option -->
          <br/>
        </xsl:if>

      </xsl:if>

    </span>

  </xsl:for-each>

</xsl:template> <!-- checkbox_multi -->



<!--
****************************************************************************************
* DROPDOWN - create a dropdown list of items
****************************************************************************************
-->
<xsl:template name="dropdown">
  <xsl:param name="item"/>        <!-- the lookup value -->
  <xsl:param name="noedit"/>      <!-- optional, control is read-only -->
  <xsl:param name="multiple"/>    <!-- optional, causes position number to be added to item name -->
  <xsl:param name="position"/>    <!-- the row number -->

  <!-- if optionlist name ends in '[]' change it to '.n' where 'n' is the row number -->
  <xsl:variable name="name1" select="string($item/@optionlist)"/>
  <xsl:variable name="name2">
    <xsl:choose>
      <xsl:when test="substring($name1, string-length($name1)-1) = '[]'">
        <xsl:value-of select="concat(substring($name1, 1, string-length($name1)-2),'.', $position -1)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$name1"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <!-- this turns the value of the optionlist attribute into a node set -->
  <xsl:variable name="optionlist" select="/root/lookup/*[name()=$name2]"/>

  <xsl:choose>

    <xsl:when test="$mode='list' or $mode='read' or $mode='delete' or ($mode='update' and $item/@pkey)
                 or $item/@noedit or $noedit='y'">

      <!-- item is read only, so output as plain text -->

      <!-- look for an option where the key attribute equals the lookup value -->
      <xsl:variable name="option" select="$optionlist/option[@key=$item]" />
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

      <xsl:if test="$item/@javascript">
        <!-- output any javascript before the control -->
        <script language="javascript">
          <!--<xsl:value-of select="$item/@javascript" disable-output-escaping="yes"/>-->
          <xsl:call-template name="disable-output-escaping">
            <xsl:with-param name="string" select="$item/@javascript" />
          </xsl:call-template>
        </script>
      </xsl:if>

      <xsl:variable name="name">
        <xsl:choose>
          <!-- if 'multiple' is set then include row number in item name -->
          <xsl:when test="$multiple">
            <xsl:value-of select="concat(name($item),'[',$position,']')"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="name($item)"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>

      <!-- create a select statement for $item with a list of options -->
      <select class="dropdown" name="{$name}" id="{$name}">

        <xsl:if test="$item/@rows">
          <!-- identify how many rows are to be displayed -->
          <xsl:attribute name="size"><xsl:value-of select="$item/@rows"/></xsl:attribute>
        </xsl:if>

        <xsl:call-template name="scripting_events">
          <!-- insert any scripting events which have been defined -->
          <xsl:with-param name="item" select="$item"/>
        </xsl:call-template>

        <xsl:for-each select="$optionlist/option">

          <!-- use the 'key' attribute of the node as the 'value' attribute of 'option' -->
          <xsl:variable name="key" select="@key"/>

          <option value="{@key}" >

            <xsl:call-template name="scripting_events">
              <!-- insert any scripting events which have been defined -->
              <xsl:with-param name="item" select="$optionlist/option[@key=$key]"/>
            </xsl:call-template>
            
            <xsl:if test="@class">
              <!-- this entry has a 'class' attribute, so add it to the output stream -->
              <xsl:attribute name="class"><xsl:value-of select="@class"/></xsl:attribute>
            </xsl:if>

            <xsl:choose>
              <xsl:when test="$item=@key">
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
  <xsl:param name="noedit"/>    <!-- optional, control is read-only -->
  <xsl:param name="multiple"/>  <!-- optional, causes position number to be added to item name -->
  <xsl:param name="position"/>  <!-- the row number -->
  <xsl:param name="cellattr"/>  <!-- structure/row/cell attributes -->

  <xsl:choose>

    <xsl:when test="$mode='list' or $mode='read' or $mode='delete'
                 or $noedit='y' or not($item/@task_id)">
      <!-- if $mode is read/delete then field is read only (not editable) -->
      <!-- therefore picker button is not wanted -->
      <!-- also ignore if $filepicker is not supplied -->

      <!-- display the image -->
      <div class="picker-image">
        <xsl:call-template name="image">
          <xsl:with-param name="item"     select="$item"/>
          <xsl:with-param name="cellattr" select="$cellattr"/>
        </xsl:call-template>
      </div>

      <xsl:if test="not($item/@notext)">
        <!-- display the file name -->
        <div class="picker-text">
          <xsl:value-of select="$item"/>
        </div>
      </xsl:if>

    </xsl:when>

    <xsl:otherwise>

      <!-- display the image -->
      <div class="picker-image">
        <xsl:call-template name="image">
          <xsl:with-param name="item"     select="$item"/>
          <xsl:with-param name="cellattr" select="$cellattr"/>
        </xsl:call-template>
      </div>

      <xsl:if test="not($item/@notext)">
        <!-- display current value in a text box -->
        <div class="picker-text">
          <xsl:call-template name="textfield">
            <xsl:with-param name="item"     select="$item"/>
            <xsl:with-param name="multiple" select="$multiple"/>
            <xsl:with-param name="position" select="$position"/>
            <xsl:with-param name="cellattr" select="$cellattr"/>
          </xsl:call-template>
        </div>
      </xsl:if>

      <!-- create a picker button -->
      <div class="picker-button">
        <input type="image" src="{$imagedir}popup.gif" alt="Call picker form to obtain file name" >
          <xsl:attribute name="name">
            <xsl:choose>
              <!-- if 'multiple' indicator is set include position number -->
              <xsl:when test="$multiple">
                <xsl:value-of select="concat($item/@task_id,'[',$position,']')"/>
              </xsl:when>
              <xsl:otherwise> <!-- use item name without any position number -->
                <xsl:value-of select="$item/@task_id"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>
        </input>
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
  <xsl:param name="multiple"/>
  <xsl:param name="position"/>
  
  <!--  if 'multiple' is set then include row number in item name -->
  <xsl:variable name="name">
    <xsl:choose>
      <xsl:when test="$multiple">
        <xsl:value-of select="concat(name($item),'[',$position,']')" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="name($item)" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <!-- include in POST array, but make it invisible -->
  <input type="hidden" name="{$name}" value="{$item}" />

  <xsl:if test="$item/@visible">
    <!-- override to show this as a non-editable field -->
    <xsl:value-of select="$item"/>
  </xsl:if>
  
  <!-- check if field has error attribute set -->
  <xsl:if test="$item/@error">
    <br/><span class="error"><xsl:value-of select="$item/@error"/></span>
  </xsl:if>

</xsl:template> <!-- hidden -->



<!--
****************************************************************************************
* HYPERLINK - create a hyperlink, either as text or for an image
****************************************************************************************
-->
<xsl:template name="hyperlink">
  <xsl:param name="item"/>
  <xsl:param name="cellattr"/>      <!-- structure/row/cell attributes -->

  <xsl:if test="string-length(normalize-space($item)) > 0">
    <xsl:choose>
      <xsl:when test="$item/@image">
        <!-- create a hyperlink around an image -->
        <a href="{$item}">
          <xsl:call-template name="image">
            <xsl:with-param name="item"     select="$item"/>
            <xsl:with-param name="cellattr" select="$cellattr"/>
          </xsl:call-template>
        </a>
      </xsl:when>
      <xsl:otherwise>
        <!-- create a standard hyperlink -->
        <xsl:choose>
          <xsl:when test="$item/@url">
            <!-- a separate URL has been supplied, so use this as the HREF -->
            <a href="{$item/@url}"><xsl:value-of select="$item"/></a>
          </xsl:when>
          <xsl:otherwise>
            <!-- href and description are the same -->
            <a href="{$item}"><xsl:value-of select="$item"/></a>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
      </xsl:choose>
  </xsl:if>

</xsl:template> <!-- hyperlink -->
  
  
  
<!--
****************************************************************************************
* ICON - display an image
****************************************************************************************
-->
<xsl:template name="icon">
  <xsl:param name="icon"/>
  <xsl:param name="width"/>
  <xsl:param name="height"/>
  <xsl:param name="directory"/>

  <!-- if entry is non-blank show it as an image -->
  <xsl:if test="$icon">
    <xsl:variable name="filename">
      <xsl:choose>
        <xsl:when test="$directory">
          <xsl:value-of select="concat($directory, '/', $icon)"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$icon"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <div class="center">
      <img src="{$filename}" alt="{$icon}" title="{$icon}">
        <!-- height and width are optional -->
        <xsl:if test="$height > 0">
          <xsl:attribute name="height"><xsl:value-of select="$height"/></xsl:attribute>
        </xsl:if>
        <xsl:if test="$width > 0">
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
  <xsl:param name="cellattr"/>  <!-- structure/row/cell attributes -->

  <xsl:if test="string-length($item)">
    <xsl:if test="$item/@control='image' or $item/@image">
      
      <xsl:variable name="imageheight">
        <xsl:choose>
          <xsl:when test="$cellattr and $cellattr/@imageheight > 0">
            <!-- use specified value from the cell attributes -->
            <xsl:value-of select="$cellattr/@imageheight"/>
          </xsl:when>
          <xsl:when test="$item/@imageheight > 0">
            <!-- use specified value from the item attributes -->
            <xsl:value-of select="$item/@imageheight"/>
          </xsl:when>
          <xsl:otherwise>100</xsl:otherwise>  <!-- default value -->
        </xsl:choose>
      </xsl:variable>
      
      <xsl:variable name="imagewidth">
        <xsl:choose>
          <xsl:when test="$cellattr and $cellattr/@imagewidth > 0">
            <!-- use specified value from the cell attributes -->
            <xsl:value-of select="$cellattr/@imagewidth"/>
          </xsl:when>
          <xsl:when test="$item/@imagewidth > 0">
            <!-- use specified value from the item attributes -->
            <xsl:value-of select="$item/@imagewidth"/>
          </xsl:when>
          <xsl:otherwise>100</xsl:otherwise>  <!-- default value -->
        </xsl:choose>
      </xsl:variable>
      
      <xsl:variable name="alt">
        <xsl:choose>
          <xsl:when test="$item/@alt">
            <!-- use specified value from the item attributes -->
            <xsl:value-of select="$item/@alt"/>
          </xsl:when>
          <xsl:otherwise>
            <!-- default to image name -->
            <xsl:value-of select="$item"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      
      <xsl:variable name="border">
        <xsl:choose>
          <xsl:when test="$cellattr and $cellattr/@border">
            <!-- use specified value from the cell attributes -->
            <xsl:value-of select="$cellattr/@border"/>
          </xsl:when>
          <xsl:when test="$item/@border">
            <!-- use specified value from the item attributes -->
            <xsl:value-of select="$item/@border"/>
          </xsl:when>
          <!--<xsl:otherwise>0</xsl:otherwise>-->  <!-- default value -->
        </xsl:choose>
      </xsl:variable>

      <!-- display file as image -->
      <img>
        <xsl:attribute name="src"><xsl:value-of select="$item"/></xsl:attribute>
        <xsl:attribute name="alt"><xsl:value-of select="$alt"/></xsl:attribute>
        <xsl:attribute name="title"><xsl:value-of select="$alt"/></xsl:attribute>
        <xsl:attribute name="height"><xsl:value-of select="$imageheight"/></xsl:attribute>
        <xsl:attribute name="width"><xsl:value-of select="$imagewidth"/></xsl:attribute>
        <xsl:if test="$border>0">
          <xsl:attribute name="border"><xsl:value-of select="$border"/></xsl:attribute>
        </xsl:if>
      </img>
      <!--<xsl:text>&#160;</xsl:text>--> <!-- insert non-breaking space -->

    </xsl:if>
  </xsl:if>

</xsl:template> <!-- IMAGE -->




<!--
****************************************************************************************
* MESSAGE - output zero or more message lines
****************************************************************************************
-->
<xsl:template name="message">

  <xsl:if test="/root/infomsg/*">
    <div class="infomsg">
      <xsl:for-each select="/root/infomsg/line">
        <p><xsl:value-of select="node()"/></p>
      </xsl:for-each>
    </div>
  </xsl:if>

  <xsl:if test="/root/errmsg/*">
    <div class="errmsg">
      <xsl:for-each select="/root/errmsg/line">
        <p><xsl:value-of select="node()"/></p>
      </xsl:for-each>
    </div>
  </xsl:if>

</xsl:template> <!-- MESSAGE -->



<!--
****************************************************************************************
* MULTIDROP - create a dropdown list of items, with multiple selections
****************************************************************************************
-->
<xsl:template name="multidrop">
  <xsl:param name="item"/>        <!-- the item name -->
  <xsl:param name="noedit"/>      <!-- optional, control is read-only -->
  <xsl:param name="multiple"/>    <!-- optional, causes position number to be added to item name -->
  <xsl:param name="position"/>    <!-- the row number -->

  <!-- if optionlist name ends in '[]' change it to '.n' where 'n' is the row number -->
  <xsl:variable name="name1" select="string($item/@optionlist)"/>
  <xsl:variable name="name2">
    <xsl:choose>
      <xsl:when test="substring($name1, string-length($name1)-1) = '[]'">
        <xsl:value-of select="concat(substring($name1, 1, string-length($name1)-2),'.', $position -1)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$name1"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <!-- this turns the value of the optionlist attribute into a node set -->
  <xsl:variable name="optionlist" select="/root/lookup/*[name()=$name2]"/>

  <xsl:choose>

    <xsl:when test="$mode='list' or $mode='read' or $mode='delete' or ($mode='update' and $item/@pkey)
                 or $item/@noedit or $noedit='y'">
      <!-- field cannot be amended, so output selected items as a simple string -->

      <xsl:for-each select="//*[name()=name($item)]/array">
        <!-- use the 'value' attribute of the node as the 'value' attribute of 'option' -->
        <xsl:variable name="value" select="@value"/>

        <xsl:if test="$optionlist/option[@key=$value]">
          <!-- option found in optionlist, so output its value -->
          <xsl:value-of select="$optionlist/option[@key=$value]"/>
          <xsl:if test="not(position()=last())">
            <xsl:text>, </xsl:text> <!-- not the last entry, so append a comma -->
          </xsl:if>
        </xsl:if>

      </xsl:for-each>

    </xsl:when>

    <xsl:otherwise>

      <xsl:if test="$item/@javascript">
        <!-- output any javascript before the control -->
        <script language="javascript">
          <!--<xsl:value-of select="$item/@javascript" disable-output-escaping="yes"/>-->
          <xsl:call-template name="disable-output-escaping">
            <xsl:with-param name="string" select="$item/@javascript" />
          </xsl:call-template>
        </script>
      </xsl:if>

      <xsl:variable name="name">
        <xsl:choose>
          <!-- if 'multiple' is set then include row number in item name -->
          <xsl:when test="$multiple">
            <xsl:value-of select="concat(name($item),'[',$position,']')"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="name($item)"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>

      <!-- create hidden field to send back empty selection -->
      <!-- as options do not appear in POST array unless they have been selected -->
      <input type="hidden" name="{$name}" value="" />

      <!-- create a select statement for $item with a list of options -->
      <select class="dropdown" name="{$name}[]" multiple="multiple">

        <xsl:if test="$item/@rows">
          <!-- identify how many rows are to be displayed -->
          <xsl:attribute name="size"><xsl:value-of select="$item/@rows"/></xsl:attribute>
        </xsl:if>

        <xsl:call-template name="scripting_events">
          <!-- insert any scripting events which have been defined -->
          <xsl:with-param name="item" select="$item"/>
        </xsl:call-template>

        <xsl:for-each select="$optionlist/option">

          <!-- use the 'key' attribute of the node as the 'value' attribute of 'option' -->
          <xsl:variable name="key" select="@key"/>

          <option value="{$key}" >

            <xsl:call-template name="scripting_events">
            <!-- insert any scripting events which have been defined -->
              <xsl:with-param name="item" select="$optionlist/option[@key=$key]"/>
            </xsl:call-template>
            
            <xsl:if test="@class">
              <!-- this entry has a 'class' attribute, so add it to the output stream -->
              <xsl:attribute name="class"><xsl:value-of select="@class"/></xsl:attribute>
            </xsl:if>

            <xsl:if test="//*[name()=name($item)]/array[@value=$key]">
              <!-- this option has been selected -->
              <xsl:attribute name="selected">selected</xsl:attribute>
            </xsl:if>

            <!-- output the value of the current option -->
            <xsl:value-of select="node()"/>
          </option>
        </xsl:for-each>

      </select>
    </xsl:otherwise>
  </xsl:choose>

</xsl:template> <!-- multidrop -->



<!--
****************************************************************************************
* MULTILINE - create a multiline field in a form area
****************************************************************************************
-->
<xsl:template name="multiline">
  <xsl:param name="item"/>        <!-- the item name -->
  <xsl:param name="noedit"/>      <!-- optional, control is read-only -->
  <xsl:param name="multiple"/>    <!-- optional, causes position number to be added to item name -->
  <xsl:param name="position"/>    <!-- the row number -->
  <xsl:param name="cellattr"/>    <!-- structure/row/cell attributes -->

  <xsl:variable name="cols">
    <xsl:choose>
      <xsl:when test="$cellattr/@cols">
        <xsl:value-of select="$cellattr/@cols"/>  <!-- use value from cell attributes -->
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$item/@cols"/>  <!-- use value from item attributes -->
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  
  <xsl:variable name="rows">
    <xsl:choose>
      <xsl:when test="$cellattr/@rows">
        <xsl:value-of select="$cellattr/@rows"/>  <!-- use value from cell attributes -->
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$item/@rows"/>  <!-- use value from item attributes -->
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  
  <xsl:choose>

    <xsl:when test="$mode='search'">
      <!-- use a normal input box instead of a multiline textarea -->
      <input class="text" type="text" name="{name($item)}" value="{$item}" size="{$cols}"/>
    </xsl:when>

    <xsl:otherwise>

      <xsl:if test="$item/@javascript">
        <!-- output any javascript before the control -->
        <script language="javascript">
          <!--<xsl:value-of select="$item/@javascript" disable-output-escaping="yes"/>-->
          <xsl:call-template name="disable-output-escaping">
            <xsl:with-param name="string" select="$item/@javascript" />
          </xsl:call-template>
        </script>
      </xsl:if>

      <xsl:choose>
        <xsl:when test="$item/@hidecontrol">
          <input type="hidden" name="{name($item)}" value="{$item}" />
        </xsl:when>
        
        <xsl:when test="$item/@CDATA">
          <!-- output as pre-formatted text without escaping '<' and '>' characters -->
          <!--<xsl:value-of select="$item" disable-output-escaping="yes"/>-->
          <xsl:call-template name="disable-output-escaping">
            <xsl:with-param name="string" select="$item" />
          </xsl:call-template>
          
        </xsl:when>

        <xsl:otherwise>
          <xsl:variable name="name">
            <xsl:choose>
              <!-- if 'multiple' is set then include row number in item name -->
              <xsl:when test="$multiple">
                <xsl:value-of select="concat(name($item),'[',$position,']')"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="name($item)"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:variable>

          <!-- create multiline field to allow data to be input or amended -->
          <textarea>
            
            <xsl:if test="$item/@css_class">
              <xsl:attribute name="class"><xsl:value-of select="$item/@css_class" /></xsl:attribute>
            </xsl:if>
            <xsl:attribute name="name"><xsl:value-of select="$name"/></xsl:attribute>
            <xsl:attribute name="id">  <xsl:value-of select="$name"/></xsl:attribute>
            <xsl:attribute name="rows"><xsl:value-of select="$rows"/></xsl:attribute>
            <xsl:attribute name="cols"><xsl:value-of select="$cols"/></xsl:attribute>

            <!-- under certain conditions set this field to read only -->
            <xsl:if test="$mode='list' or $mode='read' or $mode='delete'
                       or $item/@noedit or $noedit='y'">
              <xsl:attribute name="readonly">readonly</xsl:attribute>
            </xsl:if>

            <xsl:call-template name="scripting_events">
              <!-- insert any scripting events which have been defined -->
              <xsl:with-param name="item" select="$item"/>
            </xsl:call-template>

            <!-- now insert the item value -->
            <xsl:value-of select="$item"/>

          </textarea>
        </xsl:otherwise>

      </xsl:choose>

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
  <xsl:param name="multiple"/>  <!-- optional, causes position number to be added to item name -->
  <xsl:param name="position"/>  <!-- the row number -->
  <xsl:param name="cellattr"/>  <!-- structure/row/cell attributes -->

  <!-- this turns the value of the foreignfield attribute into a node set -->
  <xsl:variable name="foreign_field" select="//*[name()=$path][position()=$position]/*[name()=$item/@foreign_field]"/>

  <xsl:choose>

    <!-- if $mode is read/delete then field is read only (not editable) -->
    <!-- therefore popup button is not wanted -->
    <!-- also ignore if $popupname is not supplied, or 'noedit' switch is set -->
    <xsl:when test="$mode='list' or $mode='read' or $mode='delete' or ($mode='update' and $item/@pkey)
                or $noedit='y' or $item/@noedit or not($item/@task_id)">
      <xsl:choose>
        <xsl:when test="$foreign_field  and not(name($foreign_field)=name($item))">
          <!-- display the value of the field obtained from the foreign table -->
          <xsl:value-of select="$foreign_field"/>
          <!--<xsl:call-template name="replace">
            <xsl:with-param name="text" select="$foreign_field"/>
            <xsl:with-param name="replace" select="'&amp;nbsp;'"/>
            <xsl:with-param name="by" select="'&#160;'"/>
          </xsl:call-template>-->
        </xsl:when>
        <xsl:otherwise>
          <!-- display the value of the foreign key -->
          <xsl:value-of select="$item"/>
          <!--<xsl:call-template name="replace">
            <xsl:with-param name="text" select="$item"/>
            <xsl:with-param name="replace" select="'&amp;nbsp;'"/>
            <xsl:with-param name="by" select="'&#160;'"/>
          </xsl:call-template>-->
        </xsl:otherwise>
      </xsl:choose>
    </xsl:when>

    <xsl:otherwise>

      <div class="popuptext">
        <xsl:if test="$mode='search'">
          <!-- include this value in the POST array -->
          <input type="hidden" name="{name($item)}" value="{$item}" />
        </xsl:if>

        <xsl:variable name="popupvalue">
          <xsl:choose>
            <xsl:when test="string-length($foreign_field) > 0">
              <!-- use the value of the field obtained from the foreign table -->
              <xsl:value-of select="$foreign_field"/>
              <!--<xsl:call-template name="replace">
                <xsl:with-param name="text" select="$foreign_field"/>
                <xsl:with-param name="replace" select="'&amp;nbsp;'"/>
                <xsl:with-param name="by" select="'&#160;'"/>
              </xsl:call-template>-->
            </xsl:when>
            <xsl:otherwise>
              <!-- use the value of the foreign key -->
              <xsl:value-of select="$item"/>
              <!--<xsl:call-template name="replace">
                <xsl:with-param name="text" select="$item"/>
                <xsl:with-param name="replace" select="'&amp;nbsp;'"/>
                <xsl:with-param name="by" select="'&#160;'"/>
              </xsl:call-template>-->
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>

        <xsl:choose>
          <xsl:when test="$item/@allow_input">
            <!-- allow the foreign key to be input -->
            <input type="text" name="{name($item)}" value="{$popupvalue}">
              <xsl:choose>
                <xsl:when test="$cellattr/@size">
                  <!-- use size specified in screen structure file -->
                  <xsl:attribute name="size"><xsl:value-of select="$cellattr/@size"/></xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:attribute name="size"><xsl:value-of select="$item/@size"/></xsl:attribute>
                </xsl:otherwise>
              </xsl:choose>
            </input>
          </xsl:when>
          <xsl:otherwise>
            <!-- display the value of the foreign key -->
            <xsl:value-of select="$popupvalue"/>
          </xsl:otherwise>
        </xsl:choose>
      </div>

      <div class="popupbutton">
        <!-- create a popup button -->
        <input type="image" src="{$imagedir}popup.gif" alt="Call popup form to obtain value" >
          <xsl:attribute name="name">
            <xsl:choose>
              <!-- if 'multiple' indicator is set include position number -->
              <xsl:when test="$multiple">
                <xsl:value-of select="concat($item/@task_id,'[',$position,']')"/>
              </xsl:when>
              <xsl:otherwise> <!-- use item name without any position number -->
                <xsl:value-of select="$item/@task_id"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>
        </input>
      </div>

    </xsl:otherwise>

  </xsl:choose>

</xsl:template> <!-- popup -->




<!--
****************************************************************************************
* QUICKSEARCH - create a dropdown list and textbox for the 'quicksearch' option
****************************************************************************************
-->
<xsl:template name="quicksearch">
  
  <div class="quicksearch">
    <form method="post" action="{$script}">
      <div>
        <!-- add a dropdown list for the selectable field names -->
        <select class="dropdown" name="quicksearch_field">
          <xsl:for-each select="/root/lookup/quicksearch_field/option">
            <option value="{@key}" >
              <xsl:if test="@key=/root/params/quicksearch_default">
                <xsl:attribute name="selected">selected</xsl:attribute>
              </xsl:if>
              <xsl:value-of select="node()"/>
            </option>
          </xsl:for-each>
        </select>
        <!-- add a text box and a submit button to fire the search-->
        <input name="quicksearch_value" type="text" value="" size="20" />
        <input class="submit" type="submit" name="quicksearch" value="{/root/params/text/quick-search}" />
        <!-- create a hidden field for session_name -->
        <xsl:if test="$session_name">
          <input type="hidden" name="session_name" value="{$session_name}" />
        </xsl:if>
      </div>
    </form>
  </div> <!-- quicksearch -->
  
</xsl:template> <!-- quicksearch -->
  
  
<!--
****************************************************************************************
* RADIOGROUP - create a group of radio buttons
****************************************************************************************
-->
<xsl:template name="radiogroup">
  <xsl:param name="item"/>        <!-- the item name -->
  <xsl:param name="noedit"/>      <!-- optional, control is read-only -->
  <xsl:param name="multiple"/>    <!-- optional, causes position number to be added to item name -->
  <xsl:param name="position"/>    <!-- the row number -->

  <!-- if optionlist name ends in '[]' change it to '.n' where 'n' is the row number -->
  <xsl:variable name="name1" select="string($item/@optionlist)"/>
  <xsl:variable name="name2">
    <xsl:choose>
      <xsl:when test="substring($name1, string-length($name1)-1) = '[]'">
        <xsl:value-of select="concat(substring($name1, 1, string-length($name1)-2),'.', $position -1)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$name1"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <!-- this turns the value of the optionlist attribute into a node set -->
  <xsl:variable name="optionlist" select="/root/lookup/*[name()=$name2]"/>

  <!-- alignment is 'vertical' or 'horizontal' (default is 'horizontal') -->
  <xsl:variable name="align_hv" select="substring($item/@align_hv,1,1)"/>

  <!-- text alignment is 'left' or 'right' (default is 'right') -->
  <xsl:variable name="align_lr" select="substring($item/@align_lr,1,1)" />

  <xsl:choose>

    <xsl:when test="$mode='list' or $mode='read' or $mode='delete' or ($mode='update' and $item/@pkey)
                 or $item/@noedit or $noedit='y'">

      <!-- item is read only, so output as plain text -->

      <!-- look for an option where the key attribute equals the lookup value -->
      <xsl:variable name="option" select="$optionlist/*[@key=$item]" />

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

      <span class="radio">
        
        <xsl:if test="$item/@javascript">
          <!-- output any javascript before the control -->
          <script language="javascript">
            <!--<xsl:value-of select="$item/@javascript" disable-output-escaping="yes"/>-->
            <xsl:call-template name="disable-output-escaping">
              <xsl:with-param name="string" select="$item/@javascript" />
            </xsl:call-template>
          </script>
        </xsl:if>
  
        <!-- create an input statement for $item with a list of options -->
        <xsl:for-each select="$optionlist/option">
  
          <!-- ignore entries which have a blank description -->
          <xsl:if test="string-length(normalize-space(node())) > 0">

            <xsl:variable name="name">
              <xsl:choose>
                <!-- if 'multiple' is set then include row number in item name -->
                <xsl:when test="$multiple">
                  <xsl:value-of select="concat(name($item),'[',$position,']')"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="name($item)"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:variable>
            
            <xsl:if test="$mode='search' and $item/@label and position()=1">
              <!-- this is a checkbox that has been turned into a radiogroup for a search screen, -->
              <!-- and it has a label, so display it to the left of the first radio button -->
              <xsl:value-of select="$item/@label"/>:&#160;
              <xsl:if test="$align_hv='v'">
                <br/> <!-- alignment is vertical, so insert line break after each option -->
              </xsl:if>
            </xsl:if>

            <label>
              
              <xsl:if test="@class">
                <!-- this entry has a 'class' attribute, so add it to the output stream -->
                <xsl:attribute name="class"><xsl:value-of select="@class" /></xsl:attribute>
              </xsl:if>
              
              <xsl:if test="$align_lr='l'">  <!--  put label on the left -->
                 <xsl:value-of select="node()"/>
              </xsl:if>
  
              <input type="radio" name="{$name}" id="{$name}">
  
                <xsl:variable name="key" select="@key"/>
  
                <xsl:attribute name="value"><xsl:value-of select="@key" /></xsl:attribute>
  
                <xsl:call-template name="scripting_events">
                  <!-- insert any scripting events which have been defined -->
                  <xsl:with-param name="item" select="$optionlist/option[@key=$key]"/>
                </xsl:call-template>
  
                <!-- use the 'key' attribute of the node as the 'value' attribute -->
                <xsl:if test="$item=@key">
                  <!-- this option has been selected -->
                  <xsl:attribute name="checked">checked</xsl:attribute>
                </xsl:if>
  
                <xsl:if test="$item=node()">
                  <!-- this option has been selected (variation for ENUM fields) -->
                  <xsl:attribute name="checked">checked</xsl:attribute>
                </xsl:if>
  
              </input>
  
              <xsl:if test="not($align_lr='l')">  <!--  put label on the right -->
                <xsl:value-of select="node()"/>
              </xsl:if>
              
            </label>

            <!-- insert single space as a separator -->
            <xsl:text> </xsl:text>

            <xsl:if test="$align_hv='v'">
              <!-- alignment is vertical, so insert line break after each option -->
              <br/>
            </xsl:if>
  
          </xsl:if>
  
        </xsl:for-each>
      
      </span>

    </xsl:otherwise>

  </xsl:choose>

</xsl:template> <!-- radiogroup -->



<!--
****************************************************************************************
* REPLACE - replace one string with another
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
* SCRIPTING_EVENTS - common HTML scripting events
****************************************************************************************
-->
<xsl:template name="scripting_events">
  <xsl:param name="item"/>

    <!-- copy all attributes containing scripting events to the output document -->
    <xsl:for-each select="$item/@onfocus|$item/@onblur|$item/@onselect|$item/@onchange
                         |$item/@onclick|$item/@ondblclick|$item/@onmousedown|$item/@onmouseup
                         |$item/@onmouseover|$item/@onmusemove|$item/@onmouseout
                         |$item/@onkeypress|$item/@onkydown|$item/@onkeyup|$item/@show">
    <xsl:copy-of select="." />
  </xsl:for-each>

</xsl:template>




<!--
****************************************************************************************
* SELECTBOX - create a checkbox so that the user can select this row
****************************************************************************************
-->
<xsl:template name="selectbox">
  <xsl:param name="path"/>
  <xsl:param name="position"/>

  <div class="checkbox center">

    <xsl:choose>
      <xsl:when test="$path"> <!-- use $path and $position -->

        <input>
          <xsl:choose>

            <xsl:when test="$select_one">
              <!-- create a radio button which allows a single row to be selected -->
              <xsl:attribute name="class">radio</xsl:attribute>
              <xsl:attribute name="type">radio</xsl:attribute>
              <xsl:attribute name="name">select</xsl:attribute>
              <xsl:attribute name="value">
                <xsl:value-of select="$position"/>
              </xsl:attribute>

            </xsl:when>

            <xsl:otherwise>
              <!-- create a checkbox which allows several rows to be selected -->
              <xsl:attribute name="type">checkbox</xsl:attribute>
              <xsl:attribute name="name">
                <xsl:value-of select="concat('select','[',$position,']')"/>
              </xsl:attribute>

            </xsl:otherwise>

          </xsl:choose>

          <!-- look for a sibling element called 'selected' with a value of 'true' -->
          <xsl:variable name="selected" select="//*[name()=$path][position()=$position]/selected" />

          <xsl:if test="$selected='T' or $selected='1'">
            <xsl:attribute name="checked">checked</xsl:attribute>
          </xsl:if>

        </input>

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
  <xsl:param name="item"/>        <!-- the item name -->
  <xsl:param name="noedit"/>      <!-- optional, control is read-only -->
  <xsl:param name="multiple"/>    <!-- optional, causes position number to be added to item name -->
  <xsl:param name="position"/>    <!-- the row number -->
  <xsl:param name="cellattr"/>    <!-- structure/row/cell attributes -->

  <xsl:choose>

    <xsl:when test="$mode='list' or $mode='read' or $mode='delete' or ($mode='update' and $item/@pkey)
                 or $item/@noedit or $noedit='y'">

      <xsl:choose>
        <xsl:when test="$item/@CDATA">
          <!-- output as pre-formatted text without escaping '<' and '>' characters -->
          <pre>
            <xsl:if test="$item/@css_class">
              <xsl:attribute name="class"><xsl:value-of select="$item/@css_class"/></xsl:attribute>
            </xsl:if>
            <!--<xsl:value-of select="$item" disable-output-escaping="yes"/>-->
            <xsl:call-template name="disable-output-escaping">
              <xsl:with-param name="string" select="$item" />
            </xsl:call-template>
          </pre>
        </xsl:when>
        <xsl:otherwise>
          <!-- item is read only, so output value as plain text -->
          <xsl:value-of select="$item"/>
        </xsl:otherwise>
      </xsl:choose>

    </xsl:when>

    <xsl:otherwise> <!-- field can be modified -->

      <xsl:if test="$item/@javascript">
        <!-- output any javascript before the control -->
        <script language="javascript">
          <!--<xsl:value-of select="$item/@javascript" disable-output-escaping="yes"/>-->
          <xsl:call-template name="disable-output-escaping">
            <xsl:with-param name="string" select="$item/@javascript" />
          </xsl:call-template>
        </script>
      </xsl:if>
      
      <xsl:variable name="name">
        <xsl:choose>
          <!-- if 'multiple' indicator is set then include position number -->
          <xsl:when test="$multiple">
            <xsl:value-of select="concat(name($item),'[',$position,']')"/>
          </xsl:when>
          <xsl:otherwise> <!-- use item name without any position number -->
            <xsl:value-of select="name($item)"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>

      <input name="{$name}" id="{$name}">

        <xsl:choose>

          <!-- set type to either 'password' or 'text' -->
          <xsl:when test="$item/@password">
            <xsl:attribute name="class">password</xsl:attribute>
            <xsl:attribute name="type">password</xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:choose>
              <xsl:when test="$cellattr/@class">
                <!-- combine standard class and custom class -->
                <xsl:attribute name="class"><xsl:value-of select="concat('text ',$cellattr/@class)"/></xsl:attribute>
              </xsl:when>
              <xsl:otherwise>
                <xsl:attribute name="class">text</xsl:attribute>
              </xsl:otherwise>
            </xsl:choose>
            
            <xsl:attribute name="type">text</xsl:attribute>
          </xsl:otherwise>

        </xsl:choose>

        <xsl:attribute name="value">
          <xsl:value-of select="$item"/>
        </xsl:attribute>

        <xsl:if test="not($mode='search')">
          <xsl:attribute name="maxlength"><xsl:value-of select="$item/@size"/></xsl:attribute>
        </xsl:if>

        <xsl:choose>

          <xsl:when test="$multiple">
            <xsl:choose>
              <xsl:when test="$cellattr/@size">
                <!-- use size specified in screen structure file -->
                <xsl:attribute name="size"><xsl:value-of select="$cellattr/@size"/></xsl:attribute>
              </xsl:when>
              <xsl:otherwise>
                <xsl:attribute name="size"><xsl:value-of select="$item/@size"/></xsl:attribute>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:when>
          <xsl:otherwise>
            <xsl:choose>
              <xsl:when test="$cellattr/@size">
                <!-- use size specified in screen structure file -->
                <xsl:attribute name="size"><xsl:value-of select="$cellattr/@size"/></xsl:attribute>
              </xsl:when>
              <xsl:when test="$item/@size > 70">
                <!-- item size > 70, so reduce display area to 70 characters -->
                <xsl:attribute name="size">70</xsl:attribute>
              </xsl:when>
              <xsl:otherwise>
                <xsl:attribute name="size"><xsl:value-of select="$item/@size"/></xsl:attribute>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:otherwise>

        </xsl:choose>

        <xsl:call-template name="scripting_events">
          <!-- insert any scripting events which have been defined -->
          <xsl:with-param name="item" select="$item"/>
        </xsl:call-template>

      </input>

      <!-- look for a hyperlink containing scripting events -->
      <xsl:if test="$item/@href_label or $item/@href_image">
        <a>
          <xsl:choose>
            <xsl:when test="$item/@href_link">
              <xsl:attribute name="href"><xsl:value-of select="$item/@href_link" /></xsl:attribute>
            </xsl:when>
            <xsl:otherwise>
              <xsl:attribute name="href">#</xsl:attribute>
            </xsl:otherwise>
          </xsl:choose>

          <xsl:if test="$item/@href_onclick">
            <xsl:attribute name="onclick" ><xsl:value-of select="$item/@href_onclick" /></xsl:attribute>
          </xsl:if>

          <xsl:if test="$item/@href_name">
            <xsl:attribute name="name" ><xsl:value-of select="$item/@href_name" /></xsl:attribute>
          </xsl:if>
          <xsl:if test="$item/@href_id">
            <xsl:attribute name="id" ><xsl:value-of select="$item/@href_id" /></xsl:attribute>
          </xsl:if>

          <xsl:choose>
            <xsl:when test="$item/@href_image">
              <!-- insert a clickable image -->
              <img>
                <xsl:attribute name="src"><xsl:value-of select="$item/@href_image"/></xsl:attribute>
                <xsl:attribute name="alt"><xsl:value-of select="$item/@href_image"/></xsl:attribute>
                <!--<xsl:attribute name="border">0</xsl:attribute>-->
              </img>
            </xsl:when>
            <xsl:otherwise>
              <!-- insert clickable text -->
              <xsl:value-of select="$item/@href_label"/>
            </xsl:otherwise>
          </xsl:choose>
        </a>
      </xsl:if>

    </xsl:otherwise>

  </xsl:choose>

</xsl:template>

</xsl:stylesheet>
