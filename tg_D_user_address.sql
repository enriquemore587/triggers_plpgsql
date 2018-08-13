-- funcion del trigger de eliminar en la tabla cw.user_address
CREATE OR REPLACE FUNCTION audit.f_tg_D_user_address() RETURNS TRIGGER AS $f_tg_D_user_address$
  DECLARE
  user_name VARCHAR(50);
  BEGIN
    select current_user into user_name;
    INSERT INTO audit.user_address
    (
			"id",
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
			OLD.id,
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
			'DELETE',
			now()
		);
      RETURN NULL;
  END;

$f_tg_D_user_address$ LANGUAGE 'plpgsql';

-- trigger para eliminar user_address
CREATE TRIGGER tg_D_user_address AFTER DELETE
ON cw.user_address FOR EACH ROW
EXECUTE PROCEDURE audit.f_tg_D_user_address();
