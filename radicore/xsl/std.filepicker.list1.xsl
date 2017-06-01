<?xml version='1.0'?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--
//*****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2017 by Radicore Software Limited <http://www.radicore.org>
//*****************************************************************************
-->

<xsl:output method='html'
            indent="yes"
            omit-xml-declaration="yes"
            doctype-system="about:legacy-compat"
            encoding="UTF-8"
/>

<!-- include common templates -->
<xsl:include href="std.buttons.xsl"/>
<xsl:include href="std.column_hdg.xsl"/>
<xsl:include href="std.data_field.xsl"/>
<xsl:include href="std.head.xsl"/>
<xsl:include href="std.pagination.xsl"/>

<!-- get the name of the MAIN table, and other variables -->
<xsl:variable name="main" select="/root/structure/main/@id"/>
<xsl:variable name="numrows" select="count(/root/filepicker/file)"/>
  
<!-- image width and height may be defined in one of two places -->
<xsl:variable name="file_directory" select="/root/params/file_directory" />
<xsl:variable name="image_width">
  <xsl:choose>
    <xsl:when test="/root/params/image_width">
      <xsl:value-of select="/root/params/image_width" />  
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="/root/structure/main/row/cell/@imagewidth" />
    </xsl:otherwise>
  </xsl:choose>
</xsl:variable>
<xsl:variable name="image_height">
  <xsl:choose>
    <xsl:when test="/root/params/image_height">
      <xsl:value-of select="/root/params/image_height" />  
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="/root/structure/main/row/cell/@imageheight" />
    </xsl:otherwise>
  </xsl:choose>
</xsl:variable>

<xsl:template match="/"> <!-- standard match to include all child elements -->

  <html xml:lang="{/root/params/language}" lang="{/root/params/language}">

  <xsl:call-template name="head" />

  <body>
    <xsl:attribute name="class">
      <xsl:value-of select="/root/params/script_short" />
    </xsl:attribute>
    
    <xsl:call-template name="body-head" />
  
    <div class="universe">

      <!-- create help button -->
      <xsl:call-template name="help" />

      <!-- create menu buttons -->
      <xsl:call-template name="menubar" />

      <div class="body">
  
        <div class="title">
          <xsl:choose>
            <!-- identify whether this is with or without the 'quicksearch' option -->
            <xsl:when test="/root/lookup/quicksearch_field">
              <xsl:attribute name="class">title with_quicksearch</xsl:attribute>
              <xsl:call-template name="quicksearch">
                <xsl:with-param name="non_empty" select="'y'"/>
              </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
              <xsl:attribute name="class">title without_quicksearch</xsl:attribute>
            </xsl:otherwise>
          </xsl:choose>
          
          <h1 class="title"><xsl:value-of select="$title"/></h1>
        </div> <!-- title -->
        
        <form method="post" action="{$script}">
  
          <!-- create navigation buttons -->
          <xsl:call-template name="navbar">
            <xsl:with-param name="noshow"   select="/root/params/noshow"/>
            <xsl:with-param name="noselect" select="/root/params/noselect"/>
          </xsl:call-template>
  
          <div class="main">
            <!-- this is the actual data -->
            <table>
  
              <!-- set up column widths -->
              <xsl:call-template name="column_group">
                <xsl:with-param name="zone" select="'main'"/>
                <xsl:with-param name="count" select="'2'"/>
              </xsl:call-template>
  
              <thead>
                <!-- set up column headings -->
                <xsl:call-template name="column_headings">
                  <xsl:with-param name="zone"   select="'main'"/>
                  <xsl:with-param name="count"  select="'2'"/>
                  <xsl:with-param name="nosort" select="/root/params/nosort"/>
                </xsl:call-template>
              </thead>
  
              <tbody>
                <!-- process each non-empty row in the MAIN table of the XML file -->
                <!-- (note: odd and even numbered rows are processed differently) -->
                <xsl:for-each select="/root/filepicker[count(*)&gt;0]">
  
                  <!-- display all the fields in the current row -->
                  <xsl:call-template name="display_row">
                    <xsl:with-param name="zone" select="'main'"/>
                    <xsl:with-param name="data" select="." />
                    <xsl:with-param name="position" select="position()" />
                  </xsl:call-template>
  
                </xsl:for-each>
              </tbody>
  
            </table>
          </div>
  
          <!-- look for optional messages -->
          <xsl:call-template name="message"/>
  
          <!-- insert the page navigation links -->
          <xsl:call-template name="pagination" >
            <xsl:with-param name="object" select="'main'"/>
          </xsl:call-template>
  
          <!-- create standard action buttons -->
          <xsl:call-template name="actbar" />
  
        </form>
        
      </div> <!-- body -->

    </div> <!-- universe -->
  
    <xsl:call-template name="body-foot" />

  </body>
  </html>

</xsl:template>



