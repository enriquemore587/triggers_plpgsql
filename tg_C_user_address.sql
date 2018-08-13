-- funcion del trigger de INSERT user_address
CREATE OR REPLACE FUNCTION audit.f_tg_C_user_address() RETURNS TRIGGER AS $tg_C_user_address$
  DECLARE
  user_name VARCHAR(50);
  BEGIN
    select current_user into user_name;
    INSERT INTO audit.user_address
    (
			id,
			state_new,
			municipality_new,
			colony_new,
			street_new,
			ext_new,
			int_new,
			cp_new,
			additional_reference_new,
			years_residence_new,
			country_new,
			user_name,
			action_performed,
			date_action
		)
    VALUES
    (
			NEW.id,
			NEW.state,
			NEW.municipality,
			NEW.colony,
			NEW.street,
			NEW.ext,
			NEW.int,
			NEW.cp,
			NEW.additional_reference,
			NEW.years_residence,
			NEW.country,
			user_name,
			'INSERT',
			now());
      RETURN NULL;
  END;

$tg_C_user_address$ LANGUAGE 'plpgsql';



-- TRIGGER - INSERT  - user_address
CREATE TRIGGER tg_C_user_address AFTER INSERT
ON cw.user_address FOR EACH ROW
EXECUTE PROCEDURE audit.f_tg_C_user_address();
