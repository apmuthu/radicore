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

<xsl:variable name="start_time"  select="/root/params/start_time"/>
<xsl:variable name="end_time"    select="/root/params/end_time"/>
<xsl:variable name="last_day_no" select="/root/params/last_day_no"/>

<!-- include common templates -->
<xsl:include href="std.buttons.xsl"/>
<xsl:include href="std.column_hdg.xsl"/>
<xsl:include href="std.data_field.xsl"/>
<xsl:include href="std.head.xsl"/>
<xsl:include href="std.pagination.xsl"/>

<!-- get the name of the OUTER and INNER tables -->
<xsl:variable name="outer" select="/root/structure/outer/@id"/>
<xsl:variable name="inner" select="/root/structure/inner/@id"/>
<xsl:variable name="numrows" select="/root/pagination/page[@id='inner']/@numrows"/>

<xsl:template match="/"> <!-- standard match to include all child elements -->

  <html xml:lang="{/root/params/language}" lang="{/root/params/language}">

    <xsl:call-template name="head" />

  <body>
    <xsl:attribute name="class">
      <xsl:value-of select="/root/params/script_short" />
    </xsl:attribute>
    
    <xsl:call-template name="body-head" />

    <form method="post" action="{$script}">
  
      <div class="universe">
  
        <!-- create help button -->
        <xsl:call-template name="help" />
  
        <!-- create menu buttons -->
        <xsl:call-template name="menubar" />
  
        <div class="body">
  
          <div class="title">
            <h1 class="title"><xsl:value-of select="$title"/></h1>
          </div>
  
          <div class="outer">
  
            <!-- This is the OUTER/PARENT table -->
            <table>
              <xsl:for-each select="/root/*[name()=$outer][1]">
                <!-- display all the fields in the current row -->
                <xsl:call-template name="display_vertical">
                  <xsl:with-param name="zone"   select="'outer'"/>
                  <xsl:with-param name="noedit" select="'y'"/>
                </xsl:call-template>
              </xsl:for-each>
            </table>
  
            <!-- insert the scrolling links for the OUTER/PARENT table -->
            <xsl:call-template name="scrolling" >
              <xsl:with-param name="object" select="$outer"/>
            </xsl:call-template>
  
          </div>
  
          <!-- create navigation buttons -->
          <xsl:call-template name="navbar">
            <xsl:with-param name="noshow"   select="'y'"/>
            <xsl:with-param name="noselect" select="/root/params/noselect"/>
          </xsl:call-template>
  
          <div class="inner">
  
            <!-- this is the INNER/CHILD table -->
            <table class="timetable">
  
              <!-- set up column widths -->
              <xsl:call-template name="column_group_timetable">
                <xsl:with-param name="zone" select="'inner'"/>
              </xsl:call-template>
  
              <thead>
                <!-- set up column headings -->
                <xsl:call-template name="column_headings">
                  <xsl:with-param name="zone"   select="'inner'"/>
                  <xsl:with-param name="nosort" select="'y'"/>
                </xsl:call-template>
              </thead>
  
              <tbody>
  
                <!-- extract and display all timetable items in the correct sequence -->
                <xsl:call-template name="display_timetable">
                  <xsl:with-param name="zone"   select="$inner"/>
                  <xsl:with-param name="noedit" select="'y'"/>
                </xsl:call-template>
  
              </tbody>
            </table>
          </div>
  
          <!-- look for optional messages -->
          <xsl:call-template name="message"/>
  
          <!-- create standard action buttons -->
          <xsl:call-template name="actbar"/>
  
        </div>
  
      </div>
  
    </form>

    <xsl:call-template name="body-foot" />

  </body>
  </html>

</xsl:template>

<!-- *********************************************************************** -->


<!-- create <colgroup> entries to define the widths of each column -->
<xsl:template name="column_group_timetable">
  <xsl:param name="zone"/>

  <!-- create entry for 'time' column -->
  <colgroup width="1%"/>

  <!-- set equal widths for the number of days -->
  <xsl:call-template name="col_timetable">
    <xsl:with-param name="day" select="1"/>
  </xsl:call-template>

</xsl:template> <!-- COLUMN_GROUP_TIMETABLE -->