<xsl:template name="display_row">
  <xsl:param name="zone"/>
  <xsl:param name="data"/>   <!-- data from current occurrence -->
  <xsl:param name="position"/>
  
  <xsl:if test="$position mod 2=1">  <!-- only process odd numbered rows -->
    
    <!-- set the row class to 'odd' or 'even' to determine the colour -->
    <tr>
      <xsl:attribute name="class">
        <xsl:choose>
          <xsl:when test="position()mod 2">odd</xsl:when>
          <xsl:otherwise>even</xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
  
      <!-- step through the fields defined in the STRUCTURE element (odd numbered rows) -->
      <xsl:for-each select="/root/structure/main/row/cell[@field]">
        
        <!-- get fieldname from the FIELD attribute -->
        <xsl:variable name="fieldname" select="string(@field)" />
        
        <!-- get value for this fieldname -->
        <xsl:variable name="fieldvalue">
          <xsl:choose>
            <xsl:when test="$fieldname='image'">
              <!-- replace 'image' value with 'file' value -->
              <xsl:value-of select="$data/*[name()='file']" />
            </xsl:when>
            <xsl:when test="$fieldname='video'">
              <!-- replace 'image' value with 'file' value -->
              <xsl:value-of select="$data/*[name()='file']" />
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="$data/*[name()=$fieldname]" />
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        
        <xsl:variable name="cellattr" select="/root/filepicker[position()=$position]/file[@*]" />
        
        <xsl:call-template name="display_file">
          <xsl:with-param name="fieldname"  select="$fieldname" />
          <xsl:with-param name="fieldvalue" select="$fieldvalue" />
          <xsl:with-param name="position"   select="$position" />
          <xsl:with-param name="cellattr"   select="$cellattr" />
        </xsl:call-template>
        
      </xsl:for-each>
  
      <!-- these table cells contain the data for 'even' numbered entries -->
      <xsl:choose>
  
        <!-- look for a sibling with same name as current node -->
        <xsl:when test="count(following-sibling::*[name()=name(current())])">
          
          <!-- extract following sibling into its own variable -->
          <xsl:variable name="next" select="following-sibling::*[name()=name(current())][1]" />
          
          <xsl:for-each select="/root/structure/main/row/cell[@field]">
            
            <!-- get fieldname from the FIELD attribute -->
            <xsl:variable name="fieldname" select="string(@field)" />
            <!-- get value for this fieldname -->
            <xsl:variable name="fieldvalue">
              <xsl:choose>
                <xsl:when test="$fieldname='image'">
                  <!-- replace 'image' value with 'file' value -->
                  <xsl:value-of select="$next/*[name()='file']" />
                </xsl:when>
                <xsl:when test="$fieldname='video'">
                  <!-- replace 'image' value with 'file' value -->
                  <xsl:value-of select="$next/*[name()='file']" />
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="$next/*[name()=$fieldname]" />
                </xsl:otherwise>
              </xsl:choose>
            </xsl:variable>
            
            <xsl:variable name="cellattr" select="/root/filepicker[position()=$position+1]/file[@*]" />
            
            <xsl:call-template name="display_file">
              <xsl:with-param name="fieldname"  select="$fieldname" />
              <xsl:with-param name="fieldvalue" select="$fieldvalue" />
              <xsl:with-param name="position"   select="$position+1" /> 
              <xsl:with-param name="cellattr"   select="$cellattr" />
            </xsl:call-template>
            
          </xsl:for-each>
          
        </xsl:when>
  
        <!-- there is nothing to follow, so create empty cells -->
        <xsl:otherwise>
          <xsl:for-each select="/root/structure/main/row/cell[@field]">
            <td></td>
          </xsl:for-each>
        </xsl:otherwise>
  
      </xsl:choose>
    </tr>
  </xsl:if>

</xsl:template>  <!-- display_row -->
  
<xsl:template name="display_file">
  <xsl:param name="fieldname"/>
  <xsl:param name="fieldvalue"/>
  <xsl:param name="position"/>
  <xsl:param name="cellattr"/>
  
  <td>
    <xsl:choose>
      <xsl:when test="$fieldname='selectbox'">
        <xsl:call-template name="selectbox">
          <xsl:with-param name="path" select="'filepicker'"/>
          <xsl:with-param name="position" select="$position"/>
        </xsl:call-template>
      </xsl:when>
      
      <xsl:when test="$fieldname='file'">
        <xsl:choose>
          <xsl:when test="/root/params/no_hyperlink">
            <!-- display file name as plain text, not a hyperlink -->
            <xsl:value-of select="$fieldvalue" />
          </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="link">
              <xsl:choose>
                <xsl:when test="/root/params/hyperlink_direct">
                  <!-- link directly to the file -->
                  <xsl:value-of select="concat($file_directory, '/', $fieldvalue)" />
                </xsl:when>
                <xsl:otherwise>
                  <!-- link to the download task -->
                  <xsl:value-of select="concat($script, '?', $session, '&amp;select=', $fieldvalue)" />
                </xsl:otherwise>
              </xsl:choose>
            </xsl:variable>
            <a href="{$link}"><b><xsl:value-of select="$fieldvalue" /></b></a>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      
      <xsl:when test="$fieldname='image'">
        <xsl:call-template name="icon">
          <xsl:with-param name="icon" select="$fieldvalue" />
          <xsl:with-param name="height" select="$image_height" />
          <xsl:with-param name="width" select="$image_width" />
          <xsl:with-param name="directory" select="$file_directory" />
        </xsl:call-template>
      </xsl:when>
      
      <xsl:when test="$fieldname='video'">
        <div class="picker-video">
          <video controls="controls">
            <xsl:attribute name="src"><xsl:value-of select="concat($file_directory, '/', $fieldvalue)"/></xsl:attribute>
            <xsl:attribute name="height"><xsl:value-of select="$image_height"/></xsl:attribute>
            <xsl:attribute name="width"><xsl:value-of select="$image_width"/></xsl:attribute>
            <xsl:if test="$cellattr/@preload">
              <xsl:attribute name="preload"><xsl:value-of select="$cellattr/@preload"/></xsl:attribute>
            </xsl:if>
          </video>
        </div>
      </xsl:when>
      
      <xsl:otherwise>
        <xsl:value-of select="$fieldvalue"/>
      </xsl:otherwise>
    </xsl:choose>
  </td>

</xsl:template>  <!-- display_file -->

</xsl:stylesheet>
