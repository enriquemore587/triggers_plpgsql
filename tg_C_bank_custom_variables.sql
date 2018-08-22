-- funcion del trigger de INSERT bank_custom_variables
CREATE OR REPLACE FUNCTION audit.f_tg_C_bank_custom_variables() RETURNS TRIGGER AS $tg_C_bank_custom_variables$
  DECLARE
  user_name VARCHAR(50);
  BEGIN
    select current_user into user_name;
    INSERT INTO audit.bank_custom_variables
    (
			id,
			expression_new,
			bank_id_new,
			product_id_new,
			nombre_new,
			salida_new,
			user_name,
			action_performed,
			date_action
		)
    VALUES
    (
			NEW.id,
			NEW.expression,
			NEW.bank_id,
			NEW.product_id,
			NEW.nombre,
			NEW.salida,
			user_name,
			'INSERT',
			now()
		);
      RETURN NULL;
  END;

$tg_C_bank_custom_variables$ LANGUAGE 'plpgsql';


-- TRIGGER - INSERT  - bank_custom_variables
CREATE TRIGGER tg_C_bank_custom_variables AFTER INSERT
ON cw.bank_custom_variables FOR EACH ROW
EXECUTE PROCEDURE audit.f_tg_C_bank_custom_variables();
