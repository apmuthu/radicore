-- update MNU_ROLE_TASK with missing entries for standard tasks

INSERT INTO mnu_role_task (role_id, task_id) 
     SELECT mnu_role.role_id, 'menu'     
       FROM mnu_role 
      WHERE mnu_role.global_access != 'Y'
        AND NOT EXISTS (SELECT 1 FROM mnu_role_task AS mrt 
                         WHERE mrt.role_id=mnu_role.role_id AND mrt.task_id='menu');

INSERT INTO mnu_role_task (role_id, task_id) 
     SELECT mnu_role.role_id, 'mnu_user(upd1)a'     
       FROM mnu_role 
      WHERE mnu_role.global_access != 'Y'
        AND NOT EXISTS (SELECT 1 FROM mnu_role_task AS mrt 
                         WHERE mrt.role_id=mnu_role.role_id AND mrt.task_id='mnu_user(upd1)a');

INSERT INTO mnu_role_task (role_id, task_id) 
     SELECT mnu_role.role_id, 'mnu_user(upd1)b'     
       FROM mnu_role 
      WHERE mnu_role.global_access != 'Y'
        AND NOT EXISTS (SELECT 1 FROM mnu_role_task AS mrt 
                         WHERE mrt.role_id=mnu_role.role_id AND mrt.task_id='mnu_user(upd1)b');

INSERT INTO mnu_role_task (role_id, task_id) 
     SELECT mnu_role.role_id, 'mnu_user(upd1)c'     
       FROM mnu_role 
      WHERE mnu_role.global_access != 'Y'
        AND NOT EXISTS (SELECT 1 FROM mnu_role_task AS mrt 
                         WHERE mrt.role_id=mnu_role.role_id AND mrt.task_id='mnu_user(upd1)c');

INSERT INTO mnu_role_task (role_id, task_id) 
     SELECT mnu_role.role_id, 'mnu_motd(show)'     
       FROM mnu_role 
      WHERE mnu_role.global_access != 'Y'
        AND NOT EXISTS (SELECT 1 FROM mnu_role_task AS mrt 
                         WHERE mrt.role_id=mnu_role.role_id AND mrt.task_id='mnu_motd(show)');

INSERT INTO mnu_role_task (role_id, task_id) 
     SELECT mnu_role.role_id, 'mnu_todo(list2)'     
       FROM mnu_role 
      WHERE mnu_role.global_access != 'Y'
        AND NOT EXISTS (SELECT 1 FROM mnu_role_task AS mrt 
                         WHERE mrt.role_id=mnu_role.role_id AND mrt.task_id='mnu_todo(list2)');

INSERT INTO mnu_role_task (role_id, task_id) 
     SELECT mnu_role.role_id, 'mnu_todo(add1)'     
       FROM mnu_role 
      WHERE mnu_role.global_access != 'Y'
        AND NOT EXISTS (SELECT 1 FROM mnu_role_task AS mrt 
                         WHERE mrt.role_id=mnu_role.role_id AND mrt.task_id='mnu_todo(add1)');

INSERT INTO mnu_role_task (role_id, task_id) 
     SELECT mnu_role.role_id, 'mnu_todo(del1)'     
       FROM mnu_role 
      WHERE mnu_role.global_access != 'Y'
        AND NOT EXISTS (SELECT 1 FROM mnu_role_task AS mrt 
                         WHERE mrt.role_id=mnu_role.role_id AND mrt.task_id='mnu_todo(del1)');

INSERT INTO mnu_role_task (role_id, task_id) 
     SELECT mnu_role.role_id, 'mnu_todo(enq1)'     
       FROM mnu_role 
      WHERE mnu_role.global_access != 'Y'
        AND NOT EXISTS (SELECT 1 FROM mnu_role_task AS mrt 
                         WHERE mrt.role_id=mnu_role.role_id AND mrt.task_id='mnu_todo(enq1)');

INSERT INTO mnu_role_task (role_id, task_id) 
     SELECT mnu_role.role_id, 'mnu_todo(search)'     
       FROM mnu_role 
      WHERE mnu_role.global_access != 'Y'
        AND NOT EXISTS (SELECT 1 FROM mnu_role_task AS mrt 
                         WHERE mrt.role_id=mnu_role.role_id AND mrt.task_id='mnu_todo(search)');

INSERT INTO mnu_role_task (role_id, task_id) 
     SELECT mnu_role.role_id, 'mnu_todo(upd1)'     
       FROM mnu_role 
      WHERE mnu_role.global_access != 'Y'
        AND NOT EXISTS (SELECT 1 FROM mnu_role_task AS mrt 
                         WHERE mrt.role_id=mnu_role.role_id AND mrt.task_id='mnu_todo(upd1)');

INSERT INTO mnu_role_task (role_id, task_id) 
     SELECT mnu_role.role_id, 'mnu_todo(complete)'     
       FROM mnu_role 
      WHERE mnu_role.global_access != 'Y'
        AND NOT EXISTS (SELECT 1 FROM mnu_role_task AS mrt 
                         WHERE mrt.role_id=mnu_role.role_id AND mrt.task_id='mnu_todo(complete)');