<xsl:template name="col_timetable">
  <xsl:param name="day"/>

  <colgroup>
    <xsl:attribute name="width">
      <!-- set column width so that each day has the same percentage -->
      <xsl:value-of select="format-number(number(100 div $last_day_no), '00.00')" />
      <xsl:text>%</xsl:text>
    </xsl:attribute>
  </colgroup>

  <!-- repeat until all days have been processed -->
  <xsl:if test="$day &lt; $last_day_no">
    <xsl:call-template name="col_timetable">
      <xsl:with-param name="day" select="$day +1"/>
    </xsl:call-template>
  </xsl:if>

</xsl:template> <!-- COL_TIMETABLE -->


<!-- *********************************************************************** -->
<xsl:template name="display_timetable">
  <xsl:param name="zone"/>      <!-- could be 'main', 'inner', 'outer', etc -->

  <!-- extract hour and minutes from $start_time -->
  <xsl:variable name="hour" select="substring($start_time,1,2)"/>
  <xsl:variable name="mins" select="substring($start_time,4,2)"/>

  <!-- start at $start_time for day number 1 -->
  <xsl:call-template name="timetable_row">
    <xsl:with-param name="zone"   select="$zone"/>
    <xsl:with-param name="hour"   select="$hour"/>
    <xsl:with-param name="mins"   select="$mins"/>
    <xsl:with-param name="day_no" select="1"/>
  </xsl:call-template>

</xsl:template> <!-- display_timetable -->

<!-- process one row at a time -->
<xsl:template name="timetable_row">
  <xsl:param name="zone"/>
  <xsl:param name="hour"/>
  <xsl:param name="mins"/>
  <xsl:param name="day_no"/>

  <xsl:variable name="this-hhmm" select="concat($hour, $mins)"/>
  <xsl:variable name="end-hhmm" select="concat(substring($end_time,1,2), substring($end_time,4,2))"/>

  <xsl:if test="$this-hhmm &lt; $end-hhmm">

    <tr>
      <!-- column 1 contains the time -->
      <td class="time"><xsl:value-of select="concat($hour, ':', $mins)"/></td>

      <!-- create another column for each day -->
      <xsl:call-template name="timetable-item">
        <xsl:with-param name="zone"   select="$zone"/>
        <xsl:with-param name="hour"   select="$hour"/>
        <xsl:with-param name="mins"   select="$mins"/>
        <xsl:with-param name="day_no" select="1"/>
      </xsl:call-template>
    </tr>

    <!-- call recursively for 15 minute intervals until end_time is reached -->
    <xsl:choose>

      <xsl:when test="$mins &lt; 45"> <!-- up to 45 minutes -->
        <!-- add 15 minutes then repeat -->
        <xsl:call-template name="timetable_row">
          <xsl:with-param name="zone"   select="$zone"/>
          <xsl:with-param name="hour"   select="$hour"/>
          <xsl:with-param name="mins"   select="$mins +15"/>
          <xsl:with-param name="day_no" select="1"/>
        </xsl:call-template>
      </xsl:when>

      <xsl:otherwise>
        <!-- add 1 hour then repeat -->
        <xsl:call-template name="timetable_row">
          <xsl:with-param name="zone"   select="$zone"/>
          <xsl:with-param name="hour"   select="format-number($hour +1, '00')"/>
          <xsl:with-param name="mins"   select="'00'"/> <!-- reset to zero minutes -->
          <xsl:with-param name="day_no" select="1"/>
        </xsl:call-template>
      </xsl:otherwise>

    </xsl:choose>
  </xsl:if>

</xsl:template> <!-- timetable_row -->

<!-- output a single timetable item -->
<xsl:template name="timetable-item">
  <xsl:param name="zone"/>
  <xsl:param name="hour"/>
  <xsl:param name="mins"/>
  <xsl:param name="day_no"/>

  <xsl:variable name="time" select="concat($hour, ':', $mins)"/>

  <!-- look for a record with this start_time and this day_no -->
  <xsl:if test="/root/*[name()=$outer][1]/*[name()=$zone][start_time=$time][day_no=$day_no]">

    <!-- retrieve end_time for current record -->
    <xsl:variable name="end_time"   select="/root/*[name()=$outer][1]/*[name()=$zone][start_time=$time][day_no=$day_no]/end_time"/>

    <!-- calculate how many 15-minute segments this item uses -->
    <!-- (this is used to set the depth of the column for this item) -->
    <xsl:variable name="start-mins" select="($hour * 60) + $mins"/>
    <xsl:variable name="end-mins"   select="(substring($end_time,1,2) * 60) + substring($end_time,4,2)"/>
    <xsl:variable name="segments"   select="($end-mins - $start-mins) div 15"/>

    <xsl:if test="$day_no > 1">
      <!-- fill in any previous columns which are missing -->
      <xsl:call-template name="previous-column">
        <xsl:with-param name="zone"     select="$zone"/>
        <xsl:with-param name="time"     select="concat($hour,$mins)"/>
        <xsl:with-param name="this_day" select="$day_no"/>
      </xsl:call-template>
    </xsl:if>

    <td rowspan="{$segments}">
      <xsl:for-each select="/root/*[name()=$outer][1]/*[name()=$zone][start_time=$time][day_no=$day_no]">
        <xsl:value-of select="item_name"/>
        <xsl:if test="string-length(item_subname) > 0">
          <br/><xsl:text>(</xsl:text><xsl:value-of select="item_subname"/><xsl:text>)</xsl:text>
        </xsl:if>
      </xsl:for-each>
    </td>

  </xsl:if>

  <!-- repeat until last day (usually Friday) -->
  <xsl:if test="$day_no &lt; $last_day_no">
    <xsl:call-template name="timetable-item">
      <xsl:with-param name="zone"   select="$zone"/>
      <xsl:with-param name="hour"   select="$hour"/>
      <xsl:with-param name="mins"   select="$mins"/>
      <xsl:with-param name="day_no" select="$day_no +1"/>
    </xsl:call-template>
  </xsl:if>

</xsl:template>

<!-- look to see if any previous columns need to be filled in or not -->
<xsl:template name="previous-column">
  <xsl:param name="zone"/>
  <xsl:param name="time"/>
  <xsl:param name="this_day"/>

  <!-- get the last cell actually created in this row (may not be present) -->
  <xsl:variable name="last_cell" select="/root/*[name()=$outer][1]/*[name()=$zone][day_no &lt; $this_day][translate(start_time,':','') = $time][position()=last()]"/>

  <xsl:variable name="test_day">
    <xsl:choose>
      <xsl:when test="$last_cell/day_no">
        <!-- start at day # after last cell actually created -->
        <xsl:value-of select="$last_cell/day_no +1"/>
      </xsl:when>
      <xsl:otherwise>
        <!-- no previous cell in this row, so start at day # 1 -->
        <xsl:value-of select="'1'"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:if test="$test_day &lt; $this_day">

    <!-- check to see if previous cells are occupied or not -->
    <xsl:call-template name="fill-column">
      <xsl:with-param name="zone"     select="$zone"/>
      <xsl:with-param name="time"     select="$time"/>
      <xsl:with-param name="this_day" select="$this_day"/>
      <xsl:with-param name="test_day" select="$test_day"/>
    </xsl:call-template>

  </xsl:if>

</xsl:template>

<xsl:template name="fill-column">
  <xsl:param name="zone"/>
  <xsl:param name="time"/>
  <xsl:param name="this_day"/>
  <xsl:param name="test_day"/>

  <!-- repeat for all days up to the day being created -->
  <xsl:if test="$test_day &lt; $this_day">

    <!-- find out if this cell is occupied from a previous row using 'rowspan' -->

    <!-- remove ':' from times for comparisons -->
    <xsl:if test="not(/root/*[name()=$outer][1]/*[name()=$zone][day_no=$test_day] [translate(start_time,':','') &lt;= $time] [translate(end_time,':','') >= $time +1] )">
      <!-- no entry in this column, so insert a blank cell -->
      <td class="blank">&#160;</td>
    </xsl:if>

    <!-- repeat for next day -->
    <xsl:call-template name="fill-column">
      <xsl:with-param name="zone"     select="$zone"/>
      <xsl:with-param name="time"     select="$time"/>
      <xsl:with-param name="this_day" select="$this_day"/>
      <xsl:with-param name="test_day" select="$test_day + 1"/>
    </xsl:call-template>

  </xsl:if>

</xsl:template>

</xsl:stylesheet>
