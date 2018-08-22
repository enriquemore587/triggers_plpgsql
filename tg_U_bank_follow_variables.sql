-- funcion del trigger de UPDATE bank_follow_variables
CREATE OR REPLACE FUNCTION audit.f_tg_U_bank_follow_variables() RETURNS TRIGGER AS $f_tg_U_bank_follow_variables$
  DECLARE
  user_name VARCHAR(50);
  BEGIN
    select current_user into user_name;
    INSERT INTO audit.bank_follow_variables
    (
			variable_id_new,
			personal_variable_id_new,
			bank_id_new,
			short_new,
			variable_id_old,
			personal_variable_id_old,
			bank_id_old,
			short_old,
			user_name,
			action_performed,
			date_action
		)
    VALUES
    (
			NEW.variable_id,
			NEW.personal_variable_id,
			NEW.bank_id,
			NEW.short,
			OLD.variable_id,
			OLD.personal_variable_id,
			OLD.bank_id,
			OLD.short,
			user_name,
			'UPDATE',
			now()
		);
      RETURN NULL;
  END;
$f_tg_U_bank_follow_variables$ LANGUAGE 'plpgsql';

-- trigger para UPDATE bank_follow_variables
CREATE TRIGGER tg_U_bank_follow_variables AFTER UPDATE
ON cw.bank_follow_variables FOR EACH ROW
EXECUTE PROCEDURE audit.f_tg_U_bank_follow_variables();