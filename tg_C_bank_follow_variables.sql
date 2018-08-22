-- funcion del trigger de INSERT bank_follow_variables
CREATE OR REPLACE FUNCTION audit.f_tg_C_bank_follow_variables() RETURNS TRIGGER AS $tg_C_bank_follow_variables$
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
			user_name,
			'INSERT',
			now()
		);
      RETURN NULL;
  END;

$tg_C_bank_follow_variables$ LANGUAGE 'plpgsql';



-- TRIGGER - INSERT  - bank_follow_variables
CREATE TRIGGER tg_C_bank_follow_variables AFTER INSERT
ON cw.bank_follow_variables FOR EACH ROW
EXECUTE PROCEDURE audit.f_tg_C_bank_follow_variables();
