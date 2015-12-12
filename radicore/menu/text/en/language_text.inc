<?php

// Each text string may include parameter substitution - refer to SPRINTF() function

$array['e0000'] = "Cannot delete a user's only role";
$array['e0001'] = "This user has been disabled.";
$array['e0002'] = "You must change your password.";
$array['e0003'] = "Retry count exceeded.";
$array['e0004'] = "Invalid value for field_id (%1\$s).";
$array['e0005'] = "pswd_days must be > 0";
$array['e0006'] = "pswd_count must be > 0";
$array['e0007'] = "pswd_format_minlen must be <= %1\$s";
$array['e0008'] = "pswd_format_upper must be <= %1\$s";
$array['e0009'] = "pswd_format_lower must be <= %1\$s";

$array['e0010'] = "pswd_format_digits must be <= %1\$s";
$array['e0011'] = "Cannot add a menu to itself.";
$array['e0012'] = "Cannot add a task to itself.";
$array['e0013'] = "Cannot add a task of type MENU.";
$array['e0014'] = "start_task_id must be of type MENU.";
$array['e0015'] = "Task '%1\$s' has been disabled.";
$array['e0016'] = "Access to task '%1\$s' has not been allowed.";
$array['e0017'] = "Unknown value in TASK_TYPE (%1\$s).";
$array['e0018'] = "Task cannot passthru to itself.";
$array['e0019'] = "This task (%1\$s) does not exist.";

$array['e0020'] = "This task must be of type PROC.";
$array['e0021'] = "This function is only valid if TASK_TYPE='PROC'.";
$array['e0022'] = "Contains invalid character (%1\$s)";
$array['e0023'] = "This TASK_ID is already in use.";
$array['e0024'] = "This function is only valid if TASK_TYPE='MENU'.";
$array['e0025'] = "Password must have at least %1\$s characters.";
$array['e0026'] = "Password must have at least %1\$s digits.";
$array['e0027'] = "Password must have at least %1\$s lowercase characters.";
$array['e0028'] = "Password must have at least %1\$s uppercase characters.";
$array['e0029'] = "Password is invalid";

$array['e0030'] = "New password must not match current password.";
$array['e0031'] = "Repeat password does not match new password.";
$array['e0032'] = "Password has been reset.";
$array['e0033'] = "Due Date must be in the future";
$array['e0034'] = "Only a single-level directory is allowed";
$array['e0035'] = "Directory name does not exist";
$array['e0036'] = "";
$array['e0037'] = "";
$array['e0038'] = "";
$array['e0039'] = "";

$array['e0040'] = "Your password will expire in %1\$s days";
$array['e0041'] = "Your password will expire in %1\$s logons";
$array['e0042'] = "Shutdown Start cannot be empty if Shutdown End is not empty";
$array['e0043'] = "Shutdown End cannot be empty if Shutdown Start is not empty";
$array['e0044'] = "Shutdown Start must be before Shutdown End";
$array['e0045'] = "Shutdown End must be after Shutdown Start";
$array['e0046'] = "Shutdown Warning cannot be non-empty if Shutdown Start is empty";
$array['e0047'] = "Shutdown Warning must be before Shutdown Start";
$array['e0048'] = "User ID: %1\$s";
$array['e0049'] = "";

$array['e0050'] = "Directory %1\$s already exists";
$array['e0051'] = "Directory %1\$s has been created";
$array['e0052'] = "Cannot open directory %1\$s";
$array['e0053'] = "Cannot create directory %1\$s";
$array['e0054'] = "Cannot create file %1\$s";;
$array['e0055'] = "This setting is not valid for this pattern";
$array['e0056'] = "";
$array['e0057'] = "";
$array['e0058'] = "";
$array['e0059'] = "";

$array['e0060'] = "Repeat Unit is invalid without Repeat Interval";
$array['e0061'] = "Repeat Unit is required with Repeat Interval";
$array['e0062'] = "Context is invalid without Task";
$array['e0063'] = "This function is not valid if PATTERN_ID='BATCH'";
$array['e0064'] = "Cannot create repeat entry";
$array['e0065'] = "";
$array['e0066'] = "";
$array['e0067'] = "";
$array['e0068'] = "";
$array['e0069'] = "";

$array['e0070'] = "Multiple rows selected - only the 1st accepted";
$array['e0071'] = "This entry cannot be moved UP any further";
$array['e0072'] = "This entry cannot be moved DOWN any further";
$array['e0073'] = "Entries have been resequenced";
$array['e0074'] = "";
$array['e0075'] = "";
$array['e0076'] = "";
$array['e0077'] = "";
$array['e0078'] = "";
$array['e0079'] = "";

$array['e0080'] = "";
$array['e0081'] = "";
$array['e0082'] = "";
$array['e0083'] = "";
$array['e0084'] = "";
$array['e0085'] = "";
$array['e0086'] = "";
$array['e0087'] = "";
$array['e0088'] = "";
$array['e0089'] = "";