INSERT INTO mnu_role_task (role_id, task_id) 
     SELECT mnu_role.role_id, 'mnu_todo(incomplete)'     
       FROM mnu_role 
      WHERE mnu_role.global_access != 'Y'
        AND NOT EXISTS (SELECT 1 FROM mnu_role_task AS mrt 
                         WHERE mrt.role_id=mnu_role.role_id AND mrt.task_id='mnu_todo(incomplete)');

INSERT INTO mnu_role_task (role_id, task_id) 
     SELECT mnu_role.role_id, 'mnu_favourite(add2)'     
       FROM mnu_role 
      WHERE mnu_role.global_access != 'Y'
        AND NOT EXISTS (SELECT 1 FROM mnu_role_task AS mrt 
                         WHERE mrt.role_id=mnu_role.role_id AND mrt.task_id='mnu_favourite(add2)');

INSERT INTO mnu_role_task (role_id, task_id) 
     SELECT mnu_role.role_id, 'mnu_favourite(add4)'     
       FROM mnu_role 
      WHERE mnu_role.global_access != 'Y'
        AND NOT EXISTS (SELECT 1 FROM mnu_role_task AS mrt 
                         WHERE mrt.role_id=mnu_role.role_id AND mrt.task_id='mnu_favourite(add4)');

INSERT INTO mnu_role_task (role_id, task_id) 
     SELECT mnu_role.role_id, 'mnu_favourite(del1)'     
       FROM mnu_role 
      WHERE mnu_role.global_access != 'Y'
        AND NOT EXISTS (SELECT 1 FROM mnu_role_task AS mrt 
                         WHERE mrt.role_id=mnu_role.role_id AND mrt.task_id='mnu_favourite(del1)');

INSERT INTO mnu_role_task (role_id, task_id) 
     SELECT mnu_role.role_id, 'mnu_favourite(enq1)'     
       FROM mnu_role 
      WHERE mnu_role.global_access != 'Y'
        AND NOT EXISTS (SELECT 1 FROM mnu_role_task AS mrt 
                         WHERE mrt.role_id=mnu_role.role_id AND mrt.task_id='mnu_favourite(enq1)');

INSERT INTO mnu_role_task (role_id, task_id) 
     SELECT mnu_role.role_id, 'mnu_favourite(list2)'     
       FROM mnu_role 
      WHERE mnu_role.global_access != 'Y'
        AND NOT EXISTS (SELECT 1 FROM mnu_role_task AS mrt 
                         WHERE mrt.role_id=mnu_role.role_id AND mrt.task_id='mnu_favourite(list2)');

INSERT INTO mnu_role_task (role_id, task_id) 
     SELECT mnu_role.role_id, 'mnu_favourite(search)'     
       FROM mnu_role 
      WHERE mnu_role.global_access != 'Y'
        AND NOT EXISTS (SELECT 1 FROM mnu_role_task AS mrt 
                         WHERE mrt.role_id=mnu_role.role_id AND mrt.task_id='mnu_favourite(search)');

INSERT INTO mnu_role_task (role_id, task_id) 
     SELECT mnu_role.role_id, 'mnu_favourite(upd1)'     
       FROM mnu_role 
      WHERE mnu_role.global_access != 'Y'
        AND NOT EXISTS (SELECT 1 FROM mnu_role_task AS mrt 
                         WHERE mrt.role_id=mnu_role.role_id AND mrt.task_id='mnu_favourite(upd1)');

INSERT INTO mnu_role_task (role_id, task_id) 
     SELECT mnu_role.role_id, 'mnu_favourite(upd4)movedown'     
       FROM mnu_role 
      WHERE mnu_role.global_access != 'Y'
        AND NOT EXISTS (SELECT 1 FROM mnu_role_task AS mrt 
                         WHERE mrt.role_id=mnu_role.role_id AND mrt.task_id='mnu_favourite(upd4)movedown');

INSERT INTO mnu_role_task (role_id, task_id) 
     SELECT mnu_role.role_id, 'mnu_favourite(upd4)moveup'     
       FROM mnu_role 
      WHERE mnu_role.global_access != 'Y'
        AND NOT EXISTS (SELECT 1 FROM mnu_role_task AS mrt 
                         WHERE mrt.role_id=mnu_role.role_id AND mrt.task_id='mnu_favourite(upd4)moveup');

INSERT INTO mnu_role_task (role_id, task_id) 
     SELECT mnu_role.role_id, 'mnu_favourite(upd4)reseq'     
       FROM mnu_role 
      WHERE mnu_role.global_access != 'Y'
        AND NOT EXISTS (SELECT 1 FROM mnu_role_task AS mrt 
                         WHERE mrt.role_id=mnu_role.role_id AND mrt.task_id='mnu_favourite(upd4)reseq');

