-- funcion del trigger de UPDATE user_address
CREATE OR REPLACE FUNCTION audit.f_tg_U_user_address() RETURNS TRIGGER AS $f_tg_U_user_address$
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

			state_old,
			municipality_old,
			colony_old,
			street_old,
			ext_old,
			int_old,
			cp_old,
			additional_reference_old,
			years_residence_old,
			country_old,
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
		
			OLD.state,
			OLD.municipality,
			OLD.colony,
			OLD.street,
			OLD.ext,
			OLD.int,
			OLD.cp,
			OLD.additional_reference,
			OLD.years_residence,
			OLD.country,
			user_name,
			'UPDATE',
			now()
		);
      RETURN NULL;
  END;
$f_tg_U_user_address$ LANGUAGE 'plpgsql';

-- trigger para UPDATE user_address
CREATE TRIGGER tg_U_user_address AFTER UPDATE
ON cw.user_address FOR EACH ROW
EXECUTE PROCEDURE audit.f_tg_U_user_address();