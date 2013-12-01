<?php

// Each text string may include parameter substitution - refer to SPRINTF() function

$array['e0001'] = "Cannot use direction OUT on START place";
$array['e0002'] = "Cannot use direction IN on END place";
$array['e0003'] = "ARC_TYPE is invalid for this DIRECTION";
$array['e0004'] = "pre_condition invalid unless ARC_TYPE = 'Explicit OR-split'";
$array['e0005'] = "There is no START place for workflow %1\$s";
$array['e0006'] = "Cannot delete START place";
$array['e0007'] = "Cannot delete END place";
$array['e0008'] = "Start Date cannot be later than End Date";
$array['e0009'] = "End Date cannot be earlier than Start Date";

$array['e0010'] = "There are no outbound arcs from transition %1\$s";
$array['e0011'] = "Outward arcs do not have the same ARC_TYPE";
$array['e0012'] = "Cannot have more than one outward arc with ARC_TYPE='Sequential'";
$array['e0013'] = "Must have more than one outward arc with ARC_TYPE='AND-split'";
$array['e0014'] = "Must have more than one outward arc with ARC_TYPE='OR-split (explicit)'";
$array['e0015'] = "Cannot have more than one outward arc with ARC_TYPE='OR-join'";
$array['e0016'] = "Invalid PLACE_TYPE on outward arc";
$array['e0017'] = "There is no START place.";
$array['e0018'] = "There is more than one START place.";
$array['e0019'] = "There is no END place.";

$array['e0020'] = "There is more than one END place.";
$array['e0021'] = "There are no intermediate places.";
$array['e0022'] = "There are no TRANSITIONS.";
$array['e0023'] = "There are no ARCS.";
$array['e0024'] = "There are no ARCS coming out of the START place.";
$array['e0025'] = "There are no ARCS going into the END place.";
$array['e0026'] = "There is an ARC coming out of the END place.";
$array['e0027'] = "There is an ARC going into the START place.";
$array['e0028'] = "Too many arcs of type 'Sequential' at place '%1\$s'";
$array['e0029'] = "Arc of type 'OR-split (Explicit)' must have OUT direction at place '%1\$s'";

$array['e0030'] = "Arc of type 'OR-split (Implicit)' must have IN direction at place '%1\$s'";
$array['e0031'] = "Not enough arcs of type 'OR-split (Implicit)' at place '%1\$s'";
$array['e0032'] = "Arc of type 'OR-join' must have OUT direction at place '%1\$s'";
$array['e0033'] = "Not enough arcs of type 'OR-join' at place '%1\$s'";
$array['e0034'] = "Arc of type 'AND-split' must have OUT direction at place '%1\$s'";
$array['e0035'] = "Arc of type 'AND-join' must have IN direction at place '%1\$s'";
$array['e0036'] = "Unknown ARC_TYPE (%1\$s) at place '%2\$s'";
$array['e0037'] = "There are no INWARD ARCS for place '%1\$s'";
$array['e0038'] = "There are no OUTWARD ARCS for place '%1\$s'";
$array['e0039'] = "Arc of type 'OR-split (Explicit)' must have OUT direction at transition '%1\$s'";

$array['e0040'] = "Less than 2 arcs of type 'OR-split (Explicit)' at transition '%1\$s'";
$array['e0041'] = "More than 2 arcs of type 'OR-split (Explicit)' at transition '%1\$s'";
$array['e0042'] = "Less than 1 pre-condition specified for arcs of type 'OR-split (Explicit)' at transition '%1\$s'";
$array['e0043'] = "More than 1 pre-condition specified for arcs of type 'OR-split (Explicit)' at transition '%1\$s'";
$array['e0044'] = "Arc of type 'OR-split (Implicit)' must have IN direction at transition '%1\$s'";
$array['e0045'] = "More than 1 arc of type 'OR-split (Implicit)' at transition '%1\$s'";
$array['e0046'] = "Arc of type 'OR-join' must have OUT direction at transition '%1\$s'";
$array['e0047'] = "More than 1 arc of type 'OR-join' at transition '%1\$s'";
$array['e0048'] = "Arc of type 'AND-split' must have OUT direction at transition '%1\$s'";
$array['e0049'] = "Not enough arcs of type 'AND-split' at transition '%1\$s'";

