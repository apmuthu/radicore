UPDATE dict_column SET noedit_nodisplay='NED', auto_insert='Y', no_search='NSR' WHERE column_id='created_date';
UPDATE dict_column SET noedit_nodisplay='NED', auto_insert='Y', no_search='NSR' WHERE column_id='created_user';
UPDATE dict_column SET noedit_nodisplay='NED', auto_update='Y', no_search='NSR' WHERE column_id='revised_date';
UPDATE dict_column SET noedit_nodisplay='NED', auto_update='Y', no_search='NSR' WHERE column_id='revised_user';

UPDATE dict_column SET noedit_nodisplay='NDI', auto_update='Y', no_search='NSR' WHERE column_id='rdcversion';
UPDATE dict_column SET noedit_nodisplay='NDI', no_search='NSR' WHERE column_id='rdcaccount_id' AND database_id!='MENU';
