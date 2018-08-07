-- funcion del trigger de eliminar en la tabla cw.users
CREATE OR REPLACE FUNCTION audit.f_tg_D_user_personal_data() RETURNS TRIGGER AS $tg_D_user_personal_data$
  DECLARE
  user_name VARCHAR(50);
  BEGIN
    select current_user into user_name;
    INSERT INTO audit.user_personal_data
    (
			id,
			name_old,
			name2_old,
			last_name_old,
			last_name2_old,
			gender_old,
			phone_old,
			mobile_phone_old,
			rfc_old,
			curp_old,
			nationality_old,
			country_old,
			entity_birth_old,
			level_study_old,
			civil_status_old,
			american_citizenship_old,
			mobile_phone_company_old,
			birthdate_old,
			folio_ine_old,
			clave_electoral_old,
			ocupations_id_old,
			user_name,
			action_performed,
			date_action
		)
    VALUES
    (
			OLD.id,
			OLD.name,
			OLD.name2,
			OLD.last_name,
			OLD.last_name2,
			OLD.gender,
			OLD.phone,
			OLD.mobile_phone,
			OLD.rfc,
			OLD.curp,
			OLD.nationality,
			OLD.country,
			OLD.entity_birth,
			OLD.level_study,
			OLD.civil_status,
			OLD.american_citizenship,
			OLD.mobile_phone_company,
			OLD.birthdate,
			OLD.folio_ine,
			OLD.clave_electoral,
			OLD.ocupations_id,
			user_name,
			'DELETE',
			now()
		);
      RETURN NULL;
  END;

$tg_D_user_personal_data$ LANGUAGE 'plpgsql';

-- trigger para eliminar user_activation_codes
CREATE TRIGGER tg_D_user_personal_data AFTER DELETE
ON cw.user_personal_data FOR EACH ROW
EXECUTE PROCEDURE audit.f_tg_D_user_personal_data();
