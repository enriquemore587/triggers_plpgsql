-- funcion del trigger de UPDATE bank_variables
CREATE OR REPLACE FUNCTION audit.f_tg_U_bank_variables() RETURNS TRIGGER AS $f_tg_U_bank_variables$
  DECLARE
  user_name VARCHAR(50);
  BEGIN
    select current_user into user_name;
    INSERT INTO audit.bank_variables
    (
			bank_id_new,
			var_fix_id_new,
			range_new,
			is_ok_new,
			var_array_new,
			product_id_new,
			active_new,
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
			NEW.bank_id,
			NEW.var_fix_id,
			NEW.range,
			NEW.is_ok,
			NEW.var_array,
			NEW.product_id,
			NEW.active,
			NEW.id,
			OLD.bank_id,
			OLD.var_fix_id,
			OLD.range,
			OLD.is_ok,
			OLD.var_array,
			OLD.product_id,
			OLD.active,
			user_name,
			'UPDATE',
			now()
		);
      RETURN NULL;
  END;
$f_tg_U_bank_variables$ LANGUAGE 'plpgsql';

-- trigger para UPDATE bank_variables
CREATE TRIGGER tg_U_bank_variables AFTER UPDATE
ON cw.bank_variables FOR EACH ROW
EXECUTE PROCEDURE audit.f_tg_U_bank_variables();