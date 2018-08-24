-- funcion del trigger de eliminar en la tabla cw.variables_fix
CREATE OR REPLACE FUNCTION audit.f_tg_D_variables_fix() RETURNS TRIGGER AS $f_tg_D_variables_fix$
  DECLARE
  user_name VARCHAR(50);
  BEGIN
    select current_user into user_name;
    INSERT INTO audit.variables_fix
    (
			"id",
			name_old,
			category_id_old,
			calc_show_old,
			sort_old,
			user_name,
			action_performed,
			date_action
		)
    VALUES
    (
			OLD.id,
			OLD.name,
			OLD.category_id,
			OLD.calc_show,
			OLD.sort,
			user_name,
			'DELETE',
			now()
		);
      RETURN NULL;
  END;

$f_tg_D_variables_fix$ LANGUAGE 'plpgsql';

-- trigger para eliminar variables_fix
CREATE TRIGGER tg_D_variables_fix AFTER DELETE
ON cw.variables_fix FOR EACH ROW
EXECUTE PROCEDURE audit.f_tg_D_variables_fix();
