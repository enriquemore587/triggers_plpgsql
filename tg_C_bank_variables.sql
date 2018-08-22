-- funcion del trigger de INSERT bank_variables
CREATE OR REPLACE FUNCTION audit.f_tg_C_bank_variables() RETURNS TRIGGER AS $tg_C_bank_variables$
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
			user_name,
			'INSERT',
			now());
      RETURN NULL;
  END;

$tg_C_bank_variables$ LANGUAGE 'plpgsql';



-- TRIGGER - INSERT  - bank_variables
CREATE TRIGGER tg_C_bank_variables AFTER INSERT
ON cw.bank_variables FOR EACH ROW
EXECUTE PROCEDURE audit.f_tg_C_bank_variables();
