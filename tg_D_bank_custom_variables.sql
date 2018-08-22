-- funcion del trigger de eliminar en la tabla cw.bank_custom_variables
CREATE OR REPLACE FUNCTION audit.f_tg_D_bank_custom_variables() RETURNS TRIGGER AS $f_tg_D_bank_custom_variables$
  DECLARE
  user_name VARCHAR(50);
  BEGIN
    select current_user into user_name;
    INSERT INTO audit.bank_custom_variables
    (
			id,
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
			OLD.id,
			OLD.expression,
			OLD.bank_id,
			OLD.product_id,
			OLD.nombre,
			OLD.salida,
			user_name,
			'DELETE',
			now()
		);
      RETURN NULL;
  END;

$f_tg_D_bank_custom_variables$ LANGUAGE 'plpgsql';

-- trigger para eliminar bank_custom_variables
CREATE TRIGGER tg_D_bank_custom_variables AFTER DELETE
ON cw.bank_custom_variables FOR EACH ROW
EXECUTE PROCEDURE audit.f_tg_D_bank_custom_variables();
