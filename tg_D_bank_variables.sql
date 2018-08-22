-- funcion del trigger de eliminar en la tabla cw.bank_variables
CREATE OR REPLACE FUNCTION audit.f_tg_D_bank_variables() RETURNS TRIGGER AS $f_tg_D_bank_variables$
  DECLARE
  user_name VARCHAR(50);
  BEGIN
    select current_user into user_name;
    INSERT INTO audit.bank_variables
    (
			id,
			bank_id_old,
			var_fix_id_old,
			range_old,
			is_ok_old,
			var_array_old,
			product_id_old,
			active_old,
			user_name,
			action_performed,
			date_action
		)
    VALUES
    (
			OLD.id,
			OLD.bank_id,
			OLD.var_fix_id,
			OLD.range,
			OLD.is_ok,
			OLD.var_array,
			OLD.product_id,
			OLD.active,
			user_name,
			'DELETE',
			now()
		);
      RETURN NULL;
  END;

$f_tg_D_bank_variables$ LANGUAGE 'plpgsql';

-- trigger para eliminar bank_variables
CREATE TRIGGER tg_D_bank_variables AFTER DELETE
ON cw.bank_variables FOR EACH ROW
EXECUTE PROCEDURE audit.f_tg_D_bank_variables();
