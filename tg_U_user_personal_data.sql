-- funcion del trigger de UPDATE user_personal_data
CREATE OR REPLACE FUNCTION audit.f_tg_U_user_personal_data() RETURNS TRIGGER AS $tg_U_user_personal_data$
  DECLARE
  user_name VARCHAR(50);
  BEGIN
    select current_user into user_name;
    INSERT INTO audit.user_personal_data
    (
			id,
			name_new,
			name2_new,
			last_name_new,
			last_name2_new,
			gender_new,
			phone_new,
			mobile_phone_new,
			rfc_new,
			curp_new,
			nationality_new,
			country_new,
			entity_birth_new,
			level_study_new,
			civil_status_new,
			american_citizenship_new,
			mobile_phone_company_new,
			birthdate_new,
			folio_ine_new,
			clave_electoral_new,
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
			ocupations_id_new,
			ocupations_id_old,
			user_name,
			action_performed,
			date_action
		)
    VALUES
    (
			NEW.id,
			NEW.name,
			NEW.name2,
			NEW.last_name,
			NEW.last_name2,
			NEW.gender,
			NEW.phone,
			NEW.mobile_phone,
			NEW.rfc,
			NEW.curp,
			NEW.nationality,
			NEW.country,
			NEW.entity_birth,
			NEW.level_study,
			NEW.civil_status,
			NEW.american_citizenship,
			NEW.mobile_phone_company,
			NEW.birthdate,
			NEW.folio_ine,
			NEW.clave_electoral,
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
			NEW.ocupations_id,
			OLD.ocupations_id,
			user_name,
			'UPDATE',
			now()
		);
      RETURN NULL;
  END;
$tg_U_user_personal_data$ LANGUAGE 'plpgsql';

-- trigger para UPDATE users
CREATE TRIGGER tg_U_user_personal_data AFTER UPDATE
ON cw.user_personal_data FOR EACH ROW
EXECUTE PROCEDURE audit.f_tg_U_user_personal_data();