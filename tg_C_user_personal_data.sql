-- funcion del trigger de INSERT user_personal_data
CREATE OR REPLACE FUNCTION audit.f_tg_C_user_personal_data() RETURNS TRIGGER AS $tg_C_user_personal_data$
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
			ocupations_id_new,
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
			NEW.ocupations_id,
			user_name,
			'INSERT',
			now());
      RETURN NULL;
  END;

$tg_C_user_personal_data$ LANGUAGE 'plpgsql';



-- TRIGGER - INSERT  - user_personal_data
CREATE TRIGGER tg_C_user_personal_data AFTER INSERT
ON cw.user_personal_data FOR EACH ROW
EXECUTE PROCEDURE audit.f_tg_C_user_personal_data();
