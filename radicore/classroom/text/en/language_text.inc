<?php

// Each text string may include parameter substitution - refer to SPRINTF() function

$array['e0001'] = "Start Time cannot be later than End Time";
$array['e0002'] = "End Time cannot be earlier than Start Time";
$array['e0003'] = "Start Time must be 00,15,30 or 45 minutes";
$array['e0004'] = "End Time must be 00,15,30 or 45 minutes";
$array['e0005'] = "Room conflict: Lesson '%1\$s' between %2\$s and %3\$s";
$array['e0006'] = "Size conflict: Student count (%1\$s) exceeds room capacity (%2\$s)";
$array['e0007'] = "Lesson conflict: Lesson '%1\$s' between %2\$s and %3\$s";
$array['e0008'] = "- class: %1\$s";
$array['e0009'] = "- student: %1\$s";

$array['e0010'] = "- teacher: %1\$s";
$array['e0011'] = "unknown conflict type (%1\$s)";
$array['e0012'] = "Event %1\$s contains errors.";
$array['e0013'] = "Cannot set both YEAR and CLASS";
$array['e0014'] = "Student is assigned to a class - cannot assign individual lessons";
$array['e0015'] = "Cannot assign to a Class while individual Lessons exist";
$array['e0016'] = "Start Time cannot be earlier than Start Time on Schedule Header";
$array['e0017'] = "End Time cannot be later than End Time on Schedule Header";
$array['e0018'] = "";
$array['e0019'] = "";

$array['e0020'] = "";
$array['e0021'] = "";
$array['e0022'] = "";
$array['e0023'] = "";
$array['e0024'] = "";
$array['e0025'] = "";
$array['e0026'] = "";
$array['e0027'] = "";
$array['e0028'] = "";
$array['e0029'] = "";

$array['e0030'] = "";
$array['e0031'] = "";
$array['e0032'] = "";
$array['e0033'] = "";
$array['e0034'] = "";
$array['e0035'] = "";
$array['e0036'] = "";
$array['e0037'] = "";
$array['e0038'] = "";
$array['e0039'] = "";

// menu details for subsystem CRSS
$array['Classes']                       = 'Classes';
$array['Conflicts']                     = 'Conflicts';
$array['Lessons']                       = 'Lessons';
$array['Rooms']                         = 'Rooms';
$array['Schedules']                     = 'Schedules';
$array['Scheduling']                    = 'Scheduling';
$array['Students']                      = 'Students';
$array['Subjects']                      = 'Subjects';
$array['Teachers']                      = 'Teachers';