// menu details for subsystem MENU
$array['Applications']                            = 'Applications';
$array['Audit']                                   = 'Audit';
$array['Dictionary']                              = 'Dictionary';
$array['Menu Controls']                           = 'Menu Controls';
$array['Menu System']                             = 'Menu System';
$array['Pattern']                                 = 'Pattern';
$array['PROTO']                                   = 'PROTO';
$array['Role']                                    = 'Role';
$array['Subsystem']                               = 'Subsystem';
$array['Task (All)']                              = 'Task (All)';
$array['Task (Menu)']                             = 'Task (Menu)';
$array['Task (Proc)']                             = 'Task (Proc)';
$array['ToDo']                                    = 'ToDo';
$array['User']                                    = 'User';
$array['Workflow']                                = 'Workflow';

// task details for subsystem MISC (no longer required)


// task details for subsystem MENU (NOT REQUIRED AS OF VERSION 1.77.0)

// navigation button details for subsystem MENU
$array['Change Password']               = 'Change Password';
$array['Export']                        = 'Export';
$array['Field Access']                  = 'Field Access';
$array['Help Text']                     = 'Help Text';
$array['List Fields']                   = 'List Fields';
$array['List Task']                     = 'List Task';
$array['List User']                     = 'List User';
$array['Menu Contents (1)']             = 'Menu Contents (1)';
$array['Menu Contents (2)']             = 'Menu Contents (2)';
$array['Menu Contents (3)']             = 'Menu Contents (3)';
$array['Menu Items(1)']                 = 'Menu Items(1)';
$array['Menu Items(2)']                 = 'Menu Items(2)';
$array['Menu Items(3)']                 = 'Menu Items(3)';
$array['Navigation Button(1)']          = 'Navigation Button(1)';
$array['Navigation Button(2)']          = 'Navigation Button(2)';
$array['Navigation Button(3)']          = 'Navigation Button(3)';
$array['Rename']                        = 'Rename';
$array['Reset Password']                = 'Reset Password';
$array['Task Access']                   = 'Task Access';

// field names for subsystem MENU
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

// field labels for subsystem MENU
$array['Access']                        = 'Access';
$array['Button Id']                     = 'Button Id';
$array['Button Text']                   = 'Button Text';
$array['Default Language']              = 'Default Language';
$array['Directory']                     = 'Directory';
$array['Drop saved pages?']             = 'Drop saved pages?';
$array['E-mail Address']                = 'E-mail Address';
$array['Field Id']                      = 'Field Id';
$array['Format: Minimum length']        = 'Format: Minimum length';
$array['Format: Upper case chars']      = 'Format: Upper case chars';
$array['Global Access']                 = 'Global Access';
$array['Hide Passwords?']               = 'Hide Passwords?';
$array['In Use']                        = 'In Use';
$array['Initial Passthru']              = 'Initial Passthru';
$array['Keep Data on exit?']            = 'Keep Data on exit?';
$array['Language Code']                 = 'Language Code';
$array['Logon Date']                    = 'Logon Date';
$array['Log SQL queries?']              = 'Log SQL queries?';
$array['Log XML documents?']            = 'Log XML documents?';
$array['Long Description']              = 'Long Description';
$array['Lower case chars']              = 'Lower case chars';
$array['Menu Id']                       = 'Menu Id';
$array['New Password']                  = 'New Password';
$array['New Task Id']                   = 'New Task Id';
$array['Number of digits']              = 'Number of digits';
$array['Old Password']                  = 'Old Password';
$array['Old Task Id']                   = 'Old Task Id';
$array['Order By']                      = 'Order By';
$array['Password Change Date']          = 'Password Change Date';
$array['Password Change']               = 'Password Change';
$array['Password Count']                = 'Password Count';
$array['Password Count']                = 'Password Count';
$array['Password Days']                 = 'Password Days';
$array['Password Encryption?']          = 'Password Encryption?';
$array['Password Retries']              = 'Password Retries';
$array['Password Warning']              = 'Password Warning';
$array['Password']                      = 'Password';
$array['Pattern']                       = 'Pattern';
$array['Preselect?']                    = 'Preselect?';
$array['Repeat Password']               = 'Repeat Password';
$array['Role ID']                       = 'Role Id';
$array['Role']                          = 'Role';
$array['Screen Refresh']                = 'Screen Refresh';
$array['Selection (fixed)']             = 'Selection (fixed)';
$array['Selection (temporary)']         = 'Selection (temporary)';
$array['Settings']                      = 'Settings';
$array['Shutdown Days']                 = 'Shutdown Days';
$array['Shutdown End']                  = 'Shutdown End';
$array['Shutdown Start']                = 'Shutdown Start';
$array['Shutdown Warning']              = 'Shutdown Warning';
$array['Sort Sequence']                 = 'Sort Sequence';
$array['Start Task']                    = 'Start Task';
$array['Subsystem']                     = 'Subsystem';
$array['Task Disabled?']                = 'Task Disabled?';
$array['Task Id']                       = 'Task Id';
$array['Task']                          = 'Task';
$array['Theme/Style']                   = 'Theme/Style';
$array['Type']                          = 'Type';
$array['Use HTTPS?']                    = 'Use HTTPS?';
$array['User Id']                       = 'User Id';
$array['User Name']                     = 'User Name';
$array['Users']                         = 'Users';
$array['Visible screen?']               = 'Visible screen?';
$array['user_roles']                    = 'Maintain User Roles';

return $array;

?>