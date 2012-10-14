SET search_path to "menu",public;

SELECT visibility, visibility * '1 day'::interval AS foobar1
                 , (visibility||' day')::interval AS foobar2
                 , visibility * INTERVAL '1 day' AS foobar3
FROM mnu_todo 
WHERE mnu_todo.user_id='AJM' AND mnu_todo.is_complete='N' 
  AND DATE_SUB(due_date::timestamp, (visibility * INTERVAL '1 day')::interval) <= '2011-12-13'