// task details for subsystem CRSS
$array['crs_class(add)']                = 'Add Class';
$array['crs_class(del)']                = 'Delete Class';
$array['crs_class(enq)']                = 'Enquire Class';
$array['crs_class(list)']               = 'List Class';
$array['crs_class(list)a']              = 'List Classes For a Lesson';
$array['crs_class(popup)']              = 'Choose Class';
$array['crs_class(search)']             = 'Search Class';
$array['crs_class(upd)']                = 'Update Class';
$array['crs_class_lesson(add)a']        = 'Add Lesson(s) to selected Class';
$array['crs_class_lesson(add)b']        = 'Add Class(es) to selected Lesson';
$array['crs_class_lesson(del)']         = 'Delete from Class/Lesson cross-reference';
$array['crs_confict(list)']             = 'List Lesson Conflicts';
$array['crs_confict(reset)']            = 'Reset Lesson Conflicts';
$array['crs_conflict(search)']          = 'Search Conflict';
$array['crs_lesson(add)']               = 'Add Lesson';
$array['crs_lesson(del)']               = 'Delete Lesson';
$array['crs_lesson(enq)']               = 'Enquire Lesson';
$array['crs_lesson(list)']              = 'List Lesson';
$array['crs_lesson(list)a']             = 'List Lessons For a Student';
$array['crs_lesson(list)b']             = 'List Lessons For a Class';
$array['crs_lesson(list)c']             = 'List Lessons For a Teacher';
$array['crs_lesson(list)d']             = 'List Lessons For a Subject';
$array['crs_lesson(popup)']             = 'Choose Lesson';
$array['crs_lesson(search)']            = 'Search Lesson';
$array['crs_lesson(upd)']               = 'Update Lesson';
$array['crs_room(add)']                 = 'Add Room';
$array['crs_room(del)']                 = 'Delete Room';
$array['crs_room(enq)']                 = 'Enquire Room';
$array['crs_room(list)']                = 'List Room';
$array['crs_room(search)']              = 'search Room';
$array['crs_room(upd)']                 = 'Update Room';
$array['crs_schedule(add)']             = 'Add Schedule Event';
$array['crs_schedule(del)']             = 'Delete Schedule Event';
$array['crs_schedule(enq)']             = 'Read Schedule Event';
$array['crs_schedule(list)']            = 'List Schedule Events';
$array['crs_schedule(list)class']       = 'Show Schedule for Class';
$array['crs_schedule(list)lesson']      = 'Show Schedule for Lesson';
$array['crs_schedule(list)room']        = 'Show Schedule for Room';
$array['crs_schedule(list)student']     = 'Show Schedule for Student';
$array['crs_schedule(list)teacher']     = 'Show Schedule for Teacher';
$array['crs_schedule(multi)']           = 'Maintain Schedule Events';
$array['crs_schedule(search)']          = 'Search Schedule Event';
$array['crs_schedule(upd)']             = 'Update Schedule Event';
$array['crs_schedule_hdr(add)']         = 'Add Schedule Header';
$array['crs_schedule_hdr(choose)']      = 'Choose Schedule Id';
$array['crs_schedule_hdr(del)']         = 'Delete Schedule Header';
$array['crs_schedule_hdr(enq)']         = 'Enquire Schedule Header';
$array['crs_schedule_hdr(list)']        = 'List Schedule Header';
$array['crs_schedule_hdr(popup)']       = 'Choose Schedule Id';
$array['crs_schedule_hdr(search)']      = 'Search Schedule Header';
$array['crs_schedule_hdr(upd)']         = 'Update Schedule Header';
$array['crs_student(add)']              = 'Add Student';
$array['crs_student(del)']              = 'Delete Student';
$array['crs_student(enq)']              = 'Enquire Student';
$array['crs_student(list)']             = 'List Student';
$array['crs_student(list)a']            = 'List Students for a Lesson';
$array['crs_student(list)b']            = 'List Students for a Class';
$array['crs_student(popup)']            = 'Choose Student';
$array['crs_student(search)']           = 'Search Student';
$array['crs_student(upd)']              = 'Update Student';
$array['crs_student_lesson(add)a']      = 'Add Lesson(s) to selected Student';
$array['crs_student_lesson(add)b']      = 'Add Students(s) to selected Lesson';
$array['crs_student_lesson(del)']       = 'Delete from Student/Lesson cross-reference';
$array['crs_subject(add)']              = 'Add Subject';
$array['crs_subject(del)']              = 'Delete Subject';
$array['crs_subject(enq)']              = 'Enquire Subject';
$array['crs_subject(list)']             = 'List Subject';
$array['crs_subject(search)']           = 'Search Subject';
$array['crs_subject(upd)']              = 'Update Subject';
$array['crs_teacher(add)']              = 'Add Teacher';
$array['crs_teacher(del)']              = 'Delete Teacher';
$array['crs_teacher(enq)']              = 'Emquire Teacher';
$array['crs_teacher(list)']             = 'List Teacher';
$array['crs_teacher(search)']           = 'Search Teacher';
$array['crs_teacher(upd)']              = 'Update Teacher';

// navigation button details for subsystem CRSS
$array['Choose Schedule']               = 'Choose Schedule';
$array['Classes']                       = 'Classes';
$array['Delete Class']                  = 'Delete Class';
$array['Events']                        = 'Events';
$array['Lessons']                       = 'Lessons';
$array['Maintain Schedule']             = 'Maintain Schedule';
$array['New Class']                     = 'New Class';
$array['Show Schedule']                 = 'Show Schedule';
$array['Students']                      = 'Students';

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

// field labels for subsystem CRSS
$array['Active?']                   = 'Active?';
$array['Capacity']                  = 'Capacity';
$array['Class']                     = 'Class';
$array['Classes']                   = 'Classes';
$array['Day']                       = 'Day';
$array['End Time']                  = 'End Time';
$array['End']                       = 'End';
$array['Errors']                    = 'Errors';
$array['First Name']                = 'First Name';
$array['Fri']                       = 'Fri';
$array['Initials']                  = 'Initials';
$array['Last Day']                  = 'Last Day';
$array['Last Name']                 = 'Last Name';
$array['Lesson']                    = 'Lesson';
$array['Lesson1']                   = 'Lesson1';
$array['Lesson2']                   = 'Lesson2';
$array['Lessons']                   = 'Lessons';
$array['Mon']                       = 'Mon';
$array['Name']                      = 'Name';
$array['Notes']                     = 'Notes';
$array['Room Capacity']             = 'Room Capacity';
$array['Room']                      = 'Room';
$array['Schedule Id']               = 'Schedule Id';
$array['Seq #']                     = 'Seq #';
$array['Seq#']                      = 'Seq#';
$array['Short Name']                = 'Short Name';
$array['Start Time']                = 'Start Time';
$array['Start']                     = 'Start';
$array['Student Count']             = 'Student Count';
$array['Student']                   = 'Student';
$array['Students']                  = 'Students';
$array['Subject']                   = 'Subject';
$array['Teacher']                   = 'Teacher';
$array['Thu']                       = 'Thu';
$array['Time']                      = 'Time';
$array['Title']                     = 'Title';
$array['Tue']                       = 'Tue';
$array['Type']                      = 'Type';
$array['Valid?']                    = 'Valid?';
$array['Wed']                       = 'Wed';
$array['Year']                      = 'Year';

return $array;

?>