$array['e0050'] = "Arc of type 'AND-join' must have IN direction at transition '%1\$s'";
$array['e0051'] = "Not enough arcs of type 'AND-join' at transition '%1\$s'";
$array['e0052'] = "Unknown ARC_TYPE (%1\$s) at transition '%2\$s'";
$array['e0053'] = "There are no INWARD ARCS for transition '%1\$s'";
$array['e0054'] = "There is more than 1 type of INWARD ARC for transition '%1\$s'";
$array['e0055'] = "There are no OUTWARD ARCS for transition '%1\$s'";
$array['e0056'] = "There is more than 1 type of OUTWARD ARC for transition '%1\$s'";
$array['e0057'] = "Workflow %1\$s contains errors.";
$array['e0058'] = "Time Limit cannot be blank if Trigger = 'TIME'";
$array['e0059'] = "Time Limit must be blank if Trigger not = 'TIME'";

$array['e0060'] = "Arcs leaving Place '%1\$s' do not have the same ARC_TYPE";
$array['e0061'] = "Arcs entering Place '%1\$s' do not have the same ARC_TYPE";
$array['e0062'] = "Not enough inward Arcs for transition '%1\$s'";
$array['e0063'] = "Too many inward Arcs for transition '%1\$s'";
$array['e0064'] = "Timed Transition '%1\$s' must have an inward Arc of type 'OR-split (Implicit)'";
$array['e0065'] = "Too many arcs of type 'OR-split (Implicit)' at place '%1\$s'";
$array['e0066'] = "The count of OR-JOINS does not match the count of OR-SPLITS";
$array['e0067'] = "Too many arcs of type 'OR-join' at place '%1\$s'";
$array['e0068'] = "The count of AND-JOINS does not match the count of AND-SPLITS";
$array['e0069'] = "Press SUBMIT to trigger this workitem";

$array['e0070'] = "Must be 1 empty pre-condition for arcs of type 'OR-split (Explicit)' at transition '%1\$s'";
$array['e0071'] = "Must be in format HHH:MM";
$array['e0072'] = "Cannot specify more than 999 hours";
$array['e0073'] = "Cannot specify more than 59 minutes";
$array['e0074'] = "";
$array['e0075'] = "";
$array['e0076'] = "";
$array['e0077'] = "";
$array['e0078'] = "";
$array['e0079'] = "";

// menu details for subsystem WORKFLOW
$array['Case']                                    = 'Case';
$array['Expired Workitems']                       = 'Expired Workitems';
$array['Token']                                   = 'Token';
$array['Workflow']                                = 'Workflow';
$array['Workitem']                                = 'Workitem';

// task details for subsystem WORKFLOW (NOT REQUIRED AS OF VERSION 1.77.0)

// navigation button details for subsystem WORKFLOW
$array['Arcs']                                    = 'Arcs';
$array['Cases']                                   = 'Cases';
$array['Fire']                                    = 'Fire';
$array['Places']                                  = 'Places';
$array['Tokens']                                  = 'Tokens';
$array['Transitions']                             = 'Transitions';
$array['Validate']                                = 'Validate';
$array['WorkItems']                               = 'WorkItems';

// field names for subsystem XXX
$array['']     = '';
$array['']     = '';
$array['']     = '';
$array['']     = '';
$array['']     = '';
$array['']     = '';
$array['']     = '';
$array['']     = '';
$array['']     = '';
$array['']     = '';

// field labels for subsystem WORKFLOW
$array['Arc Type']                  = 'Arc Type';
$array['Cancelled Date']            = 'Cancelled Date';
$array['Case Id']                   = 'Case Id';
$array['Case Status']               = 'Case Status';
$array['Consumed Date']             = 'Consumed Date';
$array['Context']                   = 'Context';
$array['Deadline']                  = 'Deadline';
$array['Direction']                 = 'Direction';
$array['Enabled Date']              = 'Enabled Date';
$array['Errors']                    = 'Errors';
$array['Finished Date']             = 'Finished Date';
$array['Place Id']                  = 'Place Id';
$array['Place Name']                = 'Place Name';
$array['Place']                     = 'Place';
$array['Pre-condition']             = 'Pre-condition';
$array['Process Name']              = 'Process Name';
$array['Role Id']                   = 'Role Id';
$array['Role']                      = 'Role';
$array['Starting Task']             = 'Starting Task';
$array['Task Id']                   = 'Task Id';
$array['Task']                      = 'Task';
$array['Time Limit']                = 'Time Limit';
$array['Token Id']                  = 'Token Id';
$array['Token Status']              = 'Token Status';
$array['Transition Id']             = 'Transition Id';
$array['Transition Name']           = 'Transition Name';
$array['Transition Trigger']        = 'Transition Trigger';
$array['Trigger']                   = 'Trigger';
$array['User Id']                   = 'User Id';
$array['Valid?']                    = 'Valid?';
$array['Workflow Id']               = 'Workflow Id';
$array['Workflow Name']             = 'Workflow Name';
$array['Workflow']                  = 'Workflow';
$array['Workitem Id']               = 'Workitem Id';
$array['Workitem Status']           = 'Workitem Status';

return $array;

?>