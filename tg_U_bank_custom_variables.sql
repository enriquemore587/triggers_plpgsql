-- funcion del trigger de UPDATE bank_custom_variables
CREATE OR REPLACE FUNCTION audit.f_tg_U_bank_custom_variables() RETURNS TRIGGER AS $tg_U_bank_custom_variables$
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
			expression_old,
			bank_id_old,
			product_id_old,
			nombre_old,
			salida_old,
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
			OLD.expression,
			OLD.bank_id,
			OLD.product_id,
			OLD.nombre,
			OLD.salida,
			user_name,
			'UPDATE',
			now()
		);
      RETURN NULL;
  END;
$tg_U_bank_custom_variables$ LANGUAGE 'plpgsql';

-- trigger para UPDATE bank_custom_variables
CREATE TRIGGER tg_U_bank_custom_variables AFTER UPDATE
ON cw.bank_custom_variables FOR EACH ROW
EXECUTE PROCEDURE audit.f_tg_U_bank_custom_variables